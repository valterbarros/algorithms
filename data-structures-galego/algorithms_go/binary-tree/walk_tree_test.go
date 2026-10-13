package playground

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
	"golang.org/x/tour/tree"
)

// Walk walks the tree t sending all values
// from the tree to the channel ch.
func Walk(t *tree.Tree, ch chan int) {
	if t == nil {
		return
	}

	Walk(t.Left, ch)

	// Thanks to channel the walk can be consumed in lazy way similar to Iterator
	// This works very well if the tree is infinity
	ch <- t.Value

	Walk(t.Right, ch)
}

// Same determines whether the trees
// t1 and t2 contain the same values.
func Same(t1, t2 *tree.Tree) bool {
	ch1 := make(chan int)
	ch2 := make(chan int)

	go func() {
		Walk(t1, ch1)
		close(ch1)
	}()
	go func() {
		Walk(t2, ch2)
		close(ch2)
	}()

	for {
		val1, ok1 := <-ch1
		val2, ok2 := <-ch2

		// If both closed at same time the trees are equal
		if !ok1 && !ok2 {
			return true
		}

		fmt.Println("Same val: ", val1, val2)

		// This is util when user send tree with different size
		if val1 != val2 || ok1 != ok2 {
			return false
		}
	}
}

func TestWalkTree(t *testing.T) {
	ch := make(chan int)
	tr := tree.New(1)
	go func() {
		Walk(tr, ch)
		close(ch)
	}()

	for val := range ch {
		fmt.Println("val: ", val)
	}

	s := Same(tree.New(1), tree.New(2))

	fmt.Println("The tree are equal?", s)

	t.Run("Should verify if both tree are equals", func(t *testing.T) {
		assert.Equal(t, true, Same(tree.New(1), tree.New(1)),
			"(%q) devem ser iguais")
		assert.Equal(t, false, Same(tree.New(1), tree.New(2)),
			"(%q) devem ser iguais")
	})
}
