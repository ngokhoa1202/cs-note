#jakarta-ee #dependency-injection #design-pattern #software-architecture #software-engineering #java #annotation #session #jvm #solid #quarkus #spring-framework #spring-boot
# Overview
- Jakarta Contexts and Dependency Injection (CDI) provides a typesafe dependency injection mechanism for Jakarta EE applications.
- CDI manages the lifecycle and dependencies of application components through a container that enforces bean lifecycle rules.
- The terminology "context" refers to the *execution environment* or *container* that manages bean instances and their scopes.
- CDI serves as the foundation for integrating Jakarta EE technologies including Jakarta Faces, Jakarta REST, and Jakarta Enterprise Beans.
# Bean
## Definition
- A bean represents a source of contextual objects that define application state or logic.
- A bean is a container-managed object with a well-defined lifecycle, scope, and set of dependencies.
- Beans are injectable objects that can be injected into other beans using the `Java` `@Inject` annotation.
## Bean Types
- A bean exposes one or more bean types that determine where it can be injected.
- Bean types include:
	- Interface types
	- Abstract class types
	- Concrete class types
	- Parameterized types (generic types with type parameters)
	- Array types
	- Primitive types
- The container uses bean types to match injection points with available beans.
## Bean Attributes
- Each bean is characterized by:
	- **Bean types**: The set of types the bean can be injected as
	- **Qualifiers**: Annotations that distinguish beans with the same type
	- **Scope**: The lifecycle context that controls bean instance creation and destruction
	- **Interceptor bindings**: Annotations that associate interceptors with the bean
	- **Implementation**: The concrete class that implements the bean
	- **Name**: An optional EL-resolvable name for the bean
## Injectable Bean Categories
- Almost any Java class can be a bean:
	- Plain Old Java Objects (POJOs) with a default constructor
	- Session beans (stateless, stateful, singleton)
	- Jakarta EE resources:
		- Data sources (`Java` `DataSource`)
		- JMS destinations (topics, queues)
		- Connection factories
		- Mail sessions
	- Persistence contexts (Entity Manager instances)
	- Producer fields and producer method return values
	- Web service references
	- Remote enterprise bean references
# Injection Points
- An injection point is a location in the code where the container injects a bean instance.
- Injection points are declared using the `Java` `@Inject` annotation.
- The container resolves injection points by matching bean types and qualifiers.
## Field Injection
```Java
@Inject
private UserService userService;
```
## Constructor Injection
```Java
@Inject
public OrderProcessor(UserService userService, PaymentService paymentService) {
    this.userService = userService;
    this.paymentService = paymentService;
}
```
## Setter Injection
```Java
@Inject
public void setUserService(UserService userService) {
    this.userService = userService;
}
```
# Qualifiers
## Purpose
- Qualifiers distinguish between multiple beans that share the same bean type.
- Without qualifiers, the container cannot determine which bean to inject when multiple implementations exist.
- Qualifiers provide *typesafe resolution* of dependencies at compile time.
## Defining Custom Qualifiers
- Custom qualifiers are annotations meta-annotated with `Java` `@Qualifier`.
- Qualifiers must specify retention policy and target elements.
```Java
package greetings;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import jakarta.inject.Qualifier;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Qualifier
@Retention(RUNTIME)
@Target({TYPE, METHOD, FIELD, PARAMETER})
public @interface Informal {
}
```
## Applying Qualifiers to Beans
- Qualifiers are applied at the type level to mark bean implementations.
```Java
package greetings;

public class Greeting {
    public String greet(String name) {
        return "Hello, " + name + ".";
    }
}
```
```Java
package greetings;

@Informal
public class InformalGreeting extends Greeting {
    @Override
    public String greet(String name) {
        return "Hi, " + name + "!";
    }
}
```
```Java
package greetings;

@Formal
public class FormalGreeting extends Greeting {
    @Override
    public String greet(String name) {
        return "Good day, " + name + ".";
    }
}
```
## Using Qualifiers at Injection Points
- Qualifiers are specified at injection points to select the desired bean implementation.
```Java
@Inject
@Informal
private Greeting informalGreeting;

@Inject
@Formal
private Greeting formalGreeting;
```
## Default Qualifier
- If no qualifier is explicitly specified, the container applies the `Java` `@Default` qualifier automatically.
- The `Java` `@Default` qualifier distinguishes beans without custom qualifiers.
```Java
package greetings;

import jakarta.enterprise.inject.Default;

@Default
public class StandardGreeting extends Greeting {
    @Override
    public String greet(String name) {
        return "Hello, " + name + ".";
    }
}
```
## Any Qualifier
- The built-in `Java` `@Any` qualifier matches all beans regardless of their qualifiers.
- Useful when injecting all implementations of a type.
```Java
@Inject
@Any
private Instance<Greeting> allGreetings;
```
# Scopes
## Overview
- Scopes define the lifecycle and visibility of bean instances.
- Each scope is associated with a context that manages bean instance creation, storage, and destruction.
- CDI provides built-in scopes and allows custom scope definitions.
## Request Scope
- A new bean instance is created for each HTTP request.
- The instance is destroyed when the HTTP request completes.
- Declared with the `Java` `@RequestScoped` annotation.
```Java
import jakarta.enterprise.context.RequestScoped;

@RequestScoped
public class ShoppingCart {
    private List<Item> items = new ArrayList<>();

    public void addItem(Item item) {
        items.add(item);
    }
}
```
## Session Scope
- A bean instance is created per HTTP session.
- The instance is destroyed when the session times out or is invalidated.
- Declared with the `Java` `@SessionScoped` annotation.
- The bean class must be serializable.
```Java
import jakarta.enterprise.context.SessionScoped;
import java.io.Serializable;

@SessionScoped
public class UserPreferences implements Serializable {
    private String theme;
    private String language;
}
```
## Application Scope
- A single bean instance exists for the entire application lifecycle (singleton pattern).
- The instance is created when first accessed and destroyed when the application shuts down.
- Declared with the `Java` `@ApplicationScoped` annotation.
```Java
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class ConfigurationService {
    private Properties configuration;

    @PostConstruct
    public void initialize() {
        configuration = loadConfiguration();
    }
}
```
## Dependent Scope
- The default scope when no scope annotation is specified.
- The bean instance lifecycle is bound to the lifecycle of the client bean.
- Each injection point receives its own instance.
- Not proxied by the container.
- Declared with the `Java` `@Dependent` annotation (optional if no scope specified).
```Java
import jakarta.enterprise.context.Dependent;

@Dependent
public class OrderValidator {
    public boolean validate(Order order) {
        return order != null && !order.getItems().isEmpty();
    }
}
```
- When using `Java` `Provider<T>.get()` with a dependent-scoped bean, each invocation creates a new instance.
```Java
@Inject
private Provider<OrderValidator> validatorProvider;

public void processOrders() {
    OrderValidator validator1 = validatorProvider.get(); // New instance
    OrderValidator validator2 = validatorProvider.get(); // Another new instance
}
```
## Conversation Scope
- Represents a user's interaction with the application across multiple requests.
- The scope exists within developer-controlled boundaries that extend across multiple HTTP requests.
- All conversations are scoped to a particular HTTP servlet session.
- Declared with the `Java` `@ConversationScoped` annotation.
- The bean class must be serializable.
```Java
import jakarta.enterprise.context.ConversationScoped;
import jakarta.inject.Inject;
import java.io.Serializable;

@ConversationScoped
public class WizardController implements Serializable {
    @Inject
    private Conversation conversation;

    private int currentStep;

    public void startWizard() {
        conversation.begin();
        currentStep = 1;
    }

    public void completeWizard() {
        conversation.end();
    }
}
```
# Producers
## Producer Methods
- Producer methods provide beans that require custom initialization logic.
- Producer methods are annotated with `Java` `@Produces`.
- The return type of the producer method becomes a bean type.
```Java
import jakarta.enterprise.inject.Produces;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DatabaseProducer {

    @Produces
    @ApplicationScoped
    public DataSource createDataSource() {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:postgresql://localhost/mydb");
        config.setUsername("user");
        config.setPassword("password");
        return new HikariDataSource(config);
    }
}
```
## Producer Fields
- Producer fields expose existing objects as beans.
- Producer fields are annotated with `Java` `@Produces`.
```Java
import jakarta.enterprise.inject.Produces;

public class LoggerProducer {

    @Produces
    private Logger logger = Logger.getLogger("application");
}
```
## Injection into Producer Methods
- Producer methods can receive injected parameters.
```Java
@Produces
@RequestScoped
public EntityManager createEntityManager(EntityManagerFactory emf) {
    return emf.createEntityManager();
}
```
## Disposer Methods
- Disposer methods clean up resources when a producer-created bean is destroyed.
- Disposer methods are annotated with `Java` `@Disposes`.
```Java
public void closeEntityManager(@Disposes EntityManager em) {
    if (em.isOpen()) {
        em.close();
    }
}
```
# Lifecycle Callbacks
## PostConstruct
- Methods annotated with `Java` `@PostConstruct` execute after dependency injection completes.
- Used for initialization logic that requires injected dependencies.
```Java
import jakarta.annotation.PostConstruct;
import jakarta.inject.Inject;

@ApplicationScoped
public class CacheManager {

    @Inject
    private ConfigurationService config;

    private Cache cache;

    @PostConstruct
    public void initialize() {
        int cacheSize = config.getCacheSize();
        cache = new Cache(cacheSize);
    }
}
```
## PreDestroy
- Methods annotated with `Java` `@PreDestroy` execute before the bean instance is destroyed.
- Used for cleanup operations such as closing connections or releasing resources.
```Java
import jakarta.annotation.PreDestroy;

@ApplicationScoped
public class ConnectionPool {

    private List<Connection> connections;

    @PreDestroy
    public void shutdown() {
        for (Connection conn : connections) {
            try {
                conn.close();
            } catch (SQLException e) {
                // Log error
            }
        }
    }
}
```
# Interceptors
## Purpose
- Interceptors separate cross-cutting concerns from business logic.
- Common use cases include logging, transaction management, security, and performance monitoring.
## Defining Interceptor Bindings
```Java
import jakarta.interceptor.InterceptorBinding;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@InterceptorBinding
@Retention(RUNTIME)
@Target({METHOD, TYPE})
public @interface Logged {
}
```
## Implementing Interceptors
```Java
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import java.util.logging.Logger;

@Logged
@Interceptor
public class LoggingInterceptor {

    private Logger logger = Logger.getLogger(LoggingInterceptor.class.getName());

    @AroundInvoke
    public Object logMethodCall(InvocationContext context) throws Exception {
        String methodName = context.getMethod().getName();
        logger.info("Entering method: " + methodName);

        try {
            return context.proceed();
        } finally {
            logger.info("Exiting method: " + methodName);
        }
    }
}
```
## Applying Interceptors
```Java
@ApplicationScoped
@Logged
public class UserService {

    public User findUser(Long id) {
        // Business logic
        return userRepository.findById(id);
    }
}
```
# Events
## Observer Pattern
- CDI provides a typesafe event notification mechanism.
- Events decouple event producers from event consumers.
## Firing Events
```Java
import jakarta.enterprise.event.Event;
import jakarta.inject.Inject;

@ApplicationScoped
public class OrderService {

    @Inject
    private Event<OrderPlaced> orderPlacedEvent;

    public void placeOrder(Order order) {
        // Process order
        orderPlacedEvent.fire(new OrderPlaced(order));
    }
}
```
## Observing Events
```Java
import jakarta.enterprise.event.Observes;

@ApplicationScoped
public class EmailNotificationService {

    public void sendOrderConfirmation(@Observes OrderPlaced event) {
        Order order = event.getOrder();
        // Send confirmation email
    }
}
```
# Alternatives
- Alternatives provide different implementations that can be selected at deployment time.
- Alternatives are annotated with `Java` `@Alternative`.
```Java
@Alternative
@ApplicationScoped
public class MockPaymentService implements PaymentService {

    @Override
    public boolean processPayment(Payment payment) {
        // Mock implementation for testing
        return true;
    }
}
```
- Alternatives must be enabled in `Java` `beans.xml`.
```XML
<beans xmlns="https://jakarta.ee/xml/ns/jakartaee"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/beans_3_0.xsd"
       version="3.0">
    <alternatives>
        <class>com.example.MockPaymentService</class>
    </alternatives>
</beans>
```
# Integration with Other Technologies
## Comparison with Spring Framework
- CDI and Spring provide similar dependency injection capabilities.
- CDI is a Jakarta EE standard, while Spring is a proprietary framework.
- See [[Bean scope]] for Spring-specific scope management.
- See [[software-engineering/software-architecture/design/design-pattern/enterprise-pattern/integration/Dependency injection pattern]] for the underlying design pattern.
## Framework Support
- CDI is supported by:
	- Jakarta EE application servers (WildFly, GlassFish, Liberty)
	- Microprofile implementations (Quarkus, Helidon)
	- Standalone CDI containers (Weld, OpenWebBeans)
- Spring Boot provides CDI compatibility through bridge libraries but uses its own DI container by default.
***
# References
1. Jakarta EE Tutorial - CDI Basic Concepts
	1. https://jakarta.ee/learn/docs/jakartaee-tutorial/current/cdi/cdi-basic/cdi-basic.html
2. Weld Reference Documentation - Scopes and Contexts
	1. https://docs.jboss.org/weld/reference/2.4.0.Final/en-US/html/scopescontexts.html#_the_conversation_scope
3. CDI Specification
	1. https://jakarta.ee/specifications/cdi/
4. Dependent Scope Lifecycle
	1. https://stackoverflow.com/questions/24822361/when-is-a-dependent-scoped-cdi-bean-destroyed-if-you-obtain-that-bean-via-prov
5. [[software-engineering/software-architecture/design/design-pattern/enterprise-pattern/integration/Dependency injection pattern]]
6. [[Bean scope]]
