## Variables

[Study](../notes/STUDY.md) / Variables 

### Declaring Vars

Type variable1 int   
Can be declared like this

```go
var (
	variable1 string
	variable2 string
)
```

Or like this

```go
var variable3 string
```
Custom type

```go
type newType string
```
Const constant

```go
const (
	constType newType = "const type"
)
```



And using inference `:=`   
Inference only works inside functions

```go
variable4 := "valter"
```
Custom type

```go
var variable5 newType
var variable6 newType = "typed valter"
// even though variable5 is of type newType/string it cant be assigned to string
variable5 = variable6
// or constType because is newType too
variable5 = constType
```

Assignment

```go
variable1 = "valter"
variable2 = "junior"
variable3 = "developer"
fmt.Println(variable1, variable2, variable3, variable4, variable5, variable6)
```

### Swap values

Is possible to swap variables value   
Valter junior -> junior valter

```go
variable1, variable2 = variable2, variable1
fmt.Println("after swap: ", variable1, variable2)