#java #java8 #api #functional-programming #high-order-function #java-generic

# Syntax
```Java title='interface Collector syntax'
public interface Collector<T,A,R>
```
- `T` :  the *type of input elements* to the reduction operation.
- `A` : the mutable *accumulation type* of the reduction operation (often hidden as an implementation detail).
- `R` : the *result type* of the reduction operation.

# References
1. https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collector.html