package utils

import (
	"fmt"
)

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
