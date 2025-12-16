#java #parallel-programming #concurrency-control #java8 #object-oriented-programming 
#java11 #java17 
# Definition
- A **Future** in Java is an object representing the <mark class="hltr-yellow">eventual completion or failure of an asynchronous operation</mark>.
```Java title='interface Future in Java'
public interface Future<V> {
    boolean cancel(boolean mayInterruptIfRunning);
    boolean isCancelled();
    boolean isDone();
    V get() throws InterruptedException, ExecutionException;
    V get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException, TimeoutException;
} 
```
# Hierarchy
```mermaid title='class Future hierarchy'
classDiagram
    Future~T~ <|-- RunnableFuture~T~
    Future~T~ <|-- CompletableFuture~T~
    Future~T~ <|-- ForkJoinTask~T~
    Future~T~ <|-- ScheduledFuture~T~
    RunnableFuture~T~ <|-- FutureTask~T~
    
    class Future~T~ {
        <<interface>>
        +cancel(boolean mayInterruptIfRunning) boolean
        +isCancelled() boolean
        +isDone() boolean
        +get() T
        +get(long timeout, TimeUnit unit) T
    }
    
    class RunnableFuture~T~ {
        <<interface>>
        +run() void
    }
    
    class CompletableFuture~T~ {
        +complete(T value) boolean
        +completeExceptionally(Throwable ex) boolean
        +thenApply(Function) CompletableFuture
        +thenAccept(Consumer) CompletableFuture
        +thenCompose(Function) CompletableFuture
        +exceptionally(Function) CompletableFuture
        +handle(BiFunction) CompletableFuture
    }
    
    class ForkJoinTask~T~ {
        <<abstract>>
        +fork() ForkJoinTask
        +join() T
        +invoke() T
    }
    
    class ScheduledFuture~T~ {
        <<interface>>
        +getDelay(TimeUnit unit) long
    }
    
    class FutureTask~T~ {
        +FutureTask(Callable~T~ callable)
        +FutureTask(Runnable runnable, T result)
    }
```
- 
# Lifecycle
```mermaid
stateDiagram-v2
    direction TB
    
    [*] --> PENDING : Future created
    
    PENDING --> COMPLETED : task succeeds
    PENDING --> CANCELLED : cancel() called
    PENDING --> FAILED : exception thrown
    
    COMPLETED --> [*] : get() returns result
    CANCELLED --> [*] : get() throws CancellationException
    FAILED --> [*] : get() throws ExecutionException
    
    note right of PENDING : isDone() = false
    note right of COMPLETED : isDone() = true<br/>isCancelled() = false
    note right of CANCELLED : isDone() = true<br/>isCancelled() = true
    note right of FAILED : isDone() = true<br/>isCancelled() = false
```
- `get()`: Blocking retrieval of the result.
- `get(timeout, unit)`: blocking retrieval of the result with timeout.
- `cancel()`: attempt to cancel execution.
- `isDone()`: check completion status.
- `isCancelled()`: Check cancellation status.
# Push-based vs pull-based
## Pull-based
```mermaid
sequenceDiagram
    participant C as Consumer<br/>(Main)
    participant P as Producer<br/>(Worker)

    C->>P: 1. submit(task)
    P-->>C: 2. Returns Future
    
    par Parallel Processing
        Note right of P: 3. Executes task<br/>in background
        Note left of C: 4. Do other work
    end

    Note right of P: 5. Task completes<br/>(stores result)

    C->>P: 6. get() - "Give me result!"
    P-->>C: 7. Returns result
```
## Push-based

```mermaid
sequenceDiagram
    participant S as Subscriber
    participant P as Publisher

    S->>P: 1. subscribe(observer)
    
    Note right of P: 2. Starts producing<br/>when ready

    P->>S: 3. onNext(item1)
    Note right of S: (data pushed!)
    Note left of S: 4. Process item1

    P->>S: 5. onNext(item2)
    Note right of S: (data pushed!)
    Note left of S: 6. Process item2

    P->>S: 7. onComplete()
```

***
# References
1. https://concurrencydeepdives.com/java-future-vs-completablefuture/
2. [[programming/javascript/vanilla-javascript/fundamentals/promise/Promise|Promise]] for JavaScript Promise.
3. 