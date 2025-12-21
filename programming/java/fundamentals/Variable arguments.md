#java #operator 

- Equivalent to [Rest parameter](Rest%20parameter.md) in JavaScript.
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
# Heap pollution

---
# References
1. https://www.baeldung.com/java-varargs for Variable arguments in Java.
2. [Rest parameter](Rest%20parameter.md) for Rest parameter in JavaScript.
3. https://en.wikipedia.org/wiki/Variadic_function for Variadic function.