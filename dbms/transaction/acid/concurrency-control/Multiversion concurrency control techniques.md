#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid #process-synchronization 

- Also known as MVVC techniques.
# Multiversion concurrency control techniques
- Multiversion concurrency control <mark style="background: #e4e62d;">keep copies of the old version</mark> of a data item when the item is written. $\implies$ there are two versions of data item: old version and new version.
- When a transaction requires access to an item, an <mark style="background: #e4e62d;">appropriate version is chosen</mark> to maintain the <mark style="background: #ADCCFFA6;">serializability</mark> of the currently executing schedule.
- Read operations are never rejected but being allowed to read the older version of data item to maintain serializability.
## Implications
- Improves concurrency because of fewer read operations' rejection.
- Requires significantly more storage (both RAM and disk) to keep multiple versions.
- Requires a garbage collector to reclaim allocated memory.
# Timestamp-ordering based Multiversion concurrency control
## Timestamp
- Refers to [Timestamp](Timestamp-ordering%20based%20concurrency%20control.md#Timestamp)
- Assume $X_1, \space X_2, ..., \space X_n$ are the versions of item $X$ created by write operations of transactions.
### Read timestamp
- Denoted by $\text{read\_TS}(X_i)$
- The <mark style="background: #e4e62d;">largest</mark> of all the timestamps of transactions that have successfully read version $X_i$.
### Write timestamp
- Denoted by $\text{write\_TS}(X_i)$
-  The timestamp of the transaction have written the value of version $X_i$.
	- Because each version $X_i$ is created by only one write operation.
## Rules
- If transaction $T$ issues a $\text{write\_item}(X)$ operation:
	- If a version $X_i$ has $\text{write\_TS}(X_i)=\text{max}\{{\text{write\_TS}(X_j) {\mid}_{j=\overline{1,n}}} \leq \text{TS}(T)\}$ and $\text{read\_TS}(X_i) > \text{TS}(T)$, then abort and rollback transaction $T$
	- Otherwise, create a new version $X_k$ of $X$ and set $\text{read\_TS}(X_k)=\text{write\_TS}(X_k)=\text{TS}(T)$
- If transaction $T$ issues a $\text{read\_item}(X)$ operation:
	- If a version $X_i$ has $\text{write\_TS}(X_i)=\text{max}\{{\text{write\_TS}(X_j) {\mid}_{j=\overline{1,n}}} \leq \text{TS}(T)\}$, then return the value of $X_i$ to transaction $T$ and set $\text{read\_TS}(X_i)=\text{max}\{\text{TS}(T), \space \text{read\_TS}(X_i)\}$
## Examples
- ![](Pasted%20image%2020241212102810.png)
# Multiversion two-phase locking using certify locks
- A variation of [Two-phase locking protocol](Two-phase%20locking%20protocol.md).
## Rules
- Multiversion 2PL allows other transactions $T'$ to read the<mark style="background: #e4e62d;"> committed version</mark> of item $X$ while a single transaction $T$ is holding a write lock on $X$
- When transaction $T$ writes item X, thereby creating a new version $X'$. If transaction $T$ wants to commit, it has to upgrade the type of lock being held from write_lock to <mark style="background: #e4e62d;">certify_lock</mark>. 
- The certify lock is completely exclusive and not compatible with any other locks. As a result, transaction $T$ may have to wait until other transactions $T$ release read_lock to acquire certify locks and commit.
## Implications
- Improves concurrency because of fewer read-write conflicts from different transactions.
- Significantly delay transaction's commit because of long time to acquire certify locks. $\implies$ longer transactions.
- Avoid cascading abortion and rollbacks because only committed version of items is allowed to be read by another transaction.
- Not deadlock-free.
---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 1.
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
