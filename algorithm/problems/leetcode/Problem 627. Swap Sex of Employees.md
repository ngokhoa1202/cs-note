#leetcode #sql 
# Algorithm
## `{SQL} case...when`statement
# Implementation
## MySQL
```MySQL title='Problem 627 in MySQL: case when statement solution'
update salary
set sex = case sex
  when 'm' then 'f'
  else 'm'
end;
```
***
# References
1. https://leetcode.com/problems/swap-sex-of-employees/description/
2. 