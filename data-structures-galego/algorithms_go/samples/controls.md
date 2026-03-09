## Controls

[Study](../notes/STUDY.md) / Controls


```go
returnBool := func() int {
	return 1
}
```

### If init

it is called if init, init a var inside if   
if init

```go
if val := returnBool(); val > 0 {
	fmt.Println("return int", val)
}
```

it is possible to redeclare val

```go
val := 1
fmt.Println("redeclare val: ", val)
```

### switch case:

```go
cond := 1
switch cond {
case 1:
	fmt.Println("hey it is 1")
default:
	fmt.Println("hey it not 1")
}
```

switch change position of condition

```go
switch {
case 1 > 0:
	fmt.Println("yes it is greater : 1 > 0")
case 0 > -1:
	fmt.Println("yes it is greather too : 0 > -1")
```