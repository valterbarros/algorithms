package parser

import (
	"fmt"
	"regexp"
	"strings"
	"studying-go/utils"
	"testing"

	"github.com/stretchr/testify/assert"
)

// deprecated
func replaceBy(data, name string) string {
	// (?i) is for case insensitive
	titleReg := regexp.MustCompile(`(?im)(^##\s[a-z]+)`)
	breadBase := "[Readme](../README.md) / " + name
	breadCrumbReg := regexp.MustCompile(breadCrumbPattern)

	// if has edit update breadcrumb
	if has := breadCrumbReg.MatchString(data); has {
		return breadCrumbReg.ReplaceAllString(data, breadBase)
	} else {
		return titleReg.ReplaceAllString(data, "$1\n\n"+breadBase)
	}
}

// deprecated
func addBreadCrumb() {
	// TODO: run each file in a go routine
	// Replace first and then overwrite the file with new content
	// add breadcrumb to all files
	utils.IterateFiles("samples/", ".md", func(name string) {
		data := utils.GetFileData("samples/" + name)

		viewName := utils.Capitalize(strings.ReplaceAll(name, ".md", ""))

		withBreadCrumb := replaceBy(data, viewName)
		fmt.Println(withBreadCrumb)

		// Save to file
		utils.SaveFile("samples/"+name, withBreadCrumb)
	})
}

func TestReplaceBy(t *testing.T) {
	t.Run("Checking for replace one time", func(t *testing.T) {
		source := `
## Arrays

### Sub topic
		`
		result := replaceBy(source, "Arrays")

		assert.Contains(t, result, "[Readme](../README.md) / Arrays",
			"result should contain breadcrumb with Arrays")
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
		assert.Regexp(t, breadCrumbReg, result,
			"result should match breadcrumb pattern after multiple replaces")
	})
}
