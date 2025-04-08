import '../linked-list/utils.dart';

int elementOrNegative(List<int> arr, int index) {
  return index < 0 || arr.elementAtOrNull(index) == null ? -99999999 : arr[index];
}

var ms = 0;

merge(List<int> left, List<int> right) {
  /**
   * merge two lists putting the greater numbers to the end of array close to array.length
   * create a new list to append order numbers
   * return the new list merged
   * */
  
  var l = left.length - 1;
  var r = right.length - 1;

  var len = (left.length) + (right.length);
  List<int> aux = List.generate(len, (_) => 0);
  // List<int> aux = [];

  // convert to 0 indexed collection index
  len--;

  /*
   * iterate over array from last to begin and decrement -- each execution
   * if one of the lists had not been checked add that to aux list sync both index l and r
   * return from less to bigger
   */
  while (l >= 0 || r >= 0) {
    if (elementOrNegative(left, l) >= elementOrNegative(right, r)) {
      aux[len] = left[l];
      l--;
    } else {
      aux[len] = right[r];

      r--;
    }
    
    // fill array from back to front
    len--;
  }
  
  return aux;
}

mergeTwoLists(List<int> arr) {
  /*
  * 1. check if arr has length > 1
  * 2. get mid array number
  * 3. sort left part recursively
  * 4. sort right part recursively
  * 5. merge();
  * return merge with sorted and merged list
  */
  
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
  // 44 ms 100k items
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}
