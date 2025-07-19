#process #operating-system #thread #parallel-programming

# Concepts
- Each CPU core can run ==only one  thread at a time==.
- ==Basic unit== of CPU utilization.
- A lightweight process: multiple threads can ==share a process's code section, data section and executable file, but each thread has its ==own register, program counter and stack section==.
- ![](Pasted%20image%2020240525164757.png)
# Multi-threading models
## Many-to-one model
- ![](Pasted%20image%2020240525165334.png)
- Many user threads are mapped to only one kernel thread.
- One thread is blocked $\Rightarrow$ all threads will be blocked.
- Not common.
## One-to-one model
- Too many threads $\Rightarrow$ poor performance.
- Most popular
- ![](Pasted%20image%2020240525165659.png)
## Many-to-many model
- Many user threads are mapped to many kernel threads.
- Not common.
- ![](Pasted%20image%2020240525165900.png)

---
# References
1. Operating System Concepts - Abraham-Silberschatz - Wiley Publisher - 10th - 2018.
	1. Chapter 4. Threads & Concurrency.
		1. 