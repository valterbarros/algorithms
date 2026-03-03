#### Functions

defer is used to run that as last function

```go
defer func() {
	fmt.Println("\ndefer fn, use it to clear data")
}()
```

functions are first class citizens in go
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