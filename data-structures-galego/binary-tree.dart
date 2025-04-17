class Node {
  int val;
  Node? right;
  Node? left;

  Node([this.val = 0]);  
}

class BinaryTree {
  Node? root;

  // preOrder traversal
  preTrav() {
    List<int> nums = [];
    preTravRecur(root, nums);
    
    return nums;
  }

  preTravRecur(Node? node, List<int> nums) {
    if (node == null) return false;
    
    nums.add(node.val);
    
    preTravRecur(node.left, nums);
    preTravRecur(node.right, nums);
  }

  // Inorder traversal
  inorTrav() {
    List<int> nums = [];
    // This nums var will be used by all recursion stack to add the value
    inorTravRecur(root, nums);

    return nums;
  }

  inorTravRecur(Node? node, List<int> nums) {
    if (node == null) return false;

    inorTravRecur(node.left, nums);

    nums.add(node.val);

    inorTravRecur(node.right, nums);
  }

  // postOrder traversal
  postTrav() {
    List<int> nums = [];
    postTravRecur(root, nums);

    return nums;
  }

  postTravRecur(Node? node, List<int> nums) {
    if (node == null) return false;

    postTravRecur(node.left, nums);

    postTravRecur(node.right, nums);

    nums.add(node.val);
  }

  search(int val) => searchRecur(val, root);

  searchRecur(int val, Node? node) {
    if (node == null) return false;
    if (node.val == val) return true;

    if (val < node.val) return searchRecur(val, node.left);

    return searchRecur(val, node.right);
  }

  insert(int val) {
    // insert root
    if (root == null) return root = Node(val);

    insertRecur(val, root);
  }

  void insertRecur(int val, Node? node) {
    if (node == null) return;

    if (val < node.val) {
      if (node.left == null) {
        node.left = Node(val);
        return;
      }

      insertRecur(val, node.left);
    } else {
      if (node.right == null) {
        node.right = Node(val);
        return;
      }

      insertRecur(val, node.right);
    }
  }
}

main() {
  var bt = BinaryTree();
  // bt.root = Node(5);
  // bt.root!.left = Node(3);
  // bt.root!.left!.right = Node(2);
  // bt.root!.left!.left = Node(1);
  
  bt.insert(5);
  bt.insert(3);
  bt.insert(10);
  bt.insert(7);
  bt.insert(15);
  bt.insert(1);
  // bt.insert(4);
  
  print(bt.search(2));
  // print(bt.search(5));
  // print(bt.search(4));
  // print(bt.search(0));

  // print(bt.preTrav());
  // print(bt.inorTrav());
  print(bt.postTrav());

  // print(Node().val);
}
