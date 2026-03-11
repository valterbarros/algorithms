// https://gobyexample.com/enums
package samples

import "fmt"

// begin
// ### Set direct value
const (
	Pending    = "pending"
	Ready      = "ready"
	InProgress = "in_progress"
)

// use a type to set enums
type ServerState int

// Methods on int type \o/
// It is possible to create a String() method to return the string
// It is like toString in other languages
func (ss ServerState) String() string {
	if ss == 0 {
		return "idle"
	}
	if ss == 1 {
		return "connected"
	}
	return "other"
}

const (
	StateIddle ServerState = iota
	StateConnected
)

//end

type EnumsType struct{}

func (e EnumsType) Run() {
	// usage
	fmt.Println("untyped: ", Pending, Ready, InProgress)
	// StateIddle, StateConnected invoke the String() method
	fmt.Println("ServerState: ", StateIddle, StateConnected)

	fmt.Println("ServerState String: ", StateIddle.String())
}
