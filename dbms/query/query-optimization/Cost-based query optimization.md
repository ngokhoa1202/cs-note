#dbms #relational-algebra #relational-model #relational-mapping #rdbms #query #algorithm #secondary-storage #sorting  

- Refers to [Algorithm for SELECT operation](Algorithm%20for%20SELECT%20operation.md)
- Refers [Disk storage](Disk%20storage.md) for symbol.
# Symbol
- $x$: the number of index levels.
- $CSi$: Cost for method Si in block accesses
- $rX$: Number of records (tuples) in a relation $X$.
- $bX$: Number of blocks occupied by relation X (also referred to as $b$).
- $bfrX$: Blocking factor (i.e., number of records per block) in relation X
- $slA$: Selectivity of an attribute A for a given condition
- $sA$: Selection cardinality of the attribute being selected (= $slA \times r) \times A$: Number of levels of the index for attribute $A$
- $bI1A$: Number of first-level blocks of the index on attribute A
- $NDV (A, X)$: Number of distinct values of attribute A in relation X
# Cost function
- The unit of cost function is <mark style="background: #e4e62d;">one block access</mark>.
## Select operations
### Linear search
- Refers to [Linear search](Algorithm%20for%20SELECT%20operation.md#Linear%20search)
- If no record is found, this is the worst case $$C=b$$
- If a record is found, this is the average case $$C=\left \lceil \frac{b}{2} \right \rceil$$
### Binary search
- Refers to [Binary search on key](Algorithm%20for%20SELECT%20operation.md#Binary%20search%20on%20key)
- General cost $$C=\text{log}_2(b) + \left \lceil \frac{s}{bfr} \right \rceil -1$$ where $s$ is the estimated number of records which can be found in the SELECT statement.
- For equality condition on a unique attribute $s=1$ $$\implies C=\text{log}_2(b)$$
### Using primary index or hash key
- Refers to [Using primary index or hash key](Algorithm%20for%20SELECT%20operation.md#Using%20primary%20index%20or%20hash%20key)
- For primary index, cost is $$C=x+1$$ where $x$ is the number of index level.
- For static or linear hashing, cost is $$C=1$$
- For extendible hashing, cost is $$C=2$$ because of one additional directory needed to access the file.
### Using primary index to retrieve multiple records
- For comparison condition on a key attribute with an ordering index, cost is $$C=x+\left \lceil \frac{b}{2} \right \rceil$$ where $x$ is the number of index level.
### Using a clustering index to retrieve multiple records
- Refers to [Using a clustering index to retrieve multiple records](Algorithm%20for%20SELECT%20operation.md#Using%20a%20clustering%20index%20to%20retrieve%20multiple%20records)
- Cost is $$C=x+\left \lceil \frac{s}{bfr} \right \rceil$$ where $s$ the estimated number of records which can be found in the SELECT statement.
### Using a secondary (B+ tree) index on an equality condition
- Refers to [Using a secondary (B+ tree) index on an equality condition](Algorithm%20for%20SELECT%20operation.md#Using%20a%20secondary%20(B+%20tree)%20index%20on%20an%20equality%20condition)
- For equality condition, cost is $$C=x+s$$ if [Duplicate index entries](Single-level%20ordered%20indexes.md#Duplicate%20index%20entries) or [Pointer list $P(i)$](Single-level%20ordered%20indexes.md#Pointer%20list%20$P(i)$) mechanism is used. If [Indirection index level](Single-level%20ordered%20indexes.md#Indirection%20index%20level) is used, cost is $$C=x+s+1$$ where $s$ is the estimated selection cardinality.
- For comparison  condition, cost is $$C=x+ \left \lceil \frac{b_{i_1}}{2} \right \rceil + \left \lceil \frac{r}{2} \right \rceil$$ where $b_{i_1}$ is the number of blocks of the first index level.
### Conjunctive selection
- Refers to [Conjunctive selection using an individual index](Algorithm%20for%20SELECT%20operation.md#Conjunctive%20selection%20using%20an%20individual%20index)
- Use either S1 or one of the methods S2 to S6 to solve.
- For the latter case, use one condition to retrieve the records and then check in the memory buffer whether each retrieved record satisfies the remaining conditions in the conjunction.
## Join operations
- Join selectivity is  $$0 \leq \text{js}=\frac{|R \bowtie_{\text{cond}}S|}{|R| \times |S|} \leq 1$$
- The size of result is estimated: $$|R \bowtie_{\text{cond}}S| =\text{js} \times |R| \times |S|$$
### Nested-loop join
- In case of three-block memory buffer is used, cost is $$C=b_R + (b_R \times b_S) + \frac{\text{js} \times |R| \times |S|}{bfr_{RS}} $$ where $bfr_{RS}$ is the blocking factor of result file.
- In case of $n_B$-block memory buffer is used, cost is  $$C=b_R + (\left \lceil \frac{b_R}{n_B-2} \right \rceil \times b_S) + \left (\frac{\text{js} \times |R| \times |S|}{bfr_{RS}} \right ) $$
### Single-loop join
- Refers to [Single-loop join](Algorithm%20for%20JOIN%20operations.md#Single-loop%20join)
- The cost depends on the type of index.
- $s_B$ is the selection cardinality for the join attribute $B$ of $S$ - the average number of records that satisfy an equality condition on an attribute.
#### Secondary index
- Refers to [Secondary index](Single-level%20ordered%20indexes.md#Secondary%20index)
##### Duplicate entries and pointer list implementation
- Cost is $$C=b_R + (|R| \times (x_B + s_B)) + \left (\frac{\text{js} \times |R| \times |S|}{bfr_{RS}} \right )$$
##### Indirection index level
- Refers to [Indirection index level](Single-level%20ordered%20indexes.md#Indirection%20index%20level)
- Cost is $$C=b_R + (|R| \times (x_B + s_B+1)) + \left (\frac{\text{js} \times |R| \times |S|}{bfr_{RS}} \right )$$
#### Clustering index
- Refers to [Clustering index](Single-level%20ordered%20indexes.md#Clustering%20index)
- Cost is $$C=b_R+(|R| \times (x_B + \left \lceil \frac{s_B}{bfr_B} \right \rceil)) + \left (\frac{\text{js} \times |R| \times |S|}{bfr_{RS}} \right )$$
#### Primary index
- Refers to [Primary index](Single-level%20ordered%20indexes.md#Primary%20index)
- Cost is $$C=b_R + (|R| \times (x_B + 1)) + \left (\frac{\text{js} \times |R| \times |S|}{bfr_{RS}} \right )$$
#### Hash key
- If hash key exists for one of the two join attributes, cost is $$C=b_R + (|R| \times h) + \left (\frac{\text{js} \times |R| \times |S|}{bfr_{RS}} \right )$$ where $h \geq 1$ is the average number of block accesses to retrieve a record, given its hash key value.
### Sort-merge join
- Cost is $$C=C_S + b_R + b_S$$ where $C_S$ is the cost for sorting the two files.

---
# References
1.  [Relational Algebra](Relational%20Algebra.md)
2. [External sorting](External%20sorting.md)
3. *[Indexing structures](Indexing%20structures.md)*
4. [Algorithm for SELECT operation](Algorithm%20for%20SELECT%20operation.md)
5. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 19 - Section 1.
6. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
7. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.
8. 