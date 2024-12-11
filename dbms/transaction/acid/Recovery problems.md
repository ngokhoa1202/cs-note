#transaction #os #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #logging #acid 

- Recovery mechanism is needed when a transaction fails.
# Recovery problems
- System crash (hardware, software conflicts).
- Transaction or system error (e.g: divided by zero).
- Local errors or exception conditions. (e.g: business constraints).
- Concurrency control enforcement. (e.g: locking mechanism,...)
- Disk failure.
- Catastrophes.
# Recovery manager
- Recovery manager has to keep track the states of transaction:
	- begin_transaction.
	- read - write.
	- end_transaction.
	- commit_transaction.
	- rollback - abort.
- Recovery operators:
	- redo: re-execute a single operation.
	- undo: rollback a single operation.
## System log - Journal
## Logging
- The log keeps track of all transaction <mark style="background: #e4e62d;">operations</mark> that affect the values of database items.
- This information may be needed to <mark style="background: #e4e62d;">permit recovery</mark> from transaction failures.
- The log is stored on <mark style="background: #e4e62d;">disk</mark> and <mark style="background: #e4e62d;">periodically</mark> backed up.
## Log record
- \[start_transaction,T\]
- \[write_item,T,X,old_value,new_value\]
- \[read_item,T,X\]
- \[commit,T\]
- \[abort,T\]
## Protocols
### Definition
- <mark style="background: #e4e62d;">Cascadeless</mark> protocols for recovery do <mark style="background: #e4e62d;">not require that READ operations</mark> be written to the system log, whereas other protocols require these entries for recovery. 
> [!Note]
> Cascading rollback is the case such that the rolling-back of transaction $T_1$ makes transaction $T_2$ rollback and so on.

- <mark style="background: #e4e62d;">Strict</mark> protocols for recovery require simpler WRITE entries that <mark style="background: #e4e62d;">do not include new_value</mark>.
- [Recoverability](Recoverability.md)
### Example
- ![](Pasted%20image%2020241208150326.png)
- ![](Pasted%20image%2020241208150422.png)
- ![](Pasted%20image%2020241208150451.png)
- ![](Pasted%20image%2020241208150503.png)

## Recovery using log records
### Undo
- Trace <mark style="background: #e4e62d;">backwards</mark> through the log and resetting all items changed by a <mark style="background: #e4e62d;">write operation </mark>of $T$ to their old_values.
### Redo
- Trace <mark style="background: #e4e62d;">forwards</mark> through the log and setting all items changed by a <mark style="background: #e4e62d;">write operation</mark> of $T$ (that did not get done permanently) to their new_values.

---
# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 1.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. *HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu*.
4. [Transaction processing](Transaction%20processing.md) 
5. [Recoverability](Recoverability.md)

