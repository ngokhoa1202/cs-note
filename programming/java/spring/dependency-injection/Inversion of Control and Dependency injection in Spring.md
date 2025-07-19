#inversion-of-control #spring  #spring-boot #software-engineering  #software-architecture  #dependency-injection  #java #object-oriented-programming  #annotation #autowiring 

# Inversion of control
- In tradditional programming, we ==ourselves implement the program flow== and reuse modules in libraries to perform some tasks in our application $\implies$ we call library functions.
- However, inversion of control ==transfers the control of objects and program flow to the framework==:
	- Allows the framework to take control of our own implementation and make calls to our code. $\implies$ libraries call our own functions.
## Characteristics
- Loosely coupled between concrete classes.
- Isolates abstraction from implementation.
- Enhance testing by mocking the objects.

# Dependency injection
## Simple example
- Tradditional programming:
```java
public class Store {
    private Item item;
 
    public Store() {
        item = new ItemImpl1();    
    }
}
```
- Use dependency injection $\equiv$ let the Dependency contrainer instatiates the object
```java
public class Store {
    private Item item;
    public Store(Item item) {
        this.item = item;
    }
}
```

# Spring container & Beans
- IOC container $\equiv$ Spring container = `ApplicationContext` is ==responsible for instantiating, configuring, assembling objects== $\equiv$ ==beans== to jnject them into dependencies. 
- To assemble beans, the container uses the ==XML metadata== or ==annotations== (which are still metadata behind the scene).
## Dependency resolution process
- The `ApplicationContext` is created and initialized with configuration metadata that describes all the beans.
- For each bean, its dependencies are expressed in the form of properties, constructor arguments, or arguments to the static-factory method (if you use that instead of a normal constructor). These ==dependencies are provided to the bean==, when the bean is actually created.
- Each property or constructor argument is an ==actual definition of the value== to set, ==or a reference to another bean== in the container ($\equiv$ a bean may contain primitive type or object type which are another bean).
- Each property or constructor argument that is a value ($\equiv$ primitive type) is ==converted from its specified format to the actual type== of that property or constructor argument. By default, Spring can convert a value supplied in string format to all built-in types, such as `int`, `long`, `String`, `boolean`, and so forth.  $\equiv$ resolve dependencies recursively (like [Dependency injection container](Dependency%20injection%20container.md) in PHP).
# References
1. https://www.baeldung.com/inversion-control-and-dependency-injection-in-spring for Inversion of Control and Spring dependency injection.
2. https://www.baeldung.com/constructor-injection-in-spring for constructor dependency injection.
3. https://docs.spring.io/spring-framework/reference/core/beans/basics.html for official documentation.
4. 