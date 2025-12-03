class MinHeap {
  List<int> heap = [];
  
  // get nodes methods
  _parent(int index) => (index - 1) ~/ 2;
  _leftChild(int index) => 2 * index + 1;
  _rightChild(int index) => 2 * index + 2;

  heapifyDown(int index) {
    var smallest = index;
    var left = _leftChild(index);
    var right = _rightChild(index);
    
    // get smallest
    if (left < heap.length && heap[left] < heap[smallest]) {
      smallest = left;
    }
    if (right < heap.length && heap[right] < heap[smallest]) {
      smallest = right;
    }
    
    if (smallest != index) {
      // if it is not myself swap greater by less
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

  // Used to push items up
  heapifyUp(int index) {
    var currentIndex = index;

    // heapify while upper is greater
    while (currentIndex > 0 && heap[_parent(currentIndex)] > heap[currentIndex]) {
      // swap greater by less
      var tmp = heap[_parent(currentIndex)];
      heap[_parent(currentIndex)] = heap[currentIndex];
      heap[currentIndex] = tmp;
      
      // after swap the less than is parent of currentIndex
      currentIndex = _parent(currentIndex);
    }
  }

  push(int el) {
    // append to heap
    heap.add(el);
    // send last index
    heapifyUp(heap.length - 1);
  }
}

main() {
  var h = MinHeap();
  h.push(2);
  h.push(1);
  h.push(0);
  
  print(h.pop());
  print(h.pop());
  print(h.pop());
  
  print(h);
}
