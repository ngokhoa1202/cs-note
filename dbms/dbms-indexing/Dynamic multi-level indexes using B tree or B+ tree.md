#dbms #indexing #query #rdbms #sql #data-structure #b-tree #algorithm-analysis #file-system #operating-system #algorithm 

# Search tree
- A search tree of order $p$ is a tree such that each node contains <mark style="background: #e4e62d;">at most</mark> $p-1$ search values and $p$ pointers in the order $$<P_1,K_1,P_2,K_2,...,P_{q-1},K_{q-1}, P_q>$$ where $q \leq p$ and the value of $K_i$ is <mark style="background: #e4e62d;">ordered</mark>.

- Two constraints must hold all the times:
	- Within a node, $K_1 < K_2 < ... < K_{q-1}$.
	- For all values $X$ in the child nodes pointed by $P_i$:
		- $X < K_i$ if $i=1$ $\implies$ leftmost subtree.
		- $K_{i-1} < X < K_i \space \forall 1 < i < q$ $\implies$ middle subtree.
		- $X > K_i$ if $i=q$ $\implies$ rightmost subtree.
- ![](Pasted%20image%2020241023141420.png)
- ![](Pasted%20image%2020241023141639.png)
## Balanced search tree
- All of the leaf node must be at the same level.
- Purpose:
	- Minimize the depth of tree, avoid skewed search tree $\implies$ minimize block accesses.
# B-tree structure
## Definition
### Form of node
- ![](Pasted%20image%2020241023143909.png)
- ![](Pasted%20image%2020241023144025.png)
#### Internal node
- The internal node of order $p$ is in the form $$<P_1,<K_1,Pr_1>,P_2,<K_2,Pr_2>,...,P_{q-1}, <K_{q-1},Pr_{q-1}>, P_q>$$ where $P_i$ is a tree pointer and $Pr_i$ is a record or a block pointer and $q \leq p$
- The internal node in B-tree i<mark style="background: #e4e62d;">s allowed to contain a key</mark>, thereby being different from that of B+-tree.
#### Leaf node
- The leaf node is similar to internal node but sets all tree pointers to `NULL` and is in the form: $$<\text{NULL},<K_1,Pr_1>,\text{NULL},<K_2,Pr_2>,...,\text{NULL}, <K_{q-1},Pr_{q-1}>, P_q>$$
### Constraints
#### Constraints inherited from search tree
- A B+-tree of order $p$ has at most $p$ tree pointers and at most $p-1$ value.
- Within a node, $K_1 < K_2 < ... < K_{q-1}$
-  For all values $X$ in the child nodes pointed by $P_i$:
		- $X < K_i$ if $i=1$ $\implies$ leftmost subtree.
		- $K_{i-1} < X < K_i \space \forall 1 < i < q$ $\implies$ middle subtree.
		- $X > K_i$ if $i=q$ $\implies$ rightmost subtree.
#### Algorithm constraints
- Each node, except the root and the leaves has <mark style="background: #e4e62d;">at least</mark> $\lceil \frac{p}{2} \rceil$ tree pointers $\equiv$ Each internal node must be at least <mark style="background: #e4e62d;">half-full</mark>.
- The value of keys which will be moved up to the parent node is <mark style="background: #e4e62d;">not replicated</mark> in the overflown child node. $\implies$ Both internal nodes and leaf nodes are allowed to store data pointer
## Operations
### Search
#### Algorithm
- p-nary search under the<mark style="background: #e4e62d;"> indexing attributes' </mark>condition.
	- Equivalent to binary search.
#### Cost
- The number of block accesses ranges in  $[1,h+1]$ where $h$ is the height or the level of B-tree.
- The average block access is $[1, \text{log}_{\lceil \frac{p}{2} \rceil}(N) + 1]$ where $N$ is the number of keys.
### Insertion
- Search the <mark style="background: #e4e62d;">leaf node </mark>to which the new record with key $K$ belongs.
- If that leaf node is overflown, then split it:
	- The first $j = \lceil \frac{p_{\text{leaf}}+1}{2} \rceil$ entries in the original node having been made overflown are kept, and the remaining entries are moved to a new leaf node.
	- The $j\text{th}$  search value is <mark style="background: #e4e62d;">moved up</mark> in the parent internal node in the correct order.
	- In case the new value cause the parent node to overflow, so the parent will be split into two new nodes, too.
- If an internal node is overflown, then split it into two new internal nodes
	- The entries up to $P_j$—the $j\text{th}$ tree pointer after inserting, where $j=\lfloor \frac{p+1}{2} \rfloor$— are kept 
	- The $j\text{th}$ search value is moved up to the parent internal node, <mark style="background: #e4e62d;">not replicated</mark>.
	- This separation effect <mark style="background: #e4e62d;">keeps propagating until all nodes no longer overflow</mark>.
### Deletion
- Search the node to which the new record with key $K$ belongs.
- Remove the record from the node.
- If that node is underflow, then merge it with other node:
	- ...
# B+ tree structure
## Definition
- ![](Pasted%20image%2020241024171125.png)
### Form of node
#### Internal node
- The internal node of order $p$ is in the form: $$<P_1, K_1,P_2,K_2,...,P_{q-1},K_{q-1}, P_q>$$ where  $P_i$ is a tree pointer and $q \leq p$
- The internal node in B+ tree <mark style="background: #e4e62d;">does not store data pointer</mark> and it is only used to *split the tree in multiple directions.*
#### Leaf node
- The leaf node of order $p$ is in the form: $$<<K_1, Pr_1>, <K_2, Pr_2>, … , <K_{q−1}, Pr_{q−1}>, P_{\text{next}l}>$$ where $Pr_i$ is a data pointer, $P_{next}$ points the successor leaf node and $q \leq p$.
- Only the leaf node in B+ is allowed to store data pointer.
- There is a <mark style="background: #e4e62d;">next pointer</mark> in each leaf node pointing the successor leaf node.
### Constraints
#### Constraints inherited from search tree
- A B-tree of order $p$ has at most $p$ tree pointers and at most $p-1$ value.
- Within a node, $K_1 < K_2 < ... < K_{q-1}$
-  For all values $X$ in the child nodes pointed by $P_i$:
		- $X < K_i$ if $i=1$ $\implies$ leftmost subtree.
		- $K_{i-1} < X < K_i \space \forall 1 < i < q$ $\implies$ middle subtree.
		- $X > K_i$ if $i=q$ $\implies$ rightmost subtree.
#### Algorithm constraints
- Each node, except the root and the leaves has <mark style="background: #e4e62d;">at least</mark> $\lceil \frac{p}{2} \rceil$ tree pointers $\equiv$ Each internal node must be at least <mark style="background: #e4e62d;">half-full</mark>.
- The value of keys which will be moved up to the parent node is <mark style="background: #e4e62d;">replicated</mark> in the overflown child leaf node. $\implies$ only leaf nodes are allowed to store data pointer.
## Operations
### Search
#### Algorithm
- p-nary search under the<mark style="background: #e4e62d;"> indexing attributes' </mark>condition.
	- Equivalent to binary search.
#### Cost
- The number of block accesses ranges in  $[1,h+1]$ where $h$ is the height or the level of B-tree.
- The average block access is $[1, \text{log}_{\lceil \frac{p}{2} \rceil}(N) + 1]$ where $N$ is the number of keys.
### Insertion
- Search the <mark style="background: #e4e62d;">leaf node</mark> to which the new record with key $K$ belongs.
- If that leaf node is overflown, then split it:
	- The first $j = \lceil \frac{p_{\text{leaf}}+1}{2} \rceil$ entries in the original node having been made overflown are kept, and the remaining entries are moved to a new leaf node.
	- The $j\text{th}$  search value is <mark style="background: #e4e62d;">replicated</mark> in the parent internal node.
	- It must be inserted in the parent node in their correct order. In case the new value cause the parent node to overflow, so the parent will be split into two new nodes, too. 
### Deletion
- Search the node to which the new record with key $K$ belongs.
- Remove the record from the node.
- If that node is underflow, then merge it with other node:
	- ...
# Examples
## Example 1
### Requirements
- A `PARTS` file with `Part#` as the key field includes records with the following `Part#` values: $23, 65, 37, 60, 46, 92, 48, 71, 56, 59, 18, 21, 10, 74, 78, 15, 16, 20, 24, 28, 39, 43, 47, 50, 69, 75, 8, 49, 33, 38$.  Suppose that the search field values are inserted in the given order in a B + -tree of order $p = 4$ and $p_{\text{leaf}}=3$ ; show how the tree will expand and what the final tree will look like. 

- Repeat Exercise 17.19, but use a B-tree of order $p = 4$ instead of a B+ -tree.
### Solution
#### B tree solution
- ![b tree](b%20tree.pdf)
#### B+ tree solution
- ![b+ tree-1](b+%20tree-1.pdf)
 ---
# References
 1. *HCMUT Advanced DBMS Slides - Vo Thi Ngoc Chau.*
2. *Fundamentals of Database Systems - Ramez Elmasri, Shamkant B. Navathe - Pearson (2015).*
	- Chapter 17: Indexing Structures for Files and Physical Database Design.
		- Section 17.3 Dynamic Multilevel indexes using B-Tree and B+-Tree.
			- Exercise 17.19 & 17.20
1. *https://www.youtube.com/watch?v=aZjYr87r1b8&t=13s*
2. HCMUT Basic DBMS Slides - Truong Quynh Chi.
3. HCMUT Advanced DBMS Slides - Le Thi Bao Thu.
	