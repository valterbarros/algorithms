import '../linked-list/utils.dart';

class Solution {
  Node? findMiddle(Node? head) {
    var slow = head;
    var fast = head;

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
    
    if (left != null) {
      tail = left;
    } else if (right != null){
      tail = right;
    }

    return head.next;
  }
  
  mergeSort(head) {
    if (head == null && head.next == null) {
      return head;
    }
    
    var middle = findMiddle(head);
    var afterMiddle = middle?.next;

    print('tempo ruim ${middle?.val} -> ${afterMiddle?.val}');
    
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
  var nums = [4,2,1,3];

  var head = populate(nums);

  var sortedHead = Solution().sortList(head);
  mapL(sortedHead);
}
