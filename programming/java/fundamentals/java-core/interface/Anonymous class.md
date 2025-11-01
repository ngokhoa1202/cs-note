#object-oriented-programming #java 

# Definition
- Anonymous classes are inner classes with no name.
- Anonymous classes' object are only instantiated in an expression and the class itself cannot be reused.
# Characteristics
- Anonymous classes have no constructor.
- Anonymous classes have no static members except constant ones.
# Usage
## Extend a class
```Java title='Anonymous class is used to extend a class'
new Book("Design Patterns") {
    @Override
    public String description() {
        return "Famous GoF book.";
    }
}
```
## Implement an interface
```Java title='Anonymous class is used to implement interface in Java'
Runnable action = new Runnable() {
    @Override
    public void run() {
        ...
    }
};
```
# References
1. https://www.baeldung.com/java-anonymous-**classes**
2. https://docs.oracle.com/javase/specs/jls/se8/html/index.html