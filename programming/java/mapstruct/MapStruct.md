#java #spring #mapstruct #object-mapping #dto #annotation #design-pattern #software-engineering #boilerplate

# Introduction
## What is MapStruct
- ==Code generator== that creates type-safe bean mapping code at ==compile time==.
- Eliminates boilerplate code for converting between DTOs, entities, and domain objects.
- Uses annotation processing $\implies$ ==zero runtime overhead==.
- Superior to reflection-based mappers (ModelMapper, Dozer) in terms of ==performance and type safety==.

## Core Purpose
- ==Automates object mapping== between:
	- Entity $\leftrightarrow$ DTO
	- Domain object $\leftrightarrow$ DTO
	- Request/Response objects $\leftrightarrow$ Domain models
- Generates readable Java code (not reflection or proxies).
- Catches mapping errors at ==compile time== instead of runtime.

## How MapStruct Works
- Annotation processor ==generates implementation== during compilation.
- Reads `@Mapper` interface definitions.
- Generates implementation class with actual mapping code.
- Implementation can be injected via Spring `@Autowired` or CDI `@Inject`.

***
# Installation

## Maven Configuration
```xml
<properties>
    <org.mapstruct.version>1.5.5.Final</org.mapstruct.version>
    <lombok.version>1.18.30</lombok.version>
</properties>

<dependencies>
    <dependency>
        <groupId>org.mapstruct</groupId>
        <artifactId>mapstruct</artifactId>
        <version>${org.mapstruct.version}</version>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.11.0</version>
            <configuration>
                <source>17</source>
                <target>17</target>
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.mapstruct</groupId>
                        <artifactId>mapstruct-processor</artifactId>
                        <version>${org.mapstruct.version}</version>
                    </path>
                    <!-- Lombok integration (if using Lombok) -->
                    <path>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok</artifactId>
                        <version>${lombok.version}</version>
                    </path>
                    <path>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok-mapstruct-binding</artifactId>
                        <version>0.2.0</version>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
```

## Gradle Configuration
```gradle
dependencies {
    implementation 'org.mapstruct:mapstruct:1.5.5.Final'
    annotationProcessor 'org.mapstruct:mapstruct-processor:1.5.5.Final'

    // Lombok integration (if using Lombok)
    compileOnly 'org.projectlombok:lombok:1.18.30'
    annotationProcessor 'org.projectlombok:lombok:1.18.30'
    annotationProcessor 'org.projectlombok:lombok-mapstruct-binding:0.2.0'
}
```

***
# Basic Mapping

## Simple Mapper
```java
import org.mapstruct.Mapper;

@Mapper
public interface UserMapper {
    UserDTO toDTO(User user);
    User toEntity(UserDTO dto);
}
```

```Java title='Domain and DTO classes'
// Entity
@Entity
@Data
public class User {
    private Long id;
    private String username;
    private String email;
    private LocalDateTime createdAt;
}

// DTO
@Data
public class UserDTO {
    private Long id;
    private String username;
    private String email;
    private LocalDateTime createdAt;
}
```

```Java title='Generated implementation'
public class UserMapperImpl implements UserMapper {
    @Override
    public UserDTO toDTO(User user) {
        if (user == null) {
            return null;
        }

        UserDTO userDTO = new UserDTO();
        userDTO.setId(user.getId());
        userDTO.setUsername(user.getUsername());
        userDTO.setEmail(user.getEmail());
        userDTO.setCreatedAt(user.getCreatedAt());

        return userDTO;
    }

    @Override
    public User toEntity(UserDTO dto) {
        if (dto == null) {
            return null;
        }

        User user = new User();
        user.setId(dto.getId());
        user.setUsername(dto.getUsername());
        user.setEmail(dto.getEmail());
        user.setCreatedAt(dto.getCreatedAt());

        return user;
    }
}
```

## Usage
```java
// Get instance
UserMapper mapper = Mappers.getMapper(UserMapper.class);

// Convert entity to DTO
User user = userRepository.findById(1L);
UserDTO dto = mapper.toDTO(user);

// Convert DTO to entity
UserDTO requestDTO = new UserDTO();
User newUser = mapper.toEntity(requestDTO);
```
# Field Mapping
## `@Mapping` - Different Field Names
```java
@Mapper
public interface ProductMapper {
    @Mapping(source = "name", target = "productName")
    @Mapping(source = "price", target = "productPrice")
    ProductDTO toDTO(Product product);
}
```

```java
// Entity
@Data
public class Product {
    private Long id;
    private String name;
    private BigDecimal price;
}

// DTO
@Data
public class ProductDTO {
    private Long id;
    private String productName;
    private BigDecimal productPrice;
}
```
## `@Mapping` with Expressions
```java
@Mapper
public interface OrderMapper {
    @Mapping(target = "totalPrice", expression = "java(order.getQuantity() * order.getUnitPrice())")
    @Mapping(target = "status", constant = "PENDING")
    OrderDTO toDTO(Order order);
}
```
## Ignore Fields
```java
@Mapper
public interface UserMapper {
    @Mapping(target = "password", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    UserDTO toDTO(User user);
}
```
## Default Values
```java
@Mapper
public interface ProductMapper {
    @Mapping(target = "active", defaultValue = "true")
    @Mapping(target = "category", defaultValue = "GENERAL")
    Product toEntity(ProductDTO dto);
}
```
## Nested Mapping
```java
@Mapper
public interface OrderMapper {
    @Mapping(source = "user.id", target = "userId")
    @Mapping(source = "user.username", target = "userName")
    @Mapping(source = "product.name", target = "productName")
    OrderDTO toDTO(Order order);
}
```

```java
@Data
public class Order {
    private Long id;
    private User user;
    private Product product;
    private Integer quantity;
}

@Data
public class OrderDTO {
    private Long id;
    private Long userId;
    private String userName;
    private String productName;
    private Integer quantity;
}
```
# Collection Mapping

## List Mapping
```java
@Mapper
public interface UserMapper {
    UserDTO toDTO(User user);

    List<UserDTO> toDTOList(List<User> users);

    Set<UserDTO> toDTOSet(Set<User> users);
}
```

```java
// Usage
List<User> users = userRepository.findAll();
List<UserDTO> dtos = mapper.toDTOList(users);
```

## Map Mapping
```java
@Mapper
public interface ConfigMapper {
    Map<String, ValueDTO> toValueDTOMap(Map<String, Value> valueMap);
}
```

# Type Conversion

## Built-in Conversions
- MapStruct automatically converts between:
	- Primitive types and wrappers (`int` $\leftrightarrow$ `Integer`)
	- `String` $\leftrightarrow$ primitive types
	- `java.util.Date` $\leftrightarrow$ `java.sql.Date`
	- `String` $\leftrightarrow$ `Enum`
## Date/Time Formatting
```java
@Mapper
public interface EventMapper {
    @Mapping(source = "eventDate", target = "eventDateString", dateFormat = "yyyy-MM-dd HH:mm:ss")
    EventDTO toDTO(Event event);
}
```

```java
@Data
public class Event {
    private String name;
    private Date eventDate;
}

@Data
public class EventDTO {
    private String name;
    private String eventDateString;
}
```

## Number Formatting
```java
@Mapper
public interface PriceMapper {
    @Mapping(source = "price", target = "priceString", numberFormat = "$#.00")
    ProductDTO toDTO(Product product);
}
```

## Custom Type Conversion
```java
@Mapper
public interface UserMapper {
    UserDTO toDTO(User user);

    default String map(FullName fullName) {
        return fullName.getFirstName() + " " + fullName.getLastName();
    }
}
```

```java
@Data
public class User {
    private Long id;
    private FullName fullName;
}

@Data
public class UserDTO {
    private Long id;
    private String fullName;  // Automatically uses custom map() method
}
```
# Spring Integration

## `@Mapper` with Spring
```java
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDTO toDTO(User user);
    User toEntity(UserDTO dto);
}
```

## Dependency Injection
```java
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final UserMapper userMapper;  // Auto-injected by Spring

    public UserDTO getUserById(Long id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new NotFoundException("User not found"));
        return userMapper.toDTO(user);
    }

    public UserDTO createUser(UserDTO dto) {
        User user = userMapper.toEntity(dto);
        User savedUser = userRepository.save(user);
        return userMapper.toDTO(savedUser);
    }
}
```

## Using Other Mappers
```java
@Mapper(componentModel = "spring", uses = {AddressMapper.class, RoleMapper.class})
public interface UserMapper {
    UserDTO toDTO(User user);
}
```

```java
@Data
public class User {
    private Long id;
    private String username;
    private Address address;      // Will use AddressMapper
    private Set<Role> roles;      // Will use RoleMapper
}

@Data
public class UserDTO {
    private Long id;
    private String username;
    private AddressDTO address;
    private Set<RoleDTO> roles;
}
```
# Update Existing Objects

## `@MappingTarget`
```java
@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    void updateUserFromDTO(UserDTO dto, @MappingTarget User user);
}
```

```java
// Usage
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final UserMapper userMapper;

    public UserDTO updateUser(Long id, UserDTO dto) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new NotFoundException("User not found"));

        userMapper.updateUserFromDTO(dto, user);
        User updatedUser = userRepository.save(user);

        return userMapper.toDTO(updatedUser);
    }
}
```
# Mapping Strategies

## `@BeanMapping` - Null Handling
```java
import org.mapstruct.BeanMapping;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateUserFromDTO(UserDTO dto, @MappingTarget User user);
}
```
- `IGNORE`: Skip null values (don't overwrite target field).
- `SET_TO_NULL`: Set target field to null.
- `SET_TO_DEFAULT`: Use default value.

## Collection Mapping Strategy
```java
import org.mapstruct.CollectionMappingStrategy;

@Mapper(
    componentModel = "spring",
    collectionMappingStrategy = CollectionMappingStrategy.ADDER_PREFERRED
)
public interface OrderMapper {
    Order toEntity(OrderDTO dto);
}
```
# Inheritance Mapping

## `@InheritInverseConfiguration`
```java
@Mapper(componentModel = "spring")
public interface CarMapper {
    @Mapping(source = "numberOfSeats", target = "seatCount")
    @Mapping(source = "make", target = "manufacturer")
    CarDTO toDTO(Car car);

    @InheritInverseConfiguration
    Car toEntity(CarDTO dto);
}
```

## `@InheritConfiguration`
```java
@Mapper(componentModel = "spring")
public interface VehicleMapper {
    @Mapping(source = "model", target = "modelName")
    VehicleDTO toDTO(Vehicle vehicle);

    @InheritConfiguration(name = "toDTO")
    @Mapping(target = "additionalInfo", ignore = true)
    DetailedVehicleDTO toDetailedDTO(Vehicle vehicle);
}
```
# Multiple Source Parameters

## Combining Multiple Objects
```java
@Mapper(componentModel = "spring")
public interface OrderMapper {
    @Mapping(source = "user.username", target = "userName")
    @Mapping(source = "product.name", target = "productName")
    @Mapping(source = "orderData.quantity", target = "quantity")
    @Mapping(source = "orderData.discount", target = "discount")
    OrderDTO createOrder(User user, Product product, OrderData orderData);
}
```

```java
// Usage
OrderDTO orderDTO = orderMapper.createOrder(user, product, orderData);
```

# Enum Mapping

## Simple Enum Mapping
```java
@Mapper(componentModel = "spring")
public interface StatusMapper {
    StatusDTO toDTO(Status status);
}
```

```java
public enum Status {
    ACTIVE, INACTIVE, PENDING
}

public enum StatusDTO {
    ACTIVE, INACTIVE, PENDING
}
// Automatically mapped by name
```

## `@ValueMapping` - Different Enum Names
```java
import org.mapstruct.ValueMapping;

@Mapper(componentModel = "spring")
public interface OrderStatusMapper {
    @ValueMapping(source = "PENDING", target = "WAITING")
    @ValueMapping(source = "COMPLETED", target = "DONE")
    @ValueMapping(source = "CANCELLED", target = "CANCELED")
    OrderStatusDTO toDTO(OrderStatus status);
}
```
# Qualifier Annotations

## Custom Qualifier
```java
import org.mapstruct.Qualifier;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Qualifier
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.CLASS)
public @interface ToUpperCase {
}

@Qualifier
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.CLASS)
public @interface ToLowerCase {
}
```

```java
@Mapper(componentModel = "spring")
public interface StringMapper {
    @ToUpperCase
    default String toUpperCase(String value) {
        return value == null ? null : value.toUpperCase();
    }

    @ToLowerCase
    default String toLowerCase(String value) {
        return value == null ? null : value.toLowerCase();
    }
}

@Mapper(componentModel = "spring", uses = StringMapper.class)
public interface UserMapper {
    @Mapping(source = "username", target = "username", qualifiedBy = ToUpperCase.class)
    @Mapping(source = "email", target = "email", qualifiedBy = ToLowerCase.class)
    UserDTO toDTO(User user);
}
```
# Lombok Integration

## MapStruct + Lombok
```java
import lombok.*;
import org.mapstruct.Mapper;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Long id;
    private String username;
    private String email;
}

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    private Long id;
    private String username;
    private String email;
}

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDTO toDTO(User user);
    User toEntity(UserDTO dto);
}
```

**Important:** Ensure `lombok-mapstruct-binding` is in annotation processor path (see [Installation](#Installation)).
# Advanced Features

## `@AfterMapping` - Post-processing
```java
import org.mapstruct.AfterMapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDTO toDTO(User user);

    @AfterMapping
    default void setFullName(@MappingTarget UserDTO dto, User user) {
        dto.setFullName(user.getFirstName() + " " + user.getLastName());
    }
}
```

## `@BeforeMapping` - Pre-processing
```java
import org.mapstruct.BeforeMapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UserMapper {
    User toEntity(UserDTO dto);

    @BeforeMapping
    default void validateDTO(UserDTO dto) {
        if (dto.getEmail() == null) {
            throw new IllegalArgumentException("Email cannot be null");
        }
    }
}
```

## Conditional Mapping
```java
import org.mapstruct.Condition;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDTO toDTO(User user);

    @Condition
    default boolean isNotEmpty(String value) {
        return value != null && !value.isEmpty();
    }
}
```

# Builder Support

## Using Builder Pattern
```java
@Mapper(componentModel = "spring", builder = @Builder(disableBuilder = false))
public interface UserMapper {
    UserDTO toDTO(User user);
}
```

```java
@Data
@Builder
public class UserDTO {
    private Long id;
    private String username;
    private String email;
}
```

```Java title='Generated code uses builder'
public UserDTO toDTO(User user) {
    if (user == null) {
        return null;
    }

    return UserDTO.builder()
        .id(user.getId())
        .username(user.getUsername())
        .email(user.getEmail())
        .build();
}
```
# Configuration

## `mapstruct.properties`
```properties
# Default component model
mapstruct.defaultComponentModel=spring

# Default injection strategy
mapstruct.defaultInjectionStrategy=constructor

# Unmapped target policy
mapstruct.unmappedTargetPolicy=ERROR

# Suppress warnings
mapstruct.suppressGeneratorTimestamp=true
mapstruct.suppressGeneratorVersionComment=true
```

## Global Configuration with `@MapperConfig`
```java
import org.mapstruct.MapperConfig;
import org.mapstruct.ReportingPolicy;

@MapperConfig(
    componentModel = "spring",
    unmappedTargetPolicy = ReportingPolicy.ERROR,
    unmappedSourcePolicy = ReportingPolicy.WARN
)
public interface CentralConfig {
}

@Mapper(config = CentralConfig.class)
public interface UserMapper {
    UserDTO toDTO(User user);
}

@Mapper(config = CentralConfig.class)
public interface ProductMapper {
    ProductDTO toDTO(Product product);
}
```

# Integration with Frameworks

## Quarkus
```java
@Mapper(componentModel = "cdi")
public interface UserMapper {
    UserDTO toDTO(User user);
}
```

```java
@ApplicationScoped
@RequiredArgsConstructor
public class UserService {
    private final UserMapper userMapper;  // CDI injection

    public UserDTO getUser(Long id) {
        User user = findUser(id);
        return userMapper.toDTO(user);
    }
}
```

## Jakarta EE / CDI
```java
import org.mapstruct.Mapper;

@Mapper(componentModel = "cdi")
public interface OrderMapper {
    OrderDTO toDTO(Order order);
}
```

```java
@Stateless
public class OrderService {
    @Inject
    private OrderMapper orderMapper;

    public OrderDTO createOrder(OrderDTO dto) {
        Order order = orderMapper.toEntity(dto);
        entityManager.persist(order);
        return orderMapper.toDTO(order);
    }
}
```
# Debugging
## View Generated Code
```bash
# Maven: Generated classes in target/generated-sources/annotations
ls target/generated-sources/annotations/com/example/mapper/

# Gradle: Generated classes in build/generated/sources/annotationProcessor
ls build/generated/sources/annotationProcessor/java/main/com/example/mapper/
```
## Enable Verbose Logging
```xml
<!-- Maven compiler plugin -->
<configuration>
    <showWarnings>true</showWarnings>
    <compilerArgs>
        <arg>-Amapstruct.verbose=true</arg>
    </compilerArgs>
</configuration>
```

```gradle
// Gradle
tasks.withType(JavaCompile) {
    options.compilerArgs << '-Amapstruct.verbose=true'
}
```

***
# References
1. https://mapstruct.org/ for official MapStruct documentation
2. https://mapstruct.org/documentation/stable/reference/html/ for complete reference guide
3. https://github.com/mapstruct/mapstruct-examples for official examples
4. https://www.baeldung.com/mapstruct for comprehensive tutorial
5. https://mapstruct.org/documentation/spring-extensions/reference/html/ for Spring extensions
6. https://stackoverflow.com/questions/tagged/mapstruct for community support
7.
