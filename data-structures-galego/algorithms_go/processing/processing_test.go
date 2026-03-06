package main

import (
	"data-structures/algorithms_go/utils"
	"regexp"
	"strings"
	"testing"
)

func TestReplaceBy(t *testing.T) {
	t.Run("Checking for replace one time", func(t *testing.T) {
		source := `
## Arrays

### Sub topic
		`
		result := replaceBy(source, "Arrays")

		ok := strings.Contains(result, "[Study](../notes/STUDY.md) / Arrays")
		if !ok {
			t.Errorf("There is no Study")
		}
	})

	t.Run("should update breadcrumb after replace n times", func(t *testing.T) {
		source := `
## Arrays

### Sub topic
		`
		result := replaceBy(source, "Arrays")
		result = replaceBy(result, "Arrays")
		result = replaceBy(result, "Arrays")
		result = replaceBy(result, "Arrays")

		breadCrumbReg := regexp.MustCompile(breadCrumbPattern)

		exact := breadCrumbReg.MatchString(result)

		if !exact {
			t.Errorf("There is no Study %s", result)
		}
	})
}

func TestProcessComments(t *testing.T) {
	t.Run("should update get comments", func(t *testing.T) {
		source := `package samples

import (
	"fmt"
	"slices"
)

type ArrayType struct{}

func (e ArrayType) Run() {
	// testing a new go feature
	// to work with...

	func defering() {
		...
	}

	defer defering()
}
`
		result := processComments(source)

		expected := `testing a new go feature
to work with...
` + "\n```go" + `

func defering() {
	...
}

defer defering()`

		utils.SaveFile("/tmp/array2-result.md", expected)

		if result != expected {
			t.Errorf("\nWrong expected: \n%s result: \n%s", expected, result)
		}
	})

	t.Run("should work with subcomment inside go fns", func(t *testing.T) {
		// Skip until be possible to add subcommands
		t.Skip()
		source := `// testing a new go feature
// to work with...

func defering() {
	// SubComment here inside code
	slice0 := make([]float32, 10, 15)
	fmt.Println("capacity slice0", cap(slice0), len(slice0))
}

defer defering()
`
		result := processComments(source)

		expected := `testing a new go feature
to work with...
` + "\n```go" + `
func defering() {
	// SubComment here inside code
	slice0 := make([]float32, 10, 15)
	fmt.Println("capacity slice0", cap(slice0), len(slice0))
}

defer defering()
`

		if result != expected {
			t.Errorf("\nWrong expected:\n\n%s result: \n\n%s", expected, result)
		}
	})
}
