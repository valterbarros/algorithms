// WIP
typedef Sort = ({ int val, List<int> list, int index });

class MinHeap {
  List<Sort> heap = [];

  _parent(int index) => (index - 1) ~/ 2;
  _leftChild(int index) => 2 * index + 1;
  _rightChild(int index) => 2 * index + 2;

  heapifyDown(int index) {
    var smallest = index;
    var left = _leftChild(index);
    var right = _rightChild(index);
    
    if (left < heap.length && heap[left].val < heap[smallest].val) {
      smallest = left;
    }
    if (right < heap.length && heap[right].val < heap[smallest].val) {
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
    
    while (currentIndex > 0 && heap[_parent(currentIndex)].val > heap[currentIndex].val) {
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

  head() {
    return heap[0];
  }
}

class Solution {
  var heap = new MinHeap();
  
  add(List<int> l1) {
    heap.push((val: l1[0], list: l1, index: 0));
  }

  merge() {
    var res = [];

    while(heap.size > 0) {
      Sort values = heap.pop();
      var list = values.list;
      var index = values.index;
      var val = values.val;
      
      res.add(val);

      if (index + 1 < list.length) {
        var nextIndex = index + 1;
        heap.push((val: list[nextIndex], list: list, index: nextIndex));
      }
    }
    
    return res;
  }  
}

main() {
  // given many lists [[1,4,5],[1,3,4],[2,6]]
  // try with array but if not work try with linked list
  // merge then and keep order
  // using heap
  
  var s = Solution();
  s.add([1,4,5]);
  s.add([1,3,4]);
  s.add([2,6]);
  
  print(s.merge());
}
