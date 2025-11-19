#leetcode #sql 
# Algorithm
## Where statement
# Implementation
## MySQL
```MySQL title='Problm 595 in MySQL'
# Write your MySQL query statement below
select world.name as name,
       world.population as population,
       world.area as area
from world
where world.area >= 3000000 or world.population >= 25000000
```
# Complexity
## Time complexity

## Space complexity

***
# References
1. https://leetcode.com/problems/big-countries/description/
2. 