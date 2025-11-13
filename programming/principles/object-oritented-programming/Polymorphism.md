#object-oriented-programming #polymorphism #java #go  #rust #python
#software-engineering #software-architecture #software-testing #solid 

# Universal polymorphism
- Universal Polymorphism is a form of polymorphism in which an object or a value can have an <mark class="hltr-yellow">infinite number of different types</mark> derived from a *single type schema*.
## Parametric polymorphism
### Definition
- Parametric Polymorphism is a form of polymorphism in which an object such as a function or  data structure can have an infinite number of different types by instantiating a single general type schema. 
### Application
- Enables <mark class="hltr-yellow">generic programming</mark>, which involves writing code that can be reused for objects of many different types.
### Purpose
- Enhances code reusability and expressiveness: a class or function definition can work uniformly across data types without duplicate code.
- Ensures type safety: generic definition is statically checked at compile time, thus improving security and reliability.
### Examples
#### Java
- [[Generics]]
#### C++
- Template programming.
#### Go
- Interface-based polymorphism.
#### Rust
## Subtype polymorphism - dynamic binding
### Definition
- Subtype Polymorphism is a form of polymorphism in which an object such as a variable or method call can have an <mark class="hltr-yellow">infinite number of different types</mark> by instantiating a *single general type schema*, given those types must be <mark class="hltr-yellow">subtypes</mark> of an assigned type base.
### Application
- Enforces *"Is - A" relationship* in Object-Oriented Programming, or [[SOLID#Liskov substitution principle]].
- Enables *method overriding*, or *dynamic dispatch* in general in Object-Oriented Programming, where the correct method implementation based on the actual class of the object is determined at runtime.
### Purpose
- Embraces loose coupling in Object-Oriented Programming.
- Promotes *abstraction* and reusability.
### Example
#### Java

#### Rust
- trait-based.
#### Go
- interface-based.
# Ad-hoc polymorphism - overloading
## Definition
- Ad Hoc Polymorphism (Overloading) is a form of polymorphism where a single function, method or operator is associated with a <mark class="hltr-yellow">finite number of distinct definitions</mark>. 
- The ambiguity inherent in using the same name for multiple implementations is statically resolve, typically by examining the context, particularly the number and types of the arguments involved.
## Application
- Operator overloading: the behavior of the operation depends on the *static-time* types of its operands. For instance, addition operation's behavior varies in data types `{Java}int`, `{Java}double` and `{Java}String`.
- Method overloading: multiple functions share the same name but differ in signatures. Only the function with correct signature is chose to be executed at *static time*.
## Purpose
- Enhances expressiveness and readability by allowing programmers to specify behaviors more precisely. For instance, method overriding in derived class specifies its own behavior rather than relying on the base class.
- Resolves ambiguity by allowing the compiler or interpreter to determine the intended operation by analyzing the types of the operands.
# References
1.  Programming languages, principles and practice - Louden K.C., Lambert K.A. - Course Technology, 3th Edition 2011.
	1. Chapter 5. Object-oriented programming.
2. Core Java Volume I Fundamentals - Cay S. Horstmann - Prentice Hall Publisher (2016).
	1. Chapter 8. Generic Programming.
		1. Section 1. Why Generic Programming?
3. [[SOLID]].
4. [[Design patterns]]