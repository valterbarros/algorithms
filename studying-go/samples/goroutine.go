package samples

import (
	"fmt"
	"time"
)

type GoroutineType struct{}

func (e GoroutineType) Run() {
	// ## Goroutine

	// [Readme](../README.md) / Goroutine

	// TODO: add examples iterating with for range on channels
	// ### Channels usage

	// channel as func very powerfull could be any type string, int etc
	var c = make(chan func())

	// It is possible to pass buffer size to channel

	// ```go
	// var c = make(chan func(), 1)
	// ```

	// The go at start is what makes the function run in a separate goroutine

	go func() {
		fmt.Println("inside routine")
		time.Sleep(time.Second * 2)
		c <- func() {
			fmt.Println("inside return fn")
		}
	}()

	// This would block main code until go routine is finished
	// receiving channel
	back := <-c
	back()
}
