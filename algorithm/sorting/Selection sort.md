#algorithm #sorting 

# Algorithm
- $N$ is the list size.
- For every element $e_i$ in the list:
	- Sorted part of the list: $[0,i-1]$ , Unsorted part $[i, N-1]$ 
	- Find the smallest element $e_{min}$ in the range $[i+1, N-1]$ 
	- Swap $e_i$ and $e_{min}$  
	- Sorted part of the list $[0,i]$ , Unsorted part $[i+1, N-1]$ 
# Time complexity
- $$T(n) \approx \frac{(n-1)n}{2}=\Theta(n^2)$$
- Best-case, worst-case, average-case complexity are always $O(n)$ 
# Space complexity
- $$S(n)=O(n)$$
- Auxillary space $O(1)$ 
