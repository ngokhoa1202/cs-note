#annotation  #spring  #spring-boot  #dependency-injection  #inversion-of-control #java 

- 
# Spring dependency injection
## Constructor dependency injection
- Inits the ==required dependencies==.
- Recommended by spring.io 
- Use `@Autowired` annotations.
```java
@RestController
public class DemoController {
	private Coach myCoach;

	// allow any name
	@Autowired
	public void doSomeStuff(Coach theCoach) {
		myCoach = theCoach;
	}
…
}
```
## Setter dependency injection
- Inits the ==optional dependencies==.
- If dependency is not provided, the class can perform some ==default logic==.
- Use `@Autowired` annotations.
```java
@Component
public class Car {

    @Autowired
    public Car(Engine engine, Transmission transmission) {
        this.engine = engine;
        this.transmission = transmission;
    }
}
```

### Field dependency injection
- Inject the dependency by  direcly setting the field, even the field is private.
- Not recommended by spring.io
- Use `@Autowired` annotation.
```java
public class Store { 
	@Autowired 
	private Item item; 
}
```

# Lazy initialization
- By default, Spring instatiates all of the objects specified as beans. Lazy initialization means that the object is instatiated o==nly when it is needed for dependency injection or explicitly constructed==.
- Use `@Lazy` annotation to the given concrete class or specify in `application.properties`
```config
spring.main.lazy-initialization=true
```


# References
1. https://docs.spring.io/spring-framework/reference/core/beans/dependencies/factory-autowire.html for lazy initilization.
2. 