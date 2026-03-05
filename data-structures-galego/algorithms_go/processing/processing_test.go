package main

import (
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
		result := ReplaceBy(source, "Arrays")

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
		result := ReplaceBy(source, "Arrays")
		result = ReplaceBy(result, "Arrays")
		result = ReplaceBy(result, "Arrays")
		result = ReplaceBy(result, "Arrays")

		breadCrumbReg := regexp.MustCompile(BreadCrumbPattern)

		exact := breadCrumbReg.MatchString(result)

		if !exact {
			t.Errorf("There is no Study %s", result)
		}
	})
}
