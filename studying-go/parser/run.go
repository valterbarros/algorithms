package parser

// trying to add breadcrumb and other automatizations to samples/*.md

import (
	"flag"
	"strings"
	"studying-go/utils"
)

func Run() {
	fileRun := flag.String("file-run", "", "File name")
	flag.Parse()

	if *fileRun == "*" {
		utils.IterateFiles("samples/", ".go", func(name string) {
			data := utils.GetFileData("samples/" + name)
			fromGoToMarkdown(data, "samples/"+strings.ReplaceAll(name, ".go", ".md"))
		})
	} else {
		data := utils.GetFileData("samples/" + *fileRun + ".go")
		fromGoToMarkdown(data, "samples/"+*fileRun+".md")
	}
}
