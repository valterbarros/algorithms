class Node {
  int value;
  Node? next;
  Node? prev;

  Node(this.value);
}

class DoublyLinkedList {
  Node? head;
  Node? tail;

  unshift(int value) {
    // 4(new) -> 0 -> 1 -> 2 -> 4;
    var newNode = Node(value);
    if(this.head == null) {
      this.head = newNode;
      this.tail = newNode;
    } else {
      var head = this.head;
      head?.prev = newNode;
      newNode.next = head;
      this.head = newNode;
    }
  }

  push(int value) {
    var newNode = Node(value);

    if(this.tail == null) {
      this.head = newNode;
      this.tail = newNode;
    } else {
      var tail = this.tail;
      tail?.next = newNode;
      newNode.prev = tail;
      this.tail = newNode;
    }
  }

  delFront() {
    var removedValue = this.head?.value;
    if (this.head == null) return null;
    if (this.head == this.tail) {
      this.head = null;
      this.tail = null;
    } else {
      var head = this.head;
      head?.next?.prev = null;
      this.head = head?.next;
    }
    
    return removedValue;
  }
  
  delBack() {
    var removedValue = this.tail?.value;
    
    if (this.tail == null) return null;

    if (this.tail == this.head) {
      this.tail = null;
      this.head = null;
    } else {
      var tail = this.tail;
      
      this.tail = tail?.prev;
      tail?.prev?.next = null;
    }
    
    return removedValue;
  }
}

void main() {
  var l = DoublyLinkedList();
  // head  2 -> 1 -> 0 -> 5 -> 10 (tail)
  l.unshift(0);
  l.unshift(1);
  l.unshift(2);
  l.push(5);
  l.push(10);
  
  l.delFront(); // -> 2
  l.delBack(); // -> 10
}
