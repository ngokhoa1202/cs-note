#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #thread 

# Multi-user environment
- Transaction processing are employed to serve multi-user system, especially to resolve <mark style="background: #e4e62d;">concurrency-related problems</mark>.
- There are two types of concurrency execution:
	- <mark style="background: #ADCCFFA6;">Interleaved processing</mark>: concurrent execution of processes is interleaved in a single CPU.
		- One person has to do multiple tasks at the same time. However, at a specific time, he is able to do only one task and he switches among tasks.
	- <mark style="background: #ADCCFFA6;">Parallel processing</mark>: processes are concurrently executed in multiple CPUs.
		- There are many tasks for many people to do. At a specific time, one person is able to do only one task. However, to a certain extent, these tasks can be independently executed by assigning one task to one person to do at a time.
# Transaction
- A  transaction is a <mark style="background: #e4e62d;">logical</mark> unit of database processing.
	- read-only transactions vs read-write transactions.
	- transaction boundaries: `begin` ... `end`
- <mark style="background: #e4e62d;">Granularity</mark> of a data item is the size of that data item within a transaction such as a field, a record, a table, or a disk block. $\rightarrow$ <mark style="background: #e4e62d;">tầm vực, độ mịn</mark> của dữ liệu.
- There are two basic operations within a transaction:
	- read_item(X)
	- write_item(X)
## read_item(X)
- Find the address of the disk block that contains item X.
- Copy that disk block into a buffer in main memory if that disk block is not already in some main memory buffer.
- Copy item X from the buffer to the program variable named X.
## write_item(X)
- Find the address of the disk block that contains item X.
- Copy that disk block into a buffer in main memory if that disk block is not already in some main memory buffer.
- Copy item X from the program variable named X into its correct location in the buffer.
- Store the updated block from the buffer back to disk either immediately or at some later point in time.


---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 1.
2. *HCMUT Advanced DBMS Slide - Le Thi Bao Thu.*
3. HCMUT Advanced DBMS Slide - Vo Thi Ngoc Chau.