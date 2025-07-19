#transaction #operating-system #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process
#software-architecture #software-architecture #computer-architecture  #acid #process-synchronization #deadlock
#graph-theory 

# Deadlock
- Deadlocks forms when two or more transactions wait for one another.
- ![](Pasted%20image%2020241211115725.png)
- There are two approaches for deadlock problem:
	- prevent a deadlock from occurring [Deadlock prevention protocols](#Deadlock%20prevention%20protocols).
	- allows a deadlock to occur, but the system is able to detect and resolve it [Deadlock detection & resolution](#Deadlock%20detection%20&%20resolution).
# Deadlock prevention protocols
- Suitable for heavy, long transactions.
- ...
# Deadlock detection & resolution
- Suitable for light, short transactions.
- The system checks if a state of deadlock actually exists, then select a victim and abort that transaction to resolve deadlock.
## Wait-for-graph
### Representation
- Given a directed graph $G=(N,E)$:
	- $N=\{T_i\}$ is the set of transactions.
	- $E$ is the set of waiting-for relationships of locking between transactions:
		- Each edge $e$ represents the fact that a transaction wants to lock an item which is being locked by another transaction.
- Each edge $e$ is drawn when transaction $T_i$ is<mark style="background: #e4e62d;"> waiting to lock an item</mark> $X$ that is <mark style="background: #e4e62d;">being locked</mark> by a transaction $T_j$. However, when transaction $T_j$ release the lock, edge $e$ is removed.
## Implications
- Deadlock exists if and only if the graph has <mark style="background: #e4e62d;">cycle</mark>.
---
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 8: Deadlocks.
2. [Mutex lock](Mutex%20lock.md)
3. [Critical section problem](Critical%20section%20problem.md)
4. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe  - Pearson (2015):*
	1. Chapter 21 - Section 1.
5. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
6. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.
7. [Serializability](Serializability.md)
8. [Locking operations](Locking%20operations.md)