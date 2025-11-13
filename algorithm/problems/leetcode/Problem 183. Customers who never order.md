#leetcode #sql 
# Algorithm
## `{SQL}not exists` clause

# Implementation
## MySQL
```SQL title='Problem 183 in MySQL'
select customers.name as customers
from customers
where not exists (select 1 from orders where orders.customerId = customers.id) ;
```
***
# References
1. https://leetcode.com/problems/customers-who-never-order/description/
2. 
