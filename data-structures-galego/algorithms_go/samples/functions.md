#### Functions

defer is used to run that as last function, that is executed before a return from function

```go
func testingDefer() int {
	// defer is used to run that as last function
	defer func() {
		fmt.Println("\ndefer fn, use it to clear data")
	}()

	return 1
}

fmt.Println("Testing return: ", testingDefer())

```

output:

```
// defer fn, use it to clear data
// Testing return:  1
```

Functions are first class citizens in go
and can be used just like any other var

```go
var f = func(text string) string {
	return text
}

fmt.Println(f("Hey Jude!"))
```

function can have multi returns

```go
locale := func() (string, string) {
	return "!Ola! Cabron!", "Hello man"
}

esMx, ptBR := locale()
fmt.Println(esMx, ptBR)
```

Go has shurtcut? yes

```go
shurt := func() bool {
	fmt.Println("shurt")

	return true
}

if true && shurt() {
	fmt.Println("shurtcut")
}
```

It is possible to create function with named return

```go
named := func(n1, n2 int) (sum int, sub int) {
	sum = n1 + n2
	sub = n1 - n2

	// note for return with no clause
	return
}

sum, sub := named(1, 2)

fmt.Println("sum and sub: ", sum, sub)
```

It is possible to pass n parameters to a function variadic

```go
parameters := func(nums ...int) {
	for _, n := range nums {
		fmt.Printf("nums: %d ", n)
	}
}

parameters(1, 2, 3)
```

it is possible to call that with array

```go
parameters([]int{3, 2, 1}...)
```

Panic and recover, in some manner it is similar to try...catch, defer + recover is basically a catch

It will cause a panic

> To force a panic we can call `panic("error here")`

```go
func funcWillPanic() int {
	defer recoverFunc()

	// trying to acess a index out of bound = panic
	return []int{1, 2, 3}[50]
}
```

The r variable from recover will return the error

```go
func recoverFunc() {
	if r := recover(); r != nil {
		fmt.Println("\n\napp was recovered from recoverFunc", r)
	}
}
```

not Panic because the recover inside defer fn

```go
funcWillPanic()
```
