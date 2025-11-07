#algorithm #data-structure #binary-tree #leetcode 
# Algorithm
- 
# Implementation
## Java
```Java title='class TreeNode'
public class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}
```

```Java title='Problem 226 in Java'
class Solution {
    public TreeNode invertTree(TreeNode root) {
        if (root == null)
            return null;
        if (root.left == null && root.right == null)
            return root;
        final var leftTmp = root.left;
        root.left = this.invertTree(root.right);
        root.right = this.invertTree(leftTmp);
        return root;
    }
} 
```
## JavaScript
```JavaScript title='class TreeNode'
class TreeNode {

  /**
   * 
   * @param {number} val 
   * @param {TreeNode | null} left 
   * @param {TreeNode | null} right 
   */
  constructor(val, left, right) {
    this.val = (val===undefined ? 0 : val)
    this.left = (left===undefined ? null : left)
    this.right = (right===undefined ? null : right)
  }
}
```

```JavaScript title='Problem 226 in JavaScript'
/**
 * @param {TreeNode} root
 * @return {TreeNode}
 */
const invertTree = function(root) {
  if (!root || (!root.left && !root.right)) return root;
  const leftTmp = root.left;
  root.left = invertTree(root.right);
  root.right = invertTree(leftTmp);
  return root;
};
```
## TypeScript

***
# References
1. https://leetcode.com/problems/invert-binary-tree/description/