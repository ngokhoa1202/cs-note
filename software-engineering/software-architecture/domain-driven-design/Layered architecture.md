#software-engineering #software-architecture #software-testing #design-pattern #microservice #dependency-manager #dependency-injection #oop #solid #agile #project-management #ddd 

# Purpose
- Domain isolation: Isolate responsibility of each layer $\implies$ ensure [SOLID](SOLID.md) 
- Embraces loose coupling.
# Basic layered architecture
- ![](Pasted%20image%2020241116162040.png)
- ![](Pasted%20image%2020241116162354.png)
## User interface - Presentation layer
- Responsible for showing information to the user and interpreting the  user’s commands. 
- The external actor might sometimes be another computer system rather than a human user.
- Legacy and will be replaced with SPA.
## Application layer - Orchestrator
- Defines the jobs the software is supposed to do and <mark style="background: #e4e62d;">orchestrates</mark> the expressive domain service objects to work out problems.
- It does <mark style="background: #e4e62d;">not contain business rule</mark>s , but only coordinates delegates tasks to collaborations of domain objects in the next layer down. 
- It does not have state reflecting the business situation, but it can have state that <mark style="background: #e4e62d;">reflects</mark> the <mark style="background: #e4e62d;">progress</mark> of a task for the user or the program.
## Domain layer - Model layer
- Represents business rules - <mark style="background: #e4e62d;">heart</mark> of application.
- Hides the actual implementation of persistence by delegating it to the infrastructure layer.
## Infrastructure layer - Persistence layer
- Provide generic technical capabilities that support the higher layers:
	- message sending for the application
	- persistence for the domain,
	- drawing widgets for the UI, etc. 
- May also support the pattern of interactions between the four layers through an <mark style="background: #e4e62d;">architectural framework</mark>.
# References
1. *Domain Driven Design - Eric Evans - 2003* for the layered architecture.
2. *https://www.visual-paradigm.com/guide/uml-unified-modeling-language/uml-class-diagram-tutorial/ for dependency in oop.*
3. https://medium.com/expedia-group-tech/onion-architecture-deed8a554423 for onion architecture.