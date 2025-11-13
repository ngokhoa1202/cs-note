#leetcode #sql 
# Algorithm

# Solution
## MySQL
```MySQL title='Solution 181 in MySQL'
# Write your MySQL query statement below
select employee.name as employee
from employee employee
inner join employee manager
    on employee.managerId = manager.id
where employee.salary > manager.salary
```

***
# References
1. https://leetcode.com/problems/employees-earning-more-than-their-managers/description/