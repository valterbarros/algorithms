// https://leetcode.com/problems/same-tree/?envType=problem-list-v2&envId=binary-tree
class Node {
  int val;
  Node? right;
  Node? left;

  Node([this.val = 0]);
}

class Solution {
  bool isSameTree(Node? p, Node? q) => traverse(p, q);

  bool traverse(Node? node1, Node? node2) {
    // if both are null at the last leaf it means the tree has same depth otherwise tree are no equal
    if (node1 == null && node2 == null) return true;

    // get left check
    var dep1 = traverse(node1?.left, node2?.left);
    // get right check
    var dep2 = traverse(node1?.right, node2?.right);

    // check if each node is equal and deps too
    // dep1 and dep2 are kind of cumulative when stack is popping
    return dep1 && dep2 && node1?.val == node2?.val;
  }
}

main() {
  var bt = Solution();

  var root1 = Node(1);
  root1.left = Node(2);
  var aux = root1.right = Node(3);

  var root2 = Node(1);
  root2.left = Node(2);
  var aux2 = root2.right = Node(3);

  print(bt.isSameTree(root1, root2));
}
