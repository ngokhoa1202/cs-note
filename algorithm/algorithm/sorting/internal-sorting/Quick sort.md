#quicksort #sorting #algorithm #java 
- Quicksort is an internal sorting algorithm.
# Algorithm
- Sort array $a$ in range $[l, r]$:
	- if $l<r$ then:
		- $k=partition(a,l,r)$ : pivot position.
		- $quicksort(a,l,k-1)$
		- $quicksort(a,k+1,r)$
## Lomuto's partition
-  The rightmost element is chosen as the initial pivot.
### Idea
- Attempts to move all elements that are less than $pivot$ to the left and all elements that are greater than $pivot$ to the right.
- Two pointer are used to perform one-way traversal.
### Method
- $pivot=a_r$
- $i=l-1$ 
- for $j=l$ to $r-1$:
	- if $a_j \leq pivot$ :
		- $i=i+1$
		- $swap(a_i,a_j)$
- $swap(a_{i+1}, a_r)$
- return $i+1$
### Characteristics
#### Three regions while looping
- ![](Pasted%20image%2020240601153857.png)
- $l=p$ (MIT book notation).
- $a_l \to a_i \leq pivot$
- $a_{i+1} \to a_{j-1} > pivot$
#### Determine which regions a element should belong to
- ![](Pasted%20image%2020240616144654.png)
- $i$ moves forward step by step.
- $j$ is entry for element needing to be swapped.
- $a_j < pivot$ $\implies$ move $a_j$ to the first region; otherwise, it currently stays in the right position.
### Example
```mermaid
graph TD
    %% Styles
    classDef pivot fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef leaf fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px;
    classDef array fill:#fff9c4,stroke:#fbc02d,stroke-width:2px;

    %% Root
    Root["<b>[50, 80, 30, 90, 40, 10, 70]</b><br/>Pivot: 70 (Last)<br/>Swap(80, 30), Swap(80, 40)<br/>Swap(90, 10), Swap(80, 70)<br/>Final: [50, 30, 40, 10, <b>70</b>, 90, 80]"]:::pivot
    
    %% Level 1 Splits
    L1["<b>[50, 30, 40, 10]</b>"]:::array
    R1["<b>[90, 80]</b>"]:::array
    
    Root -- "Left Partition" --> L1
    Root -- "Right Partition" --> R1

    %% Left Branch Processing (Pivot 10)
    L1_Action["Pivot: 10<br/>Scan: All > 10<br/>Swap(50, 10)<br/>State: [<b>10</b>, 30, 40, 50]"]:::pivot
    L1 --- L1_Action
    
    L1_Left["[]<br/>(Empty)"]:::leaf
    L1_Right["<b>[30, 40, 50]</b>"]:::array
    
    L1_Action --> L1_Left
    L1_Action --> L1_Right

    %% Left-Right Sub-branch (Pivot 50)
    L1_R_Action["Pivot: 50<br/>(No changes)<br/>State: [30, 40, <b>50</b>]"]:::pivot
    L1_Right --- L1_R_Action
    
    L1_R_Left["<b>[30, 40]</b>"]:::array
    L1_R_Right["[]"]:::leaf
    
    L1_R_Action --> L1_R_Left
    L1_R_Action --> L1_R_Right

    %% Left-Right-Left Sub-branch (Pivot 40)
    L1_R_L_Action["Pivot: 40<br/>(No changes)<br/>State: [30, <b>40</b>]"]:::pivot
    L1_R_Left --- L1_R_L_Action

    L1_R_L_Left["[30]"]:::leaf
    L1_R_L_Right["[]"]:::leaf

    L1_R_L_Action --> L1_R_L_Left
    L1_R_L_Action --> L1_R_L_Right

    %% Right Branch Processing (Pivot 80)
    R1_Action["Pivot: 80<br/>Scan: 90 > 80<br/>Swap(90, 80)<br/>State: [<b>80</b>, 90]"]:::pivot
    R1 --- R1_Action
    
    R1_Left["[]"]:::leaf
    R1_Right["[90]"]:::leaf
    
    R1_Action --> R1_Left
    R1_Action --> R1_Right
```
## Hoare's partition
- The pivot is *not necessarily* the final position of the array.
- The pivot is *not guaranteed* to stay its correct position in the immediate sorting states.
### Idea
- Initializes two pointers at the two ends of the array. 
- The two indexes moves towards each other until an inversion where a smaller value on the left side and a larger value on the right side occurs. Then, two elements are swapped.
- The process is repeated until two pointers meet each other.
### Method
- Initialize $\text{pivot} \leftarrow a_l, \space i \leftarrow l-1, \space j \leftarrow r+1$.
- while True:
	- repeat $j \leftarrow j-1$ until $a_j \leq \text{pivot}$
	- repeat $i \leftarrow i + 1$ until $a_i \geq \text{pivot}$
	- if $i < j$ then $\text{swap}(a_i, a_j)$
	-  else then return $j$
### Characteristics
#### Two regions after each partition
- After each partition, the sorting sub-array is divided into two region:
	- The left region contains the elements that are smaller than pivot.
	- The right region contains the elements that are greater or equal to pivot. 
```mermaid
graph TD
    %% Styles
    classDef pivot fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef leaf fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px;
    classDef array fill:#fff9c4,stroke:#fbc02d,stroke-width:2px;

    %% Root
    Root["<b>[50, 80, 30, 90, 40, 10, 70]</b><br/>Pivot: 50<br/>Swap(50, 10)<br/>Swap(80, 40)<br/>Final: [10, 40, 30, 90, 80, 50, 70]"]:::pivot
    
    %% Level 1 Splits
    L1["<b>[10, 40, 30]</b>"]:::array
    R1["<b>[90, 80, 50, 70]</b>"]:::array
    
    Root -- "Left Partition" --> L1
    Root -- "Right Partition" --> R1

    %% Left Branch Processing
    L1_Action["Pivot: 10<br/>(No swaps needed)"]:::pivot
    L1 --- L1_Action
    
    L1_Left["[10]"]:::leaf
    L1_Right["<b>[40, 30]</b>"]:::array
    
    L1_Action --> L1_Left
    L1_Action --> L1_Right

    %% Left-Right Sub-branch
    L1_R_Action["Pivot: 40<br/>Swap(40, 30)<br/>State: [30, 40]"]:::pivot
    L1_Right --- L1_R_Action
    
    L1_R_Left["[30]"]:::leaf
    L1_R_Right["[40]"]:::leaf
    
    L1_R_Action --> L1_R_Left
    L1_R_Action --> L1_R_Right

    %% Right Branch Processing
    R1_Action["Pivot: 90<br/>Swap(90, 70)<br/>State: [70, 80, 50, 90]"]:::pivot
    R1 --- R1_Action
    
    R1_Left["<b>[70, 80, 50]</b>"]:::array
    R1_Right["[90]"]:::leaf
    
    R1_Action --> R1_Left
    R1_Action --> R1_Right

    %% Right-Left Sub-branch
    R1_L_Action["Pivot: 70<br/>Swap(70, 50)<br/>State: [50, 80, 70]"]:::pivot
    R1_Left --- R1_L_Action
    
    R1_L_Left["[50]"]:::leaf
    R1_L_Right["<b>[70, 80]</b>"]:::array
    
    R1_L_Action --> R1_L_Left
    R1_L_Action --> R1_L_Right

    %% Right-Left-Right Sub-branch
    R1_L_R_Action["Pivot: 70<br/>(Sorted)"]:::pivot
    R1_L_Right --- R1_L_R_Action
    
    R1_L_R_Left["[70]"]:::leaf
    R1_L_R_Right["[80]"]:::leaf
    
    R1_L_R_Action --> R1_L_R_Left
    R1_L_R_Action --> R1_L_R_Right
```
#### Pivot position is not guaranteed
- Hoare's partition ensures the correct split into the two regions, but not the pivot position.
#### Example
```mermaid
graph TD
    %% Styling
    classDef array fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef pivot fill:#e1f5fe,stroke:#0277bd,stroke-width:2px;
    classDef leaf fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px;

    %% Level 0: Root
    Root["<b>Start Array</b><br/>[50, 80, 30, 90, 40, 10, 70]<br/>i=0, j=6"]:::array

    %% Level 1: First Partition
    %% Based on image: Left gets [10, 40, 30], Right gets [90, 80, 50, 70]
    Part1["<b>Partition 1</b><br/>Left: [10, 40, 30]<br/>Right: [90, 80, 50, 70]"]:::pivot
    Root --> Part1

    %% Level 2: Branching
    L1["[10, 40, 30]"]:::array
    R1["[90, 80, 50, 70]"]:::array
    Part1 --> L1
    Part1 --> R1

    %% LEFT SUBTREE
    %% [10, 40, 30] splits into [10] and [40, 30]
    PartL1["<b>Partition 2</b><br/>Left: [10]<br/>Right: [40, 30]"]:::pivot
    L1 --> PartL1
    
    LL1["[10]"]:::leaf
    LR1["[40, 30]"]:::array
    PartL1 --> LL1
    PartL1 --> LR1

    %% [40, 30] splits into [30] and [40]
    PartLR1["<b>Partition 3</b><br/>Left: [30]<br/>Right: [40]"]:::pivot
    LR1 --> PartLR1
    
    LRL1["[30]"]:::leaf
    LRR1["[40]"]:::leaf
    PartLR1 --> LRL1
    PartLR1 --> LRR1

    %% RIGHT SUBTREE
    %% [90, 80, 50, 70] splits into [70, 80, 50] and [90]
    PartR1["<b>Partition 4</b><br/>Left: [70, 80, 50]<br/>Right: [90]"]:::pivot
    R1 --> PartR1

    RL1["[70, 80, 50]"]:::array
    RR1["[90]"]:::leaf
    PartR1 --> RL1
    PartR1 --> RR1

    %% [70, 80, 50] splits into [50] and [70, 80]
    PartRL1["<b>Partition 5</b><br/>Left: [50]<br/>Right: [70, 80]"]:::pivot
    RL1 --> PartRL1

    RLL1["[50]"]:::leaf
    RLR1["[70, 80]"]:::array
    PartRL1 --> RLL1
    PartRL1 --> RLR1

    %% [70, 80] splits into [70] and [80]
    PartRLR1["<b>Partition 6</b><br/>Left: [70]<br/>Right: [80]"]:::pivot
    RLR1 --> PartRLR1

    RLRL1["[70]"]:::leaf
    RLRR1["[80]"]:::leaf
    PartRLR1 --> RLRL1
    PartRLR1 --> RLRR1

    %% Final result reconstruction (Conceptual Edge)
    Final["<b>Final Sorted</b><br/>[10, 30, 40, 50, 70, 80, 90]"]:::array
    LL1 -.-> Final
    LRL1 -.-> Final
    LRR1 -.-> Final
    RLL1 -.-> Final
    RLRL1 -.-> Final
    RLRR1 -.-> Final
    RR1 -.-> Final
```

# Implementation
## Lomuto's partition
### Java
```Java title='Quicksort in Java: Lomuto partition' hl=16-17,26
public class QuickSort {
    
    public static void quickSort(int[] arr) {
        if (arr == null || arr.length == 0) {
            return;
        }
        quickSortHelper(arr, 0, arr.length - 1);
    }
    
    private static void quickSortHelper(int[] arr, int low, int high) {
        if (low < high) {
            // Partition the array and get pivot index
            int pivotIndex = partition(arr, low, high);
            
            // Recursively sort elements before and after partition
            quickSortHelper(arr, low, pivotIndex - 1);
            quickSortHelper(arr, pivotIndex + 1, high);
        }
    }
    
    /**
     * Lomuto partition scheme
     * Chooses the last element as pivot
     */
    private static int partition(int[] arr, int low, int high) {
        int pivot = arr[high];
        int i = low - 1; // Index of smaller element
        
        for (int j = low; j < high; j++) {
            // If current element is smaller than or equal to pivot
            if (arr[j] <= pivot) {
                i++;
                swap(arr, i, j);
            }
        }
        
        // Place pivot in correct position
        swap(arr, i + 1, high);
        return i + 1;
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
```
### Go

### JavaScript
## Hoare's partition
### Java
```Java title='Quicksort in Java: Hoare partition' hl=24,25,29-31,34-36,39-40,43,13-14
public class QuickSort {
    
    public static void quickSort(int[] arr) {
        if (arr == null || arr.length == 0) {
            return;
        }
        quickSortHelper(arr, 0, arr.length - 1);
    }
    
    private static void quickSortHelper(int[] arr, int low, int high) {
        if (low < high) {
            int pivotIndex = partitionHoare(arr, low, high);
            quickSortHelper(arr, low, pivotIndex);
            quickSortHelper(arr, pivotIndex + 1, high);
        }
    }
    
    /**
     * Hoare partition scheme (original QuickSort partition)
     * More efficient than Lomuto - fewer swaps on average
     */
    private static int partition(int[] arr, int low, int high) {
        int pivot = arr[low]; // Choose first element as pivot
        int i = low - 1;
        int j = high + 1;
        
        while (true) {
            // Find element on left that should be on right
            do {
                i++;
            } while (arr[i] < pivot);
            
            // Find element on right that should be on left
            do {
                j--;
            } while (arr[j] > pivot);
            
            // If pointers crossed, partition is complete
            if (i >= j) {
                return j;
            }
            
            swap(arr, i, j);
        }
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
```
### Go
### JavaScript
# Time complexity
## Mathematical analysis
### Best case
- Each partition halves the size of the array.
- Let $n$ be the size of the array, the time complexity is $$T(n)=2T\left(\frac{n}{2}\right)+\Theta(n)=\Theta(n\text{log}n)$$
### Worst case
- The given array has already been sorted in the same or reverse order; therefore, each partition only decreases the problem size by $1$.
- The time complexity is $$T(n)=T(n-1)+T(0)+\Theta(n)=\Theta(n^2)$$
- 
### Average case
- The time complexity is $$T(n)=O(n\text{log}(n))$$
## Lomuto's partition and Hoare's partition
- Hoare's partition is slightly more efficient because it performs three times fewer swaps than Lomuto's partition on average.
# Space complexity
- $O(n)$
***
# References
1. Introduction to Algorithms - Thomas H. Cormen, Charles E. Leserson, Ronald L. Rivest, Clinfford Sten - The MIT Press - Third Edition 2009.
	1. Chapter II. Sorting and Order Statistics.
		1. Section 7. Quicksort.
2. https://en.wikipedia.org/wiki/Quicksort#:~:text=Quicksort%20was%20developed%20by%20British,data%2C%20particularly%20on%20larger%20distributions.&text=Animated%20visualization%20of%20the%20quicksort%20algorithm.
3. [[Recurrence relation#Master theorem]]
4. https://www.geeksforgeeks.org/dsa/hoares-vs-lomuto-partition-scheme-quicksort/
5. 