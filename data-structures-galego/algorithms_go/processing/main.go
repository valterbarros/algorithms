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
	// isCodeOpen := false

	finish := ""
	splitted := reg.Split(data, -1)

	for _, original := range splitted {
		str := original

		if str != "" {
			// remove identation additional and comment //
			str = str[1:]
		} else {
			// if it is empty that is a new line
			finish += "\n"
			continue
		}

		// check if it current is comment and if comment that is at begin of string?
		isComment := strings.Contains(original, "//")

		if isComment {
			str = strings.ReplaceAll(str, "// ", "")
		}

		// after split \n was removed fro all lines
		str = str + "\n"

		// open comment ```go
		// it comes from a comment and that is a code
		if !hasCodeSeq && !isComment {
			str = "\n```go\n" + str
		}

		// close comment ```
		if hasCodeSeq && isComment {
			str = "```\n" + str
		}

		hasCodeSeq = !isComment

		finish += str
	}

	// remove new line \n
	removeReg := regexp.MustCompile(`[\n\}]+$`)
	finish = removeReg.ReplaceAllString(finish, "")

	utils.SaveFile("/tmp/arrays2.md", finish)
	return finish
}

func removeHead(data string) string {
	reg2 := regexp.MustCompile(`(?i)Run\(\)\s\{\n`)
	idx := reg2.FindStringIndex(data)

	return data[idx[1]:]
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
