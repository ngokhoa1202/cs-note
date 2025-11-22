#dbms #dbms-architecture #rdbms #algorithm #secondary-storage #computer-architecture #sorting #caching

# External sorting
- External sorting are sorting algorithms which are designed to <mark style="background: #e4e62d;">sort large files of record</mark>s stored on secondary storage which do not entirely fit in main memory.
- Sort-merge strategy is an example.
- Requires buffer space (or cache) in main memory.
# Sort-merge strategy
- External sorting is separated into two main phases.
- The total block accesses needed can be approximated by: $$2b\times \left ( 1+\text{log}_{d_M}\left \lceil \frac{b}{n_B} \right \rceil \right )$$
## Sorting phase
- Runs (portions or pieces) of the file that can <mark style="background: #e4e62d;">fit in the available buffer space</mark> are read into main memory, sorted using an internal sorting algorithm, and written back to disk as temporary sorted subfiles (or runs).
- The number of initial runs $n_R$: $$n_R=\left \lceil \frac{b}{n_B} \right \rceil$$ where $b$ is the number of blocks of file and $n_B$ is the number of blocks of buffer.
- The number of block accesses needed is $2b$. Because each file block is accessed twice: once for being read into buffer, once for being written back to the disk into one of the runs.
## Merging phase
- Sorted runs are merged during one or more merge passes. Each merge pass can have one or more merge steps.
- The degree of merging $d_M$ is the number of runs that can be merged in each merge step. $$d_M=\text{min}(n_B-1,n_R)$$
- The number of passes $n_P$ to perform an external sorting: $$n_P=\left \lceil \text{log}_{d_M}(n_R) \right \rceil$$
- The number of block accesses needed is $2\times b \times n_P$
## Algorithm
- ![](Pasted%20image%2020241130131658.png)
# Example
- We can read next block from the corresponding run only when there is an empty block in the buffer.
- ![](Pasted%20image%2020241130131737.png)
- ![](Pasted%20image%2020241130132016.png)
- ![](Pasted%20image%2020241130132037.png)
- ![](Pasted%20image%2020241130132051.png)
- ![](Pasted%20image%2020241130132100.png)
- ![](Pasted%20image%2020241130132115.png)
- ![](Pasted%20image%2020241130132145.png)
- ![](Pasted%20image%2020241130132158.png)
- ![](Pasted%20image%2020241130132223.png)
***
# References
1. HCMUT Advanced DBMS Slides - Vo Thi Ngoc Chau.
2. Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015):
	1. Chapter 16 - Section 4.