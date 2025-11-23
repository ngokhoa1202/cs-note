#leetcode #binary-tree #tree #data-structure 
# Algorithm
## Post-order traversal
# Implementation
## Java
```Java title='Problem 222 in Java: Post-order traversal solution'
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
  public int countNodes(TreeNode root) {
    if (root == null) return 0;
    if (root.left == null && root.right == null) return 1;
    final var noOfLeftNodes = this.countNodes(root.left);
    final var noOfRightNodes = this.countNodes(root.right);
    return 1 + noOfLeftNodes + noOfRightNodes;
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/count-complete-tree-nodes/description/
2. 