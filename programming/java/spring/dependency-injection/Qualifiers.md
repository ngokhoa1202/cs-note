#dependency-injection   #java #spring #spring-boot  #inversion-of-control  #annotation #metadata 

- Specify ==which concrete class should be== instantiated and ==injected== into the dependency among many concrete classes sharing the same interface.

# Qualifier
- After the `@Autowired` annotation of the method needing dependency, specify the bean id with the same name as class, but first character in lowercase
```java
package com.luv2code.springcoredemo.rest;
import com.luv2code.springcoredemo.common.Coach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
…
@RestController
public class DemoController {

	private Coach myCoach;
	
	@Autowired
	public DemoController(@Qualifier("cricketCoach") Coach theCoach) {
		myCoach = theCoach;
	}
	@GetMapping("/dailyworkout")
	public String getDailyWorkout() {
		return myCoach.getDailyWorkout();
	}
}
```