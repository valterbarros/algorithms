// https://leetcode.com/problems/palindrome-linked-list/description/?envType=problem-list-v2&envId=linked-list
import 'utils.dart';

class Solution {
  (Node?, Node?) middleNode(Node? head) {
    var curr = head;
    var ahead = head;
    
    var reverse = null;

    while(ahead != null && ahead.next != null) {
      // new list
      var newNode = Node(curr?.val ?? 0);
      newNode.next = reverse;
      reverse = newNode;

      curr = curr?.next;
      ahead = ahead.next?.next;
    }

    if (ahead != null) {
      curr = curr?.next;
    }

    return (reverse, curr);
  }

  bool isPalindrome(Node? head) {
    if (head?.next == null) return true;

    var (reverse, middle) = middleNode(head);
    
    var curr = middle;
    
    while(curr != null) {
      if (curr.val != reverse?.val) return false;

      curr = curr.next;
      reverse = reverse?.next;
    }

    return true;
  }
}

main() {
  //var nums = [5,1,2,2,1,5];
  // var nums = [1];
  var nums = [1,0,1];
  
  var head = populate(nums);

  print(Solution().isPalindrome(head));
}
