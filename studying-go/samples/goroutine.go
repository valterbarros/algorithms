package samples

import (
	"fmt"
	"time"
)

type GoroutineType struct{}

func (e GoroutineType) Run() {
	// see walk_tree_test.go for more examples
	// see https://www.youtube.com/watch?v=cmlKLz5S6G4

	// ### Channels usage

	// channel as func very powerfull could be any type string, int etc
	var c = make(chan func())

	// The sender, sending data
	var c2 = make(chan int)
	go func() {
		c2 <- 1
	}()

	// The receiver it blocks the execution
	// ```go <-c2```

	// The go at start is what makes the function run in a separate goroutine

	go func() {
		fmt.Println("inside routine")
		time.Sleep(time.Second * 2)
		// Send new func() to c channel
		c <- func() {
			fmt.Println("inside return fn")
		}
		// Send new another func() to c channel
		// This second send will enqueue in channel buffer
		c <- func() {
			fmt.Println("inside return fn2")
		}
	}()

	// This would block main code until go routine is finished
	// receiving channel
	// Receiving always blocks the execution
	first := <-c
	second := <-c
	first()
	second()

	// ### The time channel

	// it is a channel triggered by time
	boom := time.After(500 * time.Millisecond)
	<-boom
	fmt.Println("boom")

	// ### Buffered vs Unbuferred channels

	// This is a unbuferred channel with 0 buffer size
	// It is only possible to send data though channel one time
	// ```go
	// ch <- 123
	// var c5 = make(chan func())
	// ```

	// this is 2 size buffered channel
	// It is possible to send data the number of buffer in this case 2
	var c6 = make(chan int, 2)
	// send data through channel
	c6 <- 1

	fmt.Println("after c6 no block")

	// ### Close channel

	// It is possible to close the channel manually
	// It is important when the receiver needs to know when its channel is closed
	// or when channel is used on for range
	c3 := make(chan int)

	go func() {
		for i := range 5 {
			c3 <- i
		}

		close(c3)
	}()

	for v := range c3 {
		fmt.Println("value is: ", v)
	}

	_, ok := <-c3
	fmt.Println("is channel open?", ok)

	// ### The select
	c4 := make(chan int)
	select {
	case c4 <- 1:
		fmt.Println("c4")
	}

	// ### Readonly channels and Writeonly channel
	// It is possible to create readonly e writeonly channels

	// Readonly
	// c7 := make(<-chan int)
	// Writeonly
	// c8 := make(chan<- int)
}
