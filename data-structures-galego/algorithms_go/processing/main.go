package main

// trying to add breadcrumb and other automatizations to samples/*.md

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

// TODO: run each file in a go routine
func main() {
	// Read all files from samples folder
	files, _ := os.ReadDir("samples/")

	// Replace first and then overwrite the file with new content
	// add breadcrumb to all files
	for _, file := range files {
		name := file.Name()

		if !strings.HasSuffix(name, ".md") {
			continue
		}

		data := getFileData("samples/" + name)

		viewName := capitalize(strings.ReplaceAll(name, ".md", ""))

		withBreadCrumb := replaceBy(data, viewName)

		// Save to file
		saveFile("samples/"+name, withBreadCrumb)
	}
}

func saveFile(file, data string) {
	os.WriteFile(file, []byte(data), 0644)
}

func resetFile(file string) {
	os.WriteFile(file, []byte(""), 0644)
}

func getFileData(file string) string {
	data, err := os.ReadFile(file)
	if err != nil {
		fmt.Println("Error to open file")
		return ""
	}

	return string(data)
}

func replaceBy(data, name string) string {
	breadCrumbReg := regexp.MustCompile(`(?im)^\[Study+\].+\)`)
	// (?i) is for case insensitive
	titleReg := regexp.MustCompile(`(?i)(^##\s[a-z]+)`)
	breadBase := "[Study](../notes/STUDY.md) / [" + name + "](.)"

	// if has edit update breadcrumb
	if has := breadCrumbReg.MatchString(data); has {
		return breadCrumbReg.ReplaceAllString(data, breadBase)
	} else {
		return titleReg.ReplaceAllString(data, "$1\n\n"+breadBase)
	}
}

func capitalize(s string) string {
	return strings.ToUpper(s[:1]) + s[1:]
}
