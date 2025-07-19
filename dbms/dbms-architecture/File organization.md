#dbms #secondary-storage #sql #nosql  #dbms-architecture  #data-structure #hash  #algorithm #algorithm-analysis #file-system #operating-system 

- The minimum unit to transfer data between main memory and secondary memory is a <mark style="background: #e4e62d;">block</mark>.
# Heap files
- Made up of <mark style="background: #e4e62d;">unordered records</mark>.
- Records are placed in the file in the order in which they are inserted. $\to$ giữ nguyên thứ tự.
## File operations

### Insertion
- Efficient ($\geq$ 1 block access).
- Copy the last block of the file into a buffer $\to$ add a new record to the block $\to$ rewritten the block back to disk.
### Searching
- Involves linear search.
- Average case: $\frac{b}{2}$  block accesses on average.
- Worst case: $b$ block accesses.
### Deletion
- First, search for the block $\implies$ $\frac{b}{2}$ block accesses.
- The found record is copied into the buffer $\to$ delete the record from the buffer $\to$ rewrite the block back to the disk.
- A <mark style="background: #e4e62d;">deletion marker</mark> is set to a certain value when deleting the record. The deleted record is hard deleted during the periodic block reorganization.
### Modification
#### Fixed-length record
- First, search for the block $\implies$ $\frac{b}{2}$ block accesses.
- The found record is copied into the buffer $\to$ modify the record in the buffer $\to$ rewrite the block back to the disk.
#### Variable-length record
- If the modified record still fits the old allocated space, the case is similar to [Fixed-length record](#Fixed-length%20record)
- Otherwise, modification requires deleting the old record, allocating new space and inserting a modified record.
### Sorting
- External sorting ...
# Ordered files
- Sorted based on the <mark style="background: #e4e62d;">ordering field</mark>.
## File operations
### Searching
#### Ordering field
- Binary search $\implies$ $log_2(b)$ block accesses on average.
#### Non-ordering field
- Linear search $\implies$ $\frac{b}{2}$ block accesses on average.
- Worst case: $b$ block accesses.
### Insertion
- First, search for the block on file.
- Expensive because the physical order must be maintained.
- There are many methods to maintain the order.
#### Unused space
- Keeps unused space in each block for new records.
#### Overflow file
- Keeps a temporary unordered file - <mark style="background: #e4e62d;">overflow file</mark> for inserting new records at the end.
- Periodically sort and merge the overflow file with the master file.
### Deletion
- First, searches for the block on file.
- Sets the deletion marker to a certain value.
- The database periodically hard deletes and reorganizes the file.
### Modification
- First, search for the block on file.
- If the ordering field is modified, the record position on the file must be changed to maintain the file order:
	- Deletes the old record.
	- Inserts the new record.
	- Reorganizes the file.
- If only the non-ordering fields are modified, the case is similar to [Heap file's record modification](#Modification)
# Hashing file
## Scenario
- Hashing for disk files are called <mark style="background: #e4e62d;">external hashing</mark> .
- The target address space is comprised of <mark style="background: #e4e62d;">buckets</mark>:
	- A bucket is either one disk <mark style="background: #ADCCFFA6;">block</mark> or multiple <mark style="background: #ADCCFFA6;">contiguous</mark> disk blocks.

- A hash function $f$ maps a field into a relative bucket number
- Bucket metadata must be stored in the file header.
-
- ![800x400](Pasted%20image%2020240914095743.png)

## Static hashing
- The number of buckets $M$ is always <mark style="background: #e4e62d;">fixed</mark>.
- A record pointer is used to point the overflown record in case of chaing.
- ![800x600](Pasted%20image%2020240915183033.png)
### File operations 
#### Searching
- Searching with <mark style="background: #e4e62d;">equality</mark> condition on hash field is constant $O(1)$ $\implies$ $\geq$ 1 block access.
- Searching with all other cases is linear search $\implies$ $\frac{b}{2}$ block accesses on average.
#### Insertion
- If there is no collision, $\geq$ 1 block access.
- In case there is collision $\implies$ resolve collision.
#### Deletion
- First, search the block on file.
- If the bucket has an overflow chain, we can replace the deleted record with one of the overflow records.
- If the record to be deleted is already in overflow, we simply remove it from the overflow linked list.
- A linked list of unused overflow locations in overflow is maintained to track empty positions in overflow.
#### Modification
- First, search the block on file.
- If the hash field is modified, the record can be moved to other buckets. The case is similar to [Heap file's record modification](#Modification)
### Disadvantages
- The number of buckets $M$ is always fixed $\implies$ difficult to expand the hashing address space.
- If the files are dynamic, we have to recalculate the number of buckets $M$, redistribute the records with a new hash function $\implies$ incur overhead. 
## Dynamic hashing
## Extendible hashing
- 
---
# References
1. HCMUT Advanced DBMS Slides - Vo Thi Ngoc Chau.
2. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 16 - Section 4.
