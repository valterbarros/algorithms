// https://gobyexample.com/enums
package samples

import "fmt"

// set direct value
const (
	Pending    = "pending"
	Ready      = "ready"
	InProgress = "in_progress"
)

// use a type to set enums
type ServerState int

// Methods on int type \o/
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

func RunEnums() {
	fmt.Println("untyped: ", Pending, Ready, InProgress)
	fmt.Println("ServerState: ", StateIddle, StateConnected)

	fmt.Println("ServerState String: ", StateIddle.String())
}
