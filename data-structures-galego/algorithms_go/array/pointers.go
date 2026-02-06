package array

import "fmt"

// passing var as pointer, it is a pointer for a int
func TestPointer(v *int) {
	fmt.Println("value of *int is: ", v)
}

func RunPointers() {
	v1 := 1
	// that holds memory address for v1
	r1 := &v1
	TestPointer(r1)

	// The *r1 code in the function body then dereferences the pointer from its memory address to the current value at that address
	// basically with that is possible to change the original value
	*r1 = 2

	fmt.Println("should change original var: ", v1 == 2)
}
