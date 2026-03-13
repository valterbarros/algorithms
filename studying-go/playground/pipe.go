package playground

import (
	"bufio"
	"fmt"
	"os"
	"sync"
	"time"
)

// to run: go build -o ./ && cat ../../tests/fixtures/expect.01.md | ./playground
// This is a algorithm prepared to use shell pipe(|)

func Pipe() {
	s := bufio.NewScanner(os.Stdin)
	concurrencyLimit := 5
	// keep only 5 goroutine active, if exceed channel create a buffer and block execution until free
	semaphore := make(chan string, concurrencyLimit)
	var wg sync.WaitGroup

	for s.Scan() {
		line := s.Text()
		wg.Add(1)

		semaphore <- ""

		go func(l string) {
			defer wg.Done()
			// closes the channel and free space for next routine
			defer func() { <-semaphore }()

			time.Sleep(10 * time.Second)
			fmt.Println("finish: ", l)
		}(line)
	}

	// avoid program finish
	wg.Wait()

	// SEMPRE cheque erros do scanner em pipelines
	if err := s.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Erro na leitura do pipe:", err)
	}
}
