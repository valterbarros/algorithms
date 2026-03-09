package samples

import (
	"fmt"
)

// begin

// Creates a interface
type animal interface {
	talk() string
}

// Creates a struct that has same sign from animal interface
type cat struct{}

func (d cat) talk() string {
	return "Meow!"
}

// Creates a dog that has same sign from animal interface
type dog struct{}

func (d dog) talk() string {
	return "Au!"
}

// it is kind of polymorphism
func trigger(t animal) {
	// note that it is not necessary to do type assert since here is garantee that t has talk method
	fmt.Println(t.talk())
}

// end

type InterfacesType struct{}

func (e InterfacesType) Run() {
	// ## Functions

	// [Readme](../README.md) / Interfaces

	// ### Using interfaces on functions

	anima1 := dog{}
	trigger(anima1) // Au!
	anima2 := cat{}
	trigger(anima2) // Meow!

	// ### Generic types

	// ### Type Assert
	// > Interfaces are used to create generic code and overcome strictness go types system

	// > is possible to do this
	// `any` is same as `interface{}`
	// `any` is a very "dynamic type"

	var whatIsType2 any = func() {}
	var a int = 1
	fmt.Println(a)
	// it is a type switch
	switch whatIsType2.(type) {
	case func():
		fmt.Println("is a function")
	case int:
		fmt.Println("is an int")
	case string:
		fmt.Println("is a string")
	default:
		fmt.Println("is not a function")
	}

	// It is possible to run type assertion like that...
	var newSt any = "Olá, Go!"

	// Or
	strVar, ok := newSt.(string)
	fmt.Println("valor of check: ", strVar, ok)

	// Peharps go supports any it is mandatory to run a type assert to use values like:
	var newSt2 any = "Olá, Go!"

	// it goes wrong because go wants you to **check if** newSt2 is string 😬

	// ```go
	// string(newSt2) 🫥
	// ```

	// The correct use
	strVarToPrint, ok := newSt2.(string)
	if ok {
		fmt.Println(string(strVarToPrint) + " another string")
	}

	// ### Array with any

	// It is possible to have a array with multi types values 🫠
	arr1 := [...]any{1, float32(2), "string", true, false}
	fmt.Println(arr1)
}
