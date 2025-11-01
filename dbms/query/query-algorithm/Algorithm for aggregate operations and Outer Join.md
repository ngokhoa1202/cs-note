#dbms #relational-algebra #relational-model #relational-mapping #rdbms #query #algorithm #secondary-storage #sorting  

# Algorithm for aggregate operations
## Algorithm for min-max operation
- Example `SELECT MAX(salary) FROM employee`
- If an (ascending) <mark style="background: #e4e62d;">B+ index</mark> on SALARY exists for the employee relation, then the index could be traversed for the largest value, which would entail following the <mark style="background: #e4e62d;">right most pointer</mark> in each index node from the root to a leaf.
## Algorithm for sum, count, average operation
- If a <mark style="background: #e4e62d;">dense index</mark> exists, the associated computation can be applied to the values in the index.
- In case of a non-dense index, the actual number of records associated with each index entry must be accounted for. 
- With GROUP BY, sorting or hashing on the group attributes is used to partition the file into groups; then aggregate function is computed in each group.
	- In case a clustering index exists in the grouping attributes, the file is already partitioned.
# Algorithm for Outer Joins operation
- Modified [Nested-loop join](Algorithm%20for%20JOIN%20operations.md#Nested-loop%20join)
- Modified [Sort-merge join](Algorithm%20for%20JOIN%20operations.md#Sort-merge%20join)


# References
1. [Relational Algebra](Relational%20Algebra.md)
2. [External sorting](External%20sorting.md)
3. *[Indexing structures](Indexing%20structures.md)*
4. [Algorithm for SELECT operation](Algorithm%20for%20SELECT%20operation.md)
5. [Algorithm for JOIN operations](Algorithm%20for%20JOIN%20operations.md)
6. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 18 - Section 3.
7. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
8. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.