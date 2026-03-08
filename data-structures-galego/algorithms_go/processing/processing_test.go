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
		source := utils.GetFileData("../tests/fixtures/source.01.source")

		result := processComments(source)

		expected := utils.GetFileData("../tests/fixtures/expect.01.md")

		utils.SaveFile("/tmp/array2-result.md", expected)

		if result != expected {
			t.Errorf("\nWrong expected: \n%s result: \n%s", expected, result)
		}
	})

	t.Run("should be possible to keep a comment side code", func(t *testing.T) {
		source := `package samples

import (
	"fmt"
	"slices"
)

type ArrayType struct{}

func (e ArrayType) Run() {
	slice3 := []int{1,2,3,4}
	// it basically put 0 in 1 and 1 in 0
	slice3[0], slice3[1] = slice3[1], slice3[0]

	// get first element
	slices[1]
}
`
		result := processComments(source)

		expected := "\n```go" + `
slice3 := []int{1,2,3,4}
// it basically put 0 in 1 and 1 in 0
slice3[0], slice3[1] = slice3[1], slice3[0]` + "\n```" + `

Get first element

` + "```go" + `
slices[1]

` + "```"

		if result != expected {
			t.Errorf("\nWrong expected:\n\n%s result: \n\n%s", expected, result)
		}
	})
	t.Run("should be possible to have multiline comments", func(t *testing.T) {
		source := utils.GetFileData("../tests/fixtures/source.02.source")

		result := processComments(source)

		expected := utils.GetFileData("../tests/fixtures/expect.02.md")

		utils.SaveFile("/tmp/array2-result.md", expected)

		if result != expected {
			t.Errorf("\nWrong expected: \n%s result: \n%s", expected, result)
		}
	})
}
