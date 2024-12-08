#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  

- These problems explain why concurrency control mechanism is needed among DBMSs.
# The Lost Update problem
- This occurs when two transactions that <mark style="background: #e4e62d;">access the same database items</mark> have their operations interleaved in a way that makes the value of some database item incorrect.
	- read operations and write operations interleave without locking mechanisms.
- ![](Pasted%20image%2020241208125218.png)
# The temporary update problem
- This occurs when one transaction updates a database item and then the transaction <mark style="background: #e4e62d;">fails</mark> for some reason. The updated item is <mark style="background: #e4e62d;">accessed by another transaction before it is changed back</mark> to its original value.
	- Transaction fails without roll-back mechanism.
- ![](Pasted%20image%2020241208125731.png)
--- 
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 1.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.