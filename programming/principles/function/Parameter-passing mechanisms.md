#structured-programming #functional-programming #java #go #c #cpp #javascript #typescript #memory 
# Pass by value
- The caller evaluates the arguments and their content is <mark class="hltr-yellow">copied</mark> into the parameter variable.
- As a result, if the argument passed is not a pointer and reference, any modification to that corresponding parameter inside the callee is *invisible* in the caller.
- Otherwise, the callee only copies the *address content* of the argument and is able to change the referenced object. 
# Pass by reference
- Pass by reference requires the argument to be a variable with an allocated address.
- Pass by reference passes the location of the argument into its reciprocal parameter so that the parameter becomes an <mark class="hltr-yellow">alias</mark> for the argument.
- As a result, any changes made to the parameter occur to the argument as well.
# Pass by value-result
- The content of the argument is copied and used in the callee. The final value of the parameter is <mark class="hltr-yellow">copied back</mark> out to the location of the argument when the callee exits.
- Pass by value-result is only distinguishable from pass by reference in the presence of aliasing.
```C title='Pass by value-result special case example'
void p(int x, int y)
{ 
	x++;
	y++;
}
main()
{ 
	int a = 1;
	p(a,a); 
	 // a = 2 if pass by value-result
	 // a = 3 if pass by reference
	...
}
```
# Pass by name
- Pass by name delay the evaluation of the argument until its actual use as a parameter in the called procedure. In other words, pass by name is similar to textual replacement.
```C title='Pass by name example'
int i;
int a[10];
void inc(int x)
{ 
	i++;
	x++;
}
main()
{ 
	i = 1;
	a[1] = 1;
	a[2] = 2;
	inc(a[i]); 
	 // a[2] = 3, a[1] remains unchanged
	return 0;
}
```
- ![](Pasted%20image%2020250608185919.png)
- At line 11: $y=i+j$
- At line 4: $j = y = i + j$
- At line 5: $i = i + 1$
- At line 7: $j+y=i+j+i+j=(i+1)+j+(i+1)=2(i+1)+2j=2 \times (0+1) + 2 \times 2 = 6$
# Application
## Java
- [[programming/java/fundamentals/java-core/common-problems/Swap two variables|Swap two variables]]
## Go
- [[programming/go/fundamentals/common-problems/Swap two variables|Swap two variables]]
## JavaScript
- [[programming/javascript/common-problems/Swap two variables|Swap two variables]]
***
# References
1. Programming languages, principles and practice - Louden K.C., Lambert K.A. - Course Technology, 3th Edition 2011.
	1. Chapter 10. Control II—Procedures and Environments
		1. Section 10.2. Parameter-passing mechanisms.
2. [[programming/javascript/common-problems/Swap two variables|Swap two variables]]
3. [[programming/java/fundamentals/java-core/common-problems/Swap two variables|Swap two variables]]
4. [[programming/go/fundamentals/common-problems/Swap two variables|Swap two variables]]
5. 