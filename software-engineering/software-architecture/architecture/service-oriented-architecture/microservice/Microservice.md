#service-oriented-architecture #microservice #software-testing #software-engineering #software-architecture #solid #ci-cd #logging #event-driven-programming 
#concurrency-control #transaction #computer-network #application-layer #cybersecurity #transaction #container 
# Topology
- Every service is implemented in alignment with a <mark class="hltr-yellow">bounded context</mark> to highly prioritize the high coupling.
- Each microservice has its own API layer to interact with clients and comprises its business logic and dedicated database infrastructure, thereby promoting service autonomy.
- ![[Pasted image 20250706150006.png]]
- Microservices form a <mark class="hltr-yellow">distributed</mark> system.
- High coupling takes precedence over all of other characteristics in microservices, even if it causes duplication.
# Cross-cutting concerns
- Crossing-cutting concerns in microservices is addressed with sidecar pattern.
- Each sidecar (or *node*) represents cross-cutting concerns in microservices including logging, circuit breaker, monitoring, security,...
- The service plain takes responsibility for orchestration and transformation independent sidecars into a unified infrastructure layer which can make routing decisions, enforce policies, sharing configuration, monitoring and collecting metrics.
- ![[Pasted image 20250706151542.png]]

- 
- ![[Pasted image 20250706153107.png]]
# User interface's variant
## Monolithic user interface
- All of the microservices share the same user interface.
- ![[Pasted image 20250706153356.png]]
## Micro-frontend
- Each microservice emits its own micro-frontend.
- ![[Pasted image 20250706153428.png]]
# Characteristics
- Protocol-aware
	- Each service communication protocol must be standardized and specified (REST, SOAP, gRPC, GraphQL, Message broker).
- Heterogeneous
	- Each service has its own implementation and technology stack.
- Service integration capability
	- Microservices must exchange data effectively.
# Microservice synchronization
- There are two distinct approaches.
## Choreography
- Choreography is a <mark class="hltr-yellow">decentralized</mark> approach where each microservice knows when to execute its operations and whom to interact with, *without a central coordinator*.
- Services communicate through events, and each service reacts to relevant events independently.
- ![[Pasted image 20250706160337.png]]
- ![[Pasted image 20250706160418.png]]
## Orchestration
- Orchestration uses a <mark class="hltr-yellow">central coordinator</mark> that explicitly tells each service what and when to do. The mediator controls the workflow and makes decisions about the sequence of operations.
- ![[Pasted image 20250706160630.png]]
# Transaction
- Distributed transactions violates the core decoupling principle of the microservices architecture because multiple components must maintain <mark class="hltr-yellow">synchronized state</mark>.
- Service boundaries should *align with* transactional boundaries. Operations requiring ACID properties should reside within the same service, while operations that can tolerate eventual consistency should communicate through asynchronous mechanisms.
- Services that are too granular lead to distributed transaction requirements, while services that are too coarse-grained sacrifice the benefits of microservices architecture.

# Metrics
- ![[Pasted image 20250707202854.png]]

# References
1. Fundamentals of Software Architecture: An Engineering Approach - Mark Richards, Neal Ford - O Reilly Media Publisher (2020)
	1. Chapter 17. Microservices Architecture.
2. [[software-engineering/software-architecture/domain-driven-design/Domain driven design]]
3. [[Service-oriented architecture]]
4. https://martinfowler.com/articles/microservices.html
5. 
