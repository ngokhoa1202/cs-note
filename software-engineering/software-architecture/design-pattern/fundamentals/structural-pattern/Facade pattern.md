#design-pattern  #oop #software-engineering #software-architecture #structural-pattern 

- Facade means the ==frontage== of a building $\implies$ deals with client and hides complex implementation.
# Purpose
- Provides a ==cohesive interface== for client to easily access complex subsystems.
# Application
- Provides a ==simple interface== for client to access complex subsystems.
- Decouples subsystem from client $\implies$ ==simplifies dependencies== and ==adds layer== to system.
# Components
- ![](Pasted%20image%2020240614162800.png)
## Facade
- Knows everything about subsystems.
- Provides interfaces for user to perform tasks on subsystems.
- Delegates reponsibility to its subsystems.
## Subsytem classes
- Implement its concrete functionality.
- Does not know about Facade $\equiv$ does not keep Facade object.
## Client
- Performs tasks on subsystem via Facade interfaces.
- Only knows about Facade.
# Example
- ![](Pasted%20image%2020240614164547.png)
# Real example
- Laravel PHP (`$app` object).
- 
# Design
- Facade should ==minimize the complexity== of subsystem.
- Facade is not a replacement for regular usage of subsystem classes.
- Facade is NOT a containers of related methods.
# Advantages
- Promotes weak coupling between client and complex subsystems $\equiv$ Ensure [Dependency inversion principle](SOLID.md#Dependency%20inversion%20principle)
# Disadvantages
- Facade object may become a god object $\implies$ Violates [Single responsibility principle](SOLID.md#Single%20responsibility%20principle)
- 
# References
1. https://refactoring.guru/design-patterns/facade/java/example for Facade real examples.
