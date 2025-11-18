// stack implementation using linked list as engine

class Node {
  int? value;
  Node? next;
  
  Node(item) {
    value = item;
  }
}

class Stack {
  int _size = 0;
  Node? head; 

  push(int item){
    var newItem = Node(item);
    newItem.next = head;
    head = newItem;
    _size ++;
  }

  pop(){
    if (head == null) throw Error();
    var removed = head;
    head = head?.next;
    _size -= 1;

    return removed?.value; 
  }

  peek(){
    if (head == null) throw Error();
    return head?.value;
  }
  size(){
    return _size;
  }
}

main() {
  var s = Stack();

  // it throws
  // s.pop();
  s.push(1);
  s.push(2);
  print(s.peek());
  s.push(3);
  print(s.pop());
  s.push(4);
  print(s.peek());
  s.push(5);
  print(s.peek());
  print(s.size());
}
