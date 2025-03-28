// https://leetcode.com/problems/linked-list-cycle?envType=problem-list-v2&envId=linked-list
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
  bool hasCycle(ListNode? head) {
    var slow = head;
    var fast = head;

    while(fast != null && fast.next != null) {
      slow = slow?.next;
      fast = fast.next?.next;

      if (slow == fast) return true;
    }

    print(slow?.val);

    return false;
  }
}

main() {
  var nums = [3, 2, 0, -4];

  ListNode? head = null;
  ListNode? tail = null;
  ListNode? cycleEntry; // node at index 1

  for (var i = 0; i < nums.length; i++) {
    var el = ListNode(nums[i]);

    if (head == null) {
      head = el;
      tail = el;
    } else {
      tail?.next = el;
      tail = el;
    }

    if (i == 1) {
      cycleEntry = el;
    }
  }

  // Create cycle: tail -> node at index 1
  tail?.next = cycleEntry;

  print(Solution().hasCycle(head)); // should print: true
}
