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
		samplesMap := map[string]samples.Sample{
			"structs":   samples.StructsType{},
			"pointers":  samples.PointersType{},
			"strings":   samples.PointersType{},
			"enums":     samples.EnumsType{},
			"variables": samples.VariablesType{},
			"types":     samples.TypesType{},
			"functions": samples.FunctionsType{},
		}

		if sample, ok := samplesMap[os.Args[2]]; ok {
			sample.Run()
		} else {
			fmt.Println("Function not recognized")
		}
	default:
		fmt.Println("Module not recognized")
	}
}
