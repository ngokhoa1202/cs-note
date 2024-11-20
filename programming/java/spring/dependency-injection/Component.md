#annotation  #spring #spring-boot  #dependency-injection  #metadata #bean #java #design-pattern  

- Idenfies a bean and helps Spring to scan it automatically.
# Component
- Use `@Component` annotation to the class that represents the dependency.
- Use when we have the source. If we have only ==third party class==:
	- Use `@Configuration` for the class has the method that instantiates the object for injection. $\implies$ Create Configuration class (usually done for us)
	- Annotate `@Bean` for that method $\implies$ Create Bean method. (usually done for us).
	- Annotate [Qualifiers](Qualifiers.md) `@Qualifier` to the method or property that needs to be injected.
- When being detected, an instance may be initialized and injected when necessary.
# Component scan
- Use `@ComponentScan` annotation
```java
package com.baeldung.component.inscope;

@SpringBootApplication
@ComponentScan({"com.baeldung.component.inscope", "com.baeldung.component.scannedscope"})
public class ComponentApplication {
    public static void main(String[] args) {...}
}
```

- Or specify the `scanBasePackage` of `@SpringApplication` annotation.
- By default, Spring only scans the packages inside the parent directory of the file `SpringApplication.java` 
- Spring only scans for packages inside tutorial folder: ![](Pasted%20image%2020240716150812.png)
- Explicitly list the packages needed to be scanned.
- 