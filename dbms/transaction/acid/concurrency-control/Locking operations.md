#transaction #operating-system #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid #process-synchronization 

- For the original problem, see [Critical section problem](Critical%20section%20problem.md) 
# Locking
- Locking is an operation which <mark style="background: #e4e62d;">secures permission to read or to write </mark>a data item for a transaction.
- Unlocking is an operation which <mark style="background: #e4e62d;">removes these permissions</mark> from the data item.
- <mark style="background: #e4e62d;">Atomic</mark> operations.
# Types of locking
- ![](Pasted%20image%2020241212105924.png)
## Binary locks
- Also known as <mark style="background: #e4e62d;">mutex locks</mark> (mutual exclusions: loại trừ nhau $\equiv$ có A thì không có B, có B thì không có A).
- Has two states 0 (unlocked) or 1 (locked).
- If the value of lock on item X is 1, item X cannot be accessed by the operation that requests item X; otherwise, item X is accessible.
>[!important]
>Binary locks are the <mark class="hltr-yellow">most restrictive</mark> type of locking mechanism because it allows at most one transaction to hold a lock on a data item at a time. Other transactions have to wait until that transaction release the lock to be able to access the data item.
- ![](Pasted%20image%2020241211100132.png)
### Rules
- A transaction T must issue the operation lock_item(X) before any read_item(X) or write_item(X) operations in T. $\implies$ <mark style="background: #ADCCFFA6;">issue lock before accessing</mark>. 
- A transaction T must issue the operation unlock_item(X) after all read_item(X) and write_item(X) operations are completed in T. $\implies$<mark style="background: #ADCCFFA6;"> release locks right after completing</mark>.
- A transaction T will not issue a lock_item(X) operation if it  already holds the lock on item X. $\implies$ <mark style="background: #ADCCFFA6;">no double locking on a item.</mark>
- A transaction T will not issue an unlock_item(X) operation unless it already holds the lock on item X. $\implies$ <mark style="background: #ADCCFFA6;">no arbitrarily unlocking. </mark>
## Multi-mode locks
### Shared locks
- Also known as <mark style="background: #e4e62d;">Read locks</mark>.
- While a transaction hold a shared lock on a data item to read it, it <mark style="background: #e4e62d;">allows other transactions</mark> to hold that shared lock <mark style="background: #e4e62d;">for reading purposes</mark> only.
### Exclusive locks
- Also known as Write locks.
- <mark style="background: #e4e62d;">Only one</mark> transaction is allowed to hold an exclusive lock on a data item to write it at a time. Other transactions have to <mark style="background: #e4e62d;">wait until that transaction releases the lock</mark> to access the data item.
>[!Note]
>As a result, multi-mode locks are <mark class="hltr-yellow">less stringent</mark> than binary locks.

- ![](Pasted%20image%2020241211100321.png)
### Certify locks
- Only applied for [Multiversion concurrency control](Multiversion%20concurrency%20control.md)
- In MVVC, a transaction $T$ holding a write_lock on item $X$ allows another transaction $T'$ to acquire read_lock on item $X$ $\implies$ write_lock in MVVC is partially exclusive.
- However, certify lock is completely exclusive. Only one transaction holds a certify lock on a item at a time and it does not allow other transactions acquire locks on that item. 
### Rules
- A transaction T must issue the operation read_lock(X) or write_lock(X) before any read_item(X) operation is performed in T.  $\implies$ <mark style="background: #ADCCFFA6;">issue read lock or write lock before reading</mark>. 
- A transaction T must issue the operation write_lock(X) before any write_item(X) operation is performed in T $\implies$ <mark style="background: #ADCCFFA6;">issue  write lock before writing</mark>.
- A transaction T must issue the operation unlock(X) after all read_item(X) and write_item(X) operations are completed in T.
	- May be relaxed: unlock X, then lock X again.
	- Required by [Two-phase locking protocol](Two-phase%20locking%20protocol.md)
- A transaction T will not issue a read_lock(X) operation if it already holds a read (shared) lock or a write (exclusive) lock on item X.
	- May be relaxed for lock conversion.
- A transaction T will not issue a write_lock(X) operation if it already holds a read (shared) lock or write (exclusive) lock on item X.
	- May be relaxed for lock conversion.
- A transaction T will not issue an unlock(X) operation unless it already holds a read (shared) lock or a write (exclusive) lock on item X.
# Lock conversion
- Also known as Lock upgrade or Lock downgrade (depending on the scenario).
- A transaction that already holds a lock on item X is allowed under certain conditions to <mark style="background: #e4e62d;">convert the lock from one locked state to another</mark>:
	- Lock upgrade: read_lock(X) $\to$ write_lock(X).
		- Because a write lock is exclusive, there must be no transaction holding the lock of X.
	- Lock downgrade: write_lock(X) $\to$ read_lock(X).
# System lock table
- A <mark style="background: #e4e62d;">system lock table</mark> must be organized by DBMSs to know <mark style="background: #e4e62d;">which records are being locked</mark>.
- For binary locks, a record in lock table can be in the form $<\text{item\_name}, \text{LOCK}, \text{Locking\_transaction}>$.
- For multi-mode locks, a record in lock table can be in the form $<\text{item\_name}, \text{LOCK}, \text{No\_of\_reads}, \text{Locking\_transaction}>$

# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
2. [Mutex lock](operating-system/process/process-synchronization/locking-mechanism/Mutex%20lock.md)
3. [Critical section problem](Critical%20section%20problem.md)
4. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):*
	1. Chapter 21 - Section 1.
5. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
6. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.