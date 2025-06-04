// https://leetcode.com/problems/binary-tree-inorder-traversal/
class Node {
  int val;
  Node? right;
  Node? left;

  Node([this.val = 0]);
}

class BinaryTree {
  Node? root;

  // Inorder traversal
  inorderTraversal() {
    if (root == null) return;

    return _inorder(root);
  }

  List<int> _inorder(Node? node) {
    if (node == null) return [];
    // Another way to do inorder traversal, using direct the recursion
    // It is concatenating through back to front on stack
    return [..._inorder(node.left), node.val, ..._inorder(node.right)];
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

  bt.insert(1);
  bt.insert(null);
  bt.insert(2);
  bt.insert(3);

  print(bt.inorderTraversal());
}
