package samples

import (
	"fmt"
)

type ControlsType struct{}

func (e ControlsType) Run() {
	// ## Controls

	// [Readme](../README.md) / Controls

	returnBool := func() int {
		return 1
	}

	// ### If init

	// it is called if init, init a var inside if
	// if init
	if val := returnBool(); val > 0 {
		fmt.Println("return int", val)
	}

	// it is possible to redeclare val
	val := 1
	fmt.Println("redeclare val: ", val)

	// ### switch case:
	cond := 1
	switch cond {
	case 1:
		fmt.Println("hey it is 1")
	default:
		fmt.Println("hey it not 1")
	}

	// switch change position of condition
	switch {
	case 1 > 0:
		fmt.Println("yes it is greater : 1 > 0")
	case 0 > -1:
		fmt.Println("yes it is greather too : 0 > -1")
	}
}
