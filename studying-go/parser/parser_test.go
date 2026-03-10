package parser

import (
	"strings"
	"studying-go/utils"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

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

func TestNewParseComments(t *testing.T) {
	t.Run("should parse comment and code together", func(t *testing.T) {
		source := utils.GetFileData("../tests/fixtures/source.06.source")
		expected := utils.GetFileData("../tests/fixtures/expect.06.md")

		result := newParseComments(source)

		assert.Equal(t, expected, result, "should parse right")
	})
	t.Run("should parse comment and code together with boilerplate", func(t *testing.T) {
		source := utils.GetFileData("../tests/fixtures/source.01.source")
		expected := utils.GetFileData("../tests/fixtures/expect.01.md")

		result := newParseComments(source)

		assert.Equal(t, expected, result, "should parse right")
	})
}

func TestParseCodeSequence(t *testing.T) {
	t.Run("should parse code", func(t *testing.T) {
		raw := utils.GetFileData("../tests/fixtures/source.04.source")
		source := strings.Split(raw, "\n")
		expected := utils.GetFileData("../tests/fixtures/expect.04.md")

		result, _ := parseCodeSequence(source, 0)

		assert.Equal(t, expected, result, "should parse right")
	})

	t.Run("should parse code with advance left code", func(t *testing.T) {
		raw := utils.GetFileData("../tests/fixtures/source.04.source")
		source := strings.Split(raw, "\n")
		expected := "```go" + `
slices.Sort(array2)
fmt.printLn(array2)
` + "```"

		result, _ := parseCodeSequence(source, 8)

		assert.Equal(t, expected, result, "should parse right")
	})
}
func TestParseCommentSequence(t *testing.T) {
	t.Run("should parse comment", func(t *testing.T) {
		raw := utils.GetFileData("../tests/fixtures/source.05.source")
		source := strings.Split(raw, "\n")
		expected := utils.GetFileData("../tests/fixtures/expect.05.md")

		result, _ := parseCommentSequence(source, 0)

		assert.Equal(t, expected, result, "should parse right")
	})

	t.Run("should parse comment with advanced left", func(t *testing.T) {
		raw := utils.GetFileData("../tests/fixtures/source.05.source")
		source := strings.Split(raw, "\n")
		expected := `Other comments not parsed due to \n prefix
lorem ipsum new code
`

		result, _ := parseCommentSequence(source, 5)

		assert.Equal(t, expected, result, "should parse right")
	})
}

func TestIsCodeCheck(t *testing.T) {
	result := isCodeCheck("array2[1]")
	result2 := isCodeCheck("// array2[1]")
	result3 := isCodeCheck(" ")
	result4 := isCodeCheck("")
	result5 := isCodeCheck("//")

	assert.Equal(t, result, true, "not equal")
	assert.Equal(t, result2, false, "not equal")
	assert.Equal(t, result3, false, "not equal")
	assert.Equal(t, result4, false, "not equal")
	assert.Equal(t, result5, false, "not equal")
}

func TestIsCommentCheck(t *testing.T) {
	result := isCommentCheck("array2[1]")
	result2 := isCommentCheck("// array2[1]")
	result3 := isCommentCheck(" ")
	result4 := isCommentCheck("")
	result5 := isCommentCheck("//")

	assert.Equal(t, result, false, "not equal")
	assert.Equal(t, result2, true, "not equal")
	assert.Equal(t, result3, false, "not equal")
	assert.Equal(t, result4, false, "not equal")
	assert.Equal(t, result5, true, "not equal")
}
