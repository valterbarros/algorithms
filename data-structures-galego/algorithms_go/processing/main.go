package main

// trying to add breadcrumb and other automatizations to samples/*.md

import (
	"data-structures/algorithms_go/utils"
	"flag"
	"fmt"
	"regexp"
	"strings"
)

const breadCrumbPattern string = `(?i)(\/\/\s)?\[Study+\].+`

func main() {
	fileRun := flag.String("file-run", "", "File name")
	flag.Parse()

	data := utils.GetFileData("samples/" + *fileRun + ".go")
	processComments(data)
	// addBreadCrumb()
}

func processComments(data string) string {
	data = removeHead(data)
	reg := regexp.MustCompile(`(?im)\n`)

	markdown := ""
	splitted := reg.Split(data, -1)
	hasCodeSeq := false

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
		isNextComment := index < len(splitted)-1 && isCommentCheck(splitted[index+1])

		if !hasCodeSeq && isComment {
			str = utils.Capitalize(strings.ReplaceAll(str, "// ", ""))
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

	utils.SaveFile("/tmp/arrays2.md", markdown)
	return markdown
}

func removeHead(data string) string {
	runReg := regexp.MustCompile(`(?i)[\s\S]+Run\(\)\s\{\n`)
	head := runReg.ReplaceAllLiteralString(data, "")
	startEndReg := regexp.MustCompile(`(?m)\/\/\sbegin([\s\S]+)\/\/\send`)
	matches := startEndReg.FindStringSubmatch(data)

	if len(matches) > 0 {
		comment := matches[1]
		// add spaces to keep pattern
		comment = regexp.MustCompile(`(?m)^`).ReplaceAllString(comment, " ")
		// $0 is breadcrumb match
		head = regexp.MustCompile(breadCrumbPattern).ReplaceAllString(head, "$0"+comment)
	}

	// remove new line \n
	removeReg := regexp.MustCompile(`[\n\}]+$`)
	head = removeReg.ReplaceAllString(head, "")

	return head
}

func isCommentCheck(str string) bool {
	// check if it current is comment and if comment that is at begin of string?
	// // new comment here => results true
	// slices[0] + ... // new comment here => results false
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
