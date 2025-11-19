#algorithm #sorting 
- Selection sort is an internal sorting algorithm.
# Algorithm
- $N$ is the list size.
- For every element $e_i$ in the list:
	- Sorted part of the list: $[0,i-1]$ , Unsorted part $[i, N-1]$ 
	- Find the smallest element $e_{min}$ in the range $[i+1, N-1]$ 
	- Swap $e_i$ and $e_{min}$  
	- Sorted part of the list $[0,i]$ , Unsorted part $[i+1, N-1]$ 
>[!Important]
> The smallest element in unsorted part is *selected* to be swapped with the first element in unsorted part so that that element can later join sorted part.

# Example
```Text title='Example of the execution of selection sort'
[23, 78, 45, 8, 32, 56] <- original array
[8, 78, 45, 23, 32, 56] <- swap(a[0], a[3])
[8, 23, 45, 78, 32, 56] <- swap(a[1], a[3])
[8, 23, 32, 78, 45, 56] <- swap(a[2], a[4])
[8, 23, 32, 45, 78, 56] <- swap(a[3], a[3])
[8, 23, 32, 45, 56, 78] <- swap(a[4], a[5)
[8, 23, 32, 45, 56, 78] <- stop
```
# Implementation

# Complexity
## Time complexity
- $$T(n) \approx \frac{(n-1)n}{2}=\Theta(n^2)$$
- The best-case, worst-case, average-case complexity are always $O(n)$ 
## Space complexity
- $$S(n)=O(n)$$
- Auxiliary space $O(1)$ 
***
# References
1. Data Structure and Algorithm Slides - Duy Tran Ngoc Bao - Ho Chi Minh City University of Technology.