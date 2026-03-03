#### Structs

```go
type person struct {
    age int
}
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

is private when first char is lowercase

```go
func (r Recurrence) privateProp() string {
    return "prop"
}
```

inherit?! in next example it is possible to access, student.age or person.student.age

```go
stud := student{person{20}}
// Actually age is inside person, but it is possible to acess direct on student as it "inherit" it
fmt.Println("age of student: ", stud.age)
```

creating new struct

```go
r := Recurrence{name: "valter 123"}
fmt.Println(r.GetName())
```
SetName and check change

```go
r.SetName("valter 2")
fmt.Println("change original name: ", r.GetName() == "valter 2")
```
