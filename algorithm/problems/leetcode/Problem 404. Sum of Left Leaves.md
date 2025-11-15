#leetcode #tree #binary-tree 
# Algorithm
## Post-order traversal
- An additional temporary variable is used to hold left leaf node values before making left traversal.
# Implementation
## Java
```Java title='Problem 404 in Java: Post-order traversal'
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
  public int sumOfLeftLeaves(TreeNode root) {
    if (root == null) return 0;
    int leftLeafVal = 0;
    if (root.left != null && root.left.left == null && root.left.right == null) // is left leaf node
      leftLeafVal = root.left.val;
    final var leftSumOfLeftLeaves = this.sumOfLeftLeaves(root.left);
    final var rightSumOfLeftLeaves = this.sumOfLeftLeaves(root.right);
    return leftLeafVal + leftSumOfLeftLeaves + rightSumOfLeftLeaves;
  }
}
```
## TypeScript
```TypeScript title='Problem 404 in TypeScript: Post-order traversal'
/**
 * Definition for a binary tree node.
 * class TreeNode {
 *     val: number
 *     left: TreeNode | null
 *     right: TreeNode | null
 *     constructor(val?: number, left?: TreeNode | null, right?: TreeNode | null) {
 *         this.val = (val===undefined ? 0 : val)
 *         this.left = (left===undefined ? null : left)
 *         this.right = (right===undefined ? null : right)
 *     }
 * }
 */

function sumOfLeftLeaves(root: TreeNode | null): number {
  if (!root) return 0;
  let leftLeaveVal = 0;
  if (root.left && !root.left.left && !root.left.right)
    leftLeaveVal = root.left.val;
  const leftSum = sumOfLeftLeaves(root.left);
  const rightSum = sumOfLeftLeaves(root.right);
  return leftLeaveVal + leftSum + rightSum; 
};
```
## JavaScript
```JavaScript title='Problem 404 in JavaScript: Post-order traversal'
/**
 * Definition for a binary tree node.
 * function TreeNode(val, left, right) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.left = (left===undefined ? null : left)
 *     this.right = (right===undefined ? null : right)
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number}
 */
const sumOfLeftLeaves = function(root) {
  if (!root) return 0;
  let leftLeaveVal = 0;
  if (root.left && !root.left.left && !root.left.right)
    leftLeaveVal = root.left.val;
  const leftSum = sumOfLeftLeaves(root.left);
  const rightSum = sumOfLeftLeaves(root.right);
  return leftLeaveVal + leftSum + rightSum; 
};
```
***
# References
1. https://leetcode.com/problems/sum-of-left-leaves/description/
2. 