#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process 
#software-architecture #software-architecture #computer-architecture  #acid #concurrency-control #graph-theory 

# Serial transaction
- A schedule $S$ is <mark style="background: #e4e62d;">serial</mark> if for every transaction $T$ participating in the schedule, <mark class="hltr-yellow">all</mark> the <mark class="hltr-yellow">operations</mark> of T <mark class="hltr-yellow">are executed consecutively</mark> in the schedule.
- Interleaving transactions' operations is not allowed in a serial schedule.
- A serial schedule is always a <mark class="hltr-yellow">correct</mark> schedule.
- Serial schedules ![](Pasted%20image%2020241209142213.png)
- Non-serial schedules: ![](Pasted%20image%2020241209142236.png)
# Serializable transaction
- A schedule $S$ is serializable if it is <mark style="background: #e4e62d;">equivalent to some serial schedule</mark> of the same $n$ transactions.
- Being serializable implies that the schedule is a <mark style="background: #e4e62d;">correct</mark> schedule:
	- It will leave the database in a <mark style="background: #e4e62d;">consistent</mark> state.
	- The interleaving is appropriate and will result in a state <mark style="background: #e4e62d;">as if the transactions were serially executed</mark>, yet will achieve <mark style="background: #e4e62d;">efficiency</mark> due to concurrent execution. $\implies$ concurrency without blocking.
# Transaction serializability
## Result equivalence
- Two schedules are <mark style="background: #e4e62d;">result equivalen</mark>t if they produce the <mark style="background: #e4e62d;">same final state</mark> of database.
## Conflicting condition
- Two operations in a schedule conflict if satisfy all these conditions:
	- Belong to two different transactions.
	- Access the same item $X$.
	- At least one of the two operations is write_item(X).
- ![](Pasted%20image%2020241209093540.png)
- ![](Pasted%20image%2020241209093840.png)

## Conflict equivalence
-  Two schedules are said to be <mark style="background: #e4e62d;">conflict equivalent</mark> if the <mark style="background: #e4e62d;">order of any two conflicting operations is the same</mark> in both schedules.
## Conflict serializability
- A schedule $S$ is said to be conflict[^1] serializable if it is conflict[^2] equivalent to some <mark class="hltr-yellow">serial</mark> schedule $S'$.
- In such a case, we can<mark style="background: #e4e62d;"> reorder</mark> the non-conflicting operations in S <mark style="background: #e4e62d;">until we form the equivalent serial</mark> schedule $S'$

## Serializability testing
### Precedence graph
- Also known as serialization graph.
#### Representation
- Given a directed graph $G=(N,E)$:
	- $N$ is the set of transactions (nodes).
	- $E$ is the set of <mark style="background: #e4e62d;">precedence</mark> relationships between transactions:
		- Each edge $e_i$ in $E$ represents a pair of conflicting operations in two certain transactions $T_j$ and $T_k$. 
		- The <mark style="background: #e4e62d;">former operation precedes the latter operation</mark>.
- An edge $e:T_i \rightarrow T_j$ belongs to one of the following cases:
	- $T_i$ performs write_item(X), then $T_j$ performs read_item(X).
	- $T_i$ performs read_item(X), then $T_j$ performs write_item(X).
	- $T_i$ performs write_item(X), then $T_j$ performs write_item(X).

>[!Note]
>An edge $e$ is not drawn only when read_item(X) follows read_item(X)
>
#### Implication
- A schedule $S$ is <mark style="background: #e4e62d;">serializable</mark> if and only if its precedence graph has <mark style="background: #e4e62d;">no cycles</mark>.
- The precedence also represents the <mark style="background: #e4e62d;">topological order</mark> of transaction. The equivalent serial schedule must obey this order.
## Examples
- ![](Pasted%20image%2020241210172959.png)
- ![](Pasted%20image%2020241210173009.png)
- ![](Pasted%20image%2020241210173018.png)
- ![](Pasted%20image%2020241210173027.png)
- 
--- 
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 5.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu*.
3. HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu.
4. [Concurrency control problems](Concurrency%20control%20problems.md)
5. [Transaction processing](Transaction%20processing.md)
6. Database Systems: The Complete Book - H. G. Molina, J. D. Ullman, J. Widom, Prentice-Hall, 2009.

[^1]: For simplicity, "conflict serializable" can be simply understood as serializable.
[^2]: For simplicity, "conflict equivalent" can be simply understood as equivalent.