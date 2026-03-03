package samples

import (
	"fmt"
	"time"
)

type GoroutineType struct{}

func (e GoroutineType) Run() {
	// TODO: add examples iterating with for range on channels
	// channels usage
	// channel as func very powerfull could be any type string, int etc
	var c = make(chan func())

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
