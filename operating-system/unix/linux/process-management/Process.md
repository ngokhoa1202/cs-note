#operating-system #process #linux #unix #process-management #concurrency #scheduling

## Definition
- A ==process== is an instance of a program in execution. It is a fundamental unit of work in an operating system and represents the basic abstraction that allows multiple programs to run concurrently on a single machine.
## Characteristics
- **Unique identifier**: Each process is identified by a ==process ID (PID)==, a unique integer assigned by the operating system
- **Independent execution**: Each process has its own address space, preventing interference with other processes
- **Resource ownership**: Processes own system resources including memory, file descriptors, and CPU time
- **State representation**: Represented by a program counter (next instruction to execute) and processor register values
- **Dynamic entity**: A process is active and changes state, unlike a program which is a passive set of instructions
## Memory Layout (Binary Image)

![600x600](Pasted%20image%2020240525160759.png)
### Text Section (Code Segment)
- Contains the executable code (machine instructions)
- Read-only and shareable among multiple processes running the same program
- Fixed size during process execution
- Located at lower memory addresses
### Data Section
- Contains global and static variables
- Divided into two subsections:
  - **Initialized data**: Global and static variables with initial values
  - **Uninitialized data (BSS)**: Global and static variables without initial values (zero-initialized)
- Fixed size during process execution
### Heap Section
- Used for dynamic memory allocation during runtime
- Managed by `malloc()`, `calloc()`, `realloc()`, and `free()` in C
- Grows upward (toward higher memory addresses)
- Size changes dynamically during process execution
- Shared by all threads within the process
### Stack Section
- Used for function call management and local variables
- Stores:
    - Function parameters
    - Return addresses
    - Local variables
    - Function call frames
- Grows downward (toward lower memory addresses)
- Each thread has its own stack
- Automatically managed (allocation/deallocation on function entry/exit)
- Fixed maximum size (can cause stack overflow if exceeded)

```C title='Memory layout demonstration'
#include <stdio.h>
#include <stdlib.h>

int global_var = 10;           // Data section (initialized)
int uninitialized_var;          // BSS section (uninitialized data)
const int constant = 100;       // Text section (read-only)

void function() {               // Text section
    int local_var = 5;          // Stack
    int *heap_var = malloc(sizeof(int));  // Pointer on stack, data on heap
    *heap_var = 20;

    printf("Stack address (local_var): %p\n", &local_var);
    printf("Heap address (heap_var): %p\n", heap_var);
    printf("Data address (global_var): %p\n", &global_var);
    printf("Text address (function): %p\n", &function);

    free(heap_var);
}

int main() {
    function();
    return 0;
}
```
## Process States
- As a process executes, it changes state. The exact states depend on the operating system, but generally include these five states:

![](Pasted%20image%2020240525161359.png)

### New
- Process is being created
- PCB (Process Control Block) is being initialized
- Memory and resources are being allocated

### Ready
- Process is prepared to execute and waiting for CPU assignment
- All resources except CPU are available
- Process is in the ready queue

### Running
- Process is currently executing on a CPU core
- Instructions are being executed
- Only one process per CPU core can be in this state at a time

### Waiting (Blocked)
- Process is waiting for an event to occur (I/O completion, signal, etc.)
- Cannot proceed until the event occurs
- Process is in a wait queue

### Terminated (Exit)
- Process has finished execution
- Resources are being deallocated
- PCB will be removed after parent calls `wait()`
### State Transitions
- **New → Ready**: Process creation completed, admitted to ready queue
- **Ready → Running**: CPU scheduler selects process for execution (==dispatch==)
- **Running → Ready**: Time quantum expired (==preemption==) or higher priority process arrives
- **Running → Waiting**: Process requests I/O or waits for an event
- **Waiting → Ready**: I/O completion or event occurs
- **Running → Terminated**: Process completes execution or is killed

```C title='Viewing process states in Linux'
// In shell: ps aux or ps -elf
// Process state codes in Linux:
// R - Running or runnable (on run queue)
// S - Interruptible sleep (waiting for an event)
// D - Uninterruptible sleep (usually I/O)
// T - Stopped (by job control signal or being traced)
// Z - Zombie (terminated but not reaped by parent)
```
## Process Control Block (PCB)
- Each process is represented in the operating system by a ==process control block== (PCB)—also called a *task control block*. The PCB is a data structure maintained by the OS that contains all information about a process.

![](Pasted%20image%2020250517072253.png)
### PCB Components
- **Process state**: Current state (new, ready, running, waiting, terminated)
- **Process ID (PID)**: Unique identifier for the process
- **Program counter**: Address of the next instruction to execute
- **CPU registers**: Contents of all process-specific registers (accumulator, index registers, stack pointers, general-purpose registers)
- **CPU scheduling information**: Process priority, pointers to scheduling queues, other scheduling parameters
- **Memory management information**: Base and limit registers, page tables, segment tables
- **Accounting information**: CPU time used, time limits, account numbers, process start time
- **I/O status information**: List of open files, list of allocated I/O devices, pending I/O operations
### PCB in Linux (`task_struct`)
- In Linux, the PCB is implemented as `struct task_struct` in the kernel:

```C title='Simplified task_struct representation'
struct task_struct {
    volatile long state;      /* Process state */
    pid_t pid;                /* Process identifier */
    struct mm_struct *mm;     /* Memory management info */
    struct files_struct *files; /* Open file information */
    int prio;                 /* Process priority */
    unsigned int time_slice;  /* Scheduling time slice */
    struct task_struct *parent; /* Parent process */
    struct list_head children;  /* List of child processes */
    // ... many more fields
};
```
## Process Creation
- Processes are created through system calls. In Unix/Linux, the primary mechanism is `fork()`.
### `fork()` System Call

```C title='Basic fork() usage'
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        // Fork failed
        fprintf(stderr, "Fork failed\n");
        return 1;
    }
    else if (pid == 0) {
        // Child process
        printf("Child process: PID = %d, Parent PID = %d\n",
               getpid(), getppid());
    }
    else {
        // Parent process
        printf("Parent process: PID = %d, Child PID = %d\n",
               getpid(), pid);
    }

    return 0;
}
```
- Creates a new process by duplicating the calling process
- Child process gets a copy of parent's address space, file descriptors, and resources
- Returns 0 to child process, child's PID to parent, -1 on error
- Both processes continue execution from the point after `fork()`
- Copy-on-write (COW) optimization: pages are shared until modified
### `exec()` Family
- The `exec()` family of functions replaces the current process image with a new program:
```C title='fork() + exec() pattern'
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        // Child process - execute a new program
        execl("/bin/ls", "ls", "-l", NULL);
        // If exec fails, this line executes
        fprintf(stderr, "Exec failed\n");
        return 1;
    }
    else if (pid > 0) {
        // Parent waits for child to complete
        wait(NULL);
        printf("Child completed\n");
    }

    return 0;
}
```

- **Common `exec()` variants:**
    - `execl()`, `execlp()`, `execle()`: Take argument list
    - `execv()`, `execvp()`, `execve()`: Take argument vector
    - `p` suffix: Searches PATH for executable
    - `e` suffix: Accepts environment variables
## Process Termination
- A process terminates when it finishes execution or is explicitly terminated.
### Normal Termination
```C title='exit() system call'
#include <stdlib.h>
#include <stdio.h>

int main() {
    printf("Process is terminating\n");
    exit(0);  // 0 typically indicates success
}
```
### Termination Steps
1. Process calls `exit()` (explicitly or implicitly at end of `main()`)
2. Operating system deallocates process resources:
   - Close open files
   - Release memory (heap, stack, data, text)
   - Remove process from scheduling queues
3. Process enters terminated state (zombie)
4. PCB remains until parent calls `wait()`
5. Exit status is passed to parent
### `wait()` System Call
- Parent processes use `wait()` to collect exit status of child processes:
```C title='wait() and waitpid() usage'
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        // Child process
        printf("Child: doing work\n");
        sleep(2);
        exit(42);  // Exit with status 42
    }
    else if (pid > 0) {
        // Parent process
        int status;
        pid_t child_pid = wait(&status);

        if (WIFEXITED(status)) {
            printf("Child %d exited with status %d\n",
                   child_pid, WEXITSTATUS(status));
        }
    }

    return 0;
}
```

```C title='waitpid() for specific child'
#include <sys/wait.h>

int status;
pid_t pid = fork();

if (pid > 0) {
    // Wait for specific child, don't block if not ready
    waitpid(pid, &status, WNOHANG);
}
```
## Process Scheduling
- Each CPU core can run ==only one process (thread) at a time==. The CPU scheduler is responsible for selecting which process to execute next.
### Scheduling Queues

- Processes are organized into queues:
    - **Ready queue**: Contains all processes that are ready to execute and waiting for CPU
          - Implemented as a linked list in Linux
          - Scheduler selects from this queue for execution
    - **Wait queues**: Processes waiting for specific events (I/O, signals, etc.)
          - Separate queues for different types of events
          - Processes moved to ready queue when event occurs
### Scheduling Actions
- **==Dispatch==**: CPU scheduler selects a process from ready queue and allocates CPU to it
- **==Preemption==**: Running process is forcibly removed from CPU (time quantum expires, higher priority process arrives)
- **Admission**: New process is added to ready queue
```Shell title='Viewing process scheduling information'
# View all processes with scheduling info
ps -eo pid,comm,pri,nice,state

# View real-time scheduling policies
chrt -p <pid>

# Set process priority (nice value)
nice -n 10 ./my_program    # Lower priority
renice -5 -p <pid>         # Increase priority
```
## Context Switching
- ==Context switching== is the mechanism by which the operating system switches the CPU from one process to another.
### Context Switch Steps
1. Save the state of the current process $P_0$ into its PCB ($PCB_0$):
   - Program counter
   - Register values
   - Memory management information
2. CPU core switches to another process $P_1$
3. When returning to $P_0$, first save state of $P_1$ into $PCB_1$
4. Load the saved state from $PCB_0$
5. Resume execution of $P_0$
![](Pasted%20image%2020240525162759.png)
### Context Switch Overhead
- **Context-switch time is pure overhead**: No useful work is done during the switch
- **Typical overhead**: 1-10 microseconds depending on hardware and OS
- **Factors affecting performance**:
  - Cache invalidation (cold cache after switch)
  - TLB (Translation Lookaside Buffer) flush for memory management
  - Number of registers to save/restore
  - CPU architecture (RISC vs CISC)
```C title='Measuring context switch time (simplified concept)'
#include <time.h>
#include <unistd.h>
#include <sys/wait.h>

// Pipe creates forced context switches
int main() {
    int fd[2];
    pipe(fd);

    if (fork() == 0) {
        // Child: repeatedly write to pipe
        char byte = 'x';
        while (1) write(fd[1], &byte, 1);
    } else {
        // Parent: repeatedly read from pipe
        // Each read/write pair forces context switches
        char byte;
        clock_t start = clock();
        for (int i = 0; i < 100000; i++) {
            read(fd[0], &byte, 1);
        }
        clock_t end = clock();
        printf("Average switch time: %f μs\n",
               (double)(end - start) / CLOCKS_PER_SEC / 100000 * 1000000);
    }
    return 0;
}
```
## Zombie Process & Orphan Process
### Zombie Process
- A ==zombie process== (defunct process) is a process that has terminated but whose parent has not yet called `wait()` to read its exit status.
#### Characteristics
- Process has finished execution (`exit()` was called)
- All resources (memory, file descriptors) have been deallocated
- Entry in the process table (PCB) remains until parent calls `wait()`
- Appears as `<defunct>` or with state `Z` in `ps` output
- Consumes minimal resources (only PCB entry)
- Cannot be killed with `kill` command (already dead)
```C title='Zombie process example'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

int main(int argc, char* argv[]) {
    int pid = fork();

    if (pid == 0) {
        // Child process
        printf("Child: PID=%d, Parent PID=%d\n", getpid(), getppid());
        printf("Child exiting, becoming zombie...\n");
        exit(EXIT_SUCCESS);
    } else if (pid > 0) {
        // Parent does NOT call wait() - child becomes zombie
        printf("Parent: PID=%d, Child PID=%d\n", getpid(), pid);
        sleep(30);  // Sleep long enough to check with ps command
        // Child is now a zombie for 30 seconds
    }

    return 0;
}
```

```Shell title='Detecting zombie processes'
# Check for zombie/defunct processes
ps -elf | grep '[Zz]'
ps aux | grep 'Z'

# Count zombie processes
ps aux | awk '$8=="Z" {print $0}' | wc -l
```
- ![](Pasted%20image%2020250517145038.png)
#### Prevention
```C title='Proper wait() usage to prevent zombies'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        // Child process
        printf("Child: PID = %d\n", getpid());
        exit(0);  // Child exits
    }
    else if (pid > 0) {
        // Parent calls wait() to reap zombie
        printf("Parent: waiting for child\n");
        wait(NULL);  // Prevents child from becoming zombie
        printf("Child reaped successfully\n");
    }

    return 0;
}
```
#### Fix zombie process
1. Fix parent process to call `wait()` or `waitpid()`
2. Kill the parent process - zombies will be adopted by init/systemd (PID 1) which automatically reaps them
3. Use signal handlers to automatically reap children:
```C title='Preventing zombie processes with SIGCHLD handler'
#include <signal.h>
#include <sys/wait.h>

void sigchld_handler(int sig) {
    // Reap all terminated children
    while (waitpid(-1, NULL, WNOHANG) > 0);
}

int main() {
    signal(SIGCHLD, sigchld_handler);  // Register handler
    // ... fork children ...
}
```
### Orphan Process
- An ==orphan process== is a process whose parent terminated before calling `wait()` on it, leaving the child process still running.
#### Characteristics
- Process is still running but parent has terminated
- Cannot remain without a parent in Unix/Linux
- Automatically ==re-parented== (adopted) by an init process:
      - Traditional Unix: adopted by `init` (PID 1)
      - Modern Linux: adopted by nearest subreaper or `systemd` (PID 1)
- Not a problem - reaper process will eventually call `wait()`
- Common in daemon processes and service management
```C title='Creating an orphan process'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        // Child process
        printf("Child: PID=%d, Parent PID=%d\n", getpid(), getppid());
        sleep(5);  // Sleep to allow parent to exit
        printf("Child: PID=%d, New Parent PID=%d (adopted)\n",
               getpid(), getppid());
        // Parent PID is now 1 (init/systemd) or subreaper PID
    }
    else if (pid > 0) {
        // Parent process exits immediately
        printf("Parent: PID=%d, exiting immediately\n", getpid());
        exit(0);  // Parent terminates, child becomes orphan
    }

    return 0;
}
```

```C title='Intentional orphan for daemon creation'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>

void create_daemon() {
    pid_t pid = fork();

    if (pid < 0) exit(EXIT_FAILURE);
    if (pid > 0) exit(EXIT_SUCCESS);  // Parent exits, child becomes orphan

    // Child continues as daemon
    if (setsid() < 0) exit(EXIT_FAILURE);  // Create new session
    umask(0);  // Reset file mode mask
    chdir("/");  // Change working directory to root

    // Close standard file descriptors
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    // Daemon is now running, adopted by init
    while (1) {
        // Daemon work here
        sleep(10);
    }
}
```
## Inter-Process Communication (IPC)
- Processes need mechanisms to communicate and synchronize.
### Shared Memory
- [[operating-system/unix/linux/process-management/inter-process-communication/Shared memory|Shared memory]]
### Message Passing
- [[operating-system/unix/linux/process-management/inter-process-communication/Message passing|Message passing]]
### Pipes
- [[operating-system/unix/linux/process-management/inter-process-communication/Pipe|Pipe]]
### Signals
- 
### Sockets
- 

```C title='Simple pipe example'
#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main() {
    int fd[2];
    char buffer[20];

    pipe(fd);  // Create pipe: fd[0] for reading, fd[1] for writing

    if (fork() == 0) {
        // Child: write to pipe
        close(fd[0]);  // Close unused read end
        write(fd[1], "Hello parent", 13);
        close(fd[1]);
    }
    else {
        // Parent: read from pipe
        close(fd[1]);  // Close unused write end
        read(fd[0], buffer, 20);
        printf("Received: %s\n", buffer);
        close(fd[0]);
    }

    return 0;
}
```
***
# References
1. Operating System Concepts - Abraham Silberschatz, Peter B. Galvin, Greg Gagne - 10th Edition - 2018 - Pearson Publisher
    1. Chapter 3: Processes
    2. Chapter 5: CPU Scheduling
2. The Linux Programming Interface - Michael Kerrisk - 2010 - No Starch Press
    1. Chapter 24: Process Creation
    2. Chapter 25: Process Termination
    3. Chapter 26: Monitoring Child Processes
3. Advanced Programming in the UNIX Environment - W. Richard Stevens, Stephen A. Rago - 3rd Edition - 2013 - Addison-Wesley
    1. Chapter 8: Process Control
    2. Chapter 9: Process Relationships
4. https://man7.org/linux/man-pages/man2/fork.2.html for fork() system call
5. https://man7.org/linux/man-pages/man2/wait.2.html for wait() and waitpid()
6. https://man7.org/linux/man-pages/man3/exec.3.html for exec() family
7. [Process Synchronization](process-synchronization/Process%20synchronization.md)
8. [CPU Scheduling](scheduling/CPU%20Scheduling.md)
9. [Threads](threading/Thread.md)
10. [[operating-system/unix/linux/process-management/inter-process-communication/Shared memory|Shared memory]]
11. [[operating-system/unix/linux/process-management/inter-process-communication/Message passing|Message passing]]
12. 