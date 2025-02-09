#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #logging #acid 

- Has two versions:
	- Undo & No-Redo recovery.
	- Undo & Redo recovery.
- Refers to [Immediate update](Recovery%20concepts.md#Immediate%20update)
- Adheres to [Write-Ahead Logging](Recovery%20concepts.md#Write-Ahead%20Logging).
# Undo & No-redo algorithm
- Employs steal flushing for undo and force flushing for redo.
- All <mark style="background: #e4e62d;">uncommitted</mark> transactions are <mark style="background: #e4e62d;">undone</mark> in case of system crash because AFIMs are flushed to disk before a transaction commits.
- Committed transactions are not redone.
# Undo & Redo algorithm
## Rules
- Employs steal flushing for undo and no-force flushing for redo.
## Implications
- Undo operations of active transactions in active table at the time of system crash since the checkpoint
- Redo operations of transactions having committed in commit table at the time of system crash since the checkpoint.
## Examples
- ![](Pasted%20image%2020241214163858.png)

---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 22 - Section 3.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. *HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu*.
4. [Transaction processing](Transaction%20processing.md) 
5. [Recoverability](Recoverability.md)
6. [Recovery problems](Recovery%20problems.md)
7. [Idempotent method](Idempotent%20method.md) for idempotent concepts.
8. [DBMS architecture](DBMS%20architecture.md)
9. [Recovery concepts](Recovery%20concepts.md)
10. [Write-Ahead Logging](Recovery%20concepts.md#Write-Ahead%20Logging)
