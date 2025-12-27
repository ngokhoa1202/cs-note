#leetcode #priority-queue #heap #sorting 
# Algorithm
## Priority queue
- A priority queue which is implemented with max heap is constructed from the `score` array.
- The maximum element of the queue is dequeued and transformed into the ranking result.
# Implementation
## Java
- `{Java}java.util.PriorityQueue` data structure is used to instantiate a priority queue object. `{Java}Collections.reverseOrder()` is passed as argument to specify that the priority queue is a max heap behind the scene.
- A `{Java}java.util.HashMap` data structure is used to reversely mapped the score to its index because of its uniqueness.
```Java title='Problem 506 in Java: Priority queue solution'
class Solution {
  public String[] findRelativeRanks(int[] scores) {
    final var pqueue = new PriorityQueue<Integer>(Collections.reverseOrder());
    final var indexMap = new HashMap<Integer, Integer>();
    String[] ranks = new String[scores.length];
    for (int i = 0; i < scores.length; ++i) {
      indexMap.put(scores[i], i);
    }

    for (final var score: scores) {
      pqueue.add(score);
    }
    var rankingCounter = 0;
    while (!pqueue.isEmpty()) {
      int score = pqueue.poll();
      rankingCounter++;
      ranks[indexMap.get(score)] = (rankingCounter == 1) ? "Gold Medal" : (rankingCounter == 2) ? "Silver Medal" : (rankingCounter == 3) ? "Bronze Medal" : String.valueOf(rankingCounter);
    }
    return ranks;
  }
}
```
# Complexity
## Time complexity

## Space complexity

***
# References
1. https://leetcode.com/problems/relative-ranks/description/
2. [[Heap sort]]
3. Algorithm Analysis and Design - Chau Thi Ngoc Vo - Ho Chi Minh City University of Technology.
	1. Chapter 4. Transform and Conquer.
		1. Section 4.3. Heaps and heap sort. 