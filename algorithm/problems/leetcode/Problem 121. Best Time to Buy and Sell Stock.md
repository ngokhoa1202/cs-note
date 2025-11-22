#leetcode #two-pointer #array #java 
# Algorithm
## Two pointers - sliding window
- Two variables $x$ and $y$ respectively represents the buy price and the sell price of the stocks. The stocks prices are denoted by $p_i$. The purpose is to find $\max(x-y)$
- The profit ending is maximized by finding the minimum of buy price $y_{min}$ and comparing the current profit at index $i$ with current profit.
- The algorithm is described as:
	- Initialize $x=p_0, y=0$
	- For each price:
		- $x=\min\{x,p_i\}$
		- $\max(y-x)=\max\{y, p_i-x\}$
	- 
# Implementation
## Java

# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
- The auxiliary space complexity is $O(1)$
***
# References
1. https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/
2. [[Maximum subarray problem#Kadane's algorithm]]
3. 