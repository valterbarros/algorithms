package main

import (
	"regexp"
	"studying-go/utils"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
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

func TestParseComments(t *testing.T) {
	t.Run("should update get comments", func(t *testing.T) {
		source := utils.GetFileData("../tests/fixtures/source.01.source")
		expected := utils.GetFileData("../tests/fixtures/expect.01.md")
		require.NotEmpty(t, source, "fixture source.01.source should exist")
		require.NotEmpty(t, expected, "fixture expect.01.md should exist")

		result := parseComments(source, "/tmp/array2-result.md")

		assert.Equal(t, expected, result, "processComments should match expected output")
	})

	t.Run("should be possible to have multiline comments", func(t *testing.T) {
		source := utils.GetFileData("../tests/fixtures/source.02.source")
		expected := utils.GetFileData("../tests/fixtures/expect.02.md")
		require.NotEmpty(t, source, "fixture source.02.source should exist")
		require.NotEmpty(t, expected, "fixture expect.02.md should exist")

		result := parseComments(source, "/tmp/array2-result.md")

		assert.Equal(t, expected, result, "processComments should match expected output for multiline comments")
	})

	t.Run("should be possible to keep a comment side code", func(t *testing.T) {
		source := utils.GetFileData("../tests/fixtures/source.03.source")
		expected := utils.GetFileData("../tests/fixtures/expect.03.md")
		require.NotEmpty(t, source, "fixture source.03.source should exist")
		require.NotEmpty(t, expected, "fixture expect.03.md should exist")

		result := parseComments(source, "/tmp/array2-result.md")

		assert.Equal(t, expected, result, "processComments should preserve comment beside code")
	})
}
