#transaction #operating-system #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #logging #acid 

- Also known as <mark style="background: #e4e62d;">No-Undo</mark> & <mark style="background: #e4e62d;">Redo</mark> recovery.
	- [No-steal flushing](Recovery%20concepts.md#No-steal%20flushing) for BFIM.
	- [No-force flushing](Recovery%20concepts.md#No-force%20flushing) for AFIM.
- Refers to [Deferred update](Recovery%20concepts.md#Deferred%20update).
- Adheres to [Write-Ahead Logging](Recovery%20concepts.md#Write-Ahead%20Logging).
# Deferred Update based Recovery
## Rules
- A transaction cannot change the database on disk until it reaches its commit point. $\implies$ all data items having been changed by that transaction must be <mark style="background: #ADCCFFA6;">pinned</mark> before the commit point.
- A transaction reaches its commit point only after all its <mark style="background: #ADCCFFA6;">REDO-type log</mark> records haven been written in the log and the log buffer is force written to the disk.
## Implications
- Only affected transactions which were recorded in the log a<mark style="background: #e4e62d;">fter the last checkpoin</mark>t were redone in case of system crash.
- Requires two tables:
	- Active table: for only active table at the time of system crash <mark style="background: #e4e62d;">since the last checkpoint</mark>. $\implies$ ignore.
	- Commit table: for transactions having committed at the time of system crash<mark style="background: #e4e62d;"> since the last checkpoint</mark>. $\implies$ redo.
# Examples
- ![](Pasted%20image%2020241214122048.png)

- Transaction 1 and transaction 4 committed after the checkpoint so they are redone. Transaction 2 and transaction 4 did not commit so they are ignored.![](Pasted%20image%2020241214122753.png)


# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 22 - Section 2.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. *HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu*.
4. [Transaction processing](Transaction%20processing.md) 
5. [Recoverability](Recoverability.md)
6. [Recovery problems](Recovery%20problems.md)
7. [Idempotent method](Idempotent%20method.md) for idempotent concepts.
8. [DBMS architecture](DBMS%20architecture.md)
9. [Recovery concepts](Recovery%20concepts.md)
10. [Write-Ahead Logging](Recovery%20concepts.md#Write-Ahead%20Logging)
11. 