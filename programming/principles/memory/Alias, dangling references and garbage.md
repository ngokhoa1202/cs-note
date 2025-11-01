#c #cpp #java #javascript #rust #go #php #operating-system #memory #virtual-memory 

# Alias
- An alias occurs when the <mark class="hltr-yellow">same object is bound to two different names</mark> at the same time.
```c title='Alias example written in C'
(1) int *x, *y;
(2) x = (int *) malloc(sizeof(int));
(3) *x = 1;
(4) y = x;
/* *x and *y now aliases */
(5) *y = 2;
(6) printf("%d\n",*x);
```

- ![](Pasted%20image%2020250510132843.png)
- ![](Pasted%20image%2020250510132858.png)
- ![](Pasted%20image%2020250510132915.png)
- ![](Pasted%20image%2020250510132930.png)
- ![](Pasted%20image%2020250510132940.png)
- Aliases can potentially cause harmful side effects to the program in case the instance having been changed is used beyond the current scope of the program.
# Dangling reference
- A dangling reference is a <mark class="hltr-yellow">location that has been deallocated</mark> from the environment but that can <mark class="hltr-yellow">still be accessed by a program</mark>.
	- This error is also called segmentation fault error.
```c title='Dangling reference example'
int *x , *y;
...
x = (int *) malloc(sizeof(int));
...
*x = 2;
...
y = x; /* *y and *x now aliases */
free(x); /* *y now a dangling reference */
...
printf("%d\n",*y); /* illegal reference */
```
- Some programming languages have its approach to tackle this memory safety problem:
	- Java does not explicitly allow pointers.
	- Rust implements its own ownership reference model.
	- ....
# Garbage
- Garbage is memory that <mark class="hltr-yellow">has been allocated</mark> in the environment but that <mark class="hltr-yellow">has become inaccessible</mark> to the program.
```c title='Garbage example in C'
void p(){
	int *x;
	x = (int *) malloc(sizeof(int));
	*x = 2; 
}
```
- When the control flow exits the function, the variable $x$ is destroyed; as a result, its referenced memory space is now inaccessible and thus become garbage.
- Most modern programming languages, such as Rust, Go, Java, PHP, and even Modern C++ implements its own garbage collector mechanism.
# References
1. Programming languages, principles and practice - Louden K.C., Lambert K.A. - Course Technology, 3th Edition 2011.
	1. Chapter 7. Basic Semantics.
		1. Section 7.7. Aliases, Dangling References, and Garbage