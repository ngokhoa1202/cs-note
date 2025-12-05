#sorting #algorithm 

# Algorithm
- Split the list into two parts: sorted and unsorted.
- $N$ is the list size.
- For every element $e_i$ in the list:
	- Sorted part is in the range $[0,i-1]$, Unsorted part is in the range $[i,N-1]$ (1)
	- Insert the following element $e_{j+1}$ into the ==current position in the sorted part== by this way:
		- Init $j=i+1$ 
		- While $e_{j-1}$ exists and $e_{j} > e_{j-1}$ :
			- swap($e_{j-1}$, $e_j$)
			- $j=j-1$ 
	- $e_{j+1}$ in (1) is now inserted into the correct position in the sorted part. Sorted part is now in the range $[0,i]$ 
# Time complexity
- Best-case complexity: $O(1)$ $\iff$ the whole list has been already sorted in order.
- Worst-case complexity: $O(n^2)$ $\iff$ the whole list has been already sorted in ==reverse order==.
- Average-case complexity: $O(n^2)$ $\iff$ Order is random.
# Space complexity
- Required space $O(n)$
- Auxiliary space: $O(1)$
