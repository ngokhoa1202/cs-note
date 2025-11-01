#software-engineering #software-architecture #software-testing 

# Module
- Module is a logical grouping of related code. (`package` in Java or `namespace` in C#)
# Modular measurement
## Cohesion
- Cohesion is the extent of the parts of a module should be contained within the same module.
### Functional cohesion
- Every part of the module is related to the other, and the module contains everything essential to function. (nhất quán về tính năng).
### Sequential cohesion
- Two modules interact, where one outputs data that becomes the input for the other. (nhất quán trình tự).
### Communication cohesion
- Two modules form a <mark class="hltr-yellow">communication chain</mark>, where each operates on information and/or contributes to some output.
- For example, add a record to the database and generate an email based on that information. 
- Nhất quán về giao tiếp
### Procedural cohesion
- Two modules must execute code in a particular order.
- Nhất quán thứ tự thực thi.
### Temporal cohesion
- Modules are related based on timing dependencies. For example, many systems have a list of seemingly unrelated things that must be initialized at system startup; these different tasks are temporally cohesive
- Nhất quán thời gian.
### Logical cohesion
- The data within modules is related logically but not functionally. 
- For example, consider a module that converts information from text,serialized objects, or streams. Operations are related, but the functions are quite different. 
- A common example of this type of cohesion exists in virtually every Java project in the form of the `StringUtils` package: a group of <mark class="hltr-yellow">static methods</mark> that operate on String but are otherwise unrelated.
- Nhất quán logic.
### Coincidental cohesion
- Elements in a module are not related other than being in the same source file; this represents the most negative form of cohesion.
### Metrics
- Lack of Cohesion in Methods - LCOM.
- $P$ is the number of pair of methods that do not share any attributes.
- $Q$ is the number of pair of methods that share at least one attribute.
- $n$ is the number of methods.
#### LCOM 1
- $$\text{LCOM}_1=P=C^2_{n}-Q$$
#### LCOM 2
- $$\text{LCOM}_2=\begin{cases} P-Q \space \text{if} P>Q \\ 0 \space {\text{otherwise}} \end{cases}$$
#### LCOM 3
- A graph $G=(V,E)$:
	- $V$ : Each vertex represents a method
	- $E$: Each edge represents that the two method share at least one attribute.
- $$\text{LCOM}_3=\text{Number of connected components of } G$$
#### LCOM 4
- A graph $G=(V,E)$:
	- $V$ : Each vertex represents a method
	- $E$: Each edge represents that the two method share at least one attribute or one of the two methods call the other.
- $$\text{LCOM}_3=\text{Number of connected components of } G$$
#### LCOM 5
- $l$ is the number of attributes.
- $k$ is the number of methods.
- $a$ is the summation of the number of distinct attributes accessed by each method.
- $$\text{LCOM}_5=\frac{a-kl}{l-kl}$$
### Measurement
- $LCOM=1$ indicates a cohesive class, which is the "good" class.
- $LCOM \geq 2$ indicates a problem. The class should be split into so many smaller classes.
- $LCOM=0$ happens when there are no methods in a class. This is also a "bad" class.
- ![](Pasted%20image%2020250308181734.png)
## Coupling

## Abstractness
- Abstractness is the ratio of abstract artifacts (abstract classes, interfaces, and so on) to concrete artifacts (implementation). $$A=\frac{\sum m^a}{\sum m^c}$$
## Instability
- Instability is he ratio of outgoing coupling ($C^e$) to the sum of both outgoing and incoming coupling ($C^e + C^a$). $$I=\frac{C^e}{C^e+C^a}$$
- Instability measures how likely a software component is to change based on its dependencies.
- Unstable components should always rely on stable components.
### Metrics
- $I=0$ means the component is maximally stable. It has no outgoing dependencies and many other components have to depend on it. Any modification to it is challenging and risky such as kernel API, drivers...
- $I=1$ means the component is maximally unstable. It has to depend on many other components and no other component depends on it. It is, as a result, easy to change without having any negative impact on the others.
## Distance from the Main Sequence
- Distance from the main sequence is deduced from the instability and abstractness metrics $D= |A+I-1|$.
- ![[Pasted image 20250705153116.png]]
- The distance metric imagines an **ideal** relationship between *abstractness and instability*; classes that fall near this idealized line exhibit a healthy mixture of these two competing concerns.
- ![[Pasted image 20250705153252.png]]
- Classes that fall too far into the upper-right corner enter into the zone of uselessness: code that is too abstract becomes difficult to use.
- Conversely, code that falls into the lower-left corner enter the zone of pain: code with too much implementation and not enough abstraction becomes easily broken and hard to maintain.
- ![[Pasted image 20250705153328.png]]
## Connascence
>[!Note]- connacscence definition
>Two components are connascent if a change in one would require the other to be modified in order to maintain the overall correctness of the system.
- The type of connascence from weakest to strongest.
- The strong type of connascence should always be refactored to the weak type of connascence.
- ![[Pasted image 20250705155254.png]]
- *Coupling measures quantity and direction of dependencies, while connascence measures their quality and nature.*
- ![[Pasted image 20250705160635.png]]
## Static Connascence:
- Name: Components must agree on names (methods, variables)
- Type: Components must agree on data types
- Meaning: Components must agree on interpretation of values
- Position: Components must agree on parameter order
- Algorithm: Components must agree on algorithms used
## Dynamic Connascence
- Execution: Order of execution matters
- Timing: Timing of execution matters
- Values: Values must change together
- Identity: Components must reference the same entity


# References
1. Fundamentals of Software Architecture An Engineering Approach - Mark Richards Neal Ford - O_Reilly Media (2020)
	1. Chapter 2. Architectural Thinking.
	2. 
2. HCMUT Software Architecture Slides - Trần Trương Tuấn Phát - 2025.