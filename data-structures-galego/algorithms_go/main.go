// You can edit this code!
// Click here and start typing.

package main

import (
	"data-structures/algorithms_go/samples"
	"fmt"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		// eg: go run main.go array structs
		fmt.Println("Usage: go run main.go [array]")
		return
	}

	switch os.Args[1] {
	case "array":
		if len(os.Args) < 3 {
			fmt.Println("Choose a function: two-pointers, binary-search, sliding-window, exponential-search, structs, pointers, hashmap")
			return
		}
		switch os.Args[2] {
		case "structs":
			samples.RunStructs()
		case "pointers":
			samples.RunPointers()
		case "strings":
			samples.RunStrings()
		case "enums":
			samples.RunEnums()
		default:
			fmt.Println("Function not recognized")
		}
	default:
		fmt.Println("Module not recognized")
	}
}
