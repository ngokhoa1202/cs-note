#java #spring #lombok #java-core #object-oriented-programming #configuration #installation #annotation
#design-pattern #software-engineering 
# Introduction
## What is Lombok
- Project Lombok is a ==Java library== that automatically ==reduces boilerplate code== through annotation processing at compile time.
- Uses annotation processors to ==generate code during compilation==, not runtime $\implies$ no performance overhead.
- Commonly used with Spring Boot, Hibernate, and Jakarta EE applications.
## Core Purpose
- ==Eliminates repetitive code== for:
	- Getters and setters
	- Constructors (no-args, all-args, required-args)
	- `equals()`, `hashCode()`, `toString()` methods
	- Builder patterns
	- Logger instances
	- Resource management (try-with-resources)
## How Lombok Works
- Lombok hooks into the ==Java compilation process== via annotation processors.
- At compile time, Lombok reads annotations and ==generates bytecode== directly into `.class` files.
- Source code remains clean, but compiled `.class` files contain the generated methods.

# Installation
## Maven Configuration
- Add dependency to `pom.xml`:
```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.30</version>
    <scope>provided</scope>
</dependency>
```
## Gradle Configuration
- Add to `build.gradle`:
```gradle
dependencies {
    compileOnly 'org.projectlombok:lombok:1.18.30'
    annotationProcessor 'org.projectlombok:lombok:1.18.30'
}
```
# Core Annotations

## `@Getter` and `@Setter`
- ==Generates getter and setter methods== for class fields.
- Can be applied at ==class level== (all fields) or ==field level== (specific fields).
### Class-level Example
```java
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
    private Long id;
    private String username;
    private String email;
}
```

```Java title='Generated code equivalence'
public class User {
    private Long id;
    private String username;
    private String email;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
```
### Field-level Example
```java
import lombok.Getter;
import lombok.Setter;

public class Account {
    @Getter @Setter
    private String accountNumber;

    @Getter
    private BigDecimal balance;  // Read-only field

    private String internalId;   // No getter/setter
}
```
### Access Level Control
```java
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

public class Employee {
    @Getter @Setter
    private String name;

    @Getter(AccessLevel.PROTECTED)
    @Setter(AccessLevel.PRIVATE)
    private Double salary;
}
```
## `@ToString`
- Generates `toString()` method with ==all non-static fields==.
- Useful for debugging and logging.
### Basic Usage
```java
import lombok.ToString;

@ToString
public class Product {
    private Long id;
    private String name;
    private BigDecimal price;
}

// Usage
Product product = new Product();
System.out.println(product);
// Output: Product(id=1, name=Laptop, price=999.99)
```
### Exclude Fields
```java
import lombok.ToString;

@ToString(exclude = {"password", "secretKey"})
public class User {
    private String username;
    private String password;
    private String secretKey;
    private String email;
}
```
### Include Only Specific Fields
```java
import lombok.ToString;

@ToString(of = {"id", "name"})
public class Product {
    private Long id;
    private String name;
    private String description;
    private BigDecimal price;
}
```
### Include Superclass Fields
```java
import lombok.ToString;

@ToString(callSuper = true)
public class Employee extends Person {
    private String employeeId;
    private String department;
}
```

## `@EqualsAndHashCode`
- Generates `equals()` and `hashCode()` methods based on ==non-static, non-transient fields==.
- Essential for collections (HashMap, HashSet) and JPA entity comparison.
### Basic Usage
```java
import lombok.EqualsAndHashCode;

@EqualsAndHashCode
public class User {
    private Long id;
    private String username;
    private String email;
}
```
### Exclude Fields
```java
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(exclude = {"createdAt", "updatedAt"})
public class Article {
    private Long id;
    private String title;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
```
### Use Specific Fields Only
```java
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = {"id"})
public class Entity {
    private Long id;
    private String name;
    private String description;
}
```
### With Inheritance
```java
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
public class Manager extends Employee {
    private String department;
    private List<Employee> team;
}
```

## `@NoArgsConstructor`, `@RequiredArgsConstructor`, `@AllArgsConstructor`
- Generate constructors with different parameter sets.
### `@NoArgsConstructor`
- Generates ==constructor with no parameters==.
- Required for JPA entities and frameworks that use reflection.

```java
import lombok.NoArgsConstructor;

@NoArgsConstructor
public class Product {
    private Long id;
    private String name;
}

// Generated:
// public Product() {}
```
### `@AllArgsConstructor`
- Generates constructor with ==all fields as parameters==.
```java
import lombok.AllArgsConstructor;

@AllArgsConstructor
public class User {
    private Long id;
    private String username;
    private String email;
}

// Generated:
// public User(Long id, String username, String email) {
//     this.id = id;
//     this.username = username;
//     this.email = email;
// }
```
### `@RequiredArgsConstructor`
- Generates constructor for ==final fields and @NonNull fields only==.

```java
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    @NonNull
    private final EmailService emailService;
    private Logger logger;  // Not included in constructor
}

// Generated:
// public OrderService(OrderRepository orderRepository, EmailService emailService) {
//     this.orderRepository = orderRepository;
//     this.emailService = emailService;
// }
```

### Static Factory Methods
```java
import lombok.AllArgsConstructor;
import lombok.AccessLevel;

@AllArgsConstructor(staticName = "of")
public class Point {
    private int x;
    private int y;
}

// Usage:
Point point = Point.of(10, 20);
```
## `@Data`
- ==Combines multiple annotations== into one: `@Getter`, `@Setter`, `@ToString`, `@EqualsAndHashCode`, `@RequiredArgsConstructor`.
- Most commonly used Lombok annotation for ==simple POJOs and DTOs==.
```java
import lombok.Data;

@Data
public class UserDTO {
    private Long id;
    private String username;
    private String email;
    private LocalDateTime createdAt;
}

// Equivalent to:
// @Getter @Setter @ToString @EqualsAndHashCode @RequiredArgsConstructor
```
### Use Case with JPA Entity
```java
import lombok.Data;
import jakarta.persistence.*;

@Data
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String email;
    private String password;
}
```
## `@Value`
- Creates ==immutable classes== $\equiv$ final class with final fields.
- Generates: `@Getter`, `@AllArgsConstructor`, `@ToString`, `@EqualsAndHashCode`.
- No setters generated $\implies$ all fields are ==read-only==.
```java
import lombok.Value;

@Value
public class Coordinate {
    double latitude;
    double longitude;
}

// Equivalent to:
// public final class Coordinate {
//     private final double latitude;
//     private final double longitude;
//
//     public Coordinate(double latitude, double longitude) {
//         this.latitude = latitude;
//         this.longitude = longitude;
//     }
//
//     public double getLatitude() { return latitude; }
//     public double getLongitude() { return longitude; }
//     // + toString(), equals(), hashCode()
// }
```
### Mutable Fields in `@Value`
```java
import lombok.Value;
import lombok.experimental.NonFinal;

@Value
public class Configuration {
    String environment;

    @NonFinal
    int retryCount;  // Mutable field
}
```
## `@Builder`
- Implements the ==Builder design pattern== for object construction.
- Provides ==fluent API== for creating objects with many optional parameters.
- Commonly combined with `@AllArgsConstructor` or used standalone.
### Basic Usage
```java
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class User {
    private Long id;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private LocalDateTime createdAt;
}

// Usage:
User user = User.builder()
    .id(1L)
    .username("john_doe")
    .email("john@example.com")
    .firstName("John")
    .lastName("Doe")
    .createdAt(LocalDateTime.now())
    .build();
```

### `@Builder` with `@AllArgsConstructor`
```java
import lombok.*;

@Getter
@Builder
@AllArgsConstructor
public class Product {
    private Long id;
    private String name;
    private BigDecimal price;
    private String category;
}
```
### Default Values
```java
import lombok.Builder;

@Builder
public class SearchCriteria {
    @Builder.Default
    private int page = 0;

    @Builder.Default
    private int size = 10;

    @Builder.Default
    private String sortBy = "createdAt";

    private String keyword;
}

// Usage:
SearchCriteria criteria = SearchCriteria.builder()
    .keyword("laptop")
    .build();
// page=0, size=10, sortBy="createdAt" (defaults applied)
```
### `{Java}@Singular` for Collections
```java
import lombok.Builder;
import lombok.Singular;
import java.util.List;
import java.util.Set;

@Builder
public class Course {
    private String name;

    @Singular
    private List<String> topics;

    @Singular
    private Set<String> prerequisites;
}

// Usage:
Course course = Course.builder()
    .name("Spring Boot Advanced")
    .topic("Dependency Injection")
    .topic("AOP")
    .topic("Security")
    .prerequisite("Java 8+")
    .prerequisite("Maven")
    .build();
```
### Custom Builder Method Name
```java
import lombok.Builder;

@Builder(builderMethodName = "create")
public class Report {
    private String title;
    private String content;
}

// Usage:
Report report = Report.create()
    .title("Monthly Report")
    .content("...")
    .build();
```
### `{Java}@Builder` on Methods
```java
import lombok.Builder;

public class UserFactory {
    @Builder(builderMethodName = "createUser")
    public static User newUser(String username, String email, String role) {
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setRole(role);
        user.setCreatedAt(LocalDateTime.now());
        return user;
    }
}

// Usage:
User user = UserFactory.createUser()
    .username("alice")
    .email("alice@example.com")
    .role("ADMIN")
    .build();
```
## `{Java}@Slf4j` (and Logger Variants)
- Automatically ==creates a logger instance== for the class.
- Supports multiple logging frameworks: `@Slf4j`, `@Log4j`, `@Log4j2`, `@CommonsLog`, `@Log`, `@Flogger`.
### `@Slf4j` Usage
```java
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UserService {
    public void createUser(User user) {
        log.info("Creating user: {}", user.getUsername());
        try {
            // Business logic
            log.debug("User {} created successfully", user.getId());
        } catch (Exception e) {
            log.error("Error creating user", e);
        }
    }
}

// Equivalent to:
// private static final org.slf4j.Logger log =
//     org.slf4j.LoggerFactory.getLogger(UserService.class);
```
### Custom Logger Topic
```java
import lombok.extern.slf4j.Slf4j;

@Slf4j(topic = "custom.logger.name")
public class PaymentService {
    public void processPayment() {
        log.info("Processing payment");
    }
}
```
## `@NonNull`
- Generates ==null-check validation== for method parameters and fields.
- Throws `NullPointerException` if null value is provided.
### Method Parameter Validation
```java
import lombok.NonNull;

public class OrderService {
    public void createOrder(@NonNull User user, @NonNull Product product) {
        // Automatically checks if user or product is null
        // Throws NullPointerException with message if null
    }
}

// Generated:
// public void createOrder(User user, Product product) {
//     if (user == null) {
//         throw new NullPointerException("user is marked non-null but is null");
//     }
//     if (product == null) {
//         throw new NullPointerException("product is marked non-null but is null");
//     }
//     // Original method body
// }
```
### Constructor Validation
```java
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class EmailService {
    @NonNull
    private final EmailRepository emailRepository;

    @NonNull
    private final TemplateEngine templateEngine;
}
```
## `@SneakyThrows`
- ==Throws checked exceptions== without declaring them in method signature.
- Useful for avoiding verbose try-catch blocks (use with caution).

```java
import lombok.SneakyThrows;

public class FileProcessor {
    @SneakyThrows
    public String readFile(String path) {
        // No need to declare "throws IOException"
        return Files.readString(Paths.get(path));
    }
}

// Equivalent to:
// public String readFile(String path) {
//     try {
//         return Files.readString(Paths.get(path));
//     } catch (IOException e) {
//         throw new RuntimeException(e);
//     }
// }
```
## `@Cleanup`
- Automatically calls `close()` method on resources.
- Alternative to try-with-resources for ==automatic resource management==.

```java
import lombok.Cleanup;
import java.io.*;

public class FileService {
    public void processFile(String path) throws IOException {
        @Cleanup InputStream in = new FileInputStream(path);
        @Cleanup OutputStream out = new FileOutputStream("output.txt");

        // File operations
        // in.close() and out.close() automatically called
    }
}
```
## `@With`
- Creates ==immutable object with modified field== (wither methods).
- Returns new instance with one field changed, original remains unchanged.

```java
import lombok.Value;
import lombok.With;

@Value
@With
public class User {
    Long id;
    String username;
    String email;
}

// Usage:
User user1 = new User(1L, "john", "john@example.com");
User user2 = user1.withEmail("newemail@example.com");

// user1: id=1, username=john, email=john@example.com
// user2: id=1, username=john, email=newemail@example.com
```

***
# Advanced Features

## @FieldDefaults
- Sets ==default access level== for all fields in a class.
- Reduces visual noise by eliminating repetitive `private` keywords.

```java
import lombok.experimental.FieldDefaults;
import lombok.AccessLevel;

@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class Configuration {
    String apiKey;
    String apiSecret;
    int timeout;
}

// Equivalent to:
// public class Configuration {
//     private final String apiKey;
//     private final String apiSecret;
//     private final int timeout;
// }
```

## @Accessors
- Customizes ==getter/setter method naming conventions==.
- Supports fluent API and field prefix removal.
### Fluent Accessors
```java
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(fluent = true)
public class User {
    private String username;
    private String email;
}

// Usage:
User user = new User();
user.username("john")
    .email("john@example.com");

String name = user.username();  // No "get" prefix
```
### Chain Setters
```java
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class Product {
    private String name;
    private BigDecimal price;
}

// Usage:
Product product = new Product()
    .setName("Laptop")
    .setPrice(new BigDecimal("999.99"));
```
### Prefix Removal
```java
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(prefix = "m")
public class LegacyClass {
    private String mName;
    private int mAge;
}

// Generates: getName(), setName() instead of getMName(), setMName()
```

## @SuperBuilder
- ==Builder pattern for inheritance hierarchies==.
- Extends `@Builder` to support superclass fields.

```java
import lombok.Getter;
import lombok.experimental.SuperBuilder;

@Getter
@SuperBuilder
public class Person {
    private String firstName;
    private String lastName;
}

@Getter
@SuperBuilder
public class Employee extends Person {
    private String employeeId;
    private String department;
}

// Usage:
Employee employee = Employee.builder()
    .firstName("John")       // From Person
    .lastName("Doe")         // From Person
    .employeeId("EMP001")    // From Employee
    .department("IT")        // From Employee
    .build();
```

## @UtilityClass
- Creates ==utility class== with private constructor and static methods only.

```java
import lombok.experimental.UtilityClass;

@UtilityClass
public class StringUtils {
    public String capitalize(String input) {
        if (input == null || input.isEmpty()) return input;
        return input.substring(0, 1).toUpperCase() + input.substring(1);
    }

    public boolean isBlank(String input) {
        return input == null || input.trim().isEmpty();
    }
}

// Equivalent to:
// public final class StringUtils {
//     private StringUtils() {
//         throw new UnsupportedOperationException("Utility class");
//     }
//
//     public static String capitalize(String input) { ... }
//     public static boolean isBlank(String input) { ... }
// }
```
# Integration with Frameworks
## Spring Boot
```java
import lombok.*;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {
    private final UserRepository userRepository;
    private final EmailService emailService;

    public User createUser(UserDTO dto) {
        log.info("Creating user: {}", dto.getUsername());

        User user = User.builder()
            .username(dto.getUsername())
            .email(dto.getEmail())
            .build();

        return userRepository.save(user);
    }
}
```
## JPA Entity 
```java
import lombok.*;
import jakarta.persistence.*;

@Entity
@Table(name = "products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString(exclude = {"category"})
@EqualsAndHashCode(of = {"id"})
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(precision = 10, scale = 2)
    private BigDecimal price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;
}
```
## Hibernate Integration
```java
import lombok.*;
import jakarta.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<OrderItem> items = new ArrayList<>();
}
```
## Delombok
```Shell
# Maven
mvn lombok:delombok

# Gradle
./gradlew delombok
```
# Configuration
## `lombok.config`
- Project-wide ==Lombok configuration file==.
- Place in project root directory.

```properties
# lombok.config

# Global settings
lombok.addLombokGeneratedAnnotation = true
lombok.anyConstructor.addConstructorProperties = true

# Field defaults
lombok.fieldDefaults.defaultPrivate = true
lombok.fieldDefaults.defaultFinal = false

# Accessors
lombok.accessors.chain = false
lombok.accessors.fluent = false

# Log
lombok.log.fieldName = logger
lombok.log.fieldIsStatic = true

# Builder
lombok.builder.className = Builder
lombok.singular.auto = true

# ToString
lombok.toString.includeFieldNames = true
lombok.toString.doNotUseGetters = false

# EqualsAndHashCode
lombok.equalsAndHashCode.doNotUseGetters = false
lombok.equalsAndHashCode.callSuper = ignore
```

## Directory-specific Configuration
```properties
# src/main/java/com/example/dto/lombok.config
lombok.data.flagUsage = warning
lombok.value.flagUsage = error

# src/main/java/com/example/entity/lombok.config
lombok.toString.callSuper = call
lombok.equalsAndHashCode.callSuper = call
```

***
# References
1. https://projectlombok.org/ for official Lombok documentation
2. https://projectlombok.org/features/Builder for Builder pattern annotation
3. https://projectlombok.org/features/Data for @Data annotation
4. https://www.baeldung.com/intro-to-project-lombok for comprehensive Lombok tutorial
5. https://projectlombok.org/setup/maven for Maven setup instructions
6. https://projectlombok.org/setup/gradle for Gradle configuration
7. https://thorben-janssen.com/lombok-hibernate-how-to-avoid-common-pitfalls/ for Lombok with Hibernate best practices
8. https://projectlombok.org/features/configuration for lombok.config reference
9. https://stackoverflow.com/questions/tagged/lombok for community troubleshooting
10.
