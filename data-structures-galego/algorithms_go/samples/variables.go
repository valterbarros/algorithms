package samples

import "fmt"

// type variable1 int

// can be declared like this
var (
	variable1 string
	variable2 string
)

// or like this
var variable3 string

type newType string

const (
	constType newType = "const type"
)

type VariablesType struct{}

func (v VariablesType) Run() {
	// and using inference :=
	// inference only works inside functions
	variable4 := "valter"

	// custom type
	var variable5 newType
	var variable6 newType = "typed valter"
	// even though variable5 is of type newType/string it cant be assigned to string
	variable5 = variable6
	// or constType because is newType too
	variable5 = constType

	variable1 = "valter"
	variable2 = "junior"
	variable3 = "developer"

	fmt.Println(variable1, variable2, variable3, variable4, variable5, variable6)

	// is possible to swap variables value
	// valter junior -> junior valter
	variable1, variable2 = variable2, variable1

	fmt.Println("after swap: ", variable1, variable2)
}
