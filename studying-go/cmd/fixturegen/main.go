// fixturegen generates a large Go source fixture for stress-testing the parser.
// Output format matches the parser's expected input: package, imports, optional // begin..// end,
// type T struct{}, func (e T) Run() { ... } with many comment and code blocks.
//
// Usage:
//
//	go run ./cmd/fixturegen [flags]
//
// Flags:
//   -lines  approximate number of lines inside Run() (default 10000)
//   -out    output path (default tests/fixtures/source.large.source)
package main

import (
	"flag"
	"fmt"
	"os"
	"strings"
)

func main() {
	lines := flag.Int("lines", 10000, "approximate number of lines inside Run()")
	outPath := flag.String("out", "tests/fixtures/source.large.source", "output file path")
	flag.Parse()

	var b strings.Builder

	// Header: package + imports
	b.WriteString("package samples\n\n")
	b.WriteString("import (\n\t\"fmt\"\n\t\"slices\"\n)\n\n")

	// Optional // begin .. // end block (parser extracts this as header)
	b.WriteString("// begin\n")
	b.WriteString("// Generated fixture for parser stress test.\n")
	b.WriteString("// end\n\n")

	b.WriteString("type FixtureType struct{}\n\n")
	b.WriteString("func (e FixtureType) Run() {\n")

	// Approximate lines per "block pair": 1 empty + ~5 comment + 1 empty + ~4 code = ~11 lines per iteration
	blockPairs := (*lines) / 11
	if blockPairs < 1 {
		blockPairs = 1
	}

	commentTemplates := []string{
		"// Section %d: some description of the following code.",
		"// This block demonstrates usage of feature %d.",
		"// Step %d - important note about the code below.",
		"// > Quote or callout for block %d.",
		"// See [doc](https://go.dev) for more on block %d.",
	}
	codeTemplates := []string{
		"x%d := %d",
		"fmt.Println(\"block\", %d)",
		"slice%d := make([]int, 0, %d)",
		"_ = x%d",
		"result%d := %d * 2",
	}

	for i := 0; i < blockPairs; i++ {
		// Comment block (3–6 lines, parser treats as comment sequence)
		nComment := 3 + (i % 4)
		for j := 0; j < nComment; j++ {
			tpl := commentTemplates[(i+j)%len(commentTemplates)]
			b.WriteString("\t" + fmt.Sprintf(tpl, i, i, i, i, i) + "\n")
		}
		// Empty line ends comment sequence
		b.WriteString("\n")
		// Code block (2–5 lines)
		nCode := 2 + (i % 4)
		for j := 0; j < nCode; j++ {
			tpl := codeTemplates[(i+j)%len(codeTemplates)]
			b.WriteString("\t" + fmt.Sprintf(tpl, i, i, i, i, i, i) + "\n")
		}
		b.WriteString("\n")
	}

	b.WriteString("}\n")

	if err := os.WriteFile(*outPath, []byte(b.String()), 0644); err != nil {
		fmt.Fprintf(os.Stderr, "write file: %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("Wrote %s (%d bytes, ~%d lines in Run)\n", *outPath, b.Len(), blockPairs*11)
}
