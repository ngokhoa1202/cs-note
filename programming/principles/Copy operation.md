#memory #java #c #cpp #os 

# Concepts
## Shallow copy
- The variables A and B refer to different areas of memory, when B is assigned to A the two variables refer to the same area of memory. Later modifications to the contents of either are <mark class="hltr-yellow">instantly reflected in the contents of other, as they share contents</mark>.
## Deep copy
- The variables $A$ and $B$ refer to different areas of memory, when B is assigned to A the values in the memory area which A points to are copied into the memory area to which $B$ points. Later modifications to the contents of either <mark class="hltr-yellow">remain unique to A or B because the</mark> <mark class="hltr-yellow">contents are not shared</mark>.
- ![](Pasted%20image%2020250511164058.png)
# Practice
## Java

## C

## C++

# References
1. https://stackoverflow.com/questions/184710/what-is-the-difference-between-a-deep-copy-and-a-shallow-copy
2. 