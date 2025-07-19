#operating-system #process #process-synchronization #mutex #parallel-programming #critical-section #thread 

# Concept
- Stands for <mark style="background: #e4e62d;">mutual exclusion</mark>.
- Has a boolean variable `available` whose value indicates the availability of the lock:
	- If the lock is available, the `acquire` invocation succeeds, then the lock is unavailable.
```c
while (true) {
  /* acquire lock */
  
  /* critical section */

  /* release lock */

  /* remainder section */
}
```

## acquire
```c
acquire() {
  /* busy waiting */
  while (!available);

  available = false;
  
  /* ready to execute critical section */
}
```

## release
```c
release() {
  available = true;

  /* allows other processes to acquire lock */
}
```

# Advantage
- Simplest solution.
# Disadvantage
- Once a process is executing the critical section, other processes become busy waiting $\equiv$ attempts to acquire lock $\implies$ high lock contention and waste CPU cycle. 

---
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
2. [Critical section problem](Critical%20section%20problem.md)
3. 