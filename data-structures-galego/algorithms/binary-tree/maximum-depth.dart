// https://leetcode.com/problems/binary-tree-level-order-traversal/description/
import 'dart:math';

class Node {
  int val;
  Node? right;
  Node? left;

  Node([this.val = 0]);
}

class Solution {
  int maxDepth(Node? root) {
    return traverse(root);
  }

  int traverse(Node? node) {
    if (node == null) return 0;

    // get left size
    var dep1 = traverse(node.left);
    // get right size
    var dep2 = traverse(node.right);

    // Sum one for each recursion execution = each tree node
    return 1 + max(dep1, dep2);
  }
}

main() {
  var bt = Solution();

  var root = Node(3);
  root.left = Node(9);
  var aux = root.right = Node(20);
  aux.left = Node(15);
  aux.right = Node(7);

  print(bt.maxDepth(root));
}
