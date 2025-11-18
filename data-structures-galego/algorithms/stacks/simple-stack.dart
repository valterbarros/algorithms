// basic stack using list as engine
import 'dart:math';

class Stack {
  List<int> items = [];
  List<int> minItems = [];
  var pointer = -1;

  push(int item){
    items.add(item);
    pointer += 1;
  }

  pop(){
    return items.elementAtOrNull(pointer);
  }

  int? peek(){
    return items.lastOrNull;
  }

  size(){
    return pointer;
  }
}

main() {
  var s = Stack();
  s.push(1);
  s.push(2);
  s.push(3);
  s.push(4);
  print(s.peek());
  print(s.pop());
}
