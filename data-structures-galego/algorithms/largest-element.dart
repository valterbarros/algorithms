// https://leetcode.com/problems/kth-largest-element-in-a-stream/description/
// 703. Kth Largest Element in a Stream

import 'heap.dart';

class KthLargest {
  var heapq = new MinHeap();
  var kNumber;

  KthLargest(int k, List<int> nums) {
    kNumber = k;
    for (var num in nums) {
      heapq.push(num);
    }
    
    // keep only k items on list
    while (heapq.size() > kNumber) {
      heapq.pop();
    }
  }

  add(int val) {
    heapq.push(val);
    
    // after push remove less element = head of heap 
    if (heapq.size() > kNumber) heapq.pop();

    return heapq.head();
  }
}

main () {
  // KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
  //
  // for ( var n in [2,5,10,9,4]) {
  //   print(kthLargest.add(n));
  // }

  KthLargest kthLargest = new KthLargest(4, [7, 7, 7, 7, 8, 3]);

  for (var n in [2,10,9,9]) {
    print(kthLargest.add(n));
  }
}
