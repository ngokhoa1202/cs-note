#process-synchronization #ipc #parallel-programming #thread #process #operating-system #critical-section 

# Original problem
- Cooperating processes can either directly <mark style="background: #e4e62d;">share a logical space address</mark> via inter-process communication or message passing mechanisms.
- <mark style="background: #e4e62d;">Concurrent</mark> access to that shared memory incurs data inconsistency.
## Producer-consumer problem
- Also known as bounded buffer problem.
- Allows a producer process to write data to a bounded buffer and a consumer process to consumer process to read data from that buffer.
- Producer's process.
```c
while (true) { 
  /* produce an item in next produced */ 
  
  while (count == BUFFER SIZE) ; /* do nothing */ 
  
  buffer[in] = next produced; 
  in = (in + 1) % BUFFER SIZE; 
  count++; 
}
```

- Consumer's process.
```c
while (true) { 
  while (count == 0) ; /* do nothing */ 
  next_consumed = buffer[out]; 
  out = (out + 1) % BUFFER SIZE; 
  count--; 
  
  /* consume the item in next consumed */ 
}
```

- The two implementations are correct. However, that the two processes concurrently read and write `count` variable causes incorrect execution.
## Rationale
- The statement `count++`  and `count--` are ultimately translated into machine language. It is the Arithmetic Logic Unit (ALU) that loads the value of `count` variable into a specific register and performs a binary operation on it.
```c
// count++
register1 = count
register1 = register1 + 1
count = register1

// count--
register2 = count
register2 = register2 - 1
count = register2
```
- Concurrent execution of `count++` and `count--` statements is equivalent to a sequential execution on the lower level where the statements may be interleaved in some arbitrary order.
```js
// T stands for turn
T0 : producer execute register1 = count {register1 = 5} 
T1 : producer execute register1 = register1 + 1 {register1 = 6} 
T2 : consumer execute register2 = count {register2 = 5} 
T3 : consumer execute register2 = register2 − 1 {register2 = 4} // cause incorrect logic on higher levels
T4 : producer execute count = register1 {count = 6} 
T5 : consumer execute count = register2 {count = 4}
```

# Critical section problem
## Definition
- A system is composed of $n$ processes $\{P_1,P_2,...,P_n\}$
- Each process has a code segment which is <mark style="background: #e4e62d;">shared</mark> with other processes $\implies$ critical section.
- Only <mark style="background: #e4e62d;">one process</mark> is allowed to execute that critical section at a time. $\equiv$ No two processes are concurrently executing the critical section.
```c
while (true) {
  /* entry section */
  // every process must request permission to access critical section
 
 /* critical section */
 // shared among processes

 /* exit section */
 // where the process escapse critical section
 
 /* remainder process */
 // each process has its own implementation
}
```

## Requirement
- A remedy to the critical section problem must satisfy three requirements:
### Mutual exclusion
-  If process $P_i$ is executing in its critical section, then no other processes can be executing in their critical sections.
### Progress
- If no process is executing in its critical section, only those processes not executing in their remainder sections can participate in deciding which will enter its critical section next, and this selection cannot be postponed indefinitely.
### Bounded waiting
- There exists a bound on the number of times that other processes are allowed to enter their critical sections after a process has made a request to enter its critical section and before that request is granted.
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 6: Synchronization tools.
2. 
