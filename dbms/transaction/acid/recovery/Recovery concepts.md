#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #logging #acid 

- Refers to [Recovery problems](Recovery%20problems.md)
# Transaction log
- Transaction log is a heap file storing recovery information:
	- BFIM - Before Image - the data value prior to modification.
	- AFIM - After Image - the data value after modification.
	- Back P - Back Pointer - points to the previous log record of the same transaction.
	- Next P - Next Pointer - points to the next log record of the same transaction.
- ![](Pasted%20image%2020241214092152.png)
# Data updates
## Immediate update
- <mark style="background: #e4e62d;">As soon as</mark> a data item is modified in cache, the disk copy is updated.
- Used for non-catastrophic transaction failures.
## Deferred update
- All modified data items in the cache are written either after a t<mark style="background: #e4e62d;">ransaction ends</mark> its execution or after a fixed number of transactions have completed their execution.
- Used for non-catastrophic transaction failures.
## Shadow update
- The modified version of a data item does <mark style="background: #e4e62d;">not overwrite</mark> its disk copy but is <mark style="background: #e4e62d;">written at a separate disk location</mark>.
## In-place update
- The disk version of the data item is <mark style="background: #e4e62d;">overwritten by</mark> the <mark style="background: #e4e62d;">cache</mark> version.
# Data recovery operations
- Undo and redo are idempotent.
## Undo
- Also known as rollback.
- Reverse data changes by <mark style="background: #e4e62d;">undoing write</mark> operations of <mark style="background: #ADCCFFA6;">uncommitted</mark> transactions. $\implies$ restore all BFIMs on disk.
- The undo order is reverse of execution order.
## Redo
- Also known as roll-forward.
- Redo operations of <mark style="background: #ADCCFFA6;">committed</mark> transactions.
- The redo order is the same as the execution order.
# Data caching
- Managed and flushed by a [Buffer manager](DBMS%20architecture.md#Buffer%20manager)
- The flushing is controlled by:
	- <mark style="background: #e4e62d;">Pin-Unpin</mark> bit: If a page is pinned (bit 1), it cannot be written back to disk as yet; therefore, the operating system should <mark style="background: #e4e62d;">not flush</mark> that page.
	- <mark style="background: #e4e62d;">Dirty</mark> bit (Modified bit): If a page is dirty (bit 1), it has been modified and hence it is AFIM of data item.
## Data flushing
- There are four ways to flush database cache from RAM to disk.
>[!tip]
>Steal $\equiv$ undo
>No-force $\equiv$ redo



- The combination of steal/no-steal and force/no-force produces 4 ways to handle recovery:
	- Steal & No-Force $\to$ Undo & Redo:
		- Most used because of small buffer & less I/O cost.
	- Steal & Force $\to$ Undo & No-Redo.
	- No-Steal & No-Force $\to$ No-undo & Redo.
	- No-Steal & Force $\to$ No-undo & No-redo.
### Steal flushing
- A cache buffer page can be flushed <mark style="background: #e4e62d;">before</mark> the transaction <mark style="background: #e4e62d;">commits</mark>.
- Require smaller buffer space to store updated pages.
### No-steal flushing
- A cache buffer page <mark style="background: #e4e62d;">cannot</mark> be flushed before the transaction commits.
- Requires large buffer space to store updated pages.
- Errors can occur on disk.
- Needs a garbage collector.
### Force flushing
- <mark style="background: #e4e62d;">All</mark> the updated pages are <mark style="background: #e4e62d;">immediately</mark> flushed to disk before the transaction commits. (forced)
- Requires high I/O cost because buffer must regularly access the disk.
- Errors only occur on RAM. 
- Does not need a garbage collector.
### No-force flushing
- All the updated pages are <mark style="background: #e4e62d;">deferred</mark>  to flush before the transaction commits. (not forced - can wait).
- Requires lower I/O cost because buffer is less likely to access the disk.
# Write-Ahead Logging
- Also known as WAL.
- Write-Ahead Logging must ensure:
	- For undo: Before a data item’s AFIM is flushed to the database disk (overwriting the BFIM), its <mark style="background: #e4e62d;">BFIM</mark> must be <mark style="background: #e4e62d;">written to the log</mark> and the <mark style="background: #e4e62d;">log must be saved</mark> on a log disk.
	- For redo: Before a transaction commits, all its <mark style="background: #e4e62d;">AFIMs</mark> must be <mark style="background: #e4e62d;">written to the log</mark> and the log must be saved on a log disk.
# Checkpoint
- The database <mark style="background: #e4e62d;">periodically flushes</mark> its buffer to disk to minimize the task of recovery.
- A checkpoint's operations include:
	- Suspend execution of active transactions temporarily.
	- Force write modified buffer data from RAM to disk.
	- Write a checkpoint record to the log, save the log to disk.
	- Resume normal transaction execution.
- High I/O cost for force-write causes long delay for transaction.
## Fuzzy checkpoint
- Transaction is <mark style="background: #e4e62d;">resumed processing</mark> after a <mark style="background: #e4e62d;">begin_checkpoint</mark> record is written to  the log without having to wait for completing force write.
- When step 2 is completed, an end_checkpoint record is written to the log.
- A file containing a pointer to the valid checkpoint is kept on disk to keep the checkpoint valid.
---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 22 - Section 1.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. *HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu*.
4. [Transaction processing](Transaction%20processing.md) 
5. [Recoverability](Recoverability.md)
6. [Recovery problems](Recovery%20problems.md)
7. [Idempotent method](Idempotent%20method.md) for idempotent concepts.
8. [DBMS architecture](DBMS%20architecture.md)