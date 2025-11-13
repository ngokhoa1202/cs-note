#java #operator 

- Equivalent to [Rest parameter](Rest%20parameter.md) in Javascript.
- 
# Variable arguments
- Variable arguments allow a variadic function to accept indefinite arguments without knowing its number at compile time.
```Java title='Varargs example'
public String formatWithVarArgs(String... values) {
    // ...
}
```
# Rules
- Each method can have only one varargs parameter.
- The varargs parameter must be the last parameter.
- The varargs parameter should be safely used to avoid [[Heap pollution]] or a compilation warning is raised.
	- The varargs array should not be modified or added new elements.
	- The varargs array should not be exposed to external contexts.
	- If two of the above rules have to be violated and the heap pollution is ensured to not occur,  the method must be annotated with`@SafeVargs` 
```Java title='@SafeVargs annotation' hl=1
@SafeVarargs
static <T> void doSomething(T... args) { ... }
```
***
# References
1. https://www.baeldung.com/java-varargs for Variable arguments in Java.
2. [Rest parameter](Rest%20parameter.md) for Rest parameter in Javascript.
3. https://en.wikipedia.org/wiki/Variadic_function for Variadic function.
4. [Variadic function](Variadic%20function.md) for general variadic function.
5. [[Heap pollution]]