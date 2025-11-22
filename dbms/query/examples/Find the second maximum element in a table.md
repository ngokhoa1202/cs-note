#sql #mysql #relational-algebra #dbms  #postgresql #query 
# Algorithm
## Two max scan
- If the table has only one record, this query correctly returns `NULL`.
- Two scans are compatible with legacy databases, which does not support window functions.
- Two scans, one for sub query and one for outer query degrade the performance in massive datasets.
## `{SQL} limit`, `{SQL}offset` and `{SQL}select distinct`
- If the table has less than two records, the query returns an empty result set.
- `{SQL}distinct` keyword is used to prevent duplicate records.
## `{SQL} dense_rank()` function
- `{SQL}dense_rank()` function ranks a column based on a specific comparison factor without using `{SQL}distinct` keyword.
- Multiple records can share the same rank.
# Implementation
## MySQL
```MySQL title='Two max scan solution in MySQL'
select max(salary) as second_max_salary
from employee
where salary < (select max(salary)
                from employee)
```

```MySQL title='limit offset and select distinct solution in MySQL'
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1; // offset 0 is the largest entry
```

```MySQL title='dense_rank() function solution in MySQL'
WITH ranked_salary AS (
    SELECT 
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) as rank_num
    FROM employee
)
SELECT salary
FROM ranked_salary
WHERE rank_num = 2
LIMIT 1; -- Optional: returns just one row if multiple people share the 2nd salary
```
# Complexity

***
# References
1. https://leetcode.com/problems/second-highest-salary/description/
2. 