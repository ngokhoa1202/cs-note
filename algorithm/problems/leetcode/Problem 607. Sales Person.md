#leetcode #sql #mysql #relational-algebra 
# Algorithm
## `{SQL} not exists` statement
- All the orders related to the company whose name is "RED" is found in one query.
- `{SQL} not exists` statement is used to exclude all the salesperson participated in those orders.
# Implementation
## MySQL
```MySQL title='Problem 607 in MySQL: not exists statement approach'
# Write your MySQL query statement below
select name
from salesperson
where not exists (select *
                  from orders
                  inner join company
                    on orders.com_id = company.com_id
                  where company.name = 'RED' and orders.sales_id = salesperson.sales_id);
```
# Complexity
## Time complexity

## Space  complexity

***
# References
1. https://leetcode.com/problems/sales-person/description/
2. 