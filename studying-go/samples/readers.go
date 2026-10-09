package samples

import (
	"fmt"
	"io"
	"strings"
)

// begin
// func, var, const comes here
// end

type ReadersType struct{}

func (e ReadersType) Run() {
	// see for examples rot13_cypher_test.go

	r := strings.NewReader("It will store result from read by 8 bytes part")
	// It will store result from read by 8 bytes part
	store := make([]byte, 8)

	for {
		// n is the amount of bytes readed
		n, error := r.Read(store)

		fmt.Printf("result: %s amount: %v \n", store[:n], n)

		if error == io.EOF {
			break
		}
	}
}
