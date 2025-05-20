// https://leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/description/
class TreeNode {
  int val;
  TreeNode? right;
  TreeNode? left;

  TreeNode([this.val = 0]);
}

// Return the binary tree constructed from traversal
class Solution {
  TreeNode? buildTree(List<int> inorder, List<int> postorder) {
    if (inorder.isEmpty || postorder.isEmpty) return null;

    // get root and remove
    var root = TreeNode(postorder.removeLast());

    print(inorder.indexOf(root.val));
    // get left and right nodes
    var i = inorder.indexOf(root.val);
    // get all left sub tree
    var inoLeft = inorder.sublist(0, i);
    // get all right sub tree
    var inoRight = inorder.sublist(i + 1, inorder.length);

    // recursive right and left
    root.right = buildTree(inoRight, postorder); 
    root.left = buildTree(inoLeft, postorder);

    return root;
  }
}

main() {
  // inorder: root on middle postorder: root on last
  var inorder = [9,3,15,20,7];
  var postorder = [9,15,7,20,3];

  Solution().buildTree(inorder, postorder);
}
