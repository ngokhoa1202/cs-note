#concurrency-control #operating-system #thread #process #process-synchronization #parallel-programming
#asynchronous-programming

- Concurrency control models provide architectural patterns for managing concurrent execution.
- Different models suit different types of problems and workloads.
# Task-Based Models
## Thread Pool (Parallel Workers)
- <mark class="hltr-yellow">Fixed pool of worker threads process tasks from a shared queue</mark>.
- Tasks are independent units of work.
- Workers continuously fetch and execute tasks until queue is empty.
### Architecture
```mermaid
flowchart TD
    Start([Start]) --> InitPool[Initialize Thread Pool<br/>with N worker threads]
    InitPool --> Queue[Task Queue]

    Task1[Task 1] --> Queue
    Task2[Task 2] --> Queue
    Task3[Task 3] --> Queue
    TaskN[Task N] --> Queue

    Queue --> W1{Worker 1<br/>Available?}
    Queue --> W2{Worker 2<br/>Available?}
    Queue --> WN{Worker N<br/>Available?}

    W1 -->|Yes| Exec1[Execute Task]
    W2 -->|Yes| Exec2[Execute Task]
    WN -->|Yes| ExecN[Execute Task]

    Exec1 --> Complete1[Task Complete]
    Exec2 --> Complete2[Task Complete]
    ExecN --> CompleteN[Task Complete]

    Complete1 --> W1
    Complete2 --> W2
    CompleteN --> WN

    W1 -->|Queue Empty| End([End])
    W2 -->|Queue Empty| End
    WN -->|Queue Empty| End

    style Queue fill:#fff9c4,stroke:#f57f17
    style W1 fill:#e1f5fe
    style W2 fill:#e1f5fe
    style WN fill:#e1f5fe
    style Exec1 fill:#c8e6c9
    style Exec2 fill:#c8e6c9
    style ExecN fill:#c8e6c9
```

### Characteristics
- **Advantages**: Limits resource usage; reduces thread creation overhead; load balancing.
- **Disadvantages**: Queue contention; worker starvation; difficult to size pool correctly.
- **Use Cases**: Web servers, database connection pools, background job processing.
## Fork-Join
- <mark class="hltr-yellow">Divide problem into smaller subproblems recursively, solve in parallel, then combine results</mark>.
- Based on divide-and-conquer strategy.
- Work-stealing algorithm balances load among threads.
### Architecture
```mermaid
flowchart TD
    Start([Large Task]) --> Check{Problem<br/>Small Enough?}

    Check -->|Yes| Solve[Solve Directly]
    Check -->|No| Fork[Fork into Subtasks]

    Fork --> Sub1[Subtask 1]
    Fork --> Sub2[Subtask 2]

    Sub1 --> Check1{Small?}
    Sub2 --> Check2{Small?}

    Check1 -->|Yes| Solve1[Solve]
    Check1 -->|No| Fork1[Fork Again]

    Check2 -->|Yes| Solve2[Solve]
    Check2 -->|No| Fork2[Fork Again]

    Fork1 --> Sub1A[Subtask 1A]
    Fork1 --> Sub1B[Subtask 1B]
    Fork2 --> Sub2A[Subtask 2A]
    Fork2 --> Sub2B[Subtask 2B]

    Sub1A --> Solve1A[Solve]
    Sub1B --> Solve1B[Solve]
    Sub2A --> Solve2A[Solve]
    Sub2B --> Solve2B[Solve]

    Solve1A --> Join1[Join Results]
    Solve1B --> Join1
    Solve2A --> Join2[Join Results]
    Solve2B --> Join2

    Solve1 --> Join[Join All Results]
    Solve2 --> Join
    Join1 --> Join
    Join2 --> Join

    Solve --> Result([Final Result])
    Join --> Result

    style Start fill:#e1f5fe
    style Fork fill:#fff9c4
    style Join fill:#c8e6c9
    style Result fill:#c8e6c9
```

### Characteristics
- **Advantages**: Automatic load balancing; scales with available cores; recursive decomposition natural for some problems.
- **Disadvantages**: Overhead for small tasks; recursive overhead; requires problem decomposability.
- **Use Cases**: Sorting algorithms (merge sort, quick sort), tree traversal, parallel aggregation.
## Pipeline (Assembly Line)
- <mark class="hltr-yellow">Data flows through stages; each stage performs specific operation</mark>.
- Multiple data items processed simultaneously at different stages.
- Each stage typically has dedicated thread or thread pool.
### Architecture
```mermaid
flowchart LR
    Input([Input Stream]) --> Stage1[Stage 1<br/>Filter]
    Stage1 --> Queue1[Queue 1]
    Queue1 --> Stage2[Stage 2<br/>Transform]
    Stage2 --> Queue2[Queue 2]
    Queue2 --> Stage3[Stage 3<br/>Aggregate]
    Stage3 --> Queue3[Queue 3]
    Queue3 --> Stage4[Stage 4<br/>Output]
    Stage4 --> Output([Output Stream])

    D1[Data Item 1] -.-> Input
    D2[Data Item 2] -.-> Input
    D3[Data Item 3] -.-> Input

    style Stage1 fill:#e1f5fe
    style Stage2 fill:#c8e6c9
    style Stage3 fill:#fff9c4
    style Stage4 fill:#ffccbc
    style Queue1 fill:#f5f5f5
    style Queue2 fill:#f5f5f5
    style Queue3 fill:#f5f5f5
```

### Characteristics
- **Advantages**: Throughput optimization; natural for stream processing; stages can run at different speeds.
- **Disadvantages**: Pipeline stalls; backpressure handling; complex error handling.
- **Use Cases**: Data processing pipelines, video encoding, network packet processing.

# Message-Passing Models
## Actor Model
- <mark class="hltr-yellow">Actors are independent entities that communicate only via asynchronous messages</mark>.
- Each actor has private state and mailbox.
- Actors process one message at a time from their mailbox.

### Architecture
```mermaid
flowchart TD
    subgraph System
        A1[Actor 1<br/>State + Mailbox]
        A2[Actor 2<br/>State + Mailbox]
        A3[Actor 3<br/>State + Mailbox]
    end

    Client([Client]) -->|Send Message| A1
    A1 -->|Process Message| Behavior1{Update State<br/>or<br/>Send Messages}

    Behavior1 -->|Create| A4[New Actor]
    Behavior1 -->|Send| Msg1[Message to A2]
    Behavior1 -->|Update| State1[Own State]

    Msg1 --> A2
    A2 -->|Process| Msg2[Message to A3]
    Msg2 --> A3

    A3 -->|Reply| Response[Response Message]
    Response --> Client

    style A1 fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    style A2 fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px
    style A3 fill:#fff9c4,stroke:#f57f17,stroke-width:2px
    style A4 fill:#ffccbc
    style Msg1 fill:#f5f5f5
    style Msg2 fill:#f5f5f5
```

### Processing Flow
```mermaid
sequenceDiagram
    participant C as Client
    participant A1 as Actor 1
    participant A2 as Actor 2
    participant M as Mailbox

    C->>M: Send Message
    activate M
    M->>A1: Dequeue Message
    deactivate M
    activate A1

    A1->>A1: Process Message
    A1->>A1: Update State
    A1->>M: Send to Actor 2
    deactivate A1

    activate M
    M->>A2: Dequeue Message
    deactivate M
    activate A2
    A2->>A2: Process Message
    A2->>C: Send Response
    deactivate A2
```

### Characteristics
- **Advantages**: No shared state; natural distribution; fault isolation; location transparency.
- **Disadvantages**: Message overhead; debugging difficulty; potential deadlocks with request-response.
- **Use Cases**: Distributed systems (Akka, Erlang), reactive applications, microservices.

## Communicating Sequential Processes (CSP)
- <mark class="hltr-yellow">Processes communicate through typed channels with synchronous or buffered message passing</mark>.
- Channels are first-class citizens.
- Focus on communication primitives rather than processes.
### Architecture
```mermaid
flowchart LR
    subgraph Processes
        P1[Process 1]
        P2[Process 2]
        P3[Process 3]
    end

    P1 -->|Send| Ch1[Channel 1<br/>Unbuffered]
    Ch1 -->|Receive| P2

    P2 -->|Send| Ch2[Channel 2<br/>Buffered n=3]
    Ch2 -->|Receive| P3

    P1 -->|Send| Ch3[Channel 3]
    Ch3 -->|Receive| P3

    P3 -->|Select| Choice{Select from<br/>Multiple Channels}
    Choice -->|Ch2| Handle2[Handle Ch2]
    Choice -->|Ch3| Handle3[Handle Ch3]

    style Ch1 fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    style Ch2 fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px
    style Ch3 fill:#fff9c4,stroke:#f57f17,stroke-width:2px
    style P1 fill:#ffccbc
    style P2 fill:#ffccbc
    style P3 fill:#ffccbc
```

### Characteristics
- **Advantages**: Composable; type-safe; explicit communication; supports select operation.
- **Disadvantages**: Potential deadlocks; channel management overhead; memory for buffered channels.
- **Use Cases**: Go goroutines, concurrent pipelines, coordinating concurrent operations.
# Data-Oriented Models
## Data Parallelism
- <mark class="hltr-yellow">Same operation applied to multiple data elements simultaneously</mark>.
- Data divided among processing units.
- SIMD (Single Instruction, Multiple Data) style parallelism.
### Architecture
```mermaid
flowchart TD
    Data[Large Dataset] --> Split[Split Data]

    Split --> D1[Data Chunk 1]
    Split --> D2[Data Chunk 2]
    Split --> D3[Data Chunk 3]
    Split --> DN[Data Chunk N]

    D1 --> Op1[Apply Operation<br/>Thread 1]
    D2 --> Op2[Apply Operation<br/>Thread 2]
    D3 --> Op3[Apply Operation<br/>Thread 3]
    DN --> OpN[Apply Operation<br/>Thread N]

    Op1 --> R1[Result 1]
    Op2 --> R2[Result 2]
    Op3 --> R3[Result 3]
    OpN --> RN[Result N]

    R1 --> Combine[Combine Results]
    R2 --> Combine
    R3 --> Combine
    RN --> Combine

    Combine --> Final([Final Result])

    style Data fill:#e1f5fe
    style Split fill:#fff9c4
    style Op1 fill:#c8e6c9
    style Op2 fill:#c8e6c9
    style Op3 fill:#c8e6c9
    style OpN fill:#c8e6c9
    style Combine fill:#ffccbc
    style Final fill:#c8e6c9
```

### Characteristics
- **Advantages**: Simple model; high performance for homogeneous operations; GPU-friendly.
- **Disadvantages**: Requires uniform operations; load imbalance if operations vary; limited applicability.
- **Use Cases**: Image processing, matrix operations, scientific computing, GPGPU.

## MapReduce
- <mark class="hltr-yellow">Map phase applies function to data partitions; Reduce phase aggregates results</mark>.
- Designed for distributed data processing.
- Framework handles distribution, fault tolerance, load balancing.
### Architecture
```mermaid
flowchart TD
    Input[Input Data] --> Split[Split into Chunks]

    Split --> M1[Map Task 1]
    Split --> M2[Map Task 2]
    Split --> M3[Map Task 3]

    M1 --> KV1[Key-Value Pairs]
    M2 --> KV2[Key-Value Pairs]
    M3 --> KV3[Key-Value Pairs]

    KV1 --> Shuffle[Shuffle & Sort<br/>Group by Key]
    KV2 --> Shuffle
    KV3 --> Shuffle

    Shuffle --> G1[Group 1<br/>Key A]
    Shuffle --> G2[Group 2<br/>Key B]
    Shuffle --> G3[Group 3<br/>Key C]

    G1 --> R1[Reduce Task 1]
    G2 --> R2[Reduce Task 2]
    G3 --> R3[Reduce Task 3]

    R1 --> O1[Output 1]
    R2 --> O2[Output 2]
    R3 --> O3[Output 3]

    O1 --> Final[Final Output]
    O2 --> Final
    O3 --> Final

    style Split fill:#e1f5fe
    style M1 fill:#c8e6c9
    style M2 fill:#c8e6c9
    style M3 fill:#c8e6c9
    style Shuffle fill:#fff9c4,stroke:#f57f17,stroke-width:3px
    style R1 fill:#ffccbc
    style R2 fill:#ffccbc
    style R3 fill:#ffccbc
```

### Characteristics
- **Advantages**: Scalable to massive datasets; automatic fault tolerance; hides distribution complexity.
- **Disadvantages**: High latency; not suitable for iterative algorithms; shuffle overhead.
- **Use Cases**: Log analysis, web indexing, large-scale data processing (Hadoop, Spark).
# Asynchronous Models
## Event-Driven (Reactor/Proactor)
- <mark class="hltr-yellow">Single-threaded event loop handles I/O events asynchronously</mark>.
- Non-blocking I/O operations registered with event loop.
- Callbacks or handlers invoked when events occur.
### Reactor Pattern
```mermaid
flowchart TD
    Start([Application Start]) --> Init[Initialize Event Loop]
    Init --> Register[Register Event Handlers]

    Register --> Loop{Event Loop<br/>Running?}

    Loop -->|Yes| Wait[Wait for Events<br/>select/poll/epoll]
    Wait --> Events{Events<br/>Available?}

    Events -->|No| Wait
    Events -->|Yes| Dispatch[Dispatch Events]

    Dispatch --> Handle1[Handler 1<br/>Process Event]
    Dispatch --> Handle2[Handler 2<br/>Process Event]
    Dispatch --> HandleN[Handler N<br/>Process Event]

    Handle1 --> Complete1[Complete]
    Handle2 --> Complete2[Complete]
    HandleN --> CompleteN[Complete]

    Complete1 --> Loop
    Complete2 --> Loop
    CompleteN --> Loop

    Loop -->|No| Shutdown([Shutdown])

    style Loop fill:#fff9c4,stroke:#f57f17,stroke-width:3px
    style Wait fill:#e1f5fe
    style Dispatch fill:#c8e6c9
    style Handle1 fill:#ffccbc
    style Handle2 fill:#ffccbc
    style HandleN fill:#ffccbc
```

### Characteristics
- **Advantages**: High concurrency with single thread; low memory overhead; no thread synchronization.
- **Disadvantages**: Callback hell; CPU-bound tasks block event loop; complex error handling.
- **Use Cases**: Node.js, Redis, Nginx, GUI applications.
## Reactive Streams
- <mark class="hltr-yellow">Asynchronous stream processing with backpressure support</mark>.
- Publisher produces data; Subscriber consumes data.
- Backpressure prevents overwhelming slow consumers.
### Architecture
```mermaid
sequenceDiagram
    participant P as Publisher
    participant S as Subscriber
    participant Sub as Subscription

    S->>P: subscribe()
    activate P
    P->>Sub: create Subscription
    P->>S: onSubscribe(subscription)
    deactivate P

    activate S
    S->>Sub: request(n)
    deactivate S

    activate Sub
    Sub->>P: request n items
    deactivate Sub

    activate P
    P->>S: onNext(item1)
    P->>S: onNext(item2)
    P->>S: onNext(itemN)
    deactivate P

    activate S
    Note over S: Process items
    S->>Sub: request(m)
    deactivate S

    activate Sub
    Sub->>P: request m more
    deactivate Sub

    activate P
    P->>S: onComplete()
    deactivate P
```

### Characteristics
- **Advantages**: Backpressure handling; composable operators; async by default; resource-efficient.
- **Disadvantages**: Steep learning curve; complex debugging; operator overhead.
- **Use Cases**: RxJava, Project Reactor, Akka Streams, real-time data processing.
## Coroutines (Structured Concurrency)
- <mark class="hltr-yellow">Lightweight threads that can suspend and resume execution</mark>.
- Cooperative multitasking within single OS thread.
- Structured concurrency ensures proper lifecycle management.
### Architecture
```mermaid
flowchart TD
    Start([Main Coroutine]) --> Launch1[Launch Coroutine 1]
    Start --> Launch2[Launch Coroutine 2]

    Launch1 --> C1Run[C1: Execute]
    C1Run --> C1Suspend{Suspend Point<br/>await/yield}

    Launch2 --> C2Run[C2: Execute]
    C2Run --> C2Suspend{Suspend Point<br/>await/yield}

    C1Suspend -->|Suspend| Scheduler[Coroutine Scheduler]
    C2Suspend -->|Suspend| Scheduler

    Scheduler --> Switch{Switch Context}

    Switch --> C1Resume[Resume C1]
    Switch --> C2Resume[Resume C2]
    Switch --> MainResume[Resume Main]

    C1Resume --> C1Continue[C1: Continue]
    C1Continue --> C1Done{Done?}
    C1Done -->|No| C1Suspend
    C1Done -->|Yes| C1Complete[Complete]

    C2Resume --> C2Continue[C2: Continue]
    C2Continue --> C2Done{Done?}
    C2Done -->|No| C2Suspend
    C2Done -->|Yes| C2Complete[Complete]

    C1Complete --> WaitAll[Wait All Children]
    C2Complete --> WaitAll
    WaitAll --> End([End])

    style Scheduler fill:#fff9c4,stroke:#f57f17,stroke-width:3px
    style C1Suspend fill:#e1f5fe
    style C2Suspend fill:#e1f5fe
    style Switch fill:#c8e6c9
```

### Characteristics
- **Advantages**: Lightweight; sequential code style; structured concurrency; no callback hell.
- **Disadvantages**: Language support required; debugging can be tricky; learning curve.
- **Use Cases**: Kotlin coroutines, Python asyncio, JavaScript async/await, Go goroutines.
# Memory Models
## Software Transactional Memory (STM)
- <mark class="hltr-yellow">Transactions on memory operations; atomic, consistent, isolated</mark>.
- Similar to database transactions but for memory.
- Optimistic concurrency - assume no conflicts, retry if conflict occurs.

### Architecture
```mermaid
flowchart TD
    Start([Thread Starts Transaction]) --> Begin[Begin Transaction]
    Begin --> Read[Read Shared Variables<br/>into Local Snapshot]

    Read --> Compute[Perform Computations]
    Compute --> Write[Write to Local Copy]

    Write --> Commit{Attempt Commit}

    Commit --> Validate[Validate:<br/>Check for Conflicts]
    Validate --> Check{Conflicts<br/>Detected?}

    Check -->|Yes| Abort[Abort Transaction]
    Abort --> Retry[Retry Transaction]
    Retry --> Begin

    Check -->|No| Apply[Apply Changes Atomically<br/>to Shared Memory]
    Apply --> Success([Commit Success])

    style Begin fill:#e1f5fe
    style Validate fill:#fff9c4,stroke:#f57f17,stroke-width:3px
    style Abort fill:#ff6b6b,color:#fff
    style Apply fill:#c8e6c9
    style Success fill:#c8e6c9
```

### Characteristics
- **Advantages**: Composable; no deadlocks; automatic conflict resolution; simpler than locks.
- **Disadvantages**: Retry overhead; not suitable for I/O operations; performance unpredictable under high contention.
- **Use Cases**: Haskell STM, Clojure atoms/refs, concurrent data structures.
# Model Comparison
| Model            | Paradigm        | Communication  | State       | Best For               |
| ---------------- | --------------- | -------------- | ----------- | ---------------------- |
| Thread Pool      | Shared Memory   | Task Queue     | Shared      | Independent tasks      |
| Fork-Join        | Shared Memory   | Parent-Child   | Shared      | Divide-and-conquer     |
| Pipeline         | Shared Memory   | Queues         | Shared      | Stream processing      |
| Actor            | Message Passing | Async Messages | Private     | Distributed systems    |
| CSP              | Message Passing | Channels       | Private     | Coordinated processes  |
| Data Parallel    | Shared Memory   | None           | Shared      | Homogeneous operations |
| MapReduce        | Distributed     | Shuffle        | Partitioned | Big data processing    |
| Event-Driven     | Async           | Event Loop     | Shared      | I/O-bound operations   |
| Reactive Streams | Async           | Backpressure   | Shared      | Async data streams     |
| Coroutines       | Async           | Structured     | Shared      | Sequential async code  |
| STM              | Shared Memory   | Transactions   | Versioned   | Complex state updates  |

***
# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Pearson Publisher.
	1. Chapter 4: Threads.
	2. Chapter 6: Synchronization Tools.
2. [[programming/javascript/node.js/architecture/Event loop|Event loop]] for Node.js event loop.
3. https://en.wikipedia.org/wiki/Concurrency_pattern
4. Java Concurrency in Practice - Brian Goetz - 2006 - Addison-Wesley.
5. Seven Concurrency Models in Seven Weeks - Paul Butcher - 2014 - Pragmatic Bookshelf.
