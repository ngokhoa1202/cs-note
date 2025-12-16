#event-driven-architecture  #software-testing #software-engineering
#software-architecture  #ci-cd #logging #event-driven-programming #concurrency-control
#computer-network #application-layer #cybersecurity #message-broker
# Components
- Event-driven architecture follows a *request-based* model. 
- The request processors handle the request, either retrieving or updating information in a database.
- ![[assets/Pasted image 20251212070632.png]]
## Request orchestrator
- Requests made to the system to perform a specific action are first dispatched to a *request orchestrator*. 
- The request orchestrator can be either a user interface or an API layer or an enterprise bus. 
- It takes the responsibility for *deterministically* and *synchronously forwarding* the the request to various *request processors*; coordinating the final response before replying to the client.
## Request processor
- Request Processors are *workers* that execute specific parts of the request processing.
- Each processor:
	- contains multiple *Components* which are actually business logic units.
	- maintains *its own Request State* for local context and executes deterministic operations.
	- directly interacts with the database and returns result back to the orchestrator.
# Topology
## Broker topology
### Definition
- The Broker Topology is a *decentralized*, choreographed approach where there is *no central orchestrator*.
- Events are published to an *message broker* such as Apache Kafka or RabbitMQ, and event processors independently subscribe to the events they're interested in and react accordingly.
- ![[assets/Pasted image 20251213162052.png]]
- Every event processor, after completing its work, should *broadcast* its accomplishment by publishing a new event to a notification broker.
- The processor fires the event without checking whether any subscribers exist. If no one is listening, the event simply disappears into the void.
- ![[assets/Pasted image 20251213162857.png]]

- ![[assets/Pasted image 20251213163114.png]]
### Consequences
- Services are *completely decoupled* from one another because they communicate exclusively through events published to the broker, with no direct knowledge of other services' existence or implementation details, thereby delivering *exceptional scalability*.
- The *workflow* control is *heavily impacted* because no mediator monitors and orchestrates the business transaction, thus results in *error handling* and *reliability* issues.
- *Performance* bottlenecks become *localized* to individual services rather than affecting the entire system.
## Mediator topology
### Definition
- Mediator topology employs *centralized orchestration* where a mediator component explicitly controls the workflow.
- The *mediator* receives initial events and then *orchestrates* all subsequent processing steps, explicitly defining the business workflow logic, sequencing, conditional branching, and error handling.
- Event processors listen to event channels, process the event and *return results to the mediator* rather than publishing events independently. They do not broadcast their accomplishments.
- ![[assets/Pasted image 20251213171041.png]]
- In most implementations of the mediator topology, there are *multiple mediators*, usually associated with a particular *domain service* or grouping of events.
- ![[assets/Pasted image 20251213172124.png]]
- ![[assets/Pasted image 20251213172225.png]]
- ![[assets/Pasted image 20251213172254.png]]
- ![[assets/Pasted image 20251213172306.png]]
- ![[assets/Pasted image 20251213172322.png]]
- ![[assets/Pasted image 20251213172346.png]]
- ![[assets/Pasted image 20251213172355.png]]
### Consequences
- The business workflow is cohesive and *centralized*, thereby make it simpler to handle errors, manage transactions or perform retry-logic; however, when it becomes increasingly complicated, the Mediator is larger and more difficult to maintain.
- The entire system's *availability* depends on the mediator's availability because it is a single point of failure.
- *Performance* bottlenecks are obvious in the Mediator because the Mediator must *sequentially* execute services to some extent.
- Mediator topology can scale horizontally by partitioning workflows (e.g., by customer ID or order ID), but this must ensure each workflow is handled by exactly one mediator instance.
# Asynchronous operations
- 
***
# References
1. Fundamentals of Software Architecture An Engineering Approach - Mark Richards, Neal Ford - O Reilly Media Publisher (2020).
	1. Chapter 14. Event-Driven Architecture Style.
2. [[software-engineering/software-architecture/design/design-pattern/classical-pattern/behavioral-pattern/Mediator pattern|Mediator pattern]]
3. https://en.wikipedia.org/wiki/Business_Process_Execution_Language for Business  Process Execution Language.