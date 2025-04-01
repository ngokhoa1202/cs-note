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
## Metrics
- Lack of Cohesion in Methods - LCOM.
- $P$ is the number of pair of methods that do not share any attributes.
- $Q$ is the number of pair of methods that share at least one attribute.
- $n$ is the number of methods.
### LCOM 1
- $$\text{LCOM}_1=P=C^2_{n}-Q$$
### LCOM 2
- $$\text{LCOM}_2=\begin{cases} P-Q \space \text{if} P>Q \\ 0 \space {\text{otherwise}} \end{cases}$$
### LCOM 3
- A graph $G=(V,E)$:
	- $V$ : Each vertex represents a method
	- $E$: Each edge represents that the two method share at least one attribute.
- $$\text{LCOM}_3=\text{Number of connected components of } G$$
### LCOM 4
- A graph $G=(V,E)$:
	- $V$ : Each vertex represents a method
	- $E$: Each edge represents that the two method share at least one attribute or one of the two methods call the other.
- $$\text{LCOM}_3=\text{Number of connected components of } G$$
### LCOM 5
- $l$ is the number of attributes.
- $k$ is the number of methods.
- $a$ is the summation of the number of distinct attributes accessed by each method.
- $$\text{LCOM}_5=\frac{a-kl}{l-kl}$$
### Measurement
- $LCOM=1$ indicates a cohesive class, which is the "good" class.
- $LCOM \geq 2$ indicates a problem. The class should be split into so many smaller classes.
- $LCOM=0$ happens when there are no methods in a class. This is also a "bad" class.
- ![](Pasted%20image%2020250308181734.png)
---
# References
1. Fundamentals of Software Architecture An Engineering Approach - Mark Richards Neal Ford - O_Reilly Media (2020)
	1. Chapter 2.
2. HCMUT Software Architecture Slides - Trần Trương Tuấn Phát - 2025