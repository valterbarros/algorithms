import '../linked-list/utils.dart';

int elementOrNegative(List<int> arr, int index) {
  return index < 0 || arr.elementAtOrNull(index) == null ? -99999999 : arr[index];
}

/**
 * merge two lists putting the greater numbers to the end of array close to array.length
 * create a new list to append order numbers
 * return the new list merged
 * */
merge(List<int> left, List<int> right) {
  var l = 0;
  var r = 0;

  List<int> aux = [];

  /*
   * iterate over array until one of the l o r being greater or equal than array size
   * That while condition is saying I'm true until one both of the index being less than length
   * return from less to bigger
   */
  while (l < left.length && r < right.length) {
    if (elementOrNegative(left, l) < elementOrNegative(right, r)) {
      aux.add(left[l]);
      l++;
    } else {
      aux.add(right[r]);

      r++;
    } 
  }
  
  var merged = [
    ...aux,
    // Since the while is checking until both of index is less
    // than length one of the range will always be empty left or right
    // It is very important to keep the order of merged list
    ...right.getRange(r, right.length),
    ...left.getRange(l, left.length),
  ];
  
  return merged;
}

/*
* 1. check if arr has length > 1
* 2. get mid array number
* 3. sort left part recursively
* 4. sort right part recursively
* 5. merge();
* return merge with sorted and merged list
*/
mergeTwoLists(List<int> arr) {
  if (arr.length < 2) return arr;

  var mid = arr.length ~/ 2;

  var rangeRight = arr.getRange(mid, arr.length).toList();
  var rangeLeft = arr.getRange(0, mid).toList();

  var left = mergeTwoLists(rangeLeft);
  var right = mergeTwoLists(rangeRight);

  return merge(left, right);
}

main() {
  // var arr = [4,2,1,3];
  var arr = [0, 20,4,2,0,1,3,4,10,31,4];
  // var arr = randomList();

  Stopwatch stopwatch = Stopwatch()..start();
  var list = mergeTwoLists(arr);
  print('final: $list');
  stopwatch.stop();
  // 
  // 69 ms 100k items
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}
