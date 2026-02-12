package samples

import "fmt"

type FunctionsType struct{}

func (ff FunctionsType) Run() {
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

	// Go has shurtcut?

	shurt := func() bool {
		fmt.Println("shurt")

		return true
	}

	// is not possible to run condition shurt() && true
	if val := shurt(); val {
		fmt.Println(val)
	}

	// a := range[]int{1,2,3}
}
