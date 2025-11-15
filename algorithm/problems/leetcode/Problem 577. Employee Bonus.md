#leetcode #sql #mysql 
# Algorithm
## Right join (or left join)
# Implementation
## MySQL
```MySQL title='Problm 577 in MySQL: Right join solution'
# Write your MySQL query statement below
select employee.name as name,
       bonus.bonus as bonus
from bonus
right join employee
  on bonus.empId = employee.empId
where bonus.bonus is null or bonus.bonus < 1000;
```
# Complexity
## Time complexity

## Space complexity

***
# References
1. 