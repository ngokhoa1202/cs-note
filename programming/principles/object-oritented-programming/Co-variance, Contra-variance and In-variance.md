#object-oriented-programming #discrete-math #relation #java 

# Co-variant and Contra-variant functions
- Let $D$ be a set on which a pre-order, written as $\preceq$ . 
- A function $f : D → D$ is 
	- co-variant in case $f$ respects the pre-order, that is $x \preceq y \implies f(x) \preceq f(y)$.  
	- contra-variant in case the pre-order is reversed, that is $x \preceq y \implies f(x) \succeq f(y)$.
	- in-variant if neither the two above conditions hold, that is $x \preceq y \centernot\implies f(x) \preceq f(y) \space \lor f(x) \succeq f(y)$
# Co-variances
- Co-variances means that if $A$ is subtype of $B$, then $\text{Container}(A)$ is a <mark class="hltr-blue">subtype</mark> of $\text{Container}(B)$. In other words, $A$ and $B$ varies in the <mark class="hltr-blue">same</mark> direction.
	- $A \preceq B \implies C(A) \preceq C(B)$ where $C$ is a general container function.
- Co-variances is applied in the <mark class="hltr-yellow">producer</mark> pattern that instantiates an object such as specifying the return type.
```Java title='Co-variances example in Java'
class Animal {
    Animal reproduce() { ... }
}

class Dog extends Animal {
    Dog reproduce() { ... }  // OK - Dog is subtype of Animal
}
```
- $$\text{Dog} \preceq \text{Animal} \implies () \to \text{Dog} \preceq () \to \text{Animal}$$
# Contra-variances
- Co-variances means that if $A$ is a subtype of $B$, then $\text{Container}(A)$ is a <mark class="hltr-blue">supertype</mark> of $\text{Container}(B)$. In other words, $A$ and $B$ varies in the <mark class="hltr-blue">opposite</mark> direction.
	-  $A \preceq B \implies C(A) \succeq C(B)$ where $C$ is a general container function.
- Contra-variances is applied in the <mark class="hltr-yellow">consumer</mark> pattern that consuming an object such as passing parameters.
```Java title='Contra-variances example Java'
// Semantically correct but not overriding in Java because the overriding method must be exact the overriden method
class Animal {
    void feed(Dog food) { ... }
}

class Dog extends Animal {
    void feed(Animal food) { ... }  // Would be contravariant
}
```
- $$\text{Dog} \preceq \text{Animal} \implies \text{Dog} \to () \succeq \text{Animal} \to ()$$
# In-variances
- In-variances means that even if $A$ is a subtype of $B$,  $\text{Container}(A)$ and $\text{Container}(B)$ have <mark class="hltr-yellow">no subtype relationship</mark>.
	-   $A \preceq B \centernot\implies C(A) \succeq C(B)$ or $C(A) \preceq C(B)$ where $C$ is a general container function.
---
# References
1. Programming Languages: Principles and Paradigms - Maurizio Gabbrielli and Simone Martini - Springer Publisher (2010).
	1. Chapter 10. The Object-Oriented Paradigm.
		1. Section 4: Polymorphism and Generics.
2. [[Relation#Partial ordering]] for Partial ordering in Relation.
3. https://stackoverflow.com/questions/8481301/covariance-invariance-and-contravariance-explained-in-plain-english.
4. 
