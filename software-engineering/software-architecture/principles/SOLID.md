#software-engineering #oop #solid #software-architecture #design-pattern #agile 
 

# Single responsibility principle
- Every class should have only ==one reason== to change.
- Design focused class solving one logical problem only.
- If two responsibilities ==change at quite different rates==, then separate them.

# Open-closed principle.
- Software entities (classes, packages, methods, ...) should be ==open for extension, but closed for modification==.
- ==Abstraction== is the key.

# Liskov substitution principle
- Subtypes must be ==substitutable== to base types $\equiv$ their behavior should not its parent behavior.
- Degenerate method in child class if it is unnecessary.
- Employs creational pattern (such as factory method, ....) to resolves `is-a` conflicted behavior. 
# Interface segregation principle
- Clients should not be forced to depend on ==interfaces that they do not use==.
- Keep interface concise and simple $\equiv$ Interface methods ==do not make sense for class==:
	- ==Avoid empty method== which overrides interface methods.
	- Methods throwing `UnsupportedOperationException`
# Dependency inversion principle
- High-level modules should not depend on low-level modules. Both should ==depend on abstractions==.
- Abstraction should not depend on details. ==Details should depend on abstractions==.
- $\implies$ ==Loosely coupled dependency== instead of tightly coupled dependency.
- $\implies$ ==Interface== or ==abstract function== instead of concrete class.
- $\implies$ Should provide dependency from ==external== environment.
---
# References
1. [Design patterns](Design%20patterns.md) for design pattern categories - real examples of SOLID principles.
2. [Domain driven design](Domain%20driven%20design.md) for Domain Driven Design - application of SOLID for enterprise application.
3. [Layered architecture](Layered%20architecture.md) for Layered architecture - application of SOLID in software architecture.