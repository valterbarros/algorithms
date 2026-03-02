// https://gobyexample.com/pointers

package samples

import "fmt"

// passing var as pointer, it is a pointer for a int
func TestPointer(v *int) {
	fmt.Println("value of *int is: ", v)
}

type PointersType struct{}

func (p PointersType) Run() {
	variable1 := 1
	// that holds memory address for v1
	pointer1 := &variable1
	TestPointer(pointer1)

	// to get the original value from pointer it could be possible using dereference
	fmt.Println("original value: ", *pointer1)

	// The *r1 code in the function body then dereferences the pointer from its memory address to the current value at that address
	// basically with that is possible to change the original value
	*pointer1 = 2

	fmt.Println("should change original var: ", variable1 == 2)

	// Create a map key string and value is pointer of int
	strMap := make(map[string]*int)
	integ := 1
	strMap["string"] = &integ
}
