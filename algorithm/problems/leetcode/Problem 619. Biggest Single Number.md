#leetcode #sql #mysql 
# Algorithm
## Sub query
- Two nested queries are used:
	- The inner query is used to find <mark class="hltr-yellow">single numbers</mark>.
	- The outer query is used to find the <mark class="hltr-yellow">maximum</mark> number among these single numbers.
# Implementation
## MySQL
```MySQL title='Problem 619 in MySQL: Sub query solution'
# Write your MySQL query statement below
select max(num) as num from (
  select num
  from MyNumbers
  group by num
  having count(num) = 1
) as max_number
```
# Complexity
## Time complexity

## Space complexity

***
# References
1. https://leetcode.com/problems/biggest-single-number/description/
2. 