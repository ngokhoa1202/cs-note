#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #acid 

# Transaction schedule
## Definition
- Transaction schedule is the <mark style="background: #ADCCFFA6;">order of execution</mark> of operations when transactions are <mark style="background: #e4e62d;">concurrently executing in an interleaved fashion</mark>. 
- A schedule $S$ consists of $n$ transactions $T_1,T_2,...,T_n$:
	- For each transaction $T_1$, the order of execution of operations within $T_1$ must be maintained in $S$.
	- The operations from other transactions $T_{j \neq i}$ can be interleaved.
- Notation:
	- ![](Pasted%20image%2020241209092058.png)
## Examples
- ![](Pasted%20image%2020241209092301.png) $$S_a: r_1(X), \space r_2(X), \space w_1(X), \space r_1(Y), \space w_2(X), \space w_1(Y);$$
- ![](Pasted%20image%2020241209092529.png) $$S_b:r_1(X), \space w_1(X), \space r_2(X), \space w_2(X), \space w_1(Y), \space a_1;$$
# Conflicting operations
## Conflicting condition
- Two operations in a schedule conflict if satisfy all these conditions:
	- Belong to two different transactions.
	- Access the same item $X$.
	- At least one of the two operations is write_item(X).
- ![](Pasted%20image%2020241209093540.png)
- ![](Pasted%20image%2020241209093840.png)
# Schedules classified on recoverability
## Recoverable schedules
- Recoverable schedules never roll back a committed transaction and hence ensure [Durability](Transaction%20processing.md#Durability) of ACID.
### Recoverable schedule
- A schedule $S$ is <mark style="background: #e4e62d;">recoverable</mark> if no transaction $T$ in $S$ commits until all transactions $T'$ that have written an item that $T$ reads have committed.
- If cascading rollback is allowed, an uncommitted transaction has to be rolled back in case it reads an item from another failed transaction. ($\rightarrow$ kéo theo). 
### Cascadeless schedule
- A schedule $S$ is <mark style="background: #e4e62d;">cascadeless</mark> if every transaction $T$ in the schedule <mark style="background: #e4e62d;">reads only items written by committed transactions</mark>. ($\rightarrow$ không cho phép kéo theo)
### Strict schedule
- A schedule $S$ is <mark style="background: #e4e62d;">strict</mark> if transactions can <mark style="background: #e4e62d;">neither read nor write</mark> an item $X$ until the last transaction $T$ that wrote $X$ has committed or aborted.
## Non-recoverable schedules
- Non-recoverable schedules allow committed transaction to be rolled back and hence do not ensure [Durability](Transaction%20processing.md#Durability) of ACID.

# Examples
- $$S'_a: r_1(X), \space r_2(X), \space w_1(X), \space r_1(Y), \space w_2(Y), \space c_2, \space w_1(Y), \space c_1$$
---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 4.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu*.
3. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.
4. [Concurrency control problems](Concurrency%20control%20problems.md)
5. [Transaction processing](Transaction%20processing.md)
7. Database Systems: The Complete Book - H. G. Molina, J. D. Ullman, J. Widom, Prentice-Hall, 2009.