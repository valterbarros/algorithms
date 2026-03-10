package parser

import (
	"regexp"
	"strings"
	"studying-go/utils"
)

const breadCrumbPattern string = `(?i)(\/\/\s)?\[Readme+\].+`

func fromGoToMarkdown(data, path string) string {
	data = stripBoilerPlate(data)

	splitted := strings.Split(string(data), "\n")

	left := 0

	var markdown strings.Builder

	for left < len(splitted) {
		code, comment := "", ""

		if isCommentCheck(splitted[left]) {
			code, left = parseCommentSequence(splitted, left)
			markdown.WriteString(code)
		} else if isCodeCheck(splitted[left]) {
			comment, left = parseCodeSequence(splitted, left)
			markdown.WriteString(comment)
		} else {
			markdown.WriteString("\n")
			left++
		}
	}

	trimmed := trimTab(markdown.String())

	utils.SaveFile(path, trimmed)

	return trimmed
}

func parseCodeSequence(str []string, left int) (string, int) {
	// Parse spaces inside here
	startL := left
	right := left + 1

	markdown := "```go\n"
	close := "\n```\n"

	// Code can sequence with comments if no \n
	for len(str) > right && !isEmpty(str[right]) {
		right++
	}

	parsed := markdown + strings.Join(str[startL:right], "\n") + close

	return parsed, right
}

func parseCommentSequence(str []string, left int) (string, int) {
	startL := left
	right := left + 1

	// Code can't sequence with code or \n
	for len(str) > right && isCommentCheck(str[right]) {
		right++
	}

	joined := strings.Join(str[startL:right], "   \n")
	parsed := strings.ReplaceAll(joined, "// ", "") + "\n"

	return parsed, right
}

func stripBoilerPlate(data string) string {
	runReg := regexp.MustCompile(`(?i)[\s\S]+Run\(\)\s\{\n`)
	body := runReg.ReplaceAllLiteralString(data, "")

	comment := extractBeginEnd(data)
	body = regexp.MustCompile(breadCrumbPattern).ReplaceAllString(body, "$0"+comment)

	// remove new line \n
	clearReg := regexp.MustCompile(`[\n\}]+$`)
	body = clearReg.ReplaceAllString(body, "")

	return body
}

// Extract comment head
// // begin
// ...inner
// // end
// returns inner
func extractBeginEnd(data string) string {
	startEndReg := regexp.MustCompile(`(?m)^\s*\/\/\s?begin\r?\n([\s\S]+?)\s*\/\/\s*end`)
	matches := startEndReg.FindStringSubmatch(data)

	if len(matches) > 0 {
		comment := matches[1]
		// ident comment code
		comment = regexp.MustCompile(`(?m)^`).ReplaceAllString(comment, "\t")

		return "\n" + comment
	}

	return ""
}

func trimTab(str string) string {
	if !isEmpty(str) {
		return regexp.MustCompile(`(?m)^(\t|  )`).ReplaceAllString(str, "")
	}
	return str
}

func isCommentCheck(str string) bool {
	// check if it current is comment and if comment that is at begin of string?
	// // new comment here => results true
	// slices[0] + ... // new comment here => results false
	return !isEmpty(str) && strings.Contains(str, "//") && strings.Index(str, "//") < 10
}

func isCodeCheck(str string) bool {
	return regexp.MustCompile(`(?i)^\s*[a-z\}]+`).MatchString(str)
}

func isEmpty(str string) bool {
	return strings.TrimSpace(str) == ""
}
