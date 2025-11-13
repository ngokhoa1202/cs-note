#leetcode #sql #postgresql #microsoft-sql-server 
# Algorithm
## Correlated query - naive approach

# Implementation
## PostgreSQL
- The subtraction operation can be directly performed on `Date` object on PostgreSQL.
```PostgreSQL title='Problem 197 in PostgreSQL: correlated query'
select id
from weather today
where today.temperature > (select temperature 
                           from weather yesterday
                           where yesterday.recordDate = today.recordDate - 1
                          )
```
## Microsoft SQL Server
- The `{SQL}DATEDIFF` function is used to calculate day difference between the two timestamp.
```SQL title='Problem 197 in Microsoft SQL Server: correlated query'
select id
from weather today
where today.temperature > (select temperature 
                           from weather yesterday
                           where datediff(day, yesterday.recordDate, today.recordDate) = 1
                          )
```

---
# References
1. https://leetcode.com/problems/rising-temperature/description/
2. https://learn.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql?view=sql-server-ver17
3. 