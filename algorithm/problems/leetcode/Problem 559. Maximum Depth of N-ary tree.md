#leetcode #tree 
# Algorithm
## Post-order traversal
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

```Java title='Problem 559 in Java: Post-order traversal using functional programming'
class Solution {
  public int maxDepth(Node root) {
    if (root == null) return 0;
    if (root.children == null) return 1;
    final var maxChildDepth = root.children.stream().map((child) -> this.maxDepth(child))
      .reduce(Math::max).orElse(0);
    return 1 + maxChildDepth;
  }
}
```

```Java title='Problem 559 in Java: Post-order traversal using imperative programming'
class Solution {
  public int maxDepth(Node root) {
    if (root == null) return 0;
    if (root.children == null) return 1;
    int maxChildDepth = 0;
    for (final var child: root.children) {
      maxChildDepth = Math.max(maxChildDepth, this.maxDepth(child));
    }
    return 1 + maxChildDepth;
  }
}
```
# Complexity
## Time complexity
- $O(\text{log}n)$
## Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/maximum-depth-of-n-ary-tree/description/
2. 