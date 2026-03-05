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
	// TODO: try to get comments from .go file and pass to .md file formatted
	reg := regexp.MustCompile(`(?im)^(\s{0,1}\/\/\s|\s+\b)`)

	hasCodeSeq := false
	isCodeOpen := false

	finish := reg.ReplaceAllStringFunc(data, func(m string) string {
		str := m

		if isCodeOpen {
			str = strings.TrimSpace(m)
		} else {
			str = strings.ReplaceAll(strings.TrimSpace(m), "//", "")
		}

		// open comment ```go
		// it comes from a comment and that is a code
		if !hasCodeSeq && !strings.Contains(m, "//") {
			str = "\n```go\n"
		}

		// close comment ```
		if hasCodeSeq && strings.Contains(m, "//") {
			str = "```\n"
		}

		hasCodeSeq = !strings.Contains(m, "//")

		return str
	})

	// utils.SaveFile("/tmp/arrays2.md", finish)
	return finish
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
