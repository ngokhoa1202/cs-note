#transaction #operating-system #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid #process-synchronization 

- Also known as Validation (or Certification) concurrency control techniques.
- Acronym is OCC.
# Validation-based concurrency control
- Transaction serializability is checked only when transactions prepare to commit. $\implies$ optimistically.
- OCC has three phases.
## Read phase
- A transaction can read values of committed data items.
- However, updates are applied <mark style="background: #e4e62d;">only to local copies</mark> (versions) of the data items (in database cache).
## Validation phase
- Serializability is checked before transactions permanently write their updates to the database.
- This phase for $T_i$ checks that, for each transaction $T_j$ that is either committed or is in its validation phase, <mark style="background: #ADCCFFA6;">one of </mark>the following conditions holds (check from top to bottom):
	- $T_j$ completes its write phase before $T_i$ starts its read phase.
	- $T_i$ starts its write phase after $T_j$ completes its write phase, and the read_set of $T_i$ has no items in common with the write_set of $T_j$. 
	- $T_j$ completes its read phase before $T_i$ completes its read phase, and both the read_set and write_set of $T_i$ have no items in common with the write_set of $T_j$, 
- If none of the three conditions hold, $T_i$ is likely to interfere $T_j$ and therefore, $T_i$ is aborted.
## Write phase
- On a successful validation transactions’ updates are applied to the database; otherwise, transactions are restarted.

## Snapshot Isolation based concurrency control
- ...
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 4.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.
4. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
5. https://medium.com/@salimian/phantom-reads-the-hidden-problem-in-your-db-and-how-to-prevent-it-by-selecting-the-best-isolation-7ec74f966156 for phantom read concepts.
6. [Two-phase locking protocol](Two-phase%20locking%20protocol.md)
7. [Locking operations](Locking%20operations.md)
8. [Deadlock](dbms/transaction/acid/concurrency-control/Deadlock.md)
9. [Timestamp-ordering based concurrency control](Timestamp-ordering%20based%20concurrency%20control.md):
	1. [Timestamp](Timestamp-ordering%20based%20concurrency%20control.md#Timestamp)
