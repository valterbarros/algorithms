num bserch(List<num> arr, num n) {
  var l = 0;
  var r = arr.length;
  
  while(l < r) {
    var mid = (l+r)~/2;
    
    if (arr[mid] == n) return mid;
    else if(arr[mid] < n) {
      l = mid + 1;
    } else {
      r = mid;
    }

    print(mid);
  }
  
  return -1;
}

void main(List<String> args) {
  // num = 10;

  var value = bserch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 1);
  print(value);
}
