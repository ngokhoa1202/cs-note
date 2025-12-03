#tree #binary-tree #graph-theory #algorithm #data-structure 
# Algorithm
## Depth-first search
### Preorder traversal
- Visit the root.
- $\text{preorder}(\text{root}.\text{left})$
- $\text{preorder}(\text{root}.\text{right})$
### Inorder traversal
- $\text{preorder}(\text{root}.\text{left})$
- Visit the root.
- $\text{preorder}(\text{root}.\text{right})$
### Postorder traversal
- $\text{preorder}(\text{root}.\text{left})$
- $\text{preorder}(\text{root}.\text{right})$
- Visit the root.
## Breadth-first search
# Complexity
## Time complexity
### Depth-first search
- $O(n)$
### Breadth-first search
- $O(n)$
## Space complexity
### Depth-first search
- $O(h)$
### Breadth-first search
- $O(w)$
***
# References
1. https://www.geeksforgeeks.org/dsa/tree-traversals-inorder-preorder-and-postorder/
2. 