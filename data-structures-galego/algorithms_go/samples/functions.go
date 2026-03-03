package samples

import "fmt"

type FunctionsType struct{}

func (ff FunctionsType) Run() {
	// defer is used to run that as last function
	defer func() {
		fmt.Println("\ndefer fn, use it to clear data")
	}()

	// functions are first class citizens in go
	// and can be used just like any other var

	var f = func(text string) string {
		return text
	}

	fmt.Println(f("Hey Jude!"))

	// function can have multi returns
	locale := func() (string, string) {
		return "!Ola! Cabron!", "Hello man"
	}

	esMx, ptBR := locale()

	fmt.Println(esMx, ptBR)

	// Go has shurtcut? yes

	shurt := func() bool {
		fmt.Println("shurt")

		return true
	}

	if true && shurt() {
		fmt.Println("shurtcut")
	}

	// a := range[]int{1,2,3}

	// It is possible to create function with named return

	named := func(n1, n2 int) (sum int, sub int) {
		sum = n1 + n2
		sub = n1 - n2

		// note for return with no clause
		return
	}

	sum, sub := named(1, 2)

	fmt.Println("sum and sub: ", sum, sub)

	// It is possible to pass n parameters

	parameters := func(nums ...int) {
		for _, n := range nums {
			fmt.Printf("nums: %d ", n)
		}
	}

	parameters(1, 2, 3)

	// it is possible to call that with array
	parameters([]int{3, 2, 1}...)

}
