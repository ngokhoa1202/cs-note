#java #operator #java5 

- Equivalent to [Rest parameter](Rest%20parameter.md) in Javascript.
# Variable arguments
- Variable arguments allow a variadic function to accept *indefinite arguments* without knowing its number at compile time.
- Every time a variable argument is passed, an *array* is automatically allocated to hold that argument.
```Java title='Varargs example'
public String formatWithVarArgs(String... values) {
    // ...
}
```
# Rules
- Each method can have only one varargs parameter.
- The varargs parameter must be the last parameter.
***
# References
1. https://www.baeldung.com/java-varargs for Variable arguments in Java.
2. [Rest parameter](Rest%20parameter.md) for Rest parameter in Javascript.
3. [[Variadic function]] for Variadic function.