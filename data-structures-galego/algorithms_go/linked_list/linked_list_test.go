package linkedlist

import (
	"fmt"
	"testing"
)

// Linked list
// methods
// append
// pop
// tail
// head
// size

type Node struct {
	next  *Node
	value int
}

func linkedList() {
	head := Node{nil, 0}
	head.next = &Node{nil, 1}
	tail := head.next

	fmt.Println(head.value)
	fmt.Println(head.next.value)
	fmt.Println(tail.value)
}

func TestLinkedList(t *testing.T) {
	// fmt.Println("test")

	linkedList()

	if false {
		t.Errorf("error")
	}
}
