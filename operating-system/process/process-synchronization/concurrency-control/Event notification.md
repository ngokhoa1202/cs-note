#operating-system #process-synchronization #parallel-programming #reactive-programming
#event-driven-programming 
# Polling - Pull-based model
```mermaid title='Polling sequence diagram'
sequenceDiagram
    participant C as Consumer
    participant Q as Queue/Coordinator
    participant P as Producer
    
    Note over C,P: Pull-Based Flow
    
    C->>Q: Submit request
    activate Q
    Q->>P: Dispatch work
    activate P
    Q-->>C: Return handle
    deactivate Q
    
    Note over C: Consumer does other work
    
    P->>P: Process data
    P->>Q: Store result
    deactivate P
    
    C->>Q: Pull result (get)
    activate Q
    alt Result ready
        Q-->>C: Return result
    else Result not ready
        Note over C: Consumer blocks/waits
        Q-->>C: Wait...
        Q-->>C: Return result when ready
    end
    deactivate Q
```

# Interrupts - Push-based model
```mermaid title='Interrupts sequence diagram'
sequenceDiagram
    participant S as Subscriber
    participant B as Event Bus
    participant P as Publisher
    
    Note over S,P: Push-Based Flow
    
    S->>B: Subscribe with callback
    activate B
    B->>P: Register subscriber
    B-->>S: Return immediately
    deactivate B
    
    Note over S: Subscriber continues work
    
    activate P
    P->>P: Produce data
    P->>B: Emit event
    activate B
    B->>S: Invoke callback (push)
    activate S
    S->>S: Process pushed data
    deactivate S
    deactivate B
    deactivate P
    
    Note over S: Subscriber receives data<br/>without requesting
```

# I/O Multiplexing - Hybrid model
```mermaid title='I/o Multiplexing sequence diagram'
sequenceDiagram
    participant C as Consumer
    participant F as Future/Promise
    participant E as Executor
    participant W as Worker
    
    Note over C,W: Hybrid Model (Pull + Push)
    
    C->>F: Create future
    F->>E: Submit task
    E->>W: Dispatch to worker
    F-->>C: Return handle (pull-based)
    
    Note over C: Consumer continues work
    
    activate W
    W->>W: Execute task
    W->>F: Complete with result
    deactivate W
    
    Note over F: Push-based callbacks
    F->>F: Trigger callback chain
    F->>C: Invoke callback 1 (push)
    activate C
    C->>C: Process in callback
    deactivate C
    
    F->>C: Invoke callback 2 (push)
    activate C
    C->>C: Transform result
    deactivate C
    
    Note over C: Optional: Pull final result
    C->>F: get() / join()
    F-->>C: Return final result (pull)
```

***
# References
1. 