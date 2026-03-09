## Types

[Study](../notes/STUDY.md) / Types 

```go
type FuncType func()
```
It is possible to add method a to func type?!

```go
func (f FuncType) callFn() {
	f()
}
```


```go
type IntType int
```

```go
type anyStruct struct {
	param any
}
```

Add method to int type

```go
func (i IntType) getInt() {
	fmt.Println("selected type: ", i)
}
```



### Methods on types


```go
var fnType FuncType
fnType = func() {
	fmt.Println("inside FuncType")
}
// More advance example a function type call a method of that method
fnType.callFn()
```

Method on int

```go
var intType IntType
intType = 1
intType.getInt()
```

### Int types

> there is some types for int and float   
Basically int: int, int8, int16, int32, int64   
Go get type by inference and set int, that is based on processor architecture   
Go get type by inference and set int, that is based on processor architecture

```go
num := 1
fmt.Println("infer int type: ", reflect.TypeOf(num))
```

It is not possible to make operations with differents types like int8 + int1   
Var byt int8 = 1   
Var byt2 int16 = 2   
X Error   
```go   
Byt+byt2   
````

X error:   
```go   
Var variable uint = -1   
```

> rune is alias for int32   
Byte is an alias for uint8

Returns int

```go
fmt.Println(reflect.TypeOf(num))
```
### Other types

For float there is just   
Float32 and float64


```go
num2 := 2.0
// returns float64
fmt.Println(reflect.TypeOf(num2))
```

Type boolean

```go
isOk := true
fmt.Println(isOk)
```

Type error

```go
var erro error = errors.New("panic internal error")
fmt.Println(erro)
```

Function type   
This is anonymous function

```go
whatIsType := func() {}
fmt.Println(reflect.TypeOf(whatIsType))
```

### Type Assert

Is possible to do this   
`any == interface{}`


```go
var whatIsType2 any = func() {}
var a int = 1
fmt.Println(a)
// it is a type switch
switch whatIsType2.(type) {
case func():
	fmt.Println("is a function")
case int:
	fmt.Println("is an int")
case string:
	fmt.Println("is a string")
default:
	fmt.Println("is not a function")
}
```

It is possible to run type assertion like that

```go
var newSt any = "Olá, Go!"
```
Checks if newSt is string

```go
strVar, ok := newSt.(string)
fmt.Println("valor of check: ", strVar, ok)