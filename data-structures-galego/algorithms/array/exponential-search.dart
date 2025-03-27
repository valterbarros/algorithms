import 'dart:math';

// lo = 2
// hi = 4
// mid = 3
// resultado = 4
int binarySearch(List<int> arr, int n, int lo, int hi) {
  // var lo = 0;
  // var hi = arr.length;

  while (lo < hi) {
    var mid = (lo+hi)~/2;
    print("${lo} : ${hi} : ${mid}");

    if (arr[mid] == n) return mid;
    else if(arr[mid] < n) {
      lo = mid + 1;
    } else {
      hi = mid;
    }
  }
  
  return -1;
}

exponentialSearch(List<int> arr, int target) {
  if (arr[0] == target) return 0;
  
  var n = arr.length;
  var i = 1;
  
  while (i < n && arr[i] < target) {
    i*=2;
  }
  
  if (arr.contains(i) && arr[i] == target) return i;
  
  return binarySearch(arr, target, i~/2, min(i, n-1));
}

void main(List<String> args) {
  var value = exponentialSearch([1,2,3,4,5,6,7,8,9,10,11,12], 12);
  // print(value);
}
