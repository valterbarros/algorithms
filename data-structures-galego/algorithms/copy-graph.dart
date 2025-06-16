// https://leetcode.com/problems/clone-graph/
// unfortunately this example doesn't has dart example

import 'dart:collection';

class Node {
  int val;
  List<Node> neighbors;

  Node(this.val, this.neighbors);
}

class Solution {
  cloneGraph(Node node) {
    Queue<Node> queue = new Queue();
    queue.addFirst(node);
    // create it to avoid infinity loop different nodes can have same neighbors 
    Map<int, Node> clones = new Map();
    // Process the queue until is empty
    while(queue.isNotEmpty) {
      var curr = queue.removeFirst();

      var curr_clone = Node(curr.val, []);
      clones[curr.val] = curr_clone;
      
      curr.neighbors.forEach((n) {
        var nei = clones[n.val];
        if (nei == null) {
          // add for next interaction
          queue.addLast(n);
          clones[n.val] = Node(n.val, []);
        }
        
        curr_clone.neighbors.add(clones[n.val]!);
      });
    }
    
    return clones[node.val];
  }
}

main() {
  var node1 = Node(1, []);
  var node2 = Node(2, []);
  var node3 = Node(3, []);
  var node4 = Node(4, []);

  // [[2,4],[1,3],[2,4],[1,3]]
  node1.neighbors = [node2, node4];
  node2.neighbors = [node1, node3];
  node3.neighbors = [node2, node4];
  node4.neighbors = [node1, node3];
  
  Solution().cloneGraph(node1);
}
