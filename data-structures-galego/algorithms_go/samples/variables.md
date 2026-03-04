## Variables

[Study](../notes/STUDY.md) / Variables

### Declaring Vars

type variable1 int

can be declared like this

```go
var (
    variable1 string
    variable2 string
)
```

or like this

```go
var variable3 string
```

custom type

```go
type newType string
```

const

```go
const (
    constType newType = "const type"
)
```

and using inference :=
inference only works inside functions

```go
variable4 := "valter"
```

custom type

```go
var variable5 newType
var variable6 newType = "typed valter"
// even though variable5 is of type newType/string it cant be assigned to string
variable5 = variable6
// or constType because is newType too
variable5 = constType
```

assignment

```go
variable1 = "valter"
variable2 = "junior"
variable3 = "developer"
fmt.Println(variable1, variable2, variable3, variable4, variable5, variable6)
```

### Swap values

is possible to swap variables value
valter junior -> junior valter

```go
variable1, variable2 = variable2, variable1
fmt.Println("after swap: ", variable1, variable2)
```
