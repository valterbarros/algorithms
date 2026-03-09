// https://gobyexample.com/structs

package samples

import "fmt"

// begin
// ### Creating structs
type person struct {
	age int
}

// inherit?
type student struct {
	person
}

// creates struct
type Recurrence struct {
	name string
}

type Recurrences []struct {
	name string
}

// ### Adding methods to struct

// (r Recurrence) is Receiver and this function can be called struct embeded too
func (r Recurrence) GetName() string {
	return r.name
}

// using * alter the original r variable
func (r *Recurrence) SetName(name string) {
	fmt.Println("hey jude", r)
	r.name = name
}

// ### Private method
// is private when first char is lowercase
func (r Recurrence) privateProp() string {
	return "prop"
}

// end

type StructsType struct{}

func (s StructsType) Run() {
	// ## Structs

	// [Study](../notes/STUDY.md) / Structs

	// ### Inherit in structs

	// inherit?!
	stud := student{person{20}}
	// Actually age is inside person, but it is possible to acess direct on student as it "inherit" it
	fmt.Println("age of student: ", stud.age)

	// ### Using structs

	// creating new struct
	r := Recurrence{name: "valter 123"}
	fmt.Println(r.GetName())

	// Set
	r.SetName("valter 2")

	fmt.Println("change original name: ", r.GetName() == "valter 2")

	// An especime of shurtcut to create many items in single interaction
	rs := Recurrences{
		{name: "valter"},
		{name: "jessica"},
		{name: "other"},
	}
	fmt.Println(rs)
}
