#operating-system #linux #unix #synchronization #mutex #concurrency #process-management #locking
#critical-section #thread #parallel-programming
## Concept
- A ==mutex (mutual exclusion) lock== is a synchronization primitive that provides exclusive access to a shared resource by allowing only one thread to acquire the lock at a time. It is the most fundamental locking mechanism used to protect critical sections in concurrent programming.
- A mutex has a boolean variable `available` whose value indicates the availability of the lock:
    - If the lock is available, the `acquire()` invocation succeeds, and the lock becomes unavailable
    - If the lock is unavailable, the acquiring thread must wait until it is released
    - Only one thread is allowed to execute the critical section at a time while all other threads wait for the lock to be released
### Basic Structure
```C title='Critical section layout with mutex'
while (true) {
  /* acquire lock */

  /* critical section */

  /* release lock */

  /* remainder section */
}
```
## Basic Operations
### `acquire()` / `lock()`
Acquires the mutex. If already locked, the calling thread blocks until available.

```C title='Simple acquire with busy-wait (spinlock approach)'
acquire() {
  /* busy waiting */
  while (!available);

  available = false;

  /* ready to execute critical section */
}
```

```C title='Blocking acquire (true mutex approach)'
acquire() {
  if (!available) {
    /* Add thread to waiting queue */
    /* Put thread to sleep (block) */
    /* When woken up, set available = false */
  } else {
    available = false;
  }
}
```
### `release()` / `unlock()`
Releases the mutex, allowing another waiting thread to acquire it.

```C title='Simple release'
release() {
  available = true;

  /* allows other processes to acquire lock */
}
```

```C title='Blocking release (true mutex approach)'
release() {
  if (waiting_queue_not_empty) {
    /* Wake up one thread from waiting queue */
  }
  available = true;
}
```
### `trylock()`
Attempts to acquire the mutex without blocking. Returns immediately with success or failure.

```C title='Non-blocking acquire attempt'
bool trylock() {
  if (available) {
    available = false;
    return true;  /* Lock acquired */
  }
  return false;  /* Lock not available */
}
```

## Types of Mutex

### Binary Mutex (Standard)
The most common type - can be locked by only one thread at a time. The thread that locks the mutex must be the same thread that unlocks it.

### Recursive Mutex
Allows the same thread to lock the mutex multiple times without deadlocking itself. The mutex must be unlocked the same number of times it was locked.

### Error-Checking Mutex
Provides additional error checking, detecting issues like unlocking from a different thread or double-locking from the same thread.

## Implementation Examples

### POSIX Threads (C)

```C title='Basic mutex usage in POSIX threads'
#include <pthread.h>
#include <stdio.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
int shared_counter = 0;

void* increment_counter(void* arg) {
    for (int i = 0; i < 100000; i++) {
        pthread_mutex_lock(&mutex);
        shared_counter++;  // Critical section
        pthread_mutex_unlock(&mutex);
    }
    return NULL;
}

int main() {
    pthread_t thread1, thread2;

    pthread_create(&thread1, NULL, increment_counter, NULL);
    pthread_create(&thread2, NULL, increment_counter, NULL);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    printf("Final counter: %d\n", shared_counter);
    pthread_mutex_destroy(&mutex);
    return 0;
}
```

```C title='Recursive mutex example'
#include <pthread.h>

pthread_mutex_t recursive_mutex;

void init_recursive_mutex() {
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&recursive_mutex, &attr);
    pthread_mutexattr_destroy(&attr);
}

void recursive_function(int depth) {
    pthread_mutex_lock(&recursive_mutex);

    if (depth > 0) {
        recursive_function(depth - 1);
    }

    pthread_mutex_unlock(&recursive_mutex);
}
```

```C title='Try-lock pattern for non-blocking acquisition'
#include <pthread.h>
#include <errno.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

void* worker(void* arg) {
    int result = pthread_mutex_trylock(&mutex);

    if (result == 0) {
        // Successfully acquired the lock
        printf("Lock acquired, doing work\n");
        // Critical section
        pthread_mutex_unlock(&mutex);
    } else if (result == EBUSY) {
        // Lock is already held by another thread
        printf("Lock busy, doing alternative work\n");
    }
    return NULL;
}
```

### Java

```Java title='Using synchronized keyword (implicit mutex)'
public class Counter {
    private int count = 0;

    // Synchronized method - acquires lock on 'this' object
    public synchronized void increment() {
        count++;
    }

    public synchronized int getCount() {
        return count;
    }
}

// Usage
Counter counter = new Counter();

Thread t1 = new Thread(() -> {
    for (int i = 0; i < 100000; i++) {
        counter.increment();
    }
});

Thread t2 = new Thread(() -> {
    for (int i = 0; i < 100000; i++) {
        counter.increment();
    }
});

t1.start();
t2.start();
t1.join();
t2.join();
System.out.println("Final count: " + counter.getCount());
```

```Java title='Using ReentrantLock (explicit mutex)'
import java.util.concurrent.locks.ReentrantLock;

public class BankAccount {
    private int balance = 0;
    private final ReentrantLock lock = new ReentrantLock();

    public void deposit(int amount) {
        lock.lock();
        try {
            balance += amount;
        } finally {
            lock.unlock();  // Always unlock in finally block
        }
    }

    public boolean tryDeposit(int amount) {
        if (lock.tryLock()) {
            try {
                balance += amount;
                return true;
            } finally {
                lock.unlock();
            }
        }
        return false;  // Could not acquire lock
    }

    public int getBalance() {
        lock.lock();
        try {
            return balance;
        } finally {
            lock.unlock();
        }
    }
}
```

### Python

```Python title='Using threading.Lock'
import threading

counter = 0
mutex = threading.Lock()

def increment():
    global counter
    for _ in range(100000):
        mutex.acquire()
        try:
            counter += 1  # Critical section
        finally:
            mutex.release()

# Alternative: context manager syntax
def increment_with_context():
    global counter
    for _ in range(100000):
        with mutex:  # Automatically acquires and releases
            counter += 1

t1 = threading.Thread(target=increment)
t2 = threading.Thread(target=increment)

t1.start()
t2.start()
t1.join()
t2.join()

print(f"Final counter: {counter}")
```

```Python title='Using RLock (recursive lock)'
import threading

recursive_mutex = threading.RLock()

def recursive_function(depth):
    with recursive_mutex:
        print(f"Depth: {depth}")
        if depth > 0:
            recursive_function(depth - 1)

thread = threading.Thread(target=recursive_function, args=(5,))
thread.start()
thread.join()
```

### C++ (C++11 and later)

```cpp title='Using std::mutex'
#include <iostream>
#include <thread>
#include <mutex>

std::mutex mtx;
int shared_counter = 0;

void increment() {
    for (int i = 0; i < 100000; i++) {
        mtx.lock();
        shared_counter++;
        mtx.unlock();
    }
}

// Better: use lock_guard for RAII
void increment_safe() {
    for (int i = 0; i < 100000; i++) {
        std::lock_guard<std::mutex> lock(mtx);
        shared_counter++;
    }  // Automatically unlocks when lock goes out of scope
}

int main() {
    std::thread t1(increment_safe);
    std::thread t2(increment_safe);

    t1.join();
    t2.join();

    std::cout << "Final counter: " << shared_counter << std::endl;
    return 0;
}
```

```cpp title='Using std::recursive_mutex'
#include <mutex>
#include <iostream>

std::recursive_mutex rec_mtx;

void recursive_function(int depth) {
    std::lock_guard<std::recursive_mutex> lock(rec_mtx);

    std::cout << "Depth: " << depth << std::endl;

    if (depth > 0) {
        recursive_function(depth - 1);
    }
}
```

## Spinlock vs Blocking Mutex

### Spinlock (Busy-Wait)
```C title='Spinlock approach - wastes CPU cycles'
acquire() {
  while (!available);  /* Busy waiting - continuously checks */
  available = false;
}
```

**Characteristics:**
- Thread continuously checks lock status in a loop
- Wastes CPU cycles while waiting
- Good for very short critical sections (microseconds)
- No context switching overhead

### Blocking Mutex
```C title='True mutex approach - sleeps when waiting'
acquire() {
  if (!available) {
    add_to_wait_queue(current_thread);
    block();  /* Thread sleeps, gives up CPU */
  }
  available = false;
}

release() {
  available = true;
  wake_up_waiting_thread();
}
```

**Characteristics:**
- Thread sleeps (blocks) when lock unavailable
- Conserves CPU resources
- Context switching overhead when blocking/waking
- Better for longer critical sections

## Mutex Characteristics

- **Blocking behavior**: Threads sleep while waiting for the lock, conserving CPU resources
- **Ownership**: The thread that acquires the lock must release it (except recursive mutexes)
- **Context switching**: When a thread blocks on a mutex, the OS scheduler can switch to another thread
- **Priority inheritance**: Many implementations support priority inheritance to prevent priority inversion
- **Non-deterministic**: No guarantee of FIFO ordering for waiting threads (implementation-dependent)

## Mutex vs Other Synchronization Mechanisms

| Mechanism | Use Case | Blocking | Overhead | Resource Counting |
|-----------|----------|----------|----------|-------------------|
| Mutex | General-purpose mutual exclusion | Yes | Moderate | No (binary) |
| Spinlock | Very short critical sections | No (busy-wait) | Low (if held briefly) | No |
| Semaphore | Resource counting, signaling | Yes | Moderate | Yes |
| Read-Write Lock | Many readers, few writers | Yes | Higher | No |

## Common Problems

### Deadlock

Occurs when two or more threads are waiting for locks held by each other.

```C title='Classic deadlock scenario'
pthread_mutex_t lock1 = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t lock2 = PTHREAD_MUTEX_INITIALIZER;

// Thread 1
void* thread1_func(void* arg) {
    pthread_mutex_lock(&lock1);
    sleep(1);  // Give thread2 time to lock lock2
    pthread_mutex_lock(&lock2);  // DEADLOCK: waiting for lock2

    // Critical section

    pthread_mutex_unlock(&lock2);
    pthread_mutex_unlock(&lock1);
    return NULL;
}

// Thread 2
void* thread2_func(void* arg) {
    pthread_mutex_lock(&lock2);
    sleep(1);  // Give thread1 time to lock lock1
    pthread_mutex_lock(&lock1);  // DEADLOCK: waiting for lock1

    // Critical section

    pthread_mutex_unlock(&lock1);
    pthread_mutex_unlock(&lock2);
    return NULL;
}
```

**Solution**: Always acquire locks in the same order:

```C title='Deadlock prevention with lock ordering'
void* safe_thread_func(void* arg) {
    // Both threads acquire locks in the same order: lock1 then lock2
    pthread_mutex_lock(&lock1);
    pthread_mutex_lock(&lock2);

    // Critical section

    pthread_mutex_unlock(&lock2);
    pthread_mutex_unlock(&lock1);
    return NULL;
}
```

### Priority Inversion

A low-priority thread holds a lock needed by a high-priority thread, while a medium-priority thread preempts the low-priority thread, indirectly blocking the high-priority thread.

**Solution**: Use ==priority inheritance protocols== where the low-priority thread temporarily inherits the priority of the waiting high-priority thread.

### Forgotten Unlock

Forgetting to unlock a mutex leads to permanent blocking of other threads.

**Solution**: Use RAII patterns (`std::lock_guard` in C++, `with` statement in Python, `try-finally` in Java).

## Best Practices

- **Keep critical sections short**: Minimize the time a mutex is held to reduce contention
- **Use RAII/context managers**: Ensure locks are always released, even during exceptions
- **Avoid nested locking**: If multiple locks are needed, acquire them in a consistent order
- **Use try-lock for real-time systems**: Avoid indefinite blocking with `trylock()` when response time is critical
- **Choose appropriate mutex type**: Use recursive mutexes only when necessary (they have higher overhead)
- **Document lock ordering**: Clearly document the order in which locks should be acquired
- **Consider lock-free alternatives**: For very high-performance scenarios, consider lock-free data structures

## Performance Considerations

**When to use mutexes:**
- Critical section duration: 10 microseconds or longer
- Thread contention is moderate
- Context switching overhead is acceptable

**When to consider alternatives:**
- Very short critical sections ($< 10$ microseconds): Use spinlocks
- Read-heavy workloads: Use read-write locks
- Simple atomic operations: Use atomic operations instead
- High contention: Consider redesigning data structures to reduce sharing
## Kernel vs User-Space Mutexes

### Futex (Fast Userspace Mutex)
- Linux uses ==futexes==, which operate in user space when uncontended and only invoke kernel support when blocking is necessary.

```C title='Futex provides best of both worlds'
// When uncontended:
// - Operates entirely in user space (atomic operations)
// - No system call overhead

// When contended:
// - Falls back to kernel for blocking/waking threads
// - Efficient sleep-wake mechanism
```

## Advantages

- **Simple and straightforward**: Easy to understand and implement
- **Efficient resource usage**: Blocking behavior conserves CPU resources (compared to spinlocks)
- **Race condition prevention**: Effectively protects critical sections from concurrent access
- **Widely supported**: Available across all major programming languages and operating systems
- **Flexible implementations**: Various types (binary, recursive, error-checking) for different needs

## Disadvantages

- **Context switching overhead**: Blocking and waking threads incurs OS scheduler overhead
- **Priority inversion risk**: Without priority inheritance, low-priority threads can block high-priority threads
- **Potential for deadlock**: Incorrect usage with multiple locks can cause deadlock
- **No built-in timeout**: Standard mutexes block indefinitely (though some implementations provide timed variants)
- **Busy-wait wastes CPU**: Simple spinlock-based implementations waste CPU cycles - once a process is executing the critical section, other processes become busy waiting $\equiv$ attempts to acquire lock $\implies$ high lock contention and wasted CPU cycles

***
# References
1. Operating System Concepts - Abraham Silberschatz, Peter B. Galvin, Greg Gagne - 10th Edition - 2018 - Pearson Publisher
   1. Chapter 6: Synchronization Tools
   2. Chapter 7: Synchronization Examples
2. The Linux Programming Interface - Michael Kerrisk - 2010 - No Starch Press
   1. Chapter 30: Threads - Synchronization
3. Java Concurrency in Practice - Brian Goetz - 2006 - Addison-Wesley
   1. Chapter 2: Thread Safety
   2. Chapter 13: Explicit Locks
4. https://man7.org/linux/man-pages/man3/pthread_mutex_lock.3p.html for POSIX Threads mutex operations
5. https://en.cppreference.com/w/cpp/thread/mutex for C++ std::mutex reference
6. https://docs.python.org/3/library/threading.html for Python threading module
7. [Critical section problem](../Critical%20section%20problem.md)
8. [Semaphore](../Semaphore.md)
9. 