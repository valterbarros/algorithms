import '../linked-list/utils.dart';

// https://pt.khanacademy.org/computing/computer-science/algorithms/quick-sort/a/linear-time-partitioning
int partition(List<int> arr, int l, int r) {
  var pivot = arr[r];
  var i = l - 1;

  for(var j = l; j < r; j++) {
    if (arr[j] <= pivot) {
      i += 1;

      swap(arr, i, j);
    }
  }

  var next = i + 1;
  
  swap(arr, next, r);

  return next;
}

qSort(List<int> arr, int l, int r) {
  if (l < r) {
    var pi = partition(arr, l, r);
    
    print(pi);
    
    qSort(arr, l, pi - 1);
    qSort(arr, pi + 1, r);
  }
}

main() {
  var arr = [4,2,9,8,5];
  qSort(arr, 0, arr.length - 1);

  print(arr);
}
