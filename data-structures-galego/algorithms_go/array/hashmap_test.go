// https://leetcode.com/problems/first-unique-character-in-a-string/
// Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.

package array

import (
	"fmt"
	"testing"
)

func RunHashMap() int {

	s := "leetcode"
	bytes := []byte(s)

	fmt.Println(bytes[0])

	// copy string to bytes
	// map is not order garantee
	counter := make(map[byte]int)

	for _, ch := range bytes {
		_, has := counter[ch]
		if has == true {
			// if has ch just increment
			counter[ch] = 1
		} else {
			// else set new array
			counter[ch] += 1
		}
	}

	fmt.Println(counter)

	minorIdx := -1

	for i := 0; i < len(s); i++ {
		fmt.Println(counter[s[i]])
	}

	// TODO: set string order by original string

	return minorIdx
}

func TestHashMap(t *testing.T) {
	result := RunHashMap()
	if result != -1 {
		t.Errorf("expected -1, got %v", result)
	}
}
