#dbms #dbms-design #erd-diagram #object-oriented-programming #domain-driven-design 

- Stands for Enhanced Entity-Relationship Digram (Enhanced [ERD](ERD.md))
# Generalization & Specialization
- Reflects ==inheritance== in oop.
- Is-A relationship.
- ![](Pasted%20image%2020240617174914.png)
## Determine subclass
- Predicate-defined.
- Attribute-defined.
- ![](Pasted%20image%2020240617175100.png)
- User-defined.
## Constraints
### Concepts
- Disjointedness $\implies$ disjointed or overlapped entity.
	- A developer can be both a frontend developer and a backend developer $\implies$ overlap.
	- An computer engineer can either a software engineer or a hardware engineer, but not both $\implies$ disjointed.
- Completeness $\implies$ total or partial.
	- Every user must be either a student, a lecturer, a teching assistant. $\implies$ total
	- A user can be either a student, a lecturer, a teching assistant or just a guest user (but nost listed). $\implies$ partial.
### Diagram
- A and B are disjointed and partial:
	- $A \cup B \subset U$ and $A \cap B = \varnothing$   ![](Pasted%20image%2020240906091647.png)
- A and B are overlapped and partial. 
	- $A \cup B \subset U$ and $A \cap B \neq \varnothing$   ![](Pasted%20image%2020240906091851.png)
- A and B are disjointed and total 
	- $A \cup B = U$ and $A \cap B = \varnothing$  ![](Pasted%20image%2020240906092038.png)
- A and B are overlapped and total.
	- $A \cup B = U$ and $A \cap B \neq \varnothing$  ![](Pasted%20image%2020240906093035.png)
## Shared subclass
- Reflects multiple inheritance.
- Shared subclass inherits all attribute of its parent class.
- Represents ==AND== operation between entities.
- ![](Pasted%20image%2020240617180538.png)
# Category
- Represents ==OR== operations between entity.
- ![](Pasted%20image%2020240617181051.png)
- Category inherits only one parent class.