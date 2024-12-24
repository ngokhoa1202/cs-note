#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid #process-synchronization 

- From [Serializability](Serializability.md), a serializable schedule is a correct schedule.
- [Multi-mode locks](Locking%20operations.md#Multi-mode%20locks) is employed for two-phase locking protocol.
- Two-phase locking protocols make schedules <mark style="background: #e4e62d;">serializable</mark>, but <mark style="background: #e4e62d;">not deadlock-free</mark>.
# Two-phase locking protocol
- Also known as 2PL.
- <mark style="background: #e4e62d;">A transaction</mark> follows the two-phase locking protocol if all locking operations <mark style="background: #e4e62d;">precede the first unlock</mark> operation in the transaction.
- Such a transaction has two phases:
	- <mark style="background: #e4e62d;">Expanding phase</mark>: Acquiring new locks without any release.
	- <mark style="background: #e4e62d;">Shrinking phase</mark>: Releasing existing locks without any acquisition.
- If lock conversion is allowed, then lock upgrade must be done during the expanding phase, and locks downgrade must be done in the shrinking phase.
- If <mark style="background: #e4e62d;">every transaction</mark> in a schedule <mark style="background: #e4e62d;">follows</mark> the <mark style="background: #e4e62d;">two-phase locking</mark> protocol, the schedule is <mark style="background: #e4e62d;">serializable</mark> and hence correct.
	- However, the two-locking protocol itself prohibits some possible serializable schedules.
- ![](Pasted%20image%2020241211105835.png)
- ![](Pasted%20image%2020241211105853.png)
# Variations of two-phase locking protocols
## Basic 2PL
- [Two-phase locking protocol](#Two-phase%20locking%20protocol)
## Conservative 2PL
- Also known as static 2PL.
- A transaction <mark style="background: #e4e62d;">locks</mark> all the items it accesses <mark style="background: #e4e62d;">before the transaction begin</mark> execution, by <mark style="background: #e4e62d;">predeclaring</mark> its read-set and write-set. If any of the predeclared items needed cannot be locked, the transaction <mark style="background: #e4e62d;">waits</mark> until all items are available.
- This is a deadlock-free protocol.
>[!Note]
>Read set is the set of items that the transaction would read.
>Write set is the set of items that the transaction would write.
>Static 2PL means read-set and write-set predeclaration.

## Strict 2PL
- Most well-known among DBMSs.
- A transaction T does <mark style="background: #e4e62d;">not release</mark> any of its <mark style="background: #e4e62d;">exclusive (write) locks until after it commits</mark> or aborts. 
- Hence, no other transaction can read or write an item that is written by T unless T has committed, leading to a [Strict schedule](Recoverability.md#Strict%20schedule) for recoverability. 
- This is not deadlock-free.
## Rigorous 2PL
- Rigorous 2PL is an extension of [Strict 2PL](#Strict%202PL)
-  A transaction T does <mark style="background: #e4e62d;">not release</mark> any of its <mark style="background: #e4e62d;">locks (shared or exclusive) until after it commits</mark> or aborts. 
- Hence, no other transaction can read or write an item that is written by T unless T has committed, leading to a
[Strict schedule](Recoverability.md#Strict%20schedule) for recoverability.
- This is not deadlock-free.

---
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
2. [Mutex lock](Mutex%20lock.md)
3. [Critical section problem](Critical%20section%20problem.md)
4. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe  - Pearson (2015):*
	1. Chapter 21 - Section 1.
5. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
6. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.
7. [Serializability](Serializability.md)
8. [Locking operations](Locking%20operations.md)
9. [Deadlock](dbms/transaction/acid/concurrency-control/Deadlock.md) for DBMS transaction deadlock.
10. [Deadlock](operating-system/process/Deadlock.md) for OS processes' deadlock.