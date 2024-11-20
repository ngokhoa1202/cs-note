#cybersecurity  #web-security #race-condtition #parallel-programming  #os #transaction #application-layer #dbms  #hibernate  
# Scenario
- Servers handle ==multiple requests== on a regular basis.
- ==High traffic== $\implies$ multiple independent threads $\implies$ uncontrolled side effects $\implies$ many ==concurrent== side effects on a ==same== server's asset (an amount of money, a valuable item,...).
# Intruder's exploitation

## Slow bandwidth
- Network bandwidth is inconsistent $\implies$ many packets ==unexpectedly arrive== at server at the same time. 

## Parallel HTTP requests
- HTTP 1.1 allows packet pipelining $\equiv$ parallel in ==a single request==.
- But HTTP 2.0 allows to send ==parallel packets==. [HTTP Version](HTTP%20Version.md)
- ![](Pasted%20image%2020240816103629.png)

## Incompleted transaction - Partial construction race condition
- ![](Pasted%20image%2020240820163141.png)
- Your money has gone, but the receiver has not received yet $\implies$ Incompleted transation:
	- Can occur when the server-side is being attacked, on maintaince or even high traffic can cause this.
- This attack is also called ==partial== construction race condition.
## Time-sensitive attacks
- Mainly targets for password and digital signature.
- Based on the timestamp and the vulnerable cryptography (e.g: MD5 is considered insecure).
# Explanation
- Many server's threads try to both read and write the same variable at the same time. $\implies$ that variable is put in a "unstable" state.
- ![](Pasted%20image%2020240816104223.png)
- One thread is working with the addition operation and the register has not written the `X` variable on the RAM yet while another thread reads the old value of `X` and performs the assignment.
# Prevention - Solution
## Session-based locking
- Whenever user accesses server's resource, we create a new session:
	- Prevents user from opening two session at the same time.
## Multiprocessing
- Instead of multithreading, employ ==multiprocess==:
	- One process per HTTP request. Because a process has its indepedent binary image.
	- However, this solution ==slows down== our application.
- Used by PHP.
## Transaction locking
- Java Thread API supports locking mechanism via the `synchronize` keyword.
- For mutable operations on Database, always use transaction supported by the frameworks. If necessary, implement the ==roll back== mechanism. $\equiv$ either finish successfully or do nothing.
- Hibernate supports the two locking mechanism:
	- ==Pessimistic== locking: while one thread is writing, it blocks other threads both from reading and writing.
	- ==Optimisitic== locking. while one thread is writing, it blocks other threads only from writing.
## Rollback mechanism
- Always implement rollback mechanism for sensitive and high traffic application.
- Hibernate API provides Transaction-related mechanism.
- Almost DBMS provides rollback mechanism.
## Strong hash password.
- Use strong hashing algorithm (SHA-256, BCrypt,...).
- Use secure hash API:
	- Random generator is deterministic (or simply solvable if we know inputs). [Linear Congruential Generator - LCG](Linear%20Congruential%20Generator%20-%20LCG.md)
--- 
# References
1. https://portswigger.net/web-security/learning-paths/race-conditions for race condition introduction.
2. Operating System Concepts-Abraham Silberschatz 10th edition - 2018:
	1. Chapter 4: Thread and Concurrency.
		1. Multithreading concepts.
		2. 
	2. Chapter 6: Synchornization tools:
		1. Mutex lock.
3. Linear Congruential Generator - LCG. The simplest form of Random Generator.
4. [HTTP Version](HTTP%20Version.md) for comparison between HTTP 1.1 and HTTP 2.0 above.