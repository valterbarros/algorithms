// Recursive binary search
// find base case
// sub divide the problem in sub problems until the end
import 'algorithms/linked-list/utils.dart';

bsearch(List<int> arr, int search, int low, int high) {
  if (low > high) return -1;

  var mid = (low + high) ~/ 2;

  var item = arr[mid];

  if (item == search) return mid;

  if (item < search) {
    return bsearch(arr, search, mid + 1, high);
  } else {
    return bsearch(arr, search, low, mid - 1);
  }
}

main() {
  var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  var val = bsearch(arr, 1, 0, arr.length - 1);
  print(val);
  var val2 = bsearch(arr, -1, 0, arr.length - 1);
  print(val2);

  var arr3 = randomList();
  var val3 = bsearch(arr3, -1, 0, arr3.length - 1);
  print(val3);
}
