#leetcode #array #number-theory #java #go 
# Algorithm
## Optimized linear scan
- Do a linear scan for each number $n$ in the original array.
    - Do a linear scan from $2$ to $\lfloor \sqrt{n} \rfloor$ to calculate the sum and count each divisor $d$ of number $n$
    - If the number of divisors is $4$ , then add the sum of these divisors to the final sum.
# Implementation
## Java
### Optimized linear scan
```Java title='Problem 1390 in Java: Optimized linear scan solution'
class Solution {
  public int sumFourDivisors(int[] nums) {
    int sumOfDivisors = 0, noOfDivisors = 0, totalSum = 0;
    for (final var num: nums) {
      if (num == 1) continue;
      sumOfDivisors = num + 1;
      noOfDivisors = 2;
      for (int i = 2; i*i <= num; ++i) {
        if (num % i == 0 && i * i < num) {
          noOfDivisors += 2;
          sumOfDivisors += i + num / i;
        } else if (i * i == num) {
          noOfDivisors += 1;
          sumOfDivisors += i;
        }
        if (noOfDivisors > 4) {
          break;
        }
      }
      // System.out.println(noOfDivisors + " " + sumOfDivisors);
      if (noOfDivisors == 4) {
        totalSum += sumOfDivisors;
      }
    }
    return totalSum;
  }
}
```
## Go
### Optimized linear scan
```Go title='Problem 1390 in Go: Optimized linear scan solution'
func sumFourDivisors(nums []int) int {
  totalSum, sumOfDivisors, noOfDivisors := 0, 0, 0
  for _, num := range nums {
    if num == 1 {
      continue;
    }
    noOfDivisors, sumOfDivisors = 2, num + 1
    for i := 2; i*i <= num; i++ {
      if num % i == 0 {
        if i * i < num {
          noOfDivisors, sumOfDivisors = noOfDivisors + 2, sumOfDivisors + i + num / i
        } else {
          noOfDivisors, sumOfDivisors = noOfDivisors + 1, sumOfDivisors + i
        }
      }
      if noOfDivisors > 4 {
        break;
      }
    }
    if noOfDivisors == 4 {
      totalSum += sumOfDivisors
    }
  }
  return totalSum
}
```
# Complexity
- Let $\overline{m}$ be the expected value of elements in the array and $n$ be the length of the array respectively.  
## Time complexity
- The time complexity to calculate the sum of divisors and count the number of divisors of each element is $$\Theta\left(\frac{1}{\lfloor \sqrt{\overline{m}} \rfloor}\sum_{i=2}^{\lfloor\sqrt{\overline{m}}\rfloor}i\right)=\Theta(\sqrt{\overline{m}})$$
- The problem time complexity is $$\Theta(n)\Theta(\sqrt{\overline{m}})=\Theta\left(n\sqrt{\overline{m}}\right)$$
## Space complexity
- The space complexity is $\Theta(n)$.
- The auxiliary space complexity is $\Theta(1)$
***
# References
1. https://leetcode.com/problems/four-divisors/description/
2. 