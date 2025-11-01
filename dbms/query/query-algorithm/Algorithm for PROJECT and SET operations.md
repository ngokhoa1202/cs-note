#dbms #relational-algebra #relational-model #relational-mapping #rdbms #query #algorithm #secondary-storage #sorting  

- Denoted by $\pi_{a_1,a_2,...,a_n}(R)$
# Algorithm for PROJECT operation
- If attribute list has a key of relation R, retrieve <mark style="background: #e4e62d;">all</mark> tuples from $R$.
- If attribute list does not include a key attribute, remove duplicates.
# Algorithm for SET operations
## Union operations
- Sort the two relations on the same attributes.
- Scan and merge both sorted files concurrently, whenever the same tuple exists in both relations, <mark style="background: #e4e62d;">only one</mark> is kept in the merged results.
- ![](Pasted%20image%2020241214192424.png)
## Intersection
- Sort the two relations on the same attributes.
- Scan and merge both sorted files concurrently, keep in the merged results only those tuples that appear in <mark style="background: #e4e62d;">both relations</mark>.
- ![](Pasted%20image%2020241214192434.png)
## Set difference
- Sort the two relations on the same attributes.
- Keep in the merged results only those tuples that appear in relation $R$ but not in relation $S$.
- ![](Pasted%20image%2020241215132500.png)
1. [Relational Algebra](Relational%20Algebra.md)
2. [External sorting](External%20sorting.md)
3. *[Indexing structures](Indexing%20structures.md)*
4. [Algorithm for SELECT operation](Algorithm%20for%20SELECT%20operation.md)
5. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 18 - Section 3.
6. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
7. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.