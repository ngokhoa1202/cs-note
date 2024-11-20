#indexing  #dbms #query #secondary-storage #file-system #sql #nosql #algorithm #sorting #algorithm-analysis #os #file-system #data-structure #sorting 

- Defined on a field or on a combination of fields of a file.
- Includes entries in the form of   $<\text{Field value}, \text{Pointer}>$. Denoted by $<K(i), P(i)>$ . $P(i)$ can be:
	- The physical address of a block (or page) in the file.
	- The record address made up of a block address and a record offset.
	- A logical address of the block or of the record.
- The index file is always ordered $\implies$ Time complexity for equality and comparison operator on indexing field is binary search $O(log(n))$ $\implies$ <mark style="background: #e4e62d;">Average block accesses</mark> to access data records: $log_2{b_i}+1$ in which $b_i$ is the number of block of the index file.
# Primary index
- Specified on the <mark style="background: #e4e62d;">ordering key field</mark> of an <mark style="background: #ADCCFFA6;">ordered</mark> file of records.
- There is <mark style="background: #e4e62d;">one index entry for each anchor record</mark> of data file:
	- Each key $K(i)$ is the same as the primary key of data file.
	- Each pointer $P(i)$ points to that block anchor.
- ![](Pasted%20image%2020241005174153.png)
>[!info]
> The first record in each block of data file is called the <mark style="background: #BBFABBA6;">anchor record</mark> or block anchor


## Characteristics
- <mark style="background: #e4e62d;">Sparse</mark> index:
	- The number of index entries is far smaller than the number of data records simply because one index entry's size is far smaller than a data record's size.
- Insertion and deletion is inefficient because the index file is already physically ordered:
	- It is prohibitive to move old records forwards or backwards to leave space for new records.
---
# Clustering index
- Specified on the <mark style="background: #e4e62d;">ordering non-key field</mark> of an <mark style="background: #ADCCFFA6;">ordered</mark> file of records.
- There is one index entry in the clustering index <mark style="background: #e4e62d;">for each distinct value</mark> of the clustering field:
	- Each key $K(i)$ of the index file is the same as each distinct value of that indexed field.
	- Each pointer $P(i)$ points to the first data block containing records with that field value.
	- Two pointer $P(i)$ may point to the same block in case a separate cluster of block is not allocated for each group of records which share the same clustering field value.
- An empty block is commonly allocated for each clustering value on data file in the beginning to alleviate the poor inefficiency of insertion and deletion.
- The block of data files may or may not contain a block anchor to another data block.
## Implementation
### Non block-anchor clustering index
- The block of data records contain only records of data files.
- ![](Pasted%20image%2020241005181942.png)

>[!Note]
> If a column has only distinct values, it is a candidate key (`UNIQUE NOT NULL` constraint in SQL syntax).
###  Block-anchor clustering index
- The block of data records keeps a <mark style="background: #e4e62d;">block pointer</mark> which <mark style="background: #e4e62d;">references to the following block</mark> in case the former block is unable to accommodate all records of a specific clustering value.
- ![](Pasted%20image%2020241005185905.png)
## Characteristics
- Sparse index:
	- Each index entry points to the first block which contains the corresponding clustering field value.
	- The number of index entries is equal to the number of distinct values of that clustering field.
- Insertion and deletion is inefficient because the index file is already physically ordered:
	- It is prohibitive to move old records forwards or backwards to leave space for new records.
> [!Important]
> A file is able to maintain at most one physically ordering field, so it can have at most either one primary index or one clustering index, but not both.


# Secondary index
- Specified on <mark style="background: #e4e62d;">any non-ordering field</mark> of a file of records:
	- The indexed field can be either candidate key or duplicate field.
- Provides a secondary means of access in case if a primary index or a clustering index file has already existed.
>[!Note]
>A data file is able to own multiple secondary indexes.


- ![](Pasted%20image%2020241006165702.png)
## Implementation
### Duplicate index entries
- There is <mark style="background: #e4e62d;">one entry for each record</mark> of data file:
	- Each key $K(i)$ is the same as the indexed field.
	- Each pointer $P(i)$ points the block or the record owning that field $\implies$ index entry is <mark style="background: #e4e62d;">fixed-length</mark>.
- ![](Pasted%20image%2020241006173350.png)
### Pointer list $P(i)$
- There is one index entry for <mark style="background: #e4e62d;">each distinct value</mark> of the indexed field.
	- The index key $K(i)$ is the same as that clustering field.
	- Each entry keeps <mark style="background: #e4e62d;">a list of pointers</mark> $<P(i,1), P(i,2), P(i,3),...,P(i,n)>$ . Each of pointer points to the block or the record containing that indexed field. $\implies$ index entry must be variable-length.
- ![](Pasted%20image%2020241006174351.png)
### Indirection index level
- There is one index entry for <mark style="background: #e4e62d;">each distinct value</mark> of the indexed field:
	- The index key $K(i)$ is the same as that clustering field.
	- Create an <mark style="background: #e4e62d;">extra level of indirection</mark> to resolve multiple pointers caused by repetitive values of the indexed field.
	- The first index entry representing a distinct value of the indexed field points to the block containing the group of pointers of records with respect to that distinct value. The second level ends up pointing a specific record.
- If a single block is unable to accommodate a group of records, a cluster or a linked list of block is allocated.
## Characteristics
- Dense index.
	- Each index entry at the final level ends up pointing to each record of the data file.
	- Provides a *logical ordering* for data file.
- Insertion and deletion is inefficient because the index file is already physically ordered:
	- Index maintenance for [Duplicate index entries](#Duplicate%20index%20entries) is <mark style="background: #e4e62d;">most expensive</mark> because it is prohibitive to move old records forwards or backwards to leave space for new records.
	- Index maintenance for [Pointer list P(i)](#Pointer%20list%20$P(i)$) is <mark style="background: #e4e62d;">less expensive</mark> because a list of pointers is allocated in the beginning. However, when that list is full, moving index entries is inevitable and the cost grows exponentially.
	- Index maintenance for [Indirection index level](#Indirection%20index%20level) is<mark style="background: #e4e62d;"> least expensive</mark> because the index file is separated into the two levels. However, when the block of record pointers become full, memory allocation is required.
---
# References
1. *HCMUT Advanced DBMS Slides - Vo Thi Ngoc Chau.*
2. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015).*
	- Chapter 17: Indexing Structures for Files and Physical Database Design.
3. HCMUT Basic DBMS Slides - Truong Quynh Chi.
4. HCMUT Advanced DBMS Slides - Le Thi Bao Thu.

