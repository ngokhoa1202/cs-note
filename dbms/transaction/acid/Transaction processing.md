#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #thread #acid 

# Transaction
- A  transaction is a <mark style="background: #e4e62d;">logical</mark> , <mark style="background: #e4e62d;">atomic</mark> unit of work in DBMS that should either be completed in its entirety or not done at all
	- read-only transactions vs read-write transactions.
	- transaction boundaries: `begin` ... `end`
- <mark style="background: #e4e62d;">Granularity</mark> of a data item is the size of that data item within a transaction such as a field, a record, a table, or a disk block. $\rightarrow$ <mark style="background: #e4e62d;">tầm vực, độ mịn</mark> của dữ liệu.
## Transaction states
- ![](Pasted%20image%2020241208133944.png)
## Transaction basic operations
## read_item(X)
- Find the address of the disk block that contains item X.
- Copy that disk block into a buffer in main memory if that disk block is not already in some main memory buffer.
- Copy item X from the buffer to the program variable named X.
## write_item(X)
- Find the address of the disk block that contains item X.
- Copy that disk block into a buffer in main memory if that disk block is not already in some main memory buffer.
- Copy item X from the program variable named X into its correct location in the buffer.
- Store the updated block from the buffer back to disk either immediately or at some later point in time.
# Commit point
- A transaction reaches its commit point if:
	- all its <mark style="background: #e4e62d;">operations</mark> that access the database have been <mark style="background: #e4e62d;">executed successfully</mark>.
	- the effect of all the transaction operations on the database has been <mark style="background: #e4e62d;">recorded</mark> in the log.
- After having been committed, and its effect is <mark style="background: #e4e62d;">permanently</mark> recorded in the database. The transaction then writes an entry \[commit,T\] into the log.

# Desirable properties of transaction
- DBMS transaction must have ACID properties.
## Atomicity
- A transaction should be either successfully executed in its <mark style="background: #e4e62d;">entirety</mark> or <mark style="background: #e4e62d;">not performed at all</mark>.
- If a transaction fails, the recovery mechanism must <mark style="background: #e4e62d;">undo any effects</mark> of that transaction on the database.
## Consistency
- A correct execution of the transaction must take the database from <mark style="background: #e4e62d;">one consistent state</mark> to another consistent state.
## Isolation
- A transaction should appear <mark style="background: #e4e62d;">as though</mark> it is being executed <mark style="background: #e4e62d;">in isolation</mark> from other transaction. That is, the execution of a transaction <mark style="background: #e4e62d;">should not be interfered</mark> with by any other transaction executing concurrently.
## Durability
- Once a transaction changes the database and the changes are committed, these changes <mark style="background: #e4e62d;">must never be lost</mark> because of subsequent failure.
# Concurrency control problems
- [Concurrency control problems](Concurrency%20control%20problems.md)
# Recovery problems
- [Recovery problems](Recovery%20problems.md)
---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 1.
2. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
3. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.
4. [Concurrency control problems](Concurrency%20control%20problems.md)
5. Database Systems: The Complete Book - H. G. Molina, J. D. Ullman, J. Widom, Prentice-Hall, 2009.
