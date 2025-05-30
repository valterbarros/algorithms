// https://pt.khanacademy.org/computing/computer-science/algorithms/quick-sort/a/linear-time-partitioning
// https://medium.com/@princeabhi00985/a-comprehensive-comparison-of-lomutos-partitioning-and-hoare-s-partitioning-in-quicksort-bf37eabd8df0
import '../linked-list/utils.dart';

partitionHoare(List<int> nums, int low, int high) {
  var pivot = nums[high];
  var i = low;
  var lt = low;
  var gt = high;

  while(i <= gt) {
    var curr = nums[i];

    if (curr < pivot) {
      swap(nums, lt, i);
      i++;
      lt++;
    } else if (curr > pivot) {
      swap(nums, i, gt);
      gt--;
    } else {
      i++;
    }
  }

  var smaller = lt - 1;
  var larger = gt + 1;

  return (smaller, larger);
}

(int, int) partitionLomuto(List<int> arr, int left, int right) {
  var pivot = arr[right];
  var low = left;

  for(var j = left; j < right; j++) {
    if (arr[j] <= pivot) {
      swap(arr, low, j);

      low += 1;
    }
  }

  var next = low;
  
  swap(arr, next, right);

  var smaller = next - 1;
  var larger = next + 1;

  return (smaller, larger);
}

qSort(List<int> arr, int left, int right) {
  if (left < right) {
    // Uncomment to enable lomuto
    var (smaller, larger) = partitionLomuto(arr, left, right);
    // Uncomment to enable Hoare
    // var (smaller, larger) = partitionHoare(arr, l, r);

    qSort(arr, left, smaller);
    qSort(arr, larger, right);
  }
}

main() {
  // var arr = [4,2,9,8,5];
  // var arr = [5,2,3,1];
  var arr = [5,2,3,0,0,1,6,8,1,4,4,4,4];
  // var arr = [2,2,2,2,2];
  // var arr = randomList();

  Stopwatch stopwatch = Stopwatch()..start();
  qSort(arr, 0, arr.length - 1);
  stopwatch.stop();

  print(arr);

  // 19 ms 100k items partitionLomuto
  // 20193 ms 100mi items partitionLomuto
  // 23 ms 100k items partitionHoare
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}
