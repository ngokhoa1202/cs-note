#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid 

- Refers to [Locking operations](Locking%20operations.md)
# Granularity level considerations
- The degree of concurrency is low for coarse granularity and high for fine granularity $\implies$ the coarser granularity level is, the slower performance is.
- Examples:
	- A field of a record.
	- A record.
	- A disk block.
	- A file.
	- The entire database.
# Multiple granularity locking
## Definition
- Data items are organized as a <mark style="background: #e4e62d;">tree</mark>.
- <mark style="background: #e4e62d;">Intention locks</mark> are employed by a transaction to indicate along the path from a root node to its child nodes which type of locks (shared or exclusive) are needed
	-  <mark style="background: #e4e62d;">Intention-shared</mark> (IS): indicates that a shared lock(s) will be requested on some descendant nodes(s).
	- <mark style="background: #e4e62d;">Intention-exclusive</mark> (IX): indicates that an exclusive lock(s) will be requested on some descendant node(s).
	- <mark style="background: #e4e62d;">Shared-intention-exclusive</mark> (SIX): indicates that the current node is locked in shared mode but an exclusive lock(s) will be requested on some descendant nodes(s).
- ![](Pasted%20image%2020241214075034.png)
## Rules
- The lock compatibility must adhered to.
- The root of the tree must be locked first, in any mode.
- A node N can be locked by a transaction T in S or IX mode only if the parent node is already locked by T in either IS or IX mode.
- A node N can be locked by T in X, IX, or SIX mode only if the parent of N is already locked by T in either IX or SIX mode.
- T can lock a node only if it has not unlocked any node (to enforce 2PL policy).
- T can unlock a node, N, only if none of the children of N are currently locked by T.
- ![](Pasted%20image%2020241214075833.png)
- ![](Pasted%20image%2020241214082815.png)
## Implications
- Enhance the degree of concurrency when mixed transactions are used:
	- Short transactions that access fine items.
	- Long transactions that access the entire file.
- Less transaction blocking and less locking overhead.

---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 5.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.
4. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
5. https://medium.com/@salimian/phantom-reads-the-hidden-problem-in-your-db-and-how-to-prevent-it-by-selecting-the-best-isolation-7ec74f966156 for phantom read concepts.
6. [Two-phase locking protocol](Two-phase%20locking%20protocol.md)
7. [Locking operations](Locking%20operations.md)
8. [Deadlock](dbms/transaction/acid/concurrency-control/Deadlock.md)
9. [Timestamp-ordering based concurrency control](Timestamp-ordering%20based%20concurrency%20control.md):
	1. [Timestamp](Timestamp-ordering%20based%20concurrency%20control.md#Timestamp)
