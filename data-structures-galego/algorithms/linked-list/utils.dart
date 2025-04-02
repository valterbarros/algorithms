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

swap(List<int> arr, int i, int j) {
  if (arr.elementAtOrNull(i) != null && arr.elementAtOrNull(j) != null) {
    var n1 = arr[j];
    var n2 = arr[i];

    arr[i] = n1;
    arr[j] = n2;
  }
}
