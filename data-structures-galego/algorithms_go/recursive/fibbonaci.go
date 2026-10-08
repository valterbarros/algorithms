package recursive

import "fmt"

// In mathematics, the Fibonacci sequence is a sequence in which each element is the sum of the two elements that precede it.
func fib(n int) int {
	if n <= 1 {
		return 1
	}

	return fib(n-1) + fib(n-2)
}

// fibonacci is a function that returns
// a function that returns an int.
func fibonacci() func(n int) int {
	return fib
}

func main() {
	f := fibonacci()
	for i := 0; i < 10; i++ {
		fmt.Println(f(i))
	}
}
