package parser

import (
	"regexp"
	"testing"

	"github.com/stretchr/testify/assert"
)

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
