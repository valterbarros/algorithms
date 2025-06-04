// https://leetcode.com/problems/binary-tree-level-order-traversal/description/
class Node {
  int val;
  Node? right;
  Node? left;

  Node([this.val = 0]);
}

class BinaryTree {
  Node? root;

  levelOrder() {
    // array with levels array
    List<List<int>> nums = [];

    traverse(root, nums, 0);

    return nums;
  }

  traverse(Node? node, List<List<int>> nums, int depth) {
    if (node == null) return false;

    // Add new level if necessary
    if (nums.elementAtOrNull(depth) == null) {
      nums.add([]);
    }

    // add value to level
    nums[depth].add(node.val);

    traverse(node.left, nums, depth + 1);
    traverse(node.right, nums, depth + 1);
  }

  insert(int? val) {
    if (val == null) return;

    // insert root
    if (root == null) return root = Node(val);

    _insertRecur(val, root);
  }
  void _insertRecur(int val, Node? node) {
    if (node == null) return;

    // Insertion by less
    if (val < node.val) {
      if (node.left == null) {
        // successfully append value to binary tree
        node.left = Node(val);
        return;
      }

      // keep searching until right is empty
      _insertRecur(val, node.left);
    } else {
      if (node.right == null) {
        // successfully append value to binary tree
        node.right = Node(val);
        return;
      }

      // keep searching until right is empty
      _insertRecur(val, node.right);
    }
  }
}

main() {
  var bt = BinaryTree();

  bt.insert(3);
  bt.insert(9);
  bt.insert(20);
  bt.insert(15);
  bt.insert(7);

  print(bt.levelOrder());
}
