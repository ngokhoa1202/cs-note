#leetcode #tree 
# Algorithm
## Linked list
# Implementation
## Java
```Java title='class Node'
class Node {
    public int val;
    public List<Node> children;

    public Node() {}

    public Node(int _val) {
        val = _val;
    }

    public Node(int _val, List<Node> _children) {
        val = _val;
        children = _children;
    }
};
```

```Java title='Problem 589 in Java: Linked list solution'
class Solution {
  public List<Integer> preorder(Node root) {
    if (root == null) return new LinkedList<Integer>();
    final var currentPreorder = new LinkedList<Integer>(List.of(root.val));
    for (final var child: root.children) {
      final var childPreorder = this.preorder(child);
      currentPreorder.addAll(childPreorder);
    }
    return currentPreorder;
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
1. https://leetcode.com/problems/n-ary-tree-preorder-traversal/
2. 