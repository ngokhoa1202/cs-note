#leetcode #sql 
# Algorithm
## `{SQL}order by` statement
# Implementation
## MySQL
```MySQL title='Problem 620 in MySQL: order by statement solution'
# Write your MySQL query statement below
select *
from cinema
where mod(cinema.id, 2) = 1 and cinema.description != "boring"
order by cinema.rating desc;
```
***
# References
1. https://leetcode.com/problems/not-boring-movies/description/
2. 