#leetcode #sorting #heap #algorithm #data-structure #array #binary-tree #priority-queue
# Definition
- The (binary) heap data structure is an array object that can be viewed as a *nearly complete binary tree*.
- The tree is completely ﬁlled on all levels except possibly the lowest, which is ﬁlled from the left.
## Array representation
- The root of the tree is stored at $a_0$
- Given a node at index $i$, its left child and right child are respectively stored at index $2i$ and index $2i+1$. Its parent is stored at index $\lfloor\frac{n}{2}\rfloor$ 
- There are two types of heap:
	- Max heap: The root is the maximum element in the tree $$a_{\lfloor \frac{i}{2}\rfloor} \geq a_i$$
	- Min heap: The root is the minimum element in the tree $$a_{\lfloor \frac{i}{2}\rfloor} \leq a_i$$
- ![[Pasted image 20251116174033.png]]
# Operation
- Given an array $a$ which represents a heap and its length is $n$.
- The index of array $a$ starts from 1.
## Max heap
### Upheap
- Upheap is to <mark class="hltr-yellow">insert</mark> a new element into the heap but the heap property must be maintained.
- The time complexity is $O(\text{log}n)$.
- The heap array must be allocated in advance.
#### Iterative approach
##### 1-indexed array solution
- $\text{upheap}: (a: \text{integer}[],k: \text{integer}) \to \text{void}$:
	- Initialize $v=a_k$
	- While $a_{\lfloor \frac{k}{2} \rfloor} \leq v$ :
		- $a_k=a_{\lfloor \frac{k}{2} \rfloor}$ 
		- $k=\lfloor\frac{k}{2}\rfloor$
	- $a_k=v$
- $\text{insert}:(a: \text{integer}[], n: \text{integer}, v: \text{integer}) \to \text{void}$:
	- $n=n+1$
	- $a_n=v$
	- $\text{upheap}(a, n)$
##### 0-indexed array solution

#### Recursive approach
### Downheap
- Downheap is to <mark class="hltr-yellow">remove</mark> the root element from the heap but the heap property must be maintained.
- The time complexity is $O(\text{log}(n))$
#### Iterative approach
- $\text{downheap}: (k: \text{integer}, a: \text{integer}[]) \to \text{void}$
	- Initialize $v=a_k$
	- While $k \leq \lfloor \frac{n}{2} \rfloor$:
		- Initialize $j=2k$
		- If $j<n$:
			- If $a_j < a_{j+1}$ then $j=j+1$
		- If $v \geq a_j$ then break the loop.
		- $a_k=a_j$
		- $k=j$
	- $a_k=v$
- $\text{remove}(a: \text{integer}[], n: \text{integer}) \to \text{integer}$
	- Initialize $\text{removedElement}=a_1$
	- $a_1=a_n$
	- $n=n-1$
	- $\text{downheap}(1,a)$
	- return $removedElement$
#### Recursive approach

### Heap construction
#### Top-down heap construction
- Start from an empty array which represents null complete binary tree.
- Insert each element sequentially into the complete binary tree (array).
- $\text{buildTopdown}(a: \text{integer}[], n: integer)$
	- for $k=1 \to n: \text{insert}(a,n,k)$ 
#### Bottom-up heap construction
- Fill original elements into the array viewed as a complete binary tree.
- Modifies the array to make it become a heap:
	- From bottom to up.
	- From left to right.
- $\text{buildBottomup}(a: integer[], n: integer)$
	- for $k=\lfloor\frac{n}{2}\rfloor \to 1: \text{downheap(k, a)}$
## Min heap
# Example
## Max heap

# Implementation
## Max heap
### Java
```Java title='Max heap implementation in array'
public class HeapSort {
  public static void sort(int[] nums) {
    buildMaxHeap(nums);
    int n = nums.length;
    for (int i = n - 1; i > 0; i--) {
      // Move current root to end
      int temp = nums[0];
      nums[0] = nums[i];
      nums[i] = temp;

      downheap(nums, 0, i);
    }
  }

  private static void buildMaxHeap(int[] nums) {
    int n = nums.length;
    for (int i = 1; i < n; i++) {
      upheap(nums, i);
    }
  }

  private static void downheap(int[] heap, int k, int n) {
    int value = heap[k];
    while (2 * k + 1 < n) {
      int j = 2 * k + 1;
      if (j + 1 < n && heap[j] < heap[j + 1]) {
        j++;
      }
      if (value >= heap[j]) {
        break;
      }
      heap[k] = heap[j];
      k = j;
    }
    heap[k] = value;
  }

  private static void upheap(int[] heap, int k) {
    int value = heap[k];
    while (k > 0 && heap[(k - 1) / 2] < value) {
      heap[k] = heap[(k - 1) / 2];
      k = (k - 1) / 2;
    }
    heap[k] = value;
  }

}

```
# Heap sort
- Given array $a$ with length $n$, sort it in ascending order.
- $\text{heapsort}(a: \text{integer}, n: integer) \to \text{integer}[]$
	- $\text{buildMaxHeap}(a,n)$
	- for $k=n \to 1: a_k=\text{remove}(a,k)$
***
# References
1. Introduction to Algorithms - Thomas H. Cormen, Charles E. Leserson, Ronald L. Rivest, Clinfford Sten - The MIT Press - Third Edition 2009.
	1. Chapter II. Sorting and Order Statistics.
		1. Section 6. Heap sort.
2. HCMUT Algorithm Design and Analysis - Chau Thi Ngoc Vo - Ho Chi Minh City University of Technology.
3. 