class Node {
  int? val;
  Node? next;
  Node([this.val = 0, this.next]);
}

mapL(Node? head) {
  if (head == null) return;

  Node? curr = head;

  while(curr != null) {
    print('val: ${curr.val}');

    curr = curr.next;
  }
}

populate(List<dynamic> arr) {
  Node? head = null;
  Node? tail = null;

  // populate
  for(var n in arr) {
    var el = Node(n);

    if (head == null) {
      head = el;
      tail = el;
    } else {
      tail?.next = el;
      tail = el;
    }
  }

  return head;
}
