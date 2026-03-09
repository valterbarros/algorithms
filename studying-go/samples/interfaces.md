## Functions

[Readme](../README.md) / Interfaces 

Creates a interface

```go
type animal interface {
	talk() string
}
```

Creates a struct that has same sign from animal interface

```go
type cat struct{}
```

```go
func (d cat) talk() string {
	return "Meow!"
}
```

Creates a dog that has same sign from animal interface

```go
type dog struct{}
```

```go
func (d dog) talk() string {
	return "Au!"
}
```

it is kind of polymorphism

```go
func trigger(t animal) {
	// note that it is not necessary to do type assert since here is garantee that t has talk method
	fmt.Println(t.talk())
}
```

### Generic types

The old way to run generics is using interface and duplicating code   
But now go has Generics as default a example of generics


```go
type code[T any] struct {
	code T
}
```



It is possible to have string type

```go
code1 := code[string]{"123f1"}
fmt.Println(code1)
// It is possible to have int type
code2 := code[int]{123}
fmt.Println(code2)
```

### Using interfaces on functions


```go
anima1 := dog{}
trigger(anima1) // Au!
anima2 := cat{}
trigger(anima2) // Meow!
```

### Type Assert   
> Interfaces are used to create generic code and overcome strictness go types system

> is possible to do this   
`any` is same as `interface{}`   
`any` is a very "dynamic type"


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

It is possible to run type assertion like that...

```go
var newSt any = "Olá, Go!"
```
Or

```go
strVar, ok := newSt.(string)
fmt.Println("valor of check: ", strVar, ok)
```

Peharps go supports any it is mandatory to run a type assert to use values like:

```go
var newSt2 any = "Olá, Go!"
```
it goes wrong because go wants you to **check if** newSt2 is string 😬

```go   
string(newSt2) 🫥   
```

The correct use

```go
strVarToPrint, ok := newSt2.(string)
if ok {
	fmt.Println(string(strVarToPrint) + " another string")
}
```

### Array with any

It is possible to have a array with multi types values 🫠

```go
arr1 := [...]any{1, float32(2), "string", true, false}
fmt.Println(arr1)