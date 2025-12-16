#jakarta-ee #dependency-injection #design-pattern #software-architecture #software-engineering #java #annotation #session  #annotation #jvm #solid #quarkus #spring-framework
#spring-boot 
>[!Important]
>The terminology "context" means the *execution environment* or the *container* that enforce the rules of bean lifecycle.
# Bean
- A bean is a source of contextual objects that define application state or logic.
- A bean has its attributes:
	- Bean types:
		- Interface, abstract class.
		- Concrete class.
		- Parameterized type (User-defined or built-in generic types).
		- Array type, Primitive type.
	- Qualifiers.
	- Scope.
	- Interceptor bindings.
	- Implementation.
- A bean can be simply understood as injectable objects
	- Almost Java classes.
	- Session beans.
	- Jakarta EE resources:
		- Data sources.
		- Messaging topics.
		- Queues.
		- Connection factories.
		- ...
	- Persistence contexts (like [Entity manager](programming/java/jakarta-ee/Entity%20manager.md)).
	- Producer fields and its return objects.
	- Web service references.
	- Remote enterprise bean references.
- To inject the user-defined beans, use the `{Java}@Inject` annotation.
# Qualifier
- Specify which ==concrete implementation should be injected== into a dependency.
## Example
- Base class
```java
package greetings;

public class Greeting {
	public String greet(String name) {
		return "Hello, " + name + ".";
	}
}
```

- Define bean using `@Qualifier` annotation
```java
package greetings;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
import java.lang.annotation.Retention;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
import java.lang.annotation.Target;
import jakarta.inject.Qualifier;

@Qualifier
@Retention(RUNTIME)
@Target({TYPE, METHOD, FIELD, PARAMETER})
public @interface Informal {

}
```
- Define concrete class and specifies it with `@Informal` annotation
```java
package greetings;
@Informal
public class InformalGreeting extends Greeting {
	public String greet(String name) {
		return "Hi, " + name + "!";
	}
}
```

- If no bean is explicitly specified, a `@Default` annotation is automagically added to the concrete class by the JVM.
```java
package greetings;
@Default
public class InformalGreeting extends Greeting {
	public String greet(String name) {
		return "Hi, " + name + "!";
	}
}
```
# Dependency scope - Bean scope
## Request scope
- One instance is created per HTTP request and it is destroyed when the request completes.
- Annotated with `{Java}@RequestScoped` annotation.
## Application scope
- Singleton - Only one instance is created during the application lifecycle.
- Annotated with `{Java}@ApplicationScoped` annotation.
## Dependent scope
- Dependent scope is the default scope in case no scope is explicitly specified.
- Dependent scope is not proxied.
- Annotated with `{Java}@Dependent`
- The lifecycle of a dependent scope bean is tightly bound to the lifecycle of its owner object.
- `{Java}Provider.get()` invocation always creates a new instance of a `{Java}@Dependent` bean.
## Conversation scope
- A user’s interaction with a servlet, including Jakarta Faces applications. The conversation scope exists within developer-controlled boundaries that extend it across multiple requests for long-running conversations. All long-running conversations are scoped to a particular HTTP servlet.
- Compare to [Bean scope](Bean%20scope.md) in Spring.
## `{Java}@PreDestroy` and `{Java}@PostConstruct`
---
# References
1. https://docs.jboss.org/weld/reference/2.4.0.Final/en-US/html/scopescontexts.html#**_the_conversation_scope for conversation scope.
2. https://jakarta.ee/learn/docs/jakartaee-tutorial/current/cdi/cdi-basic/cdi-basic.html#_using_scopes for official documentation for Jakarta CDI.
3. [[software-engineering/software-architecture/design/design-pattern/enterprise-pattern/integration/Dependency injection pattern|Dependency injection pattern]]
4. https://stackoverflow.com/questions/24822361/when-is-a-dependent-scoped-cdi-bean-destroyed-if-you-obtain-that-bean-via-prov for the Dependent scope.
5. 