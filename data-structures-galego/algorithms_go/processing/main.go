package main

// trying to add breadcrumb and other automatizations to samples/*.md

import (
	"data-structures/algorithms_go/utils"
	"fmt"
	"regexp"
	"strings"
)

func main() {
	data := utils.GetFileData("samples/arrays.go")
	processComments(data)
	// addBreadCrumb()
}

func processComments(data string) string {
	data = removeHead(data)
	// TODO: try to get comments from .go file and pass to .md file formatted
	reg := regexp.MustCompile(`(?im)\n`)

	hasCodeSeq := false

	markdown := ""
	splitted := reg.Split(data, -1)

	for index, original := range splitted {
		str := original

		if str != "" {
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
		isNextNewLine := index < len(splitted)-1 && splitted[index+1] == ""
		// isNextComment := index < len(splitted)-1 && isCommentCheck(original)

		if !hasCodeSeq && isComment {
			str = utils.Capitalize(strings.ReplaceAll(str, "// ", ""))
		}

		// after split \n was removed fro all lines
		str = str + "\n"

		// open comment ```go
		// it comes from a comment and that is a code
		if !hasCodeSeq && !isComment {
			hasCodeSeq = true
			str = "\n```go\n" + str
		} else if hasCodeSeq && isNextNewLine /* The isNextNewLine closes the code sequence*/ {
			hasCodeSeq = false
			// close comment ```
			str = str + "```\n"
		}

		markdown += str
	}

	// remove new line \n
	removeReg := regexp.MustCompile(`[\n\}]+$`)
	markdown = removeReg.ReplaceAllString(markdown, "")

	utils.SaveFile("/tmp/arrays2.md", markdown)
	return markdown
}

func removeHead(data string) string {
	reg2 := regexp.MustCompile(`(?i)Run\(\)\s\{\n`)
	idx := reg2.FindStringIndex(data)

	return data[idx[1]:]
}

func isCommentCheck(str string) bool {
	// check if it current is comment and if comment that is at begin of string?
	return str != "" && strings.Contains(str, "//") && strings.Index(str, "//") < 10
}

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

const breadCrumbPattern string = `(?im)^\[Study+\].+`

func replaceBy(data, name string) string {
	// (?i) is for case insensitive
	titleReg := regexp.MustCompile(`(?im)(^##\s[a-z]+)`)
	breadBase := "[Study](../notes/STUDY.md) / " + name
	breadCrumbReg := regexp.MustCompile(breadCrumbPattern)

	// if has edit update breadcrumb
	if has := breadCrumbReg.MatchString(data); has {
		return breadCrumbReg.ReplaceAllString(data, breadBase)
	} else {
		return titleReg.ReplaceAllString(data, "$1\n\n"+breadBase)
	}
}
