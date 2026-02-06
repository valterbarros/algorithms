// https://leetcode.com/problems/reverse-words-in-a-string-iii/description/

package array

import (
	"fmt"
	"testing"
)

func init() {
	fmt.Println("init function called")
}

func reverse(b []byte, left int, right int) {
	for left < right {
		// swap of bytes
		b[left], b[right] = b[right], b[left]
		left++
		right--
	}
}

func RunTwoPointers(s string) string {
	left := 0
	right := 0
	// in go string is a sequence of bytes, in that way is note possible to acess [0] [1] of a string
	// exist too a difference between strings and runes
	// A more deep detail is that it is not called a cast it is called a convertion and the value is copied from string to bytes
	// original string keeps intact
	bytes := []byte(s)

	// here the simple quote represents the rune or byte(uint8)
	fmt.Println(bytes[0] == ' ')

	// while like
	for right < len(s) {
		if bytes[right] == ' ' {
			reverse(bytes, left, right-1)

			left = right + 1
		}

		right += 1
	}

	reverse(bytes, left, right-1)

	fmt.Println("Hello", string(bytes))

	return string(bytes)
}

func TestReverse(t *testing.T) {
	input := "valter jessica"
	expected := "retlav acissej"
	result := RunTwoPointers(input)

	if result != expected {
		t.Errorf("esperado %v, obteve %v", expected, result)
	}
}
