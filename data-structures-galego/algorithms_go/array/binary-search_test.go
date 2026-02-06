package array

import (
	utils "algorithms_go/array/utils"
	"testing"
)

// create to call with default params
func RunBinarySearchMain() {
	items := []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
	utils.RunBinarySearch(4, items, 0, len(items))
}

func TestBinarySearch(t *testing.T) {
	RunBinarySearchMain()
}
