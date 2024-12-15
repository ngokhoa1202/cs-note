#dbms #relational-algebra #relational-model #relational-mapping #rdbms #query #algorithm #secondary-storage #sorting  

- There are three ways to implement JOIN operation.
- Refers to [Disk storage](Disk%20storage.md)
# Nested-loop join
## Precondition
- None
- Brute-force approach.
## Algorithm
- For each record $t$ in relation $R$ (outer loop), retrieve every record $s$ from relation $S$ (inner loop) and test whether the two records satisfy the join condition $t[A] = s[B]$.
# Single-loop join
## Precondition
- An index or hash key exists for one of the two join attributes.
## Algorithm
- If an index (or hash key) exists on attribute  $B$ of relation $S$ — retrieve each record $t$ in R, one at a time, and then use the access structure to retrieve directly all matching records $s$ from $S$ that satisfy $s[B] = t[A]$.
# Sort-merge join
## Precondition
- Records of R and S are <mark style="background: #e4e62d;">physically sorted</mark>  by value of the <mark style="background: #e4e62d;">join
attributes</mark> A and B, respectively.
## Algorithm
- Both files are scanned in <mark style="background: #e4e62d;">order of the join attributes</mark>, matching the records that have the same values for A and B.
- Each record of each file is scanned only once for key attribute and needs removing duplicates for non-key attribute.
- ![](Pasted%20image%2020241214184433.png)
- ![](Pasted%20image%2020241214184524.png)
## Examples
- ![](Pasted%20image%2020241214184637.png)
- ![](Pasted%20image%2020241214184651.png)
- ![](Pasted%20image%2020241214184701.png)
- ![](Pasted%20image%2020241214184715.png)
- ...
# Hash join
## Precondition
- The records of files R and S are both hashed to the <mark style="background: #e4e62d;">same hash file</mark>, using the <mark style="background: #e4e62d;">same hash function</mark> on the <mark style="background: #e4e62d;">join attributes</mark> $A$ of relation $R$ and attribute $B$ of $S$ as hash keys.
## Algorithm
- A single pass through the file with <mark style="background: #ADCCFFA6;">fewer records</mark> (say, $R$) hashes its records to the hash file buckets.
- A single pass through the other file ($S$) then hashes each of its records to the appropriate bucket, where the record is combined with all matching records from $R$. 
- If the two hash values matches, then the two join attributes are checked for matching.

- In case the hash buckets fits the buffer:  we only hash and check in the buffer ![](Pasted%20image%2020241214185844.png)
- In case the hash buckets are greater than the buffer size: loads, hashes sub files into buffer and checks: ![](Pasted%20image%2020241214190135.png) ![](Pasted%20image%2020241214190147.png)

---
# References
1. [Relational Algebra](Relational%20Algebra.md)
2. [External sorting](External%20sorting.md)
3. *[Indexing structures](Indexing%20structures.md)*
4. [Algorithm for SELECT operation](Algorithm%20for%20SELECT%20operation.md)
5. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 18 - Section 3.
6. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
7. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.