## Strings

[Study](../notes/STUDY.md) / Strings

###String "interpolations"

Doc with replacements %d %s, etc   
Https://pkg.go.dev/fmt#hdr-Printing

```go
str := fmt.Sprintf("the number is: %d", 1)
str1 := fmt.Sprintf("the number is: %s", "one")
fmt.Println("interpolated: ", str, str1)
```

### The rune and byte types

This is a rune   
With rune is possible to store utf8 characters in a single value   
Rune is int32

```go
var fullChar rune
// can only be one character, just like char in other languages
fullChar = 'é'
fmt.Println("full char: ", fullChar) // -> 233
```

Byte is uint8   
In go string is a sequence of bytes readonly, in that way is note possible to acess [0] [1] of a string   
A more deep detail is that it is not called a cast it is called a convertion and the value is copied in memory from string to bytes   
Original string keeps intact   
It returns two bytes because é is no ascii(using 7 bits, from 0 to 127)

```go
var notFull []byte
notFull = []byte("é")
fmt.Println("not full char: ", notFull) // -> [195, 169]
```

### Strings in a loop


```go
chars := "é😍😋...😋.😋.😅"
// in loop string is interated as runes
for idx, char := range chars {
	// char is type rune
	fmt.Println(idx, char)
}
```

### Replace

It is possible to get strings by range   
Get from 3 until end of string

```go
newString := "  testando"
fmt.Println("new String: ", newString[3:])
```

Replace string

```go
fmt.Println("string replaced: ", strings.ReplaceAll("valter", "v", "w"))
```
Or using regex

Using regex, the (?im) is to change mode of regex, in that case is using case insensitive and multiline regex

```go
reg1 := regexp.MustCompile(`(?im)V`)
fmt.Println("string replaced2: ", reg1.ReplaceAllString("valter", "w"))