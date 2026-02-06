package array

import (
	utils "data-structures/algorithms_go/array/utils"
	"fmt"
	"testing"
)

// a exponential search uses binary search
// and basically double the search for each try
func RunExponentialSearch() int {
	fmt.Println("start")
	target := 16
	items := []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

	if items[0] == target {
		return 0
	}

	total := len(items)
	i := 1

	for i < total && items[i] < target {
		i *= 2
	}

	// min is used in case of i overflow the array length
	safeRight := min(i, total-1)

	if items[safeRight] == target {
		fmt.Println("found in exponential")
		return i
	}

	// send only the windows, that optmizes the search for some cases
	utils.RunBinarySearch(target, items, i/2, safeRight)

	return 0
}

func TestExponentialSearch(t *testing.T) {
	RunExponentialSearch()
}
