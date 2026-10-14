package playground

import (
	"bytes"
	"fmt"
	"io"
	"regexp"
	"slices"
	"strings"
	"sync"
	"testing"

	"github.com/stretchr/testify/assert"
)

type SafeCache struct {
	mu      sync.Mutex
	visited []string
}

func (sc *SafeCache) hasBeenVisited(url string) bool {
	// Protect all this function block with lock
	sc.mu.Lock()
	defer sc.mu.Unlock()

	contain := slices.Contains(sc.visited, url)

	if contain {
		return true
	}

	sc.visited = append(sc.visited, url)
	return false
}

var safeCache SafeCache

// Crawl uses fetcher to recursively crawl
// pages starting with url, to a maximum of depth.
func Crawl(url string, depth int, fetcher Fetcher, wg *sync.WaitGroup, w io.Writer) {
	defer wg.Done()
	if depth <= 0 {
		return
	}

	if safeCache.hasBeenVisited(url) {
		return
	}

	body, urls, err := fetcher.Fetch(url)
	if err != nil {
		fmt.Fprintf(w, "%v", err)
		return
	}

	fmt.Fprintf(w, "found: %s %q\n", url, body)
	for _, u := range urls {
		wg.Add(1)
		go Crawl(u, depth-1, fetcher, wg, w)
	}
}

type Fetcher interface {
	// Fetch returns the body of URL and
	// a slice of URLs found on that page.
	Fetch(url string) (body string, urls []string, err error)
}

// fakeFetcher is Fetcher that returns canned results.
//
//	"url": {
//
//	{
//			body: "body",
//			urls: ["url1", "url2", "url3"]
//		}
//	}
type fakeFetcher struct {
	result map[string]*fakeResult
}

type fakeResult struct {
	body string
	urls []string
}

func (f *fakeFetcher) Fetch(url string) (string, []string, error) {
	if res, ok := f.result[url]; ok {
		return res.body, res.urls, nil
	}
	return "", nil, fmt.Errorf("not found: %s ", url)
}

// fetcher is a populated fakeFetcher.
var fetcher = fakeFetcher{
	result: map[string]*fakeResult{
		"https://golang.org/": &fakeResult{
			"The Go Programming Language",
			[]string{
				"https://golang.org/pkg/",
				"https://golang.org/cmd/",
			},
		},
		"https://golang.org/pkg/": &fakeResult{
			"Packages",
			[]string{
				"https://golang.org/",
				"https://golang.org/cmd/",
				"https://golang.org/pkg/fmt/",
				"https://golang.org/pkg/os/",
			},
		},
		"https://golang.org/pkg/fmt/": &fakeResult{
			"Package fmt",
			[]string{
				"https://golang.org/",
				"https://golang.org/pkg/",
			},
		},
		"https://golang.org/pkg/os/": &fakeResult{
			"Package os",
			[]string{
				"https://golang.org/",
				"https://golang.org/pkg/",
			},
		},
	},
}

func TestCrawler(t *testing.T) {
	t.Run("should contain links", func(t *testing.T) {
		str := RunCrawl(t)

		lines := strings.Split(str, "\n")

		assert.Contains(t, str, "https://golang.org/pkg/os/")
		assert.Contains(t, str, "https://golang.org/cmd")
		assert.Contains(t, str, "https://golang.org/pkg/fmt")
		assert.Equal(t, 5, len(lines))
	})

	t.Run("Should not have duplicated urls", func(t *testing.T) {
		str := RunCrawl(t)

		reg := regexp.MustCompile(`https:\/\/golang.org\/\s`)
		result := reg.FindAllString(str, 10)

		assert.Equal(t, 1, len(result))
	})
}

func RunCrawl(t *testing.T) string {
	t.Helper()
	clear(safeCache.visited)

	var wg sync.WaitGroup

	buffer := &bytes.Buffer{}

	wg.Add(1)
	go Crawl("https://golang.org/", 4, &fetcher, &wg, buffer)

	wg.Wait()

	return buffer.String()
}
