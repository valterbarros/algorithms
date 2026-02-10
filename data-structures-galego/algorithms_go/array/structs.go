package array

import "fmt"

// creates struct
type Recurrence struct {
	name string
}

type Recurrences []struct {
	name string
}

// (r Recurrence) is Receiver and this function can be called struct embeded too
func (r Recurrence) GetName() string {
	return r.name
}

// using * alter the original r variable
func (r *Recurrence) SetName(name string) {
	fmt.Println("hey jude", r)
	r.name = name
}

func (r Recurrence) privateProp() string {
	return "prop"
}

func RunStructs() {
	// creating new struct
	r := Recurrence{name: "valter 123"}

	fmt.Println(r.GetName())

	// _, ok := r.(Recurrence)
	// fmt.Println("is of type Recurrence: ", ok)

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
