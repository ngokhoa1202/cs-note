#transaction #operating-system #sql #nosql #dbms #dbms-architecture #rdbms #parallel-programming #process #caching #software-architecture #software-architecture #computer-architecture  #logging #acid 

- Based on [Shadow update](Recovery%20concepts.md#Shadow%20update) $\implies$ AFIM does not overwrite its BFIM but is stored at another location on disk.
# Shadow paging
- There are two directories:
	- <mark style="background: #ADCCFFA6;">Current directory</mark> contains the entry points to database pages on disk used and modified during transaction execution.
	- <mark style="background: #ADCCFFA6;">Shadow directory</mark> the most recent or current entry points to database pages on disk that <mark style="background: #e4e62d;">are never modified</mark>.
- When a write_item operation is performed, a <mark style="background: #e4e62d;">new copy</mark> of the modified database page is <mark style="background: #e4e62d;">created</mark>, but the <mark style="background: #e4e62d;">old copy</mark> of that page is <mark style="background: #e4e62d;">not overwritten</mark>.
- For pages updated by the transaction, two versions are kept. The old version is referenced by the shadow directory and the new version by the current directory.
- ![](Pasted%20image%2020241214150405.png)
# Implication
- Complex storage management.
- Requires garbage collection.
- Atomic migration between current and shadow directories.

# References
1. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 20 - Section 1.
2. *HCMUT Advanced DBMS Slide - Lê Thị Bảo Thu.*
3. *HCMUT Advanced DBMS Slide - Võ Thị Ngọc Châu*.
4. [Transaction processing](Transaction%20processing.md) 
5. [Recoverability](Recoverability.md)
6. [Recovery concepts](Recovery%20concepts.md)
7. 