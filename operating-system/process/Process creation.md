#c #cpp #operating-system #gnu #linux #process 

# Overview
- The `fork()` system call allows one process, the parent, to <mark class="hltr-yellow">create a new proces</mark>s, the child. This is done by making the new child process an (almost) exact <mark class="hltr-yellow">duplicate of the paren</mark>t: the child obtains copies of the parent’s stack, data, heap,and text segments.
- The `exit(status)` library function <mark class="hltr-yellow">terminates</mark> a process, reclaiming all resources (memory, open file descriptors, and so on). The status argument is an integer that determines the termination status for the process. Using the `wait()` system call, the parent can retrieve this status.
- The `wait(&status)` system call has two purposes. 
	- First, if a child of this process has not yet terminated by calling `exit()`, then `wait()`<mark class="hltr-yellow"> suspends execution</mark> of the process until one of its children has terminated. 
	- Second, the termination <mark class="hltr-yellow">status of the child</mark> is returned in the status argument of `wait()`.
- ![](Pasted%20image%2020250517101142.png)
# Fork
- The `fork()` system call creates a new process, the child, which is an almost exact duplicate of the parent process, thus enhance greater concurrency.
## Example
- If no condition is specified and the number of `fork()` system call is $n$, then there is totally $2^n$ during the execution of the program.
```c title='fork() system call example'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

void display(int n)
{
  for (int i = n; i < n + 5; ++i) {
    printf("%d ", i);
    fflush(stdout);
  }
  printf("\n");
}

int main(int argc, char* argv[])
{
  int n = 0;
  scanf("%d", &n);
  for (int i = 0; i < n; ++i) {
    fork();
    printf("Hello C\n");
  }

  int child_id = fork();
  if (child_id == -1) {
    exit(1);
  }

  if (child_id > 0) { // in parent process
    printf("Hello C\n");
  } else {
    int grandchild_id = fork();
    if (grandchild_id == -1) {
      exit(1);
    }
    if (grandchild_id == 0) { // in grandchild process
      printf("Hello C\n");
    }
  }

  return 0;
}

```
# Wait
- `wait()` suspends the execution of the process until one of its children has terminated and returns the status of that child process.
- `wait()` is used to preclude zombie processes and orphan processes.
## Example
```c title='wait() system call example'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
  printf("Current pid: %d. Parent pid: %d\n", getpid(), getppid());

  printf("I am process %d\n", getpid());
  if (wait(NULL) == -1) {

    printf("No children to wait for\n");
  } else {
    printf("I am waiting for children\n");
  }

  return 0;
}

```
- The behavior is inconsistent because the parent process may end before its child terminate without `wait()`. $\implies$ orphan process.
```cpp title='Unexpected behaviors occurs when parent process does not wait for its child'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

void display(int n)
{
  for (int i = n; i < n + 5; ++i) {
    printf("%d ", i);
    fflush(stdout);
  }
}

int main(int argc, char* argv[])
{
  int pid = fork();
  int n;
  if (pid == 0) { // child process
    n = 5;
  } else { // parent process
    n = 10;
  }
  display(n);
}
```

- The behavior is now the parent process waits for the end of the child process to resumes its execution after `wait()` system call is invoked.
```c title='wait() system call example'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

void display(int n)
{
  for (int i = n; i < n + 5; ++i) {
    printf("%d ", i);
    fflush(stdout);
  }
  printf("\n");
}

int main(int argc, char* argv[])
{
  int pid = fork();
  int n;
  if (pid == 0) { // child process
    n = 5;
  } else { // parent process
    n = 10;
  }
  if (pid > 0) { // parent process
    wait(NULL); // suspends execution unitl child process finishes
  }
  display(n);
  return 0;
}

```
---
# Preferences
1. https://www.youtube.com/watch?v=tcYo6hipaSA&list=PLfqABt5AS4FkW5mOn2Tn9ZZLLDwA3kZUY&index=2
2. The Linux programming interface A Linux and UNIX system programming handbook - Micheal Kerrisk -No Starch Press (2010).
	1. Section 24. Process creation
		1. Section 24.1 Overview of fork(), exit(), wait(), and execve()
		2. 
3. [Process](Process.md)
4. 