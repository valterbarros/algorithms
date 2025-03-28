// https://leetcode.com/problems/merge-two-sorted-lists/?envType=problem-list-v2&envId=linked-list

import './linked-list.dart';

mergeL(List<int> nums1, List<int> nums2) {
  var l1 = DoublyLinkedList();
  var l2 = DoublyLinkedList();
  for(var n in nums1) l1.push(n);
  for(var n in nums2) l2.push(n);

  var curr1 = l1.head;

  var curr2 = l2.head;

  var l3 = DoublyLinkedList();

  while(curr1 != null || curr2 != null) {
    if (curr1 != null && (curr2 == null || curr1.value <= curr2.value)) {
      l3.push(curr1.value);

      curr1 = curr1.next;
    } else if (curr2 != null) {
      l3.push(curr2.value);

      curr2 = curr2.next;
    }
  }

  return l3;
}

main() {
  // head  1 -> 2 -> 4 (tail)
  // head  1 -> 3 -> 4 (tail)
  // var l1 = mergeL(
  //  [1,2,4],
  //  [1,3,4]
  // );

  var l1 = mergeL(
    [5,6,10,12,21],
    [11,12,20]
  );

  var curr = l1.tail;

  while(curr != null) {
    print('value: ${curr.value}');

    curr = curr.prev;
  }
}
