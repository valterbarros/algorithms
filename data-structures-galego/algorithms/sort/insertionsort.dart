// https://www.w3schools.com/dsa/dsa_algo_insertionsort.php
import '../linked-list/utils.dart';

void insertionSort(List<int> arr) {
  for (int i = 1; i < arr.length; i++) {
    int curr = arr[i];
    int last = i - 1;

    // Shift larger elements to the right
    while (last >= 0 && arr[last] > curr) {
      // Since the for is in decremental mode we need to get the last element
      arr[last + 1] = arr[last];
      last--;
    }
    
    // Place the current element at its correct position
    // Plus 1 because the last while decrement
    arr[last + 1] = curr;
  }

  print(arr);
}

main() {
  // var arr = [3,1,2,5,6,7];
  var arr = [7, 12, 9, 11, 3];
  // var arr = [5,2,3,0,0,1,6,8,1,4];
  // var arr = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
  // var arr = [7, 12, 9, 11, 3];
  // var arr = randomList();

  Stopwatch stopwatch = Stopwatch()..start();
  insertionSort(arr);
  stopwatch.stop();

  // 1203 ms 100k items
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}
