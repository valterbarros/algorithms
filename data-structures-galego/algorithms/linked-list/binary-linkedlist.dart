// https://leetcode.com/problems/convert-binary-number-in-a-linked-list-to-integer/?envType=problem-list-v2&envId=linked-list

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
  int getDecimalValue(ListNode? head) {
    var curr = head;
    int sum = 0;

    // map(head);

    while (curr != null) {
      sum = sum * 2 + curr.val;

      curr = curr.next;
    }
    
    return sum;
  }
}

main() {
  // 2 ** 2 + 0 + 2 ** 0 = 5
  // var nums = [1,0,1];
  // 
  var nums = [0];

  ListNode? head = null;
  ListNode? tail = null;

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

  // this solution use HEAD as MSB
  print(Solution().getDecimalValue(head)); // should print: true
}
