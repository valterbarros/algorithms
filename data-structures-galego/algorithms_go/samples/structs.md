## Structs

[Study](../notes/STUDY.md) / Structs    
### Creating structs

```go
type person struct {
	age int
}
```

inherit?

```go
type student struct {
	person
}
```

creates struct

```go
type Recurrence struct {
	name string
}
```


```go
type Recurrences []struct {
	name string
}
```

### Adding methods to struct

(r Recurrence) is Receiver and this function can be called struct embeded too

```go
func (r Recurrence) GetName() string {
	return r.name
}
```

using * alter the original r variable

```go
func (r *Recurrence) SetName(name string) {
	fmt.Println("hey jude", r)
	r.name = name
}
```

### Private method   
is private when first char is lowercase

```go
func (r Recurrence) privateProp() string {
	return "prop"
}
```



### Inherit in structs

inherit?!

```go
stud := student{person{20}}
// Actually age is inside person, but it is possible to acess direct on student as it "inherit" it
fmt.Println("age of student: ", stud.age)
```

### Using structs

creating new struct

```go
r := Recurrence{name: "valter 123"}
fmt.Println(r.GetName())
```

Set

```go
r.SetName("valter 2")
```

```go
fmt.Println("change original name: ", r.GetName() == "valter 2")
```
An especime of shurtcut to create many items in single interaction

```go
rs := Recurrences{
	{name: "valter"},
	{name: "jessica"},
	{name: "other"},
}
fmt.Println(rs)