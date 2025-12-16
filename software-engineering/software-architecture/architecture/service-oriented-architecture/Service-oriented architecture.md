#microservice #service-oriented-architecture #software-architecture #software-engineering
#software-testing #application-layer #computer-network #domain-driven-design 
# Topology
- Service-oriented architecture follows a distributed macro layered structure consisting of a separately deployed user interface, separately deployed remote coarse-grained services, and a monolithic database.
- ![[Pasted image 20250706095557.png]]
- Complicated business services are <mark class="hltr-yellow">typically decomposed into coarse-grained domain services</mark> that are independent and separately deployed. 
- The database instance is shared among services.
- A deployed service can have one or multiple instances and in case of multiple instances, load balancing is required.
- An API gateway, or proxy, is employed to orchestrate and perform necessary load balancing.
- User interfaces utilize remote access protocols such as REST, WebSocket, gRPC, GraphQL or event SOAP or to access services. While domain services synchronize between each other using a message-passing mechanism.
# Deployment
## User interface's variants
### Single monolithic user interface
#### Topology
- The user interface remains consolidated as one single deployable unit.
- ![[Pasted image 20250706102525.png]]
#### Implications
- The design system and user experiences are unified and coherent.
### Domain-driven user interface
#### Topology
- The user interface is decomposed into <mark class="hltr-yellow">domain-specific modules</mark>. Each user interface service tailors to distinct <mark class="hltr-yellow">business domains</mark> while coordinates with their respective backend services to deliver focused functionality.
- ![[Pasted image 20250706104642.png]]
#### Implication
- The user interface and design system are definitely less coherent and <mark class="hltr-yellow">more specific in a business domain</mark>.
- Different user experience requirements across business areas enables optimization for specific user workflows and business processes.
### Service-oriented user interface
#### Topology
- Each service maintains its own dedicated user interface component that handles all presentation logic and user interactions specific to that service's business capabilities.
- ![[Pasted image 20250706105349.png]]
#### Implication
- The tight coupling between individual services and their corresponding user interfaces enables complete autonomy in development, deployment, and evolution of both presentation and business logic within service boundaries.
- Service independence takes precedence over user experience consistency.
## Database's variants
### One single database instance for all
#### Topology
- All of the services share the same database instance.
- ![[Pasted image 20250706105954.png]]
#### Implication
- The centralized database instance simplifies data consistency requirements and transaction management, thereby minimizing the work of orchestration.
- However, the single database instance is a deployment bottleneck as the system scales.
### One database instance per domain
#### Topology
- Services are organized into logical groups that access separate database instances rather than sharing a single centralized database.
- ![[Pasted image 20250706112506.png]]
#### Implication
- The partitioned database approach addresses several limitations inherent in shared database architectures while avoiding the full complexity of database-per-service patterns.
- This configuration enables organizations to <mark class="hltr-yellow">optimize data management strategies based on specific business domain requirements</mark>:
	- Services handling high-transaction volumes can utilize database instances optimized for write performance.
	- Services focused on reporting and analytics can access databases configured for complex query operations.
### One database instance per service
#### Topology
- Every service maintains exclusive ownership of its underlying data storage infrastructure.
- ![[Pasted image 20250706112832.png]]
#### Implication
- Services can implement specialized database technologies optimized for their specific access patterns and performance requirements.
- This configuration enables independent scaling of both computational and data storage resources based on service-specific demands.
- The isolation of database system supports robust fault isolation where database issues affecting one service do not cascade to other services in the system.
- However, it requires coordinate data aggregation and synchronization across multiple database instances.
# Cross-cutting concerns
- Cross-cutting concerns such as metrics, monitoring, security, auditing requirements, service discovery should be placed as an additional service.
- ![[Pasted image 20250706113748.png]]
# Metrics
- ![[Pasted image 20250706121333.png]]
***
# References
1. Fundamentals of Software Architecture: An Engineering Approach - Mark Richards, Neal Ford - O Reilly Media Publisher (2020).
	1. Chapter 13. Service-Based Architecture Style.
2. Operating System Concepts - Abraham-Silberschatz - Wiley Publisher - 10th - 2018.
	1. Chapter 3. Process
		1. Section 3.4. Inter-process communication.
3. [[Message passing]]
4. [[Shared memory]]
5. 