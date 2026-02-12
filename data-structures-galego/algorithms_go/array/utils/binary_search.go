package utils

import (
	"fmt"
)

// first letter of the name of the function is capitalized, so it can be used outside of this package
func RunBinarySearch(val int, items []int, low int, high int) {
	var mid int
	for low < high {
		mid = (low + high) / 2
		if items[mid] == val {
			fmt.Println("found RunBinarySearch", mid)
			return
		} else if items[mid] < val {
			low = mid + 1
		} else {
			high = mid
		}
	}
}
