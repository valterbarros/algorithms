// https://leetcode.com/problems/top-k-frequent-elements/description/
// 347. Top K Frequent Elements

typedef Sort = ({ int frequency, int num });

class MinHeap {
  List<Sort> heap = [];

  _parent(int index) => (index - 1) ~/ 2;
  _leftChild(int index) => 2 * index + 1;
  _rightChild(int index) => 2 * index + 2;

  heapifyDown(int index) {
    var smallest = index;
    var left = _leftChild(index);
    var right = _rightChild(index);

    if (left < heap.length && heap[left].frequency < heap[smallest].frequency) {
      smallest = left;
    }
    if (right < heap.length && heap[right].frequency < heap[smallest].frequency) {
      smallest = right;
    }

    if (smallest != index) {
      var tmp = heap[index];
      heap[index] = heap[smallest];
      heap[smallest] = tmp;

      heapifyDown(smallest);
    }
  }

  pop() {
    if (heap.isEmpty) return null;

    if (heap.length == 1) return heap.removeLast();

    var root = heap.first;
    heap[0] = heap.removeLast();

    heapifyDown(0);

    return root;
  }

  heapifyUp(int index) {
    var currentIndex = index;

    while (currentIndex > 0 && heap[_parent(currentIndex)].frequency > heap[currentIndex].frequency) {
      var tmp = heap[_parent(currentIndex)];
      heap[_parent(currentIndex)] = heap[currentIndex];
      heap[currentIndex] = tmp;

      currentIndex = _parent(currentIndex);
    }
  }

  push(Sort val) {
    heap.add(val);
    heapifyUp(heap.length - 1);
  }

  get size {
    return heap.length;
  }
}

class Solution {
  var heap = MinHeap();

  add(int num, int fr, int k) {
    heap.push((frequency: fr, num: num));
    
    // keep just k items inside heap
    if (heap.size > k) {
      heap.pop();
    }
  }

  List<int> topKFrequent(List<int> nums, int k) {
    var frequencies = new Map<int, int>();

    // hashmap frequencies
    for (var num in nums) {
      frequencies.update(num, (value) => value + 1, ifAbsent: () => 1);
    }

    frequencies.forEach((fr, val) => add(fr, val, k));

    List<int> res = [];
    for (var i = 0; i < k; i++) {
      res.add(heap.pop().num);
    }

    return res;
  }
}

main() {
  print(Solution().topKFrequent([1,1,1,2,3,3,3,4,4,4,5,6,7], 3));
}
