#java #spring #lombok #java-core #object-oriented-programming #configuration #installation #annotation #design-pattern #software-engineering 

# Purpose
- ==Reduces boilerplate code== for Java core (getter, setter, constructor, builder pattern).
# Install Lombok with Spring
- Configure file `pom.xml`
```xml
<dependency>  
  <groupId>org.projectlombok</groupId>  
  <artifactId>lombok</artifactId>  
</dependency>
```

# Builder pattern
- Use `@Builder` annotations before a class definition. Remember to add `@AllArgsConstructor` as well.

# References
1. https://projectlombok.org/features/Builder for Builder annotation in Lombok.
2. 