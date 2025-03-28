// https://leetcode.com/problems/middle-of-the-linked-list/?envType=problem-list-v2&envId=linked-list
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

map(ListNode? head) {
  if (head == null) return;

  ListNode? curr = head;

  while(curr != null) {
    print('val: ${curr.val}');

    curr = curr.next;
  }
}

class Solution {
  ListNode? middleNode(ListNode? head) {
    var curr = head;
    var ahead = head;

    while(ahead != null && ahead.next != null) {
      curr = curr?.next;
      ahead = ahead.next?.next;
    }
    
    print(curr?.val);

    return curr;
  }
}

main() {
  var nums = [1,2,3,4,5];

  ListNode? head = null;
  ListNode? tail = null;

  // populate
  for(var n in nums) {
    var el = ListNode(n);

    if (head == null) {
      head = el;
      tail = el;
    } else {
      tail?.next = el;
      tail = el;
    }
  }

  Solution().middleNode(head);
}
