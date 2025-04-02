import '../linked-list/utils.dart';

// https://leetcode.com/problems/relative-sort-array/
class Solution {
  List<int> relativeSortArray(List<int> arr1, List<int> arr2) {
    var list = <int>[];

    var frequency = Map<int, int>();
    
    for (var n1 in arr1) {
      frequency.update(n1, (value) => value + 1, ifAbsent: () => 1);
    }

    for (var n2 in arr1) {
      var n = n2;
      
      for (var j = 0; j < (frequency[n] ?? 0); j++) {
        list.add(n);
      }

      frequency.remove(n);
    }

    var second = [];

    for (var MapEntry(:value, :key) in frequency.entries) {
      for(var i = 0; i < value; i++) {
        second.add(key);
      }
    }

    second.sort();

    return [...list, ...second];
  }
}

main() {
  // var arr1 = [2,3,1,3,2,4,6,7,9,2,19];
  // var arr2 = [2,1,4,3,9,6];
  
  var arr1 = [2,21,43,38,0,42,33,7,24,13,12,27,12,24,5,23,29,48,30,31];
  var arr2 = [2,42,38,0,43,21];

  var l = Solution().relativeSortArray(arr1, arr2);
  
  print(l);
}
