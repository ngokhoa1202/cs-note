#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid 

# Multi-user environment
- Transaction processing are employed to serve multi-user system, especially to resolve <mark style="background: #e4e62d;">concurrency-related problems</mark> and <mark style="background: #e4e62d;">recovery-related problems</mark>.
- There are two types of concurrency execution:
	- <mark style="background: #ADCCFFA6;">Interleaved processing</mark>: concurrent execution of processes is interleaved in a single CPU.
		- One person has to do multiple tasks at the same time. However, at a specific time, he is able to do only one task and he switches among tasks if possible.
	- <mark style="background: #ADCCFFA6;">Parallel processing</mark>: processes are concurrently executed in multiple CPUs.
		- There are many tasks for many people to do. At a specific time, one person is able to do only one task. However, to a certain extent, these tasks can be independently executed by assigning one task to one person to do at a time.
# Interleave vs parallel
- Concurrent execution of processes is actually interleaved. Interleaving <mark style="background: #e4e62d;">keeps the CPU busy</mark> when a process requires an input or output (I/O) operation, such as reading a block from disk. The <mark style="background: #e4e62d;">CPU is switched to execute another process</mark> rather than remaining idle during I/O time $\equiv$ <mark style="background: #e4e62d;">context switching</mark>. Interleaving also prevents a long process from delaying other processes.
- If the computer system has multiple hardware processors (CPUs), parallel processing of multiple processes is possible
- ![](Pasted%20image%2020241208132240.png)
# Concurrency-related problems
- These problems explain why concurrency control mechanism is needed among DBMSs.
## The Lost Update problem
- This occurs when two transactions that <mark style="background: #e4e62d;">access the same database items</mark> have their operations interleaved in a way that makes the value of some database <mark style="background: #e4e62d;">item incorrect</mark>.
	- read operations and write operations interleave without locking mechanisms.
- ![](Pasted%20image%2020241208125218.png)
## The temporary update (dirty read) problem
- This occurs when one transaction updates a database item and then the transaction <mark style="background: #e4e62d;">fails</mark> for some reason. The updated item is <mark style="background: #e4e62d;">accessed by another transaction before it is changed back</mark> to its original value.
	- Transaction fails without roll-back mechanism.
- ![](Pasted%20image%2020241208125731.png)
## The incorrect summary problem
- If one transaction is calculating an <mark style="background: #e4e62d;">aggregate summary function</mark> on a number of records while<mark style="background: #e4e62d;"> other transactions are updating</mark> some of these records, the aggregate function may <mark style="background: #e4e62d;">calculate some values before they are updated</mark> and<mark style="background: #e4e62d;"> others after they are updated</mark>.
- ![](Pasted%20image%2020241208131512.png)
## The unrepeatable read problem
- This occurs when transaction $T$ reads the same item twice and the <mark style="background: #e4e62d;">item is changed</mark> by another transaction $T'$ between the two reads.
## The phantom read problem
-  This occurs when a transaction re-executes a <mark style="background: #e4e62d;">query</mark> returning a **set of rows** that satisfy a certain condition and finds that the set has <mark style="background: #e4e62d;">additional or fewer rows</mark> than it had during an earlier execution of the <mark style="background: #e4e62d;">same query</mark> $\equiv$ a phantom. This happens because another transaction **<mark style="background: #e4e62d;">inserted or deleted rows that affect the query’s result</mark> between the transaction’s two executions.


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
9. 
