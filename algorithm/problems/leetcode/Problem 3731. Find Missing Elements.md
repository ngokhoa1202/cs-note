#go #leetcode #array #set #associative-array 
# Algorithm
## Set
- Use a *linear scan* to find the maximum element, minimum element and initialize a set to store distinct elements in the array.
- Keep performing a linear scan for integer numbers from the maximum element to the minimum element to check the existence of numbers. If it does not exist, then add it the final resulting array.
# Implementation
## Go
### Set
- Because Go does not have a built-int set data structure, the set is replaced with `map`.
```Go title='Problem 3731 in Go: Set solution'
func findMissingElements(nums []int) []int {
  maxEle, minEle, numbers := math.MinInt, math.MaxInt, make(map[int]bool, len(nums))
  for _, num := range nums {
    maxEle = max(maxEle, num)
    minEle = min(minEle, num)
    numbers[num] = true
  }
  missings := make([]int, maxEle - minEle + 1 - len(nums))
  i := -1
  for num := minEle; num <= maxEle; num++ {
    if !numbers[num] {
      i++
      missings[i] = num
    } 
  }
  return missings
}
```
# Complexity
## Time complexity
- The time complexity is $$T(n)=\Theta(2n)=O(n)$$
## Space complexity
- $\Theta(2n)=O(n)$
- The auxiliary space is $\Theta(n)=O(n)$
***
# References
1. https://leetcode.com/problems/find-missing-elements/description/
2. 