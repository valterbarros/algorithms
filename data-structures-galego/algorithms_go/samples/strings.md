#### Strings

**String "interpolations"**

```go
str := fmt.Sprintf("the number is: %d", 1)
str1 := fmt.Sprintf("the number is: %s", "one")
fmt.Println("interpolated: ", str, str1)
```

**this is a rune**
**With rune is possible to store utf8 characters in a single value**
**rune is int32**

```go
var fullChar rune
fullChar = 'é'
fmt.Println("full char: ", fullChar) // -> 233
```

**byte is uint8**
**in go string is a sequence of bytes readonly, in that way is note possible to acess [0] [1] of a string**
**A more deep detail is that it is not called a cast it is called a convertion and the value is copied in memory from string to bytes**
**original string keeps intact**
**it returns two bytes because é is no ascii**

```go
var notFull []byte
notFull = []byte("é")
fmt.Println("not full char: ", notFull) // -> [195, 169]
```

**in loop string is interated as runes**

```go
chars := "é..."
for idx, char := range chars {
    fmt.Println(idx, char)
}
```
