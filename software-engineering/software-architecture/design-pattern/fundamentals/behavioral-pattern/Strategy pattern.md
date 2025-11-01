#behavioral-pattern #design-pattern #software-engineering #software-architecture #functional-programming #oop #high-order-function #java #solid 

- Also known as Policy.
# Purpose
- Defines a <mark style="background: #e4e62d;">family of algorithms</mark>, <mark style="background: #e4e62d;">encapsulates</mark> each of them <mark style="background: #e4e62d;">into a separate class</mark> and make them interchangable.
# Application
- Many related classes which are different only their behaviors and these behaviors may be changeable with respect to a predicate.
- Various implementations of a specific algorithm.
# Components
- Diagram
	- ![](Pasted%20image%2020240922162534.png)
## Strategy
- Provides a common interface for the algorithm.
## Concrete Strategy
- Implements the interface declared in Strategy.
## Context
- Configured with the Concrete Strategy.
- Composes a Strategy instance and invokes the Strategy interface corresponding to a particular predicate.
- Exposes interface for client to change the strategy and forwards their requests to the strategy.
## Client
- Must be aware of Concrete Strategies.
- Changes the strategy via the Context interface and expects some service from Context.
# Example
- Functional-style callback in Javascript.

# Advantages
- Ensure [Open-closed principle.](SOLID.md#Open-closed%20principle.) we can add new strategy without modifying the context.
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle) because the algorithm implementation is separated from the context.
# Disadvantages
- Overcomplicated because the algorithms are rarely changed.
- Most modern programming languages support high-order function - or callback - to replace Strategy pattern.

# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Strategy pattern.