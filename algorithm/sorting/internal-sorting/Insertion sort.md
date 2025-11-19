#sorting #algorithm #java #array 
- Insertion sort is an *internal* sorting algorithm.
# Algorithm
- Split the list into two parts: sorted and unsorted.
- Let $N$ be the list size.
- For every element $e_i$ in the list:
	- Sorted part is in the range $[0,i-1]$, Unsorted part is in the range $[i,N-1]$ (1)
	- Insert the following element $e_{j}$ into the current position in the sorted part by *shifting*:
		- $\text{current}=e_i$
		- Init $j=i-1$ 
		- While $j \geq 0$ and $e_{j} > \text{current}$ :
			- $e_{j+1} = e_{j}$
			- $j=j-1$ 
		- $e_{j+1}=\text{current}$
	- $e_{j+1}$ in (1) is now inserted into the correct position in the sorted part. Sorted part is now in the range $[0,i]$ 
>[!Important]
>The elements in sorted part are right shifted to leave the correct position for the first element in unsorted part
# Example
```Text title='Example of the execution of insertion sort'
23 78 45 8 32 56 <- Original array
23 | 78 45 8 32 56 <- Initilization i=0, j=0

23 78 45 8 32 56 <- i=1, j=0: nums[0]=23 > current = 78: F => stop, nums[j+1]=nums[1]=current=78 => the array remains the same.

23 78 | 45 8 32 56 <- i=2, j=1: nums[1]=78 > current = 45: T
23 78 | 78 8 32 56 <- nums[j+1]=nums[2]=nums[j]=nums[1]=78
23 45 | 78 8 32 56 <- j=0, nums[0]=23 > current=45: False, nums[j+1]=nums[1]=current=45

23 45 78 | 8 32 56 <- i=3, j=2, current=nums[3]=8
8 23 45 78 | 32 56 <- i=4, j = 3, current=nums[4]=32
8 23 32 45 78 | 56 <- i=5, j=4, current=nums[5]=56
8 23 32 45 56 78 | <- i=6 => stop
```
# Implementation
## Java
```Java title='Insertion sort in Java'
public class InsertionSort {

  public static void sort(int[] nums) {
    int current = 0, j = 0;
    for (int i = 1; i < nums.length; ++i) {
      current = nums[i];
      j = i - 1;
      while (j >= 0 && nums[j] > current) { // right shift all elements that are greater than current element being sorted
        nums[j+1] = nums[j];
        j--;
      }
      nums[j+1] = current; // j+1 is the right position for current element
    }
  }
}
```
# Complexity
## Time complexity
- Best-case complexity: $O(1)$ $\iff$ the whole list has been already sorted in order.
- Worst-case complexity: $O(n^2)$ $\iff$ the whole list has been already sorted in *reverse* order.
- Average-case complexity: $O(n^2)$ $\iff$ Order is random.
## Space complexity
- Required space $O(n)$
- Auxiliary space: $O(1)$
***
# References
1. Data Structure and Algorithm Slides - Duy Tran Ngoc Bao - Ho Chi Minh City University of Technology.
2. 
