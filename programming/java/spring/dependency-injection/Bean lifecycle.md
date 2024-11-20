#bean #spring #spring-boot #java #software-architecture  #design-pattern  #oop 

# Bean lifecycle
- ![800](Pasted%20image%2020240716205458.png)
# Initialization callback
- Called after spring finishes its initialization and before bean usage.
- Implements `InitializingBean` interface
- Or use `@PostConstruct` annotation to specify initilization callback
```java
package org.jpa;  
  
import jakarta.annotation.PostConstruct;  
import org.springframework.context.annotation.Primary;  
import org.springframework.stereotype.Component;  
  
@Component  
@Primary  
public class Midfielder implements FootballPlayer {  
  
  @Override  
  public void play() {  
    System.out.println("I pass the ball");  
  }  
  
  @PostConstruct  
  public void afterInit() {  
    System.out.println("After initialization phase, i will do some stuffs");  
  } 
  
  @PreDestroy  
	public void beforeDestroy() {  
	  System.out.println("Before destruction phase, i will do some stuffs");  
	}
}
```

# Destruction callback
- Called after the bean container has been destroyed.
- Implement `DisposableBean` interface.
- Or use `@PreDestroy` annotation.
- [Initialization callback](#Initialization%20callback) for example.

# References
1. https://docs.spring.io/spring-framework/reference/core/beans/factory-nature.html#beans-factory-lifecycle-combined-effects for bean lifecycle.