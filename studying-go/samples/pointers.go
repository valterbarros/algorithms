// https://gobyexample.com/pointers

package samples

import "fmt"

type PointersType struct{}

func (p PointersType) Run() {
	// ### Working with pointers

	// passing var as pointer, it is a pointer for a int
	TestPointer := func(v *int) {
		*v = *v + 1
		fmt.Println("value of *int is: ", v)
	}

	// The `pointer1` holds memory address for v1
	// that holds memory address for v1
	variable1 := 1
	pointer1 := &variable1
	TestPointer(pointer1)
	fmt.Println("change value: ", variable1) // it returns 2 because TestPointer changed it

	// to get the original value from pointer it could be possible using dereference
	fmt.Println("original value: ", *pointer1)

	// The *r1 code in the function body then dereferences the pointer from its memory address to the current value at that address
	// basically with that is possible to change the original value
	*pointer1 = 2
	fmt.Println("should change original var: ", variable1 == 2)

	// ### Pointer as map value

	// Create a map key string and value is pointer of int
	strMap := make(map[string]*int)
	integ := 1
	strMap["string"] = &integ
}
