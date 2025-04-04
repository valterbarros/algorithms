// https://leetcode.com/problems/remove-duplicates-from-sorted-list?envType=problem-list-v2&envId=linked-list
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
  ListNode? deleteDuplicates(ListNode? head) {
    var curr = head;

    while(curr != null) {
      if (curr.val == curr.next?.val) {
        print('not equal');
        curr.next = curr.next!.next;
      } else {
        curr = curr.next;
      }
    }

    map(head);

    return head;
  }
}

main() {
  // var nums = [1,1,2];
  var nums = [1,1,2,6,6,7,7,7,7,9];

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

  Solution().deleteDuplicates(head);
}
