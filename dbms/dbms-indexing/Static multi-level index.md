#indexing  #dbms #query #secondary-storage #file-system #sql #nosql #algorithm #sorting 
#algorithm-analysis #operating-system #file-system #data-structure #sorting 

# Multi-level index
- The rationale behind indexing structures is that the blocking factor of index files ${bfr}_{i}$ is significantly smaller than that of master files.
- The search space can keep shrinking by ${bfr}_i$ if the index file is indexed $\implies$ multilevel indexing structure.
- The blocking factor of index files ${bfr}_i$ is also known as <mark style="background: #e4e62d;">fan out</mark> $fo$.
# Static multilevel indexing search space
- ![](Pasted%20image%2020241110102629.png)
## Assumption
- The first index level has distinct value for $K(i)$ and fixed-length entries. (primary index, clustering index or secondary index)
- Block size $B$
- The number of records $r$ of master file.
- The number of records $r_i$ of index files.
- The number of blocks need for index level $i$ is $b_i$ 
- Records size $R$
- Index fan out $fo$
## Explanation
- The first index level is an ordered file containing <mark style="background: #e4e62d;">entry for each distinct value</mark> $K(i)$ of the master file  (depending on whether either primary index or clustering index is employed). $\implies$ $r_1$ entries. $$fo={bfr_1}$$$$b_1=\left \lceil \frac{r_1}{fo} \right \rceil \space (\text{blocks})$$
- The second index level is a primary index on the first level, each of its entry contain a block anchor to the corresponding block of the first level $\implies r_2$ entries.  $$r_2=b_1 \space (\text{records})$$ $$b_2= \left \lceil \frac{r_2}{fo} \right \rceil \space (\text{blocks})$$
- The third index level behaves similarly: $$r_3 = b_2$$ $$b_3=\left \lceil \frac{r_3}{fo} \right \rceil$$
- The process is repeated until all of the entries of level $t$ <mark style="background: #e4e62d;">fit in a single block</mark>. The $t$th index level is  also known as the top level.
## Generalization
- Each index level reduces the number of entries at the previous level by a factor of $fo$ 
- The maximum level that a multilevel indexing structure can have: $$t=\left \lceil \text{log}_{fo}(r_1) \right \rceil$$
- 
# Example
# References
1. *HCMUT Advanced DBMS Slides - Vo Thi Ngoc Chau.*
2. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015).*
	- Chapter 17: Indexing Structures for Files and Physical Database Design.
3. HCMUT Basic DBMS Slides - Truong Quynh Chi.
4. HCMUT Advanced DBMS Slides - Le Thi Bao Thu.