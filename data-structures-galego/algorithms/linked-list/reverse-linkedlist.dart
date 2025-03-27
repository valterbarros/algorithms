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
  ListNode? reverseList(ListNode? head) {
    var curr = head;
    var new_head = null;

    while(curr != null) {
      var next = curr.next;

      curr.next = new_head;
      new_head = curr;

      curr = next;
    }
    
    print(new_head.val);

    map(new_head);

    return new_head;
  }
}

main() {
  var nums = [1,2,3,4,5]; // -> 5,4,3,2,1

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

  Solution().reverseList(head);
}
