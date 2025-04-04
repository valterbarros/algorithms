// https://www.w3schools.com/dsa/dsa_algo_insertionsort.php
import '../linked-list/utils.dart';

insertionSort(List<int> arr) {
  for(var i = 1; i < arr.length; i++) {
    var curr = arr[i];
    var last = null;

    for(var j = i - 1; j >= 0; j--) {
      if (arr[j] > curr) {
        // Since the for is in decremental mode we need to get the last element
        swap(arr, j, last ?? i);
        last = j;
      } else {
        // Break because is no more necessary since the number is less
        break;
      }
    }
  }

  print(arr);
}

main() {
  // var arr = [3,1,2,5,6,7];
  // var arr = [7, 12, 9, 11, 3];
  var arr = [5,2,3,0,0,1,6,8,1,4];
  // var arr = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
  // var arr = [7, 12, 9, 11, 3];
  // var arr = randomList();

  Stopwatch stopwatch = Stopwatch()..start();
  insertionSort(arr);
  stopwatch.stop();

  // 8378 ms 100k items
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}
