// https://gobyexample.com/strings-and-runes

package samples

import (
	"fmt"
	"regexp"
	"strings"
)

type StringsType struct{}

func (s StringsType) Run() {
	// String "interpolations"
	// https://pkg.go.dev/fmt#hdr-Printing
	str := fmt.Sprintf("the number is: %d", 1)
	str1 := fmt.Sprintf("the number is: %s", "one")

	fmt.Println("interpolated: ", str, str1)

	// this is a rune
	// With rune is possible to store utf8 characters in a single value
	// rune is int32
	var fullChar rune
	// can only be one character, just like char in other languages
	fullChar = 'é'
	fmt.Println("full char: ", fullChar) // -> 233

	// byte is uint8
	var notFull []byte
	// in go string is a sequence of bytes readonly, in that way is note possible to acess [0] [1] of a string
	// A more deep detail is that it is not called a cast it is called a convertion and the value is copied in memory from string to bytes
	// original string keeps intact
	// it returns two bytes because é is no ascii(using 7 bits, from 0 to 127)
	notFull = []byte("é")

	fmt.Println("not full char: ", notFull) // -> [195, 169]

	chars := "é😍😋...😋.😋.😅"
	// in loop string is interated as runes
	for idx, char := range chars {
		fmt.Println(idx, char)
	}

	// It is possible to get strings by range
	// get from 3 until end of string
	newString := "  testando"
	fmt.Println("new String: ", newString[3:])

	// replace string
	fmt.Println("string replaced: ", strings.ReplaceAll("valter", "v", "w"))

	// using regex, the (?im) is to change mode of regex, in that case is using case insensitive and multiline regex
	reg1 := regexp.MustCompile(`(?im)V`)
	fmt.Println("string replaced2: ", reg1.ReplaceAllString("valter", "w"))
}
