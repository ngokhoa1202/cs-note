#software-engineering #software-architecture #software-testing #solid  #web-service #data-access-object 

# Topology
- Components within the layered architecture style are organized into <mark class="hltr-yellow">logical layers</mark>, with each layer performing a specific role within the application.
- ![[Pasted image 20250705163629.png]]

## Presentation layer
- The presentation layer serves as the <mark class="hltr-yellow">interface between users and the system</mark>. 
- This layer handles all user interaction logic, including rendering user interfaces, managing and validating user input, and controlling the flow of information to and from the user.
## Business layer
- The business layer contains <mark class="hltr-yellow">core logic that defines how the business operates and makes decisions</mark>.the  This layer implements business rules, performs calculations, validates data according to *business constraints*, and *orchestrates workflows*. For example, in an e-commerce system, the business layer would handle order processing logic, calculate discounts and taxes, enforce credit limits, and manage inventory rules. 
- By centralizing business logic in this layer, organizations can ensure consistent application of rules across different presentation interfaces and protect the integrity of business operations.
## Persistence layer
- The persistence layer manages the <mark class="hltr-yellow">translation between the domain model</mark> in the business layer and <mark class="hltr-yellow">the relational model</mark> used in databases. 
- This layer implements patterns such as Repository or Data Access Object (DAO) to abstract database operations from business logic. It handles object-relational mapping, manages database connections, implements caching strategies, and ensures that business objects can be stored and retrieved without the business layer needing to understand database-specific details.
## Database layer
- The database layer represents the actual data storage mechanism, typically a database management system. This layer is responsible for <mark class="hltr-yellow">storing data permanently</mark>, maintaining data integrity through constraints and relationships, handling concurrent access through transaction management, and optimizing data retrieval through indexes and query optimization. 
- The database layer provides the foundation for data persistence and ensures that data remains consistent and accessible even across system restarts or failures.
# Isolation of layers
- Changes made in one layer of the architecture generally don’t impact or affect components in other layers, thereby ensuring the [[SOLID#Single responsibility principle]].
- A full lifecycle of request moves top-down from layer to layer and cannot skip any layers.
- If the business context is simpler, the business layer is implemented as services ![[Pasted image 20250705172529.png]]

- In case the business context is complex, the business layer serves as an additional orchestration layer. ![[Pasted image 20250705173501.png]]
# Architecture sinkhole anti-pattern
- Architecture sinkhole anti-pattern occurs when requests move from layer to layer as simple pass-through processing <mark class="hltr-yellow">with no business logic performed within each layer.</mark>
- Every layered architecture will have at least some scenarios that fall into the architecture sinkhole anti-pattern. The 80-20 rule is usually a competent practice to follow. It is acceptable if only 20 percent of the requests are sinkholes.
# Deployment
- Depending on the context, the deployment and operation of the layered-architecture projects varies:
	- The presentation layer, business layer and persistence layer is considered as a single deployable unit, with only the database layer separated as an independent component. This approach simplifies deployment and reduces network latency between the application layers while maintaining database isolation for scalability and security purposes. 
	- The presentation layer operates independently from the combined business and persistence layers. This separation enables independent scaling of the user interface components and allows for different technologies to be employed at the presentation tier while maintaining tight coupling between business logic and data access operations.
	- All the four layers are combined into one single deployable unit. This combination is useful for small applications.
- ![[Pasted image 20250706074158.png]]
>[!Important]+ Technology stacks for each deployment variant
>The first variant and third variant is suitable for MVC paradigm and server-side rendering with template engine such as Jakarta EE, Spring MVC, NodeJs and Pug.js, Laravel.
>The second variant is usually implemented with Single-Page Application including React, Angular,..., which is completely separate from the back-end system.

# Metrics
- ![[Pasted image 20250706080827.png]]

# References
1. Fundamentals of Software Architecture: An Engineering Approach - Mark Richards, Neal Ford - O Reilly Media Publisher (2020).
	1. Chapter 10. Layered Architecture Style.
2. 