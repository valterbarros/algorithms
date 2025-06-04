import 'dart:collection';

class Node {
  int val;
  Node? right;
  Node? left;

  Node([this.val = 0]);
}

class BinaryTree {
  Node? root;
  var queue = new Queue();
  // breath first search implementation
  bfs(Node? root, int search) {
    if (root == null) return;

    queue.addLast(root);

    var node = root;

    // same time elements are being added to queue those are processed at same loop
    while(queue.isNotEmpty) {
      // the queue is checked from left to right FIFO
      node = queue.removeFirst();

      if (node.val == search) return true;

      // add elements to queue by levels
      if (node.left != null) queue.addLast(node.left);
      if (node.right != null) queue.addLast(node.right);
    }

    return false;
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

  bt.insert(5);
  bt.insert(3);
  bt.insert(10);
  bt.insert(1);
  bt.insert(7);
  bt.insert(15);

  
  print(bt.bfs(bt.root, 7));
}
