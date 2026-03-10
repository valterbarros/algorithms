package parser

import (
	"regexp"
	"strings"
	"studying-go/utils"
)

const breadCrumbPattern string = `(?i)(\/\/\s)?\[Readme+\].+`

var (
	reRunBlock   = regexp.MustCompile(`(?i)[\s\S]+Run\(\)\s\{\n`)
	reBreadCrumb = regexp.MustCompile(breadCrumbPattern)
	reTrailNL    = regexp.MustCompile(`[\n\}]+$`)
	reBeginEnd   = regexp.MustCompile(`(?m)^\s*\/\/\s?begin\r?\n([\s\S]+?)\s*\/\/\s*end`)
	reIndentLine = regexp.MustCompile(`(?m)^`)
	reTrimIndent = regexp.MustCompile(`(?m)^(\t|  )`)
	reCodePrefix = regexp.MustCompile(`(?i)^\s*[a-z\}]+`)
)

type lineKind int

const (
	lineEmpty lineKind = iota
	lineComment
	lineCode
)

// this is similar to toString in other languages
func (k lineKind) String() string {
	switch k {
	case lineEmpty:
		return "empty"
	case lineComment:
		return "comment"
	case lineCode:
		return "code"
	default:
		return "unknown"
	}
}

func fromGoToMarkdown(data, path string) string {
	data = stripBoilerPlate(data)
	lines := strings.Split(data, "\n")

	var out strings.Builder
	left := 0

	for left < len(lines) {
		switch classifyLine(lines[left]) {
		case lineComment:
			content, next := parseCommentSequence(lines, left)
			out.WriteString(content)
			left = next
		case lineCode:
			content, next := parseCodeSequence(lines, left)
			out.WriteString(content)
			left = next
		default:
			out.WriteString("\n")
			left++
		}
	}

	trimmed := trimLeadingIndent(out.String())

	if path != "" {
		utils.SaveFile(path, trimmed)
	}

	return trimmed
}

func parseCodeSequence(lines []string, left int) (content string, next int) {
	start := left
	right := left + 1
	// Code block continues until an empty line; comment lines beside code stay in the same block.
	for right < len(lines) && !isEmpty(lines[right]) {
		right++
	}
	content = "```go\n" + strings.Join(lines[start:right], "\n") + "\n```\n"
	return content, right
}

func parseCommentSequence(lines []string, left int) (content string, next int) {
	start := left
	right := left + 1
	for right < len(lines) && isCommentLine(lines[right]) {
		right++
	}
	joined := strings.Join(lines[start:right], "   \n")
	content = strings.ReplaceAll(joined, "// ", "") + "\n"
	return content, right
}

func stripBoilerPlate(data string) string {
	body := reRunBlock.ReplaceAllLiteralString(data, "")
	comment := extractBeginEnd(data)
	body = reBreadCrumb.ReplaceAllString(body, "$0"+comment)
	body = reTrailNL.ReplaceAllString(body, "")
	return body
}

// extractBeginEnd extracts the block between // begin and // end.
func extractBeginEnd(data string) string {
	matches := reBeginEnd.FindStringSubmatch(data)
	if len(matches) == 0 {
		return ""
	}
	comment := reIndentLine.ReplaceAllString(matches[1], "\t")
	return "\n" + comment
}

func trimLeadingIndent(s string) string {
	if isEmpty(s) {
		return s
	}
	return reTrimIndent.ReplaceAllString(s, "")
}

// isCommentLine reports whether the line is a comment at the start (// within the first ~10 chars).
func isCommentLine(s string) bool {
	return !isEmpty(s) && strings.Contains(s, "//") && strings.Index(s, "//") < 10
}

func classifyLine(s string) lineKind {
	if isEmpty(s) {
		return lineEmpty
	}
	if isCommentLine(s) {
		return lineComment
	}
	if reCodePrefix.MatchString(s) {
		return lineCode
	}
	return lineEmpty
}

func isCodeCheck(str string) bool {
	return reCodePrefix.MatchString(str)
}

func isCommentCheck(str string) bool {
	return isCommentLine(str)
}

func isEmpty(s string) bool {
	return strings.TrimSpace(s) == ""
}
