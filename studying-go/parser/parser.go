package parser

import (
	"regexp"
	"strings"
	"studying-go/utils"
)

const breadCrumbPattern string = `(?i)(\/\/\s)?\[Readme+\].+`

func parseComments(data string, path string) string {
	data = stripBoilerPlate(data)
	// reg := regexp.MustCompile(`(?im)\n`)
	// utils.SaveFile("/tmp/arrays2.md", data)
	// return ""

	markdown := ""
	splitted := strings.Split(string(data), "\n")
	hasCodeSeq := false

	for index, original := range splitted {
		str := original

		if strings.TrimSpace(str) != "" {
			// remove identation additional
			str = str[1:]
		} else {
			// if it is empty that is a new line
			newLine := "\n"
			if hasCodeSeq /* I'm new line and a code squence is open I need to close that*/ {
				hasCodeSeq = false
				newLine = "```\n"
			}

			markdown += newLine
			continue
		}

		isComment := isCommentCheck(original)
		isNextNewLine := index < len(splitted)-1 && strings.TrimSpace(splitted[index+1]) == ""
		isNextComment := index < len(splitted)-1 && isCommentCheck(splitted[index+1])

		if !hasCodeSeq && isComment {
			str = strings.ReplaceAll(str, "// ", "")
		}

		// to avoid many comment line be in same line
		if !hasCodeSeq && isComment && isNextComment {
			str = str + "   "
		}

		// after split \n was removed fro all lines
		str = str + "\n"

		// open comment ```go
		// it comes from a comment and that is a code
		if !hasCodeSeq && !isComment {
			hasCodeSeq = true
			str = "\n```go\n" + str
		} else if hasCodeSeq && isNextNewLine /*The isNextNewLine closes the code sequence*/ {
			hasCodeSeq = false
			// close comment ```
			str = str + "```\n"
		}

		markdown += str
	}

	// remove new line \n
	removeReg := regexp.MustCompile(`[\n\}]+$`)
	markdown = removeReg.ReplaceAllString(markdown, "")

	// utils.SaveFile("/tmp/arrays2.md", markdown)
	utils.SaveFile(path, markdown)
	return markdown
}

func newParseComments(data string) string {
	// disabled
	// data = removeHead(data)
	// utils.SaveFile("/tmp/arrays2.md", data)
	// return ""

	splitted := strings.Split(string(data), "\n")

	left := 0
	// right := len(splitted) - 1

	markdown := ""

	for left < len(splitted) {
		code, comment := "", ""

		if isCommentCheck(splitted[left]) {
			code, left = parseCommentSequence(splitted, left)
			markdown += code
		} else if isCodeCheck(splitted[left]) {
			comment, left = parseCodeSequence(splitted, left)
			markdown += comment
		} else {
			markdown += "\n"
			left++
		}
	}

	utils.SaveFile("/tmp/arrays2.md", markdown)

	return markdown
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

	joined := strings.Join(str[startL:right], "\n")
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

		return comment
	}

	return ""
}

func isCommentCheck(str string) bool {
	// check if it current is comment and if comment that is at begin of string?
	// // new comment here => results true
	// slices[0] + ... // new comment here => results false
	return !isEmpty(str) && strings.Contains(str, "//") && strings.Index(str, "//") < 10
}

func isCodeCheck(str string) bool {
	return regexp.MustCompile(`(?i)^[a-z\}]+`).MatchString(str)
}

func isEmpty(str string) bool {
	return strings.TrimSpace(str) == ""
}
