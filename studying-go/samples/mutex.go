package samples

import (
	"fmt"
	"sync"
	"time"
)

// begin
type SafeCounter struct {
	mu     sync.Mutex
	mapper map[string]int
}

// It is required to pass as * because lock
func (s *SafeCounter) increment(key string) {
	// This function is locked after next instruction
	// if another call to incremented is made it don't continue
	// The door is closed
	s.mu.Lock()
	// The lock is not related with mapper
	s.mapper[key]++
	// Unlock function here
	// The door has opened
	s.mu.Unlock()
}

//end

type MutexType struct{}

func (e MutexType) Run() {
	sf := SafeCounter{mapper: map[string]int{}}
	// run this file as to get data race warnings: go run -race ../main.go
	for range 100 {
		go func() {
			time.Sleep(time.Second)
			fmt.Println("increment without lock", sf.mapper["key"])
		}()
	}
	for range 1000 {
		go sf.increment("key")
	}

	time.Sleep(time.Second)

	fmt.Println("key incremented: ", sf.mapper["key"])
}
