#operating-system #process #linux #ubuntu #gnu 

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

# Process control block
- Each process is represented in the operating system by a <mark class="hltr-yellow">process control block</mark> (PCB)—also called a *task control block*, which includes:
- ![](Pasted%20image%2020250517072253.png)
- 
# Process scheduling
- Each CPU core can run ==only one process (a thread) at a time==.
- Each process is considered ==a node in queue== (Linux: linked-list queue). 
- There are two queues: ready queue and waiting queue. CPU scheduler will ==dispatch== a process in ready queue to CPU ==for execution==.
## Context switching
- The current process $P_0$ is saved into $PCB_0$
- CPU core switches to another process $P_1$.
- Before restoring process $P_0$, process $P_1$ is saved into $PCB_1$.
- CPU core reloads state from $PCB_0$ and re-executes process $P_0$.
- ![](Pasted%20image%2020240525162759.png)
- Context-switch time is pure overhead.
# Zombie process & Orphan process
## Zombie process
- A zombie process is a process that has terminated, but whose parent has not yet called `wait()`. Its resources has been deallocated by the operating system. However, its entry in the process control table must remain there until the parent calls `wait()`.
```c title='Zombie process example'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

int main(int argc, char* argv[]) {
  int pid = fork();
  if (pid == 0) { // child process
    printf("Current pid: %d. Parent pid: %d\n", getpid(), getppid());
    printf("Child exitting soon...\n");
    exit(EXIT_SUCCESS);
  } else {
    sleep(200); //
  }
  printf("Current pid: %d. Parent pid: %d\n", getpid(), getppid());

  return 0;
}
```

- Check zombie process in the shell.
```sh title='ps -elf to check zombie/defunct process'
ps -elf | grep '[Zz]'
```
- ![](Pasted%20image%2020250517145038.png)
## Orphan process
- An orphan process is a process that is still running but whose parent had terminated before invoked `wait()`.
- For Linux systems, an orphan process is reassigned to a system reaper.
```c title='Orphan and zombie process example'
/* Removing the if statement makes the child process become orphan */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

int main(int argc, char* argv[]) {
  int pid = fork();
  // if (pid > 0) { // parent process
  // if parent process did not invoke wait() here, its child process would become orphan
  //   wait(NULL); 
  // }
  printf("Current pid: %d. Parent pid: %d\n", getpid(), getppid());

  return 0;
}
```

---
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 3: Process.