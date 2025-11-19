#algorithm #data-structure #linked-list #java 
# Algorithm
- Two iterator `itr1` and `itr2` are used to traverse the two list.
	- The smaller element of the two values is put into the new list; as a result, one of the iterator will become `null` faster than the other does. Additionally, which iterator will become `null` first is unknown.
	- The first loop is used to compare elements of the two lists when the two iterator traverses.
	- The following two loops are used to add the remaining elements of the list whose iterator is not null.
# Design
- Allocating a new list is recommended since reusing the two list pointers may cause segmentation fault.
- Only when the `next` pointer is not null, then it can be assigned to the newly allocated space.
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

```Java title='Problem 21 in Java'
class Solution {
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        ListNode list = null;
        ListNode itr = null;
        while (list1 != null && list2 != null) {
            if (list1.val < list2.val) {
                if (list == null) {
                    list = new ListNode(list1.val);
                    itr = list;
                } else itr.next = new ListNode(list1.val);
                list1 = list1.next;
            } else {
                if (list == null) {
                    list = new ListNode(list2.val);
                    itr = list;
                }  else itr.next = new ListNode(list2.val);
            }
            itr = itr.next;
        }
        while (list1 != null) {
            itr.next = list1;
            list1 = list1.next;
        }
        while (list2 != null) {
            itr.next = list2;
            list2 = list2.next;
        }
        return list;
    }
}
```
## TypeScript
```TypeScript title='class ListNode'
class ListNode {
  val: number
  next: ListNode | null
  constructor(val?: number, next?: ListNode | null) {
      this.val = (val===undefined ? 0 : val)
      this.next = (next===undefined ? null : next)
  }
}
```

```TypeScript title='Problem 21 in TypeScript'
function mergeTwoLists(list1: ListNode | null, list2: ListNode | null): ListNode | null {
    let list: ListNode | null = null;
    let itr: ListNode | null = null;
    while (list1 && list2) {
      if (list1.val < list2.val) {
        if (!list) {
          list = new ListNode(list1.val);
          itr = list;
        } else if (itr) {
          itr.next = new ListNode(list1.val);
          itr = itr.next;
        }
        list1 = list1.next;
      } else {
        if (!list) {
          list = new ListNode(list2.val);
          itr = list;
        } else if (itr) {
          itr.next = new ListNode(list2.val);
          itr = itr.next;
        }
        list2 = list2.next;
      }
    }

    while (list1) {
        if (!list) {
            list = new ListNode(list1.val);
            itr = list;
        } else if (itr) {
            itr.next = new ListNode(list1.val);
            itr = itr.next;
        }
        list1 = list1.next;
    }

    while (list2) {
        if (!list) {
            list = new ListNode(list2.val);
            itr = list;
        } else if (itr) {
            itr.next = new ListNode(list2.val);
            itr = itr.next;
        }
        list2 = list2.next;
    }

    return list;
};
```
## JavaScript
```JavaScript title='class ListNode'
class ListNode {
    /**
     * 
     * @param {number} val 
     * @param {ListNode | null} next 
     */
    constructor(val, next) {
        this.val = (val===undefined ? 0 : val)
        this.next = (next===undefined ? null : next)
    }
}
```

```JavaScript title='Problem 21 in JavaScript'
/**
 * @param {ListNode | null} list1
 * @param {ListNode | null} list2
 * @return {ListNode | null}
 */
const mergeTwoLists = function(list1, list2) {
    let list = null;
    let itr = null;
    while (list1 && list2) {
        if (list1.val < list2.val) {
            if (!list) {
                list = new ListNode(list1.val);
                itr = list;
            } else {
                itr.next = new ListNode(list1.val);
                itr = itr.next;
            }
            list1 = list1.next;
        } else {
            if (!list) {
                list = new ListNode(list2.val);
                itr = list;
            } else {
                itr.next = new ListNode(list2.val);
                itr = itr.next;
            }
            list2 = list2.next;
        }
    }
    while (list1) {
        if (!list) {
            list = new ListNode(list1.val);
            itr = list;
        } else {
            itr.next = new ListNode(list1.val);
            itr = itr.next;
        }
        list1 = list1.next;
    }
    while (list2) {
        if (!list) {
            list = new ListNode(list2.val);
            itr = list;
        } else {
            itr.next = new ListNode(list2.val);
            itr = itr.next;
        }
        list2 = list2.next;
    }
    return list;
};
```
***
# References
1. https://leetcode.com/problems/merge-two-sorted-lists/description/