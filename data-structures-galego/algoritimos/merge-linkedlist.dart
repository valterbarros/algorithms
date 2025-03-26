import './linked-list.dart';

mergeL(List<int> nums1, List<int> nums2) {
  var l1 = DoublyLinkedList();
  var l2 = DoublyLinkedList();
  for(var n in nums1) l1.push(n);
  for(var n in nums2) l2.push(n);

  var curr1 = l1.tail;
  // add zeroes
  for(var i = 0; i < nums2.length; i++) l1.push(0);
  // tail after 
  var tailL1 = l1.tail;

  var curr2 = l2.tail;
  
  while(curr2 != null) {
    
    if (curr1 != null && curr1.value > curr2.value) {
      tailL1?.value = curr1.value;

      curr1 = curr1.prev;
    } else {
      tailL1?.value = curr2.value;

      curr2 = curr2.prev;
    }

    tailL1 = tailL1?.prev;
  }

  return l1;
}

main() {
  // head  1 -> 2 -> 4 (tail)
  // head  1 -> 3 -> 4 (tail)
  var l1 = mergeL(
    [1,2,4],
    [1,3,4]
  );

  var curr = l1.tail;

  while(curr != null) {
    print('value: ${curr.value}');

    curr = curr.prev;
  }
}
