#algorithm #binary-search #binary-tree #binary-search-tree #tree #array #list 
# Algorithm
## Array representation
- The array must be monotone, either monotonically increasing or decreasing.
- The search interval is initialized to the whole array $\left[0, n\right]$
- The search interval is repeatedly halved as follow:
	- If the search key is in the middle of the interval, it is immediately returned.
	- If the search key is less than the item in the middle of the interval, narrow the interval to the lower half; otherwise narrow it to the upper half.
# Implementation

# Complexity
## Time complexity
- $O(\text{log}(n))$
## Space complexity
- $O(n)$
***
# References
1. 