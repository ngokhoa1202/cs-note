#design-pattern #object-oriented-programming #software-engineering  #software-architecture  #structural-pattern #computer-network 

# Purpose
- Provides a ==surrogate - placeholder==  for a particular class to control its access.
# Application
- Hide the implementation from the client.
- Perform some specific tasks before calling a remote service:
	- Logging.
	- Caching.
	- Security.
	- ...

# Components
- ![800](Pasted%20image%2020240626212832.png)
## Subject
- Define an ==interface for both RealSubject and Proxy== so that RealSubject can be always replaced with Proxy.
## Proxy
- ==Aggregates an object of RealSubject== which helps Proxy access RealSubject method.
- Implement interfaces declared Subject by ==delegating responsibility to RealSubject==.
### Remote proxy
- Forwards to a RealSubject ==residing in a different memory space== (e.g: cloud service).
### Virtual proxy
- ==Caches additional information== for postponing accessing $\equiv$ lazy initialization.
- Clear cache if it is full.
### Protection proxy
- ==Checks caller's permission== for security purpose.
## RealSubject
- Is the concrete class that Proxy is concealling.
- Implements its own service being invoked by Proxy.
## Client
- Given an object of Subject interface.
# Real example
- `javax.persistence.PersistenceContext`
# Design
- Proxy creates and manages the RealSubject (service) lifecycle on a regular basis.
- Proxy can perform some specific tasks (logging, caching, access control,...).
- After performing some of its additional operations, Proxy must delegate the main responsibilities to its RealSubject (service).
# Advantages
- Hide all the implementation from clients.
- Developers are granted all permissions to manage lifecycle of service.
- Ensure [Open-closed principle.](SOLID.md#Open-closed%20principle.): adding new proxies without modifying client.
# Disadvantages
- Complicated.
- Overhead.
# References
1. https://refactoring.guru/design-patterns/proxy
2. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Proxy pattern.