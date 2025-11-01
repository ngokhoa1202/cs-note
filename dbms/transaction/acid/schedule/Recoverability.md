#transaction #operating-system #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process 
#software-architecture #software-architecture #computer-architecture  #acid #concurrency-control #logging 

# Transaction schedule
## Definition
- Transaction schedule is the <mark style="background: #ADCCFFA6;">order of execution</mark> of operations when transactions are <mark style="background: #e4e62d;">concurrently executing in an interleaved fashion</mark>. 
- A schedule $S$ consists of $n$ transactions $T_1,T_2,...,T_n$:
	- For each transaction $T_i$, the order of execution of operations within $T_i$ must be maintained in $S$.
	- The operations from other transactions $T_{j \neq i}$ can be interleaved.
- Notation:
	- $r_i(X)$: Transaction $T_i$ reads item $X$.
	- $w_i(X)$: Transaction $T_i$ writes to item $X$.
	- $c_i$: Transaction $T_i$ commits
	- $a_i$: Transaction $T_i$ aborts.
## Examples
- Operations like $X := X-N,...$  are calculated on memory and has not been stored in disk yet.
- ![](Pasted%20image%2020241209092301.png) $$S_a: r_1(X), \space r_2(X), \space w_1(X), \space r_1(Y), \space w_2(X), \space w_1(Y);$$
- ![](Pasted%20image%2020241209092529.png) $$S_b:r_1(X), \space w_1(X), \space r_2(X), \space w_2(X), \space w_1(Y), \space a_1;$$
# Schedules classified on recoverability
## Recoverable schedules
- Recoverable schedules never roll back a committed transaction and hence ensure [Durability](Transaction%20processing.md#Durability) of ACID.
### Recoverable schedule
- A schedule $S$ is <mark style="background: #e4e62d;">recoverable</mark> if no transaction $T$ in $S$ commits until all transactions $T'$ that have already written the item read by $T$ have committed.
- If cascading rollback is allowed, an uncommitted transaction has to be rolled back in case it reads an item from another failed transaction. ($\rightarrow$ kéo theo). 
### Cascadeless schedule
- A schedule $S$ is <mark style="background: #e4e62d;">cascadeless</mark> if every transaction $T$ in the schedule <mark style="background: #e4e62d;">reads only items written by committed transactions</mark>.
>[!Important]
>Cascadeless schedules does not always guarantee serializability for transactions. Serializable schedules are not necessarily cascadeless.

- A cascadeless schedule does not insulate a transaction from writing to data items written by uncommitted transactions.
### Strict schedule
- A schedule $S$ is <mark style="background: #e4e62d;">strict</mark> if transactions can <mark style="background: #e4e62d;">neither read nor write</mark> an item $X$ until the last transaction $T$ that wrote $X$ has committed or aborted. $\implies$ transactions <mark class="hltr-yellow">never read temporary values</mark> updated by an uncommitted transaction.
- Most DBMSs employ strict schedule because it helps simplify the recovery process.

>[!Important]
>The order of recoverability degree of schedule: recoverable $\to$ cascadeless $\to$ strict.


## Non-recoverable schedules
- Non-recoverable schedules allow committed transaction to be rolled back and hence do not ensure [Durability](Transaction%20processing.md#Durability) of ACID.
- Non-recoverable schedules are not permitted by DBMSs by default.
# Examples
## Example 1
- $$S'_a: r_1(X), \space r_2(X), \space w_1(X), \space r_1(Y), \space w_2(X), \space w_2(Y), \space c_2, \space w_1(Y), \space c_1$$
- $S'_a$ is <mark style="background: #ADCCFFA6;">recoverable</mark> because neither $T_1$ nor $T_2$ has written $X$ and $Y$ before the other transaction reads.
- $S'_a$ is cascadeless because both $T_1$  and  $T_2$ read $X$ and $Y$ from committed transactions.
- $S'_a$ is not strict because $T_2$ has written to $X$ before $T_1$, which has written to $X$ before, commits
- $S'_a$ still suffers the <mark style="background: #ADCCFFA6;">lost update</mark> problem because the read and write operations of the two transactions are interleaved.
## Example 2
- $$S_b:r_1(X), \space w_1(X), \space r_2(X), \space w_2(X), \space w_1(Y), \space a_1;$$
- $S_b$ is <mark style="background: #ADCCFFA6;">recoverable</mark> because $T_1$ which has written to $Y$ is aborted before $T_2$.
- $S_b$ is not cascadeless because $T_2$ reads $X$ which has been written by uncommitted $T_1$
## Example 3
- $$S_c: r_1(X), \space w_1(X),\space r_2(X),\space r_1(Y),\space w_2(X),\space c_2,\space a_1$$
- $S_c$ is <mark style="background: #ADCCFFA6;">non-recoverable</mark> for the reason that $T_1$ which had written to $X$ that was read by $T_2$ had been aborted before the commit of $T_2$.
## Example 4
- $$S_d: r_1(X),  \space w_1(X), \space r_2(X), \space r_1(Y), \space w_2(X), \space w_1(Y), \space c_1, \space c_2$$
- $S_d$ is <mark style="background: #ADCCFFA6;">recoverable</mark>, but <mark style="background: #ADCCFFA6;">not cascadeless</mark>.
	- Transaction 1 which had written item X that was read by transaction 2 had committed before transaction 2.
	- However, transaction 2 could read the temporary value of item X before transaction 1  committed.
## Example 5
- $$S_e:r_1(X), \space w_1(X), \space r_2(X), \space r_1(Y), \space w_2(X), \space w_1(Y), \space a_1, \space a_2$$
- $S_e$ is <mark style="background: #ADCCFFA6;">recoverable</mark> but <mark style="background: #ADCCFFA6;">not cascadeless</mark>:
	- None of the two transactions successfully committed.
	- When executing, transaction 2 could read the temporary value of item X updated by item 1. 
	- It can be implied from the schedule that the abortion of transaction 1 leads to the abortion of transaction 2.
## Example 6
- $$S_f: r_1(X), \space w_1(X), \space r_1(Y), \space w_1(Y), \space c_1, \space r_2(X), \space w_2(X), \space c_2$$
- $S_f$ is <mark style="background: #ADCCFFA6;">strict</mark> for the simple reason that:
	- Transaction 1 had written item X and committed before transaction 2 read item X.
## Example 7
- $$S_g: r_1(X), \space r_2(Z), \space r_1(Z), \space r_3(X), \space r_3(Y), \space w_1(X), \space c_1, \space w_3(Y), \space c_3, \space r_2(Y), \space w_2(Z), \space r_2(Y), \space c_2$$
- $S_g$ is strict because:
	- No transaction read item X after transaction 1 had written item X and before transaction 1 committed.
	- No transaction read item Y after transaction 3 had written item Y and before transaction 3 committed.

# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 4.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu*.
3. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.
4. [Concurrency control problems](Concurrency%20control%20problems.md)
5. [Transaction processing](Transaction%20processing.md)
7. Database Systems: The Complete Book - H. G. Molina, J. D. Ullman, J. Widom, Prentice-Hall, 2009.