#acid #transaction #concurrency-control #dbms-architecture #rbdms 

- The following isolation level grows from the lowest isolation level to the highest isolation level coming with highest cost and degradation of performance and scalability.

| Anomaly / Problem       | Read Uncommitted | Read Committed | Repeatable Read | Serializable |
| ----------------------- | ---------------- | -------------- | --------------- | ------------ |
| **Lost Update**         | Yes              | Yes            | No              | No           |
| **Dirty Read**          | Yes              | No             | No              | No           |
| **Non-Repeatable Read** | Yes              | Yes            | No              | No           |
| **Incorrect Summary**   | Yes              | Yes            | Yes             | No           |
- <mark class="hltr-yellow">Read committed</mark> is the default isolation level among the DBMSs and ORM frameworks on a regular basis. 
---
# References
1. Database System Concepts, 6th Edition - Abraham Silberschatz, Henry F. Korth, S. Sudarshan - McGrawn Hill (2010).
	1. Chapter 14: Transactions.
		1. Section 14.8 Transaction isolation levels.
2. [Concurrency control problems](Concurrency%20control%20problems.md)
3. 