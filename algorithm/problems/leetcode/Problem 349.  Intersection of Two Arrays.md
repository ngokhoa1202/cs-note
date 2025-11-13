#leetcode #data-structure #array #set 
# Algorithm
## Intersection of two sets
- Let $S_1, S_2$ be the set of elements in `nums1` and `nums2` retrospectively. The result will be: $$S=S_1 \cup S_2$$
# Implementation
## Java
```Java title='Problem 349 in Java: two set intersection'
class Solution {
    public int[] intersection(int[] nums1, int[] nums2) {
        Set<Integer> set1 = new HashSet<>(Arrays.stream(nums1).boxed().toList());
        Set<Integer> set2 = new HashSet<>(Arrays.stream(nums2).boxed().toList());
        set1.retainAll(set2);
        return Arrays.stream(set1.toArray(new Integer[0])).mapToInt(Integer::intValue).toArray();
    }
}
```
***
# References
1. https://leetcode.com/problems/intersection-of-two-arrays/description/
2. 