// https://www.w3schools.com/dsa/dsa_algo_selectionsort.php
import '../linked-list/utils.dart';

selectionSort(List<int> arr) {
  for(var i = 0; i < arr.length - 1; i++) {
    var minIndex = i;
    for(var j = minIndex + 1; j < arr.length; j++) {
      if (arr[j] < arr[minIndex]) {
        minIndex = j;
      }
    }

    swap(arr, i, minIndex);
  }
  
  print(arr);
}

main() {
  // var arr = [3,1,2,5,6,7];
  var arr = [7, 12, 9, 11, 3];
  // var arr = [5,2,3,0,0,1,6,8,1,4];
  // var arr = randomList();

  Stopwatch stopwatch = Stopwatch()..start();
  selectionSort(arr);
  stopwatch.stop();

  // 5392ms 100k items
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}
