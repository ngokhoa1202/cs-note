#leetcode #sql #aggregate-function 
# Algorithm
## Aggregate `{SQL}count` function
# Implementation
## MySQL
```MySQL title='Problem 596 in MySQL: Aggregate count function solution'
# Write your MySQL query statement below
select courses.class as class
from courses
group by courses.class
having count(courses.student) >= 5;
```
# Complexity

***
# References
1. https://leetcode.com/problems/classes-with-at-least-5-students/description/
2. 