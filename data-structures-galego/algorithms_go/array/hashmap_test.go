// https://leetcode.com/problems/first-unique-character-in-a-string/
// Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.

package array

import (
	"testing"
)

func RunHashMap(s string) int {
	// map is not order garanteed
	// It is better for performance to use a array
	// here but as file is about hashmap then I used hashmap
	counter := make(map[rune]int)

	for _, ch := range s {
		_, has := counter[ch]
		if has == true {
			// if has ch just increment
			counter[ch] += 1
		} else {
			// else set 1
			counter[ch] = 1
		}
	}

	// as map is not order garantee, I used the order from original string
	for i := 0; i < len(s); i++ {
		if counter[rune(s[i])] == 1 {
			return i
		}
	}

	return -1
}

func TestHashMap(t *testing.T) {
	tests := []struct {
		input    string
		expected int
	}{
		{"leetcode", 0},
		{"loveleetcode", 2},
		{"aabb", -1},
		{"abcabc", -1},
		{"z", 0},
	}

	for _, tt := range tests {
		result := RunHashMap(tt.input)
		if result != tt.expected {
			t.Errorf("input: %q, expected %d, got %d", tt.input, tt.expected, result)
		}
	}
}
