## Types

It is possible to add method a to func type?!

```go
type FuncType func()
func (f FuncType) callFn() {
    f()
}
```

Add method to int type

```go
type IntType int
func (i IntType) getInt() {
    fmt.Println("selected type: ", i)
}
```

there is some types for int and float
basically int: int, int8, int16, int32, int64
go get type by inference and set int, that is based on processor architecture

```go
num := 1
fmt.Println("infer int type: ", reflect.TypeOf(num))
```

It is not possible to make operations with differents types like int8 + int16

```go
var byt int8 = 1
var byt2 int16 = 2
// Error
byt+byt2
```

uint unssined int

```go
// Error
var variable uint = -1;
```

rune is alias for int32
byte is an alias for uint8

returns int

```go
fmt.Println(reflect.TypeOf(num))
```
