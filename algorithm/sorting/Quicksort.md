#quicksort #sorting #algorithm 
# Algorithm
- Sort array $a$ in range $[l, r]$:
	- if $l<r$ then:
		- $k=partition(a,l,r)$ : pivot position.
		- $quicksort(a,l,k-1)$
		- $quicksort(a,k+1,r)$
## Lomuto partition
-  The rightmost element is chosen as the initial pivot.
### Idea
- Attempt to move all elements that are less than $pivot$ to the left and all elements that are greater than $pivot$ to the right.
- Two pointer are used to perform one-way traversal.
### Algorithm
- $pivot=a_r$
- $i=l-1$ 
- for $j=l$ to $r-1$:
	- if $a_j \leq pivot$ :
		- $i=i+1$
		- $swap(a_i,a_j)$
- $swap(a_{i+1}, a_r)$
- return $i+1$
# Characteristics
- Excludes pivot element.
## Three regions while looping
- ![](Pasted%20image%2020240601153857.png)
- $l=p$ (MIT book notation).
- $a_l \to a_i \leq pivot$
- $a_{i+1} \to a_{j-1} > pivot$
## Determine which regions a element should belong to
- ![](Pasted%20image%2020240616144654.png)
- $i$ moves forward step by step.
- $j$ is entry for element needing to be swapped.
- $a_j < pivot$ $\implies$ move $a_j$ to the first region; otherwise, it currently stays in the right position.

# Time complexity
- $O(n\text{log}n)$
# Space complexity

***
# References
1. Introduction to Algorithms - Thomas H. Cormen, Charles E. Leserson, Ronald L. Rivest, Clinfford Sten - The MIT Press - Third Edition 2009.
2. https://en.wikipedia.org/wiki/Quicksort#:~:text=Quicksort%20was%20developed%20by%20British,data%2C%20particularly%20on%20larger%20distributions.&text=Animated%20visualization%20of%20the%20quicksort%20algorithm.
3. 