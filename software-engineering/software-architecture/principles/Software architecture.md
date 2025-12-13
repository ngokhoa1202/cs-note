#software-engineering #software-architecture #software-testing 
# Definition
- Architecture is the <mark class="hltr-yellow">fundamental organization</mark> of a system, embodied in its <mark class="hltr-yellow">components</mark>, their <mark class="hltr-yellow">relationships</mark> to each other and the <mark class="hltr-yellow">environment</mark>, and the principles governing its design and evolution.
# Software architecture vs software design
## Software architecture
- **Architecture characteristics** encompass the quality attributes and non-functional requirements that shape the system, such as scalability, performance, security, and maintainability.... These characteristics <mark class="hltr-yellow">drive fundamental design decisions</mark> and establish constraints that influence the entire system.
- **Architectural style** refers to the <mark class="hltr-yellow">overarching patterns and approaches used to organize</mark> the system, such as microservices, monolithic, event-driven, or layered architectures. This choice fundamentally affects how components interact and how the system evolves over time.
- **Component structure** defines the major building blocks of the system and their relationships. At this level, architects determine how to <mark class="hltr-yellow">decompose the system into manageable components</mark>, establish boundaries between components, and define interfaces for communication.
- ![[Pasted image 20250705145725.png]]
## Software design
- Software design, in contrast, addresses the detailed implementation concerns that <mark class="hltr-yellow">translate architectural decisions into working software</mark>.
- **Class design** involves creating the detailed object-oriented structures, defining specific classes, their attributes, methods, and relationships. This is where design patterns are applied and the internal structure of components takes shape.
- **User interface** development focuses on the presentation layer, determining how users interact with the system through screens, forms, and navigation flows.
- **Source code** represents the actual implementation, where all architectural and design decisions materialize into executable programs written in specific programming languages.
# Architecture characteristics
## Operational characteristic
- Availability.
- Continuity.
- Performance.
- Recoverability.
- Reliability.
- Safety.
- Robustness.
- Scalability.
## Structural characteristic
- Configurability.
- Extensibility.
- Installability.
- Reusability.
- Localization
- Maintainability
- Portability
- Supportability
- Upgradeability
## Cross-cutting characteristic
- Accessibility.
- Archivability.
- Authentication.
- Authorization.
- Legal.
- Privacy.
- Security.
- Supportability.
- Usability.
# Problems
## Knowledge triangle
- ![](Pasted%20image%2020250219123418.png)
- Technical breadth vs technical depth.
- ![[Pasted image 20250705144734.png]]
- Avoids frozen caveman anti-pattern.
## Trade-off
- *There is no right or wrong answers in software architecture - <mark class="hltr-yellow">only trade-offs</mark>.* 
- Architecture is the stuff you can Google, it depends on the <mark class="hltr-yellow">business context</mark>.
***
# References
1. Fundamentals of Software Architecture An Engineering Approach - Mark Richards Neal Ford - O_Reilly Media (2020)
	1. Chapter 2. Architectural Thinking.
2. HCMUT Software Architecture Slides - Trần Trương Tuấn Phát.