#os #process #linux #ubuntu 

# Concepts
- Identified by process id.
- Represented by program counter and value of processor.
# Memory layout (Binary image)
- ![600x600](Pasted%20image%2020240525160759.png)
- Four basic sections:
	- <mark style="background: #e4e62d;">Text section</mark>: executable code $\Rightarrow$ fixed.
	- <mark style="background: #e4e62d;">Data section</mark>: global variable $\Rightarrow$ fixed.
	- <mark style="background: #e4e62d;">Heap section</mark>: dynamically allocated memory $\Rightarrow$ change.
	- <mark style="background: #e4e62d;">Stack section</mark>: temporary storage when calling function (parameters, return address) $\Rightarrow$ change.
# Process States
- Depends on programming language, but in general has 5 states:
- ![](Pasted%20image%2020240525161359.png)
# Process scheduling
- Each CPU core can run ==only one process (a thread) at a time==.
- Each process is considered ==a node in queue== (Linux: linked-list queue). 
- There are two queues: ready queue and waiting queue. CPU scheduler will ==dispatch== a process in ready queue to CPU ==for execution==.
## Context switching
- The current process $P_0$ is saved into $PCB_0$ 
- CPU core switches to another process $P_1$.
- Before restoring process $P_0$, process $P_1$ is saved into $PCB_1$.
- CPU core reloads state from $PCB_0$ and reexecutes process $P_0$.
- ![](Pasted%20image%2020240525162759.png)

---
# References
1. . Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 3: Process.