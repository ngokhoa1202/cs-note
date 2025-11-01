#process-synchronization #ipc #parallel-programming #thread #process #operating-system #critical-section 

- Classic <mark style="background: #e4e62d;">software-based</mark> solution to critical section problem.
- Not guaranteed to work on modern architectures $\equiv$ the processor is able to <mark style="background: #e4e62d;">reorder instructions</mark> and multi-threaded processors
- Restricted to two processes.
# Peterson's solution
- Works brilliantly on <mark style="background: #e4e62d;">single-threaded</mark> system.
- Source code for Process $P_i$
```c

// shared resources
int turn; 
boolean flag[2];


while (true) { 
  flag[i] = true; // P_i is ready now
  turn = j; // But it's turn for P_j
  while (flag[j] && turn == j) ; /* critical section */ 
  flag[i] = false; /*remainder section */ 
}
```
## Variables
- The variable `turn` indicates whose turn it is to enter its critical section. That is, if `turn == i`, then process $P_i$ is allowed to execute in its critical section. $\implies$ <mark style="background: #e4e62d;">permission</mark>.
- The `flag` array is used to indicate if a process is ready to enter its critical section. For example, if `flag[i]` is true, $P_i$ is ready to enter its critical section.  $\implies$ <mark style="background: #e4e62d;">readiness</mark>.
- The condition `flag[j] && turn == j` indicates that the other process $P_j$ is executing its critical section, so process $P_i$ has to wait.
## Algorithm
- To enter the critical section, process $P_i$ first sets `flag[i]` to be `true` and then sets `turn` to the value` j`, thereby asserting that <mark style="background: #e4e62d;">if the other process wishes to enter the critical section, it can do so</mark>. 
- If both processes try to enter at the same time, `turn` will be set to both `i` and `j` at roughly the same time. Only <mark style="background: #e4e62d;">one of these assignments will last</mark>; the other will occur but will be overwritten immediately.
- The eventual value of `turn` determines which of the two processes is allowed to enter its critical section first.
# Proof
- [Peterson's solution](Peterson's%20solution.md) is proven to satisfy all of the requirements for a solution to [Critical section problem](Critical%20section%20problem.md)
## Mutual exclusion
- Each process $P_i$ enters its critical section only if either `flag[j] == false` or `turn == i` 
- If both processes can be executing in their critical sections at the same time, then `flag[0] == flag[1] == true` $\implies$ dilemma.
## Progress
- If $P_j$ is not ready to enter the critical section, then `flag[j] == false`, and  $P_i$ can enter its critical section. 
- If $P_j$ has set `flag[j]` to `true` and is also executing in its `while` statement, then either `turn == i` or `turn == j`. If `turn == i`, then $P_i$ will enter the critical section. If `turn == j`, then $P_j$ will enter the critical section. 
- However, once $P_j$ exits its critical section, it will <mark style="background: #e4e62d;">reset</mark> `flag[j]` to `false`, allowing $P_i$ to enter its critical section. If $P_j$ resets `flag[j]` to `true`, it must also set `turn` to `i`. $P_i$  will enter the critical section.
## Bounded waiting
- $P_i$  will enter the critical section at most one entry by $P_j$.
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
2. [Critical section problem](Critical%20section%20problem.md)
3. 

