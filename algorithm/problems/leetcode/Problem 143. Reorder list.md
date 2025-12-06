
#leetcode #algorithm #java #data-structure #linked-list 
# Algorithm
- The transformation from $L_0 \rightarrow L_1 \rightarrow \space ... \to L_{n-1} \rightarrow L_n$ into $L_0 \to L_{n} \to L_1 \to L_{n-1} \to L_2 \to L_{n-2}$ can be sequentially executed as these steps:
	1. Split the list into the two halves $L_0 \to \space ... \to L_{mid}$ and $L_{mid+1} \to \space ... \to L_{n}$.
	2. Reverse the second half of the list, making it into $L_n \to \space ... \to L_{mid+1}$.
	3. Merge the two halves interchangeably.
# Implementation
## Java
```Java title='class ListNode'
public class ListNode {
  int val;
  ListNode next;
  ListNode() {}
  ListNode(int val) { this.val = val; }
  ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}
```

```Java title='Problem 143 in Java'
public class Solution {

  public void reorderList(ListNode head) {
    final var middle = this.findMiddleNode(head);
    var secondHalfItr = this.reverseList(middle.next);
    middle.next = null;
    var firstHalfItr = head;
    ListNode tmp = null;
  
    while (firstHalfItr != secondHalfItr && secondHalfItr != null) {
      tmp = firstHalfItr.next;
      firstHalfItr.next = secondHalfItr;
      firstHalfItr = tmp;
      tmp = secondHalfItr.next;
      secondHalfItr.next = firstHalfItr;
      secondHalfItr = tmp;
    }
  }

  private ListNode findMiddleNode(ListNode head) {
    if (head == null) return null;
    ListNode slowPtr = head;
    ListNode fastPtr = head;
    while (fastPtr.next != null && fastPtr.next.next != null) {
      slowPtr = slowPtr.next;
      fastPtr = fastPtr.next.next;
    }
    return slowPtr;
  }

  private ListNode reverseList(ListNode head) {
    if (head == null || head.next == null) return head;
    final var newHead = reverseList(head.next);
    head.next.next = head;
    head.next = null;
    return newHead;
  }
}
```
# Complexity
- Given $n$ is the size of the linked list.
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/reorder-list/description/