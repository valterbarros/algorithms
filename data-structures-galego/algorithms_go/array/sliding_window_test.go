// https://leetcode.com/problems/maximum-length-substring-with-two-occurrences/description/
package array

import (
	"fmt"
	"testing"
)

// 3090. Maximum Length Substring With Two Occurrences
func RunSlidingWindow() {
	str := "bcbbbcba"
	right := 0
	left := 0
	counter := make(map[byte]int)
	counter[str[0]] = 1
	_max := 1

	for right < len(str)-1 {
		right += 1

		fmt.Println(str[right], right)

		if counter[str[right]] < 1 {
			counter[str[right]] = 1
		} else {
			counter[str[right]] += 1
		}

		for counter[str[right]] == 3 {
			counter[str[left]] -= 1
			left += 1
		}

		_max = max(_max, right-left+1)
	}

	fmt.Println(counter, _max)
}

func TestSlidingWindow(t *testing.T) {
	RunSlidingWindow()
}
