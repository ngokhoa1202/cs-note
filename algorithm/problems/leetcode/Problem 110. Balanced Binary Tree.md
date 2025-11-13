#leetcode #binary-tree #tree #recursion 
# Algorithm

# Implementation
## TypeScript
```TypeScript title='class TreeNode'
class TreeNode {
    val: number
    left: TreeNode | null
    right: TreeNode | null
    constructor(val?: number, left?: TreeNode | null, right?: TreeNode | null) {
        this.val = (val===undefined ? 0 : val)
        this.left = (left===undefined ? null : left)
        this.right = (right===undefined ? null : right)
    }
}
```

```TypeScript title='Problem 110 in TypeScript'
function isBalanced(root: TreeNode | null): boolean {
    if (!root) return true;
    const leftHeight = getHeight(root.left);
    const rightHeight = getHeight(root.right);
    return Math.abs(leftHeight - rightHeight) <= 1 && isBalanced(root.left) && isBalanced(root.right);
};

function getHeight(root: TreeNode | null): number {
    if (!root) return 0;
    const leftHeight = getHeight(root.left);
    const rightHeight = getHeight(root.right);
    return 1 + Math.max(leftHeight, rightHeight);
}
```
# Complexity
## Time complexity
- Time complexity to get the height of each node is calculated as followed:
$$T_1(n)=\begin{cases}1 \space \text{when} \space n = 1 \\ 2 \times T(\frac{n}{2}) \space\text{when}\space n \geq 1\end{cases}=O(n)$$
- Time complexity to determine whether the tree is height-balanced or not is:
$$T_2(n)=O(n \times T_1(n))=O(n^2)$$
## Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/balanced-binary-tree/description/

