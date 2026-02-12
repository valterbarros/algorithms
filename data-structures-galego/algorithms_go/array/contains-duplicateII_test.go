// https://leetcode.com/problems/contains-duplicate-ii/description/?envType=problem-list-v2&envId=sliding-window
package array

import (
	"testing"
)

func containsNearbyDuplicate(nums []int, k int) bool {
	registry := make(map[int]int)
	for idx, num := range nums {
		if lastIdx, found := registry[num]; found {
			if idx-lastIdx <= k {
				return true
			}
		}
		registry[num] = idx
	}

	return false
}

func TestContains(t *testing.T) {
	tests := []struct {
		input    []int
		value    int
		expected bool
	}{
		{input: []int{1, 2, 3, 1}, value: 3.0, expected: true},
		{input: []int{1, 0, 1, 1}, value: 1.0, expected: true},
		{input: []int{1, 2, 3, 1, 2, 3}, value: 2.0, expected: false},
	}

	for _, tt := range tests {
		result := containsNearbyDuplicate(tt.input, tt.value)
		if result != tt.expected {
			t.Errorf("The result should be: %v, but got: %v", tt.expected, result)
		}
	}
}
