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
			capitalizedName := utils.Capitalize(name)
			fromGoToMarkdown(data, "samples/"+strings.ReplaceAll(capitalizedName, ".go", ".md"))
		})
	} else {
		data := utils.GetFileData("samples/" + *fileRun + ".go")
		capitalizedName := utils.Capitalize(*fileRun)
		fromGoToMarkdown(data, "samples/"+capitalizedName+".md")
	}
}
