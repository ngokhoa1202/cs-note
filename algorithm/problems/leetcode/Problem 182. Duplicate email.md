#sql #leetcode 

# Algorithm
## Using `{SQL} count` aggregate function

## Joining itself

# Implementation
## MySQL
```MySQL title='Problem 182 in MySQL: solution 2'
select distinct person1.email
from person person1
inner join person person2
on person1.email = person2.email && person1.id != person2.id;
```

```MySQL title='Problem 182 in MySQL: solution 1'
select email
from person
group by email
having count(email) > 1;
```
***
# References
1. https://leetcode.com/problems/duplicate-emails/description/