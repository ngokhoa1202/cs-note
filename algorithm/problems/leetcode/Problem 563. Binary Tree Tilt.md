#leetcode #binary-tree #recursion #tree 
# Algorithm
## Naive post-order traversal
# Implementation
## Java
```Java title='Problem 563 in Java: Naive post-order traversal solution'
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
  private int sum(TreeNode root) {
    if (root == null) return 0;
    final var leftSum = this.sum(root.left);
    final var rightSum = this.sum(root.right);
    return root.val + leftSum + rightSum;
  }
  
  public int findTilt(TreeNode root) {
    if (root == null) return 0;
    final var leftTilt = this.findTilt(root.left);
    final var rightTilt = this.findTilt(root.right);
    final var leftSum = this.sum(root.left);
    final var rightSum = this.sum(root.right);
    return Math.abs(leftSum - rightSum) + leftTilt + rightTilt;
  }
} 
```
# Complexity
## Space complexity

## Time complexity

***
# References
1. https://leetcode.com/problems/binary-tree-tilt/description/
2. 