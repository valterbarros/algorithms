package samples

import (
	"errors"
	"fmt"
	"reflect"
)

type TypesType struct{}

// begin
type FuncType func()

// It is possible to add method a to func type?!
func (f FuncType) callFn() {
	f()
}

type IntType int

type anyStruct struct {
	param any
}

// Add method to int type
func (i IntType) getInt() {
	fmt.Println("selected type: ", i)
}

// end

func (t TypesType) Run() {
	// ## Types

	// [Readme](../README.md) / Types

	// ### Methods on types

	var fnType FuncType
	fnType = func() {
		fmt.Println("inside FuncType")
	}
	// More advance example a function type call a method of that method
	fnType.callFn()

	// method on int
	var intType IntType
	intType = 1
	intType.getInt()

	// ### Int types

	// > there is some types for int and float
	// basically int: int, int8, int16, int32, int64
	// go get type by inference and set int, that is based on processor architecture
	// go get type by inference and set int, that is based on processor architecture
	num := 1
	fmt.Println("infer int type: ", reflect.TypeOf(num))

	// It is not possible to make operations with differents types like int8 + int1
	// var byt int8 = 1
	// var byt2 int16 = 2
	// X Error
	// ```go
	// byt+byt2
	// ````

	// X error:
	// ```go
	// var variable uint = -1
	// ```

	// > rune is alias for int32
	// byte is an alias for uint8

	// returns int
	fmt.Println(reflect.TypeOf(num))

	// ### Other types

	// for float there is just
	// float32 and float64

	num2 := 2.0
	// returns float64
	fmt.Println(reflect.TypeOf(num2))

	// type boolean
	isOk := true
	fmt.Println(isOk)

	// type error
	var erro error = errors.New("panic internal error")
	fmt.Println(erro)

	// function type
	// this is anonymous function
	whatIsType := func() {}
	fmt.Println(reflect.TypeOf(whatIsType))
}
