#recursion #algorithm-analysis #complexity #divide-and-conquer
# Recurrence relation
- A ==recurrence relation== defines a sequence where each term is expressed as a function of previous terms.
- Recurrence relations are used to analyze the time complexity of recursive algorithms.
- The goal is to solve the recurrence to obtain a closed-form expression for complexity as a function of input size $n$.
- Three primary methods for solving recurrences: substitution method, recursion tree method, and master theorem.
## Example: Binary search
- Binary search divides the problem in half at each step.
- Recurrence: $T(n) = T\left(\frac{n}{2}\right) + O(1)$
- This recurrence describes splitting the array and performing constant work.
- Solution: $T(n) = O(\log n)$
## Example: Merge sort
- Merge sort divides the array into two halves, sorts recursively, then merges.
- Recurrence: $T(n) = 2T\left(\frac{n}{2}\right) + O(n)$
- Two recursive calls on half-sized problems, plus linear merge work.
- Solution: $T(n) = O(n \log n)$
# Substitution method
- The substitution method involves ==guessing the solution== and proving it by mathematical induction.
- Steps:
	1. Guess the form of the solution
	2. Use mathematical induction to verify the guess
	3. Solve for constants
## Guess and prove approach
- Make an educated guess based on the recurrence structure.
- Prove the guess is correct using induction.
- Common guess patterns:
	- $T(n) = T\left(\frac{n}{2}\right) + c \Rightarrow$ guess $O(\log n)$
	- $T(n) = 2T\left(\frac{n}{2}\right) + cn \Rightarrow$ guess $O(n \log n)$
	- $T(n) = T(n-1) + c \Rightarrow$ guess $O(n)$
## Example 1: Linear recursive
$$\begin{cases}
T(1) = 1 \\
T(n) = T(n-1) + c
\end{cases}$$
- Guess: $T(n) = O(n)$, more specifically $T(n) \leq dn$ for some constant $d$.
- ==Base case==: $T(1) = 1 \leq d \cdot 1$ is true for $d \geq 1$.
- ==Inductive hypothesis==: Assume $T(k) \leq dk$ for all $k < n$.
- ==Inductive step==:
$$\begin{align}
T(n) &= T(n-1) + c \\
&\leq d(n-1) + c \quad \text{(by inductive hypothesis)} \\
&= dn - d + c \\
&\leq dn \quad \text{if } d \geq c
\end{align}$$
- Therefore, $T(n) = O(n)$ with $d = \max(1, c)$.
## Example 2: Divide by constant
$$\begin{cases}
T(1) = 1 \\
T(n) = T\left(\frac{n}{3}\right) + n^2
\end{cases}$$
- Guess: The $n^2$ term dominates, so guess $T(n) = O(n^2)$.
- More specifically, guess $T(n) \leq cn^2$ for some constant $c$.
- ==Base case==: $T(1) = 1 \leq c \cdot 1^2$ is true for $c \geq 1$.
- ==Inductive hypothesis==: Assume $T(k) \leq ck^2$ for all $k < n$.
- ==Inductive step==:
$$\begin{align}
T(n) &= T\left(\frac{n}{3}\right) + n^2 \\
&\leq c\left(\frac{n}{3}\right)^2 + n^2 \quad \text{(by inductive hypothesis)} \\
&= c\frac{n^2}{9} + n^2 \\
&= n^2\left(\frac{c}{9} + 1\right) \\
&\leq cn^2 \quad \text{if } \frac{c}{9} + 1 \leq c
\end{align}$$
- Solving: $\frac{c}{9} + 1 \leq c \Rightarrow 1 \leq c - \frac{c}{9} = \frac{8c}{9} \Rightarrow c \geq \frac{9}{8}$.
- Therefore, $T(n) = O(n^2)$ with $c \geq \frac{9}{8}$.
## Example 3: Multiple recursive calls
$$\begin{cases}
T(1) = 1 \\
T(n) = 2T\left(\frac{n}{2}\right) + n
\end{cases}$$
- Guess: $T(n) = O(n \log n)$, specifically $T(n) \leq cn\log n$.
- ==Base case==: For $n=2$, $T(2) = 2T(1) + 2 = 2 + 2 = 4 \leq c \cdot 2 \log 2 = 2c$, true for $c \geq 2$.
- ==Inductive hypothesis==: Assume $T(k) \leq ck\log k$ for all $k < n$.
- ==Inductive step==:
$$\begin{align}
T(n) &= 2T\left(\frac{n}{2}\right) + n \\
&\leq 2 \cdot c\frac{n}{2}\log\frac{n}{2} + n \quad \text{(by inductive hypothesis)} \\
&= cn\log\frac{n}{2} + n \\
&= cn(\log n - \log 2) + n \\
&= cn\log n - cn\log 2 + n \\
&= cn\log n - n(c\log 2 - 1) \\
&\leq cn\log n \quad \text{if } c\log 2 - 1 \geq 0 \Rightarrow c \geq \frac{1}{\log 2}
\end{align}$$
- Therefore, $T(n) = O(n \log n)$ with $c \geq \frac{1}{\log 2} \approx 1.44$.
## Example 4: Subtracting a constant
$$\begin{cases}
T(1) = 1 \\
T(n) = T(n-2) + c
\end{cases}$$
- Expanding by substitution:
$$\begin{align}
T(n) &= T(n-2) + c \\
&= T(n-4) + c + c \\
&= T(n-6) + 3c \\
&= T(n-2k) + kc
\end{align}$$
- When $n - 2k = 1$, we have $k = \frac{n-1}{2}$.
$$T(n) = T(1) + \frac{n-1}{2}c = 1 + \frac{n-1}{2}c = O(n)$$
# Recursion tree method
- The ==recursion tree method== visualizes the recurrence as a tree where each node represents the cost of a subproblem.
- The total cost is the sum of costs at all nodes in the tree.
- Steps:
	1. Draw the recursion tree
	2. Calculate cost at each level
	3. Sum costs across all levels
	4. Determine tree height
## Example 1: Binary recursion with linear work
$$T(n) = 2T\left(\frac{n}{2}\right) + cn$$
- ==Tree structure==:
	- Root: cost $cn$
	- Level 1: 2 nodes, each with cost $c\frac{n}{2}$, total $2 \cdot c\frac{n}{2} = cn$
	- Level 2: 4 nodes, each with cost $c\frac{n}{4}$, total $4 \cdot c\frac{n}{4} = cn$
	- Level $i$: $2^i$ nodes, each with cost $c\frac{n}{2^i}$, total $2^i \cdot c\frac{n}{2^i} = cn$
- ==Tree height==: $\log_2 n$ (when subproblem size reaches 1)
- ==Total cost==:
$$T(n) = \sum_{i=0}^{\log n} cn = cn(\log n + 1) = O(n \log n)$$
## Example 2: Unbalanced tree
$$T(n) = T\left(\frac{n}{3}\right) + T\left(\frac{2n}{3}\right) + cn$$
- ==Tree structure==:
	- Root: cost $cn$
	- Level 1: Left child $c\frac{n}{3}$, right child $c\frac{2n}{3}$, total $cn$
	- Each level has total cost $cn$
- ==Tree height==: The longest path is the right branch: $\log_{3/2} n$
- ==Total cost==:
$$T(n) = cn \cdot \text{height} = O(n \log n)$$
## Example 3: Decreasing geometric series
$$T(n) = 3T\left(\frac{n}{4}\right) + cn^2$$
- ==Tree structure==:
	- Root: cost $cn^2$
	- Level 1: 3 nodes, each $c\left(\frac{n}{4}\right)^2$, total $3c\frac{n^2}{16} = \frac{3}{16}cn^2$
	- Level 2: 9 nodes, each $c\left(\frac{n}{16}\right)^2$, total $9c\frac{n^2}{256} = \frac{9}{256}cn^2 = \left(\frac{3}{16}\right)^2cn^2$
	- Level $i$: $3^i$ nodes, total cost $\left(\frac{3}{16}\right)^i cn^2$
- ==Tree height==: $\log_4 n$
- ==Total cost==:
$$\begin{align}
T(n) &= \sum_{i=0}^{\log_4 n} \left(\frac{3}{16}\right)^i cn^2 \\
&= cn^2 \sum_{i=0}^{\log_4 n} \left(\frac{3}{16}\right)^i \\
&= cn^2 \cdot \frac{1 - \left(\frac{3}{16}\right)^{\log_4 n + 1}}{1 - \frac{3}{16}} \quad \text{(geometric series)} \\
&< cn^2 \cdot \frac{1}{1 - \frac{3}{16}} = \frac{16}{13}cn^2 = O(n^2)
\end{align}$$
- The root dominates the total cost.
## Example 4: Increasing geometric series
$$T(n) = 9T\left(\frac{n}{3}\right) + cn$$
- ==Tree structure==:
	- Root: cost $cn$
	- Level 1: 9 nodes, each $c\frac{n}{3}$, total $9c\frac{n}{3} = 3cn$
	- Level 2: 81 nodes, each $c\frac{n}{9}$, total $81c\frac{n}{9} = 9cn$
	- Level $i$: $9^i$ nodes, total cost $3^i cn$
- ==Tree height==: $\log_3 n$
- ==Total cost==:
$$\begin{align}
T(n) &= \sum_{i=0}^{\log_3 n} 3^i cn \\
&= cn \sum_{i=0}^{\log_3 n} 3^i \\
&= cn \cdot \frac{3^{\log_3 n + 1} - 1}{3 - 1} \\
&= cn \cdot \frac{3 \cdot n - 1}{2} = O(n^2)
\end{align}$$
- The leaves dominate the total cost.
# Master theorem
- The ==Master Theorem== provides a ==direct formula== for solving recurrences of the form:
$$T(n) = aT\left(\frac{n}{b}\right) + f(n)$$
- Where:
	- $a \geq 1$: number of recursive calls
	- $b > 1$: factor by which problem size is divided
	- $f(n)$: cost of work done outside recursive calls
	- $\frac{n}{b}$ can be $\left\lfloor\frac{n}{b}\right\rfloor$ or $\left\lceil\frac{n}{b}\right\rceil$
## Critical exponent
- Define the ==critical exponent==: $c_{\text{crit}} = \log_b a$
- This represents the exponent where the number of subproblems balances with the reduction factor.
- The relationship between $f(n)$ and $n^{c_{\text{crit}}}$ determines which case applies.
## Case 1: Leaf-dominated
- If $f(n) = O(n^{c_{\text{crit}} - \epsilon})$ for some constant $\epsilon > 0$, then:
$$T(n) = \Theta(n^{c_{\text{crit}}}) = \Theta(n^{\log_b a})$$
- ==Interpretation==: The cost is dominated by the leaves of the recursion tree.
- The work at each level decreases geometrically as we go down the tree.
- Most work happens at the deepest level (the leaves).
### Example: $T(n) = 9T\left(\frac{n}{3}\right) + n$
- Here $a = 9$, $b = 3$, $f(n) = n$.
- Critical exponent: $c_{\text{crit}} = \log_3 9 = 2$.
- Compare: $f(n) = n = O(n^{2-\epsilon})$ where $\epsilon = 1$.
- Since $n = O(n^{2-1}) = O(n^1)$ and $1 < 2$, Case 1 applies.
- Solution: $T(n) = \Theta(n^2)$.
### Example: $T(n) = 8T\left(\frac{n}{2}\right) + n^2$
- Here $a = 8$, $b = 2$, $f(n) = n^2$.
- Critical exponent: $c_{\text{crit}} = \log_2 8 = 3$.
- Compare: $f(n) = n^2 = O(n^{3-\epsilon})$ where $\epsilon = 1$.
- Case 1 applies.
- Solution: $T(n) = \Theta(n^3)$.
## Case 2: Balanced
- If $f(n) = \Theta(n^{c_{\text{crit}}})$, then:
$$T(n) = \Theta(n^{c_{\text{crit}}} \log n) = \Theta(n^{\log_b a} \log n)$$
- ==Interpretation==: The work is evenly distributed across all levels of the tree.
- Each level contributes the same asymptotic cost.
- The total is the cost per level times the number of levels ($\log n$).
### Example: $T(n) = 2T\left(\frac{n}{2}\right) + n$ (Merge sort)
- Here $a = 2$, $b = 2$, $f(n) = n$.
- Critical exponent: $c_{\text{crit}} = \log_2 2 = 1$.
- Compare: $f(n) = n = \Theta(n^1)$.
- Case 2 applies.
- Solution: $T(n) = \Theta(n \log n)$.
### Example: $T(n) = 4T\left(\frac{n}{2}\right) + n^2$
- Here $a = 4$, $b = 2$, $f(n) = n^2$.
- Critical exponent: $c_{\text{crit}} = \log_2 4 = 2$.
- Compare: $f(n) = n^2 = \Theta(n^2)$.
- Case 2 applies.
- Solution: $T(n) = \Theta(n^2 \log n)$.
### Example: $T(n) = T\left(\frac{n}{2}\right) + 1$ (Binary search)
- Here $a = 1$, $b = 2$, $f(n) = 1$.
- Critical exponent: $c_{\text{crit}} = \log_2 1 = 0$.
- Compare: $f(n) = 1 = \Theta(n^0)$.
- Case 2 applies.
- Solution: $T(n) = \Theta(n^0 \log n) = \Theta(\log n)$.
## Case 3: Root-dominated
- If $f(n) = \Omega(n^{c_{\text{crit}} + \epsilon})$ for some constant $\epsilon > 0$, and
- If the ==regularity condition== holds: $af\left(\frac{n}{b}\right) \leq cf(n)$ for some constant $c < 1$ and sufficiently large $n$,
- Then:
$$T(n) = \Theta(f(n))$$
- ==Interpretation==: The cost is dominated by the root of the recursion tree.
- The work at each level increases geometrically as we go down the tree.
- Most work happens at the top level (the root).
### Example: $T(n) = 2T\left(\frac{n}{2}\right) + n^2$
- Here $a = 2$, $b = 2$, $f(n) = n^2$.
- Critical exponent: $c_{\text{crit}} = \log_2 2 = 1$.
- Compare: $f(n) = n^2 = \Omega(n^{1+\epsilon})$ where $\epsilon = 1$.
- Check regularity: $2f\left(\frac{n}{2}\right) = 2\left(\frac{n}{2}\right)^2 = \frac{n^2}{2} \leq cf(n) = cn^2$ for $c = \frac{1}{2} < 1$. ✓
- Case 3 applies.
- Solution: $T(n) = \Theta(n^2)$.
### Example: $T(n) = 3T\left(\frac{n}{4}\right) + n \log n$
- Here $a = 3$, $b = 4$, $f(n) = n \log n$.
- Critical exponent: $c_{\text{crit}} = \log_4 3 \approx 0.793$.
- Compare: $f(n) = n \log n = \Omega(n^{0.793+\epsilon})$ for small $\epsilon > 0$ (since $n \log n$ grows faster than $n^{0.793}$).
- Check regularity: $3f\left(\frac{n}{4}\right) = 3 \cdot \frac{n}{4} \log \frac{n}{4} = \frac{3n}{4}(\log n - \log 4) < \frac{3n}{4}\log n \leq cn\log n$ for $c = \frac{3}{4} < 1$. ✓
- Case 3 applies.
- Solution: $T(n) = \Theta(n \log n)$.
### Example: $T(n) = T\left(\frac{n}{3}\right) + n$
- Here $a = 1$, $b = 3$, $f(n) = n$.
- Critical exponent: $c_{\text{crit}} = \log_3 1 = 0$.
- Compare: $f(n) = n = \Omega(n^{0+\epsilon})$ where $\epsilon = 1$.
- Check regularity: $1 \cdot f\left(\frac{n}{3}\right) = \frac{n}{3} \leq cf(n) = cn$ for $c = \frac{1}{3} < 1$. ✓
- Case 3 applies.
- Solution: $T(n) = \Theta(n)$.
## Gap cases
- Not all recurrences fit the Master Theorem.
- If $f(n)$ falls in the gap between cases (polynomially close but not equal), the theorem doesn't apply.
### Example: $T(n) = 2T\left(\frac{n}{2}\right) + \frac{n}{\log n}$
- Here $a = 2$, $b = 2$, $f(n) = \frac{n}{\log n}$.
- Critical exponent: $c_{\text{crit}} = \log_2 2 = 1$.
- $f(n) = \frac{n}{\log n}$ is asymptotically smaller than $n$ but not polynomially smaller.
- No case of Master Theorem applies.
- Must use substitution or recursion tree method.
# Common recurrence patterns
## Linear decrease
$$T(n) = T(n - 1) + c \Rightarrow T(n) = \Theta(n)$$
- Example: Linear search, simple iteration.
## Logarithmic decrease
$$T(n) = T\left(\frac{n}{2}\right) + c \Rightarrow T(n) = \Theta(\log n)$$
- Example: Binary search.
## Divide and conquer (balanced)
$$T(n) = 2T\left(\frac{n}{2}\right) + cn \Rightarrow T(n) = \Theta(n \log n)$$
- Example: Merge sort, quicksort (average case).
## Divide and conquer (unbalanced)
$$T(n) = T\left(\frac{n}{10}\right) + T\left(\frac{9n}{10}\right) + cn \Rightarrow T(n) = \Theta(n \log n)$$
- Example: Quicksort (best case with good pivot selection).
## Binary tree traversal
$$T(n) = 2T\left(\frac{n}{2}\right) + c \Rightarrow T(n) = \Theta(n)$$
- Example: Tree traversals where each node is visited once.
## Fibonacci-style
$$T(n) = T(n-1) + T(n-2) + c \Rightarrow T(n) = \Theta(\phi^n)$$
- Where $\phi = \frac{1+\sqrt{5}}{2} \approx 1.618$ is the golden ratio.
- Example: Naive recursive Fibonacci computation.
## Strassen's matrix multiplication
$$T(n) = 7T\left(\frac{n}{2}\right) + cn^2 \Rightarrow T(n) = \Theta(n^{\log_2 7}) \approx \Theta(n^{2.81})$$
- Better than naive $\Theta(n^3)$ matrix multiplication.
## Karatsuba multiplication
$$T(n) = 3T\left(\frac{n}{2}\right) + cn \Rightarrow T(n) = \Theta(n^{\log_2 3}) \approx \Theta(n^{1.59})$$
- Better than naive $\Theta(n^2)$ multiplication.
# Practical algorithm analysis
## Quicksort
- ==Best/Average case==: $T(n) = 2T\left(\frac{n}{2}\right) + cn = \Theta(n \log n)$
- ==Worst case==: $T(n) = T(n-1) + cn = \Theta(n^2)$
## Binary search tree operations
- ==Balanced tree==: $T(n) = T\left(\frac{n}{2}\right) + c = \Theta(\log n)$
- ==Unbalanced tree==: $T(n) = T(n-1) + c = \Theta(n)$
## Fibonacci computation
- ==Naive recursive==: $T(n) = T(n-1) + T(n-2) + c = \Theta(\phi^n)$
- ==Dynamic programming==: $T(n) = \Theta(n)$ with memoization
## Tower of Hanoi
- Recurrence: $T(n) = 2T(n-1) + 1$
- Solution: $T(n) = 2^n - 1 = \Theta(2^n)$
## Fast Fourier Transform
- Recurrence: $T(n) = 2T\left(\frac{n}{2}\right) + cn$
- Solution: $T(n) = \Theta(n \log n)$
# Summary table
| Recurrence | Solution | Example Algorithm |
|------------|----------|-------------------|
| $T(n) = T(n-1) + c$ | $\Theta(n)$ | Linear search |
| $T(n) = T\left(\frac{n}{2}\right) + c$ | $\Theta(\log n)$ | Binary search |
| $T(n) = 2T\left(\frac{n}{2}\right) + cn$ | $\Theta(n \log n)$ | Merge sort |
| $T(n) = 2T\left(\frac{n}{2}\right) + c$ | $\Theta(n)$ | Tree traversal |
| $T(n) = T(n-1) + cn$ | $\Theta(n^2)$ | Selection sort |
| $T(n) = T(n-1) + T(n-2)$ | $\Theta(\phi^n)$ | Fibonacci (naive) |
| $T(n) = 4T\left(\frac{n}{2}\right) + cn^2$ | $\Theta(n^2 \log n)$ | - |
| $T(n) = 7T\left(\frac{n}{2}\right) + cn^2$ | $\Theta(n^{\log_2 7})$ | Strassen multiplication |
| $T(n) = 9T\left(\frac{n}{3}\right) + cn$ | $\Theta(n^2)$ | - |
| $T(n) = 3T\left(\frac{n}{4}\right) + cn^2$ | $\Theta(n^2)$ | - |
***
# References
1. Cormen, Thomas H., et al. "Introduction to Algorithms." 4th ed., MIT Press, 2022. Chapter 4: Divide-and-Conquer.
2. Kleinberg, Jon, and Éva Tardos. "Algorithm Design." Pearson, 2005. Chapter 5: Divide and Conquer.
3. Sedgewick, Robert, and Kevin Wayne. "Algorithms." 4th ed., Addison-Wesley, 2011.
4. [[algorithm/complexity/Algorithm complexity]]