#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid #process-synchronization 

# Timestamp
- A timestamp is a <mark style="background: #e4e62d;">unique identifier</mark> managed by DBMS to identify a transaction.
- Monotonically increasing, equivalent to a transaction start time $\implies$ The smaller timestamp is, the older transaction is.
- Denoted by $\text{TS}(T)$.
## Read timestamp
- Denoted by $\text{read\_TS}(X)$.
- The <mark style="background: #e4e62d;">largest</mark> timestamp among all the timestamps of transactions having successfully read X.
## Write timestamp
- Denoted by $\text{write\_TS}(X)$.
- The <mark style="background: #e4e62d;">largest</mark> timestamp among all the timestamps of transactions having successfully written X.
# Timestamp ordering algorithm
## Basic timestamp ordering algorithm
### Rules
- When a transaction $T$ issues a $\text{write\_item(X)}$ operation:
	- If $\text{read\_TS}(X) > \text{TS}(T)$ or $\text{write\_TS}(X) > \text{TS}(T)$, then abort and rollback $T$ with a new timestamp and reject the operation.
		- Because a younger transaction $T'$ have read or written item $X$.
	- Otherwise, execute $\text{write\_item(X)}$ within $T$ and set $\text{write\_TS}(X) = \text{TS}(T)$
- When a transaction $T$ issues a $\text{read\_item(X)}$ operation:
	- If  $\text{write\_TS}(X) > \text{TS}(T)$, then abort and rollback $T$ with a new timestamp and reject the operation.
		- Because a younger transaction $T'$ have written item $X$.
	- Otherwise,  execute $\text{read\_item(X)}$ within $T$ and set $\text{read\_TS}(X) = \text{max}\{\text{TS}(T),\space \text{read\_TS}(X)\}$
### Implications
- The schedules produced by Basic TO are serializable and deadlock-free.
- Cyclic restart and starvation still occurs if a transaction is continually  aborted and restarted.
### Examples
- ![](Pasted%20image%2020241211164855.png)
-  When $T_2$ issues $w_2(C)$ operation, $RT_C = 175 > \text{TS}(T_2) = 150$ which means there is a younger transaction $T_3$ having read item $C$. As a result, transaction $T_2$ is aborted.
## Strict timestamp ordering algorithm
### Rules
- When a transaction $T$ issues a $\text{write\_item(X)}$ or a  $\text{read\_item(X)}$ operation:
	- If $\text{TS}(T) > \text{write\_TS}(X)$, then delay transaction $T$ until the transaction $T'$ which have written $X$ terminates.
### Implications
- The schedules produced by Strict TO are serializable, deadlock-free in terms of serializability and strict in terms of recoverability.
- Cyclic restart and starvation do not occur because the younger transaction $T'$ is not aborted but waits for the older transaction $T$ to terminate.
- Longer transactions.
## Thomas's write rule
### Rules
- When a transaction $T$ issues a $\text{write\_item(X)}$ operation:
	- If $\text{read\_TS}(X) > \text{TS}(T)$, then abort and rollback transaction $T$ with a new timestamp and reject the operation.
	- If $\text{write\_TS}(X) > \text{TS}(T)$, ignore the write operation and continue execution. 
		- Because the write operation is already outdated and obsolete.
- When a transaction $T$ issues a $\text{read\_item(X)}$ operation:
	- If  $\text{write\_TS}(X) > \text{TS}(T)$, then abort and rollback $T$ with a new timestamp and reject the operation.
		- Because a younger transaction $T'$ have written item $X$.
	- Otherwise,  execute $\text{read\_item(X)}$ within $T$ and set $\text{read\_TS}(X) = \text{max}\{\text{TS}(T),\space \text{read\_TS}(X)\}$
### Implications
- The schedules produced by Thomas's write rule are not guaranteed to be serializable.
- The rejection of write operations is fewer and hence boosts transaction's performance.

---
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
2. [Mutex lock](Mutex%20lock.md)
3. [Critical section problem](Critical%20section%20problem.md)
4. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe  - Pearson (2015):*
	1. Chapter 21 - Section 2.
5. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
6. *HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.*
7. [Serializability](Serializability.md)
8. [Locking operations](Locking%20operations.md)
9. [Deadlock](dbms/transaction/acid/concurrency-control/Deadlock.md) for DBMS transaction deadlock.
10. [Deadlock](operating-system/process/Deadlock.md) for OS processes' deadlock.
11. https://dl.acm.org/doi/pdf/10.1145/320071.320076 for Thomas's write rules.