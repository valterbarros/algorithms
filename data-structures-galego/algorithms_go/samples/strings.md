## Strings

[Study](../notes/STUDY.md) / Strings

### String "interpolations"

```go
str := fmt.Sprintf("the number is: %d", 1)
str1 := fmt.Sprintf("the number is: %s", "one")
fmt.Println("interpolated: ", str, str1)
```

### The rune and byte types

this is a rune
With rune is possible to store utf8 characters in a single value
rune is an alias for int32

```go
var fullChar rune
fullChar = 'é'
fmt.Println("full char: ", fullChar) // -> 233
```

byte is uint8
in go string is a sequence of bytes readonly, in that way is note possible to acess [0] [1] of a string
A more deep detail is that it is not called a cast it is called a convertion and the value is copied in memory from string to bytes
original string keeps intact
it returns two bytes because é is no ascii

```go
var notFull []byte
notFull = []byte("é")
fmt.Println("not full char: ", notFull) // -> [195, 169]
```

### Strings in a loop

in loop string is interated as runes

```go
chars := "é..."
for idx, char := range chars {
  // char is type rune
  fmt.Println(idx, char)
}

```

### Replace

it is possible to replace a string using a method from strings

```go
strings.ReplaceAll("valter", "v", "w")
```

Or using regex

```go
// using regex, the (?im) is to change mode of regex, in that case is using case insensitive and multiline regex
reg1 := regexp.MustCompile(`(?im)V`)
fmt.Println("string replaced2: ", reg1.ReplaceAllString("valter", "w"))
```
