b#dbms #relational-algebra #relational-model #relational-mapping #rdbms #query #algorithm #secondary-storage #sorting  

# Heuristic optimization process
- The parser of a high-level query generates an <mark style="background: #e4e62d;">initial internal representation</mark>.
- <mark style="background: #e4e62d;">Heuristics rules</mark> is applied to optimize the internal representation.
- A <mark style="background: #e4e62d;">query execution plan</mark> is generated to execute groups of operations based on the <mark style="background: #ADCCFFA6;">access paths</mark> available on the files involved in the query.
# Query tree
- Reflects a relational algebra expression. 
- It represents the input relations of the query as leaf nodes of the tree, and represents the relational algebra operations as internal nodes.
- ![](Pasted%20image%2020241215135548.png)![](Pasted%20image%2020241215135328.png)
# Heuristic optimization of query trees
- The task of heuristic optimization of query trees is to <mark style="background: #e4e62d;">find a final efficient query tree </mark>to execute.
## Query tree transformation
## Tutorial
- Set up initial (canonical) query tree for SQL query Q.
- Moving SELECT operations down the query tree.
- Apply more restrictive SELECT operation first. move relations with least cardinality to the leftmost of the query tree.
- Replacing Cartesian Product and Select with Join operation.
- Moving Project operations down the query tree.
## Examples
- ![](Pasted%20image%2020241215160517.png)
- ![](Pasted%20image%2020241215160529.png)
- ![](Pasted%20image%2020241215160537.png)
- ![](Pasted%20image%2020241215160543.png)
- ![](Pasted%20image%2020241215160552.png)

---
# References
1. [Relational Algebra](Relational%20Algebra.md)
2. [External sorting](External%20sorting.md)
3. *[Indexing structures](Indexing%20structures.md)*
4. [Algorithm for SELECT operation](Algorithm%20for%20SELECT%20operation.md)
5. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 19 - Section 1.
6. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
7. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.