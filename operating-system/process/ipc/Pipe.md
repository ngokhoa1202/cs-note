#c #os #unix #linux #windows #process-synchronization #process 

> Pipes are the oldest method of IPC on the UNIX system, having appeared in Third Edition UNIX in the early 1970s.


# Charateristics
- Pipe allows allow the output produced by one process to be used as the input to the other process.
- ![](Pasted%20image%2020250523110145.png)
- A pipe is a byte stream:
	- The process reading from a pipe can <mark class="hltr-yellow">read</mark> blocks of data of <mark class="hltr-yellow">any size</mark>, regardless of the size of blocks written by the writing process.
	- The data passes through the pipe <mark class="hltr-yellow">sequentially</mark>.
- Pipe is unidirectional.
- Writes of up to `PIPE_BUF` bytes are guaranteed to be atomic.
- 
- Pipe has limited capacity. Once a pipe is full, further writes to the pipe block until the reader removes some data from the pipe.
# Usage
- `pipe()` returns two open file descriptors in the array file descriptor: one for the read end of the pipe ( `filedes[0]`) and one for the write end ( `filedes[1]`)
- `read()` and `write()` system call are made use of to perform I/O on the pipe. Once written to the write end of a pipe, data is immediately available to be read from the read end:
	- It is not usual to have both the parent and child reading from a single pipe is that if two processes try to simultaneously read from a pipe, data races may occur.
- ![](Pasted%20image%2020250523111831.png)
- To connect two processes using a pipe, a `fork()` system call follows a `pipe()`. The child process inherits copies of its parent’s file descriptors.
- ![](Pasted%20image%2020250523112019.png)
- Immediately after the `fork()`, one process <mark class="hltr-yellow">closes</mark> its descriptor for the <mark class="hltr-yellow">write end </mark>of the pipe, and the other <mark class="hltr-yellow">closes</mark> its descriptor for the <mark class="hltr-yellow">read end</mark>.
```c title='Pipe descriptor usage'
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

int main()
{
  int fd[2]; // file descriptor
  // fd[0] - read file descriptior
  // fd[1] - write file descriptor
  if (pipe(fd) == -1) {
    printf("Opening pipe caused error\n");
    return 1;
  }

  int id = fork();
  if (id == 0) { // in child process
    close(fd[0]); // close the read file descriptor
    int x;
    printf("Enter an integer number: ");
    scanf("%d", &x);
    if (write(fd[1], &x, sizeof(int)) == -1) {
      printf("Writing to file descriptor caused error\n");
      return 2;
    };
    printf("Write to the current process's file descriptor: %d\n", x);
    close(fd[1]); // close the write file descriptor
  } else { // in parent process
    close(fd[1]); // close the write file descriptor. Always close the other file descriptor before current file descriptor reads or writes
    int y;
    if (read(fd[0], &y, sizeof(int))) {
      printf("Reading from the file descriptor caused error\n");
      return 3;
    }
    close(fd[0]); // close the read file descriptor
    printf("Read from the child process: %d\n", y);
  }
}

```

- 


---
# References
1. The Linux programming interface A Linux and UNIX system programming handbook - Micheal Kerrisk -No Starch Press (2010).
	1. Section 44. Pipes and Fifos.
2. https://www.youtube.com/watch?v=Mqb2dVRe0uo&list=PLfqABt5AS4FkW5mOn2Tn9ZZLLDwA3kZUY&index=6