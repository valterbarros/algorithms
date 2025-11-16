// https://leetcode.com/problems/min-stack/description/
import 'dart:math';

class MinStack {
  List<int> items = [];
  List<int> minItems = [];
  var pointer = -1;

  push(int item){
    items.add(item);

    var t = minItems.lastOrNull ?? item;

    minItems.add(min(item, t));

    pointer += 1;
  }

  pop(){
    items.removeLast();
    minItems.removeLast();
  }
  int? top(){
    return items.lastOrNull;
  }
  getMin(){
    return minItems.lastOrNull;
  }
}

main() {
  var s = MinStack();
  s.push(-2);
  s.push(0);
  s.push(-3);
  s.pop();
  print(s.top());
  print(s.getMin());
  s.push(4);
  // print(s.top());
  // print(s.pop());
}

