// https://leetcode.com/problems/two-sum/description/

package array

import (
	"fmt"
	"testing"
)

func RunTwoSum(nums []int, target int) []int {
	// save each number to a map,
	// and for each new number get the number - target find this result on map
	numsMap := make(map[int]int)

	for idx, num := range nums {
		diff := (target - num)

		n, has := numsMap[diff]
		numsMap[num] = idx

		if has {
			return []int{n, idx}
		}
	}

	return []int{}
}

func TestRunTwoSum(t *testing.T) {
	tests := []struct {
		nums   []int
		target int
		expect []int
	}{
		{[]int{2, 7, 11, 15}, 26, []int{2, 3}},
		{[]int{3, 2, 4}, 6, []int{1, 2}},
		{[]int{3, 3}, 6, []int{0, 1}},
	}

	for _, tt := range tests {
		result := RunTwoSum(tt.nums, tt.target)
		fmt.Println(result)
		// compare each item by item
		if result[0] != tt.expect[0] || result[1] != tt.expect[1] {
			t.Errorf("input: %q, expected, got", result)
		}
	}
}
