// https://leetcode.com/problems/merge-k-sorted-lists/description/
// 23. Merge k Sorted Lists

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}
typedef Sort = ({ int val, ListNode node });

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

  add(ListNode head) {
    heap.push((val: head.val, node: head));
  }

  ListNode? mergeKLists(List<ListNode?> lists) {
    if (lists.isEmpty) return null;
    // just for edge cases like [] or [[]]
    for (var list in lists) {
      if (list == null) continue;
      add(list);
    }

    var head = ListNode(1);
    var current = head;

    while(heap.size > 0) {
      // 1 step: remove from heap
      Sort values = heap.pop();
      var node = values.node;
      var val = values.val;

      // 2. append to general linkedlist
      // add to general linked list, copping the value not reference
      current.next = ListNode(val);
      current = current.next!;

      // 3. append next node to heap, and automatically it sort by value  
      // passing by reference
      var nextNode = node.next;
      if (nextNode != null) {
        add(nextNode);
      }
    }

    return head.next;
  }
}

ListNode generateLL(List<int> values) {
  var head = ListNode(values[0]);
  var current = head;
  for (var val in values.getRange(1, values.length)) {
    var node = ListNode(val);
    current.next = node;
    current = node;
  }

  return head;
}
  
main() {
  // given many lists [[1,4,5],[1,3,4],[2,6]]
  var s = Solution();

  s.mergeKLists([generateLL([1,4,5]), generateLL([1,3,4]), generateLL([2,6])]);
}
