import '../linked-list/utils.dart';

class Solution {
  Node? findMiddle(Node? head) {
    var slow = head;
    // Get the middle more to left example 4 -> 2 -> 1 -> 3 = 2
    var fast = head?.next;

    while(fast != null && fast.next != null) {
      slow = slow?.next;
      fast = fast.next?.next;
    }

    return slow;
  }

  mergeTwoLists(Node? left, Node? right) {
    var head = Node();
    Node? tail = head;
    
    while(left != null && right != null) {
      if (left.val !< (right.val ?? 0)) {
        tail?.next = left;
        left = left.next;
      } else {
        tail?.next = right;
        right = right.next;
      }

      tail = tail?.next;
    }
    
    // If some of left was not consumed point that to tail.next
    if (left != null) {
      tail?.next = left;
    // If some of right was not consumed point that to tail.next
    } else if (right != null){
      tail?.next = right;
    }

    return head.next;
  }
  
  mergeSort(head) {
    if (head == null || head.next == null) return head;
    
    var middle = findMiddle(head);
    var afterMiddle = middle?.next;
    middle?.next = null;
    
    var left = mergeSort(head);
    var right = mergeSort(afterMiddle);
    
    return mergeTwoLists(left, right);
  }

  Node? sortList(Node? head) {
    return mergeSort(head);
  }
}

main() {
  // var nums = [4,2,1,3];
  // var nums = [3,1,2,5,6,7];
  // var nums = [7, 12, 9, 11, 3];
  // var nums = [5,2,3,0,0,1,6,8,1,4];
  // var nums = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
  var nums = [7, 12, 9, 11, 3];
  // var nums = randomList();

  var head = populate(nums);

  Stopwatch stopwatch = Stopwatch()..start();
  var sortedHead = Solution().sortList(head);
  mapL(sortedHead);
  stopwatch.stop();

  // 17 ms 100k items
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}
