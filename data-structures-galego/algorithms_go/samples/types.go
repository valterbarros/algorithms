package samples

import (
	"errors"
	"fmt"
	"reflect"
)

type TypesType struct{}

func (t TypesType) Run() {
	// there is some types for int and float
	// basically int: int, int8, int16, int32, int64
	// go get type by inference and set int, that is based on processor architecture

	num := 1

	// It is not possible to make operations with differents types like int8 + int16
	// var byt int8 = 1
	// var byt2 int16 = 2

	// X Error
	// byt+byt2

	// uint unssined int
	// X error:
	// var variable uint = -1;

	// rune is alias for int32
	// byte is an alias for uint8

	// returns int
	fmt.Println(reflect.TypeOf(num))

	// for float there is just
	// float32 and float64

	// go get type by inference and set int, that is based on processor architecture
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

	// is possible to do this
	// var f func()
}
