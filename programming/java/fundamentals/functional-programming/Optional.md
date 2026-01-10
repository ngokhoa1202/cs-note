#java #java8 #functional-programming #null-safety
# Optional
==Optional== is a container object introduced in Java 8 that may or may not contain a non-null value. It's designed to reduce ==NullPointerException== and make null handling more explicit and functional.
# Purpose and Benefits

## The Problem with null
```Java title='Traditional null handling problems'
// Traditional approach - prone to NPE
public String getUserCity(User user) {
    return user.getAddress().getCity();  // NPE if user or address is null
}

// Defensive null checking - verbose and error-prone
public String getUserCity(User user) {
    if (user != null) {
        Address address = user.getAddress();
        if (address != null) {
            return address.getCity();
        }
    }
    return "Unknown";
}
```

## Optional Solution
```Java title='Optional approach'
public Optional<String> getUserCity(User user) {
    return Optional.ofNullable(user)
        .map(User::getAddress)
        .map(Address::getCity);
}

// Usage
String city = getUserCity(user).orElse("Unknown");
```

# Creating Optional

## of()
Creates Optional with ==non-null== value. Throws NullPointerException if value is null.

```Java title='Optional.of() - for non-null values'
// Valid usage
Optional<String> optional = Optional.of("Hello");
System.out.println(optional.get());  // "Hello"

// Throws NullPointerException
String nullValue = null;
// Optional<String> invalid = Optional.of(nullValue);  // NPE at creation
```

## ofNullable()
Creates Optional that ==may contain null==. Safe for potentially null values.

```Java title='Optional.ofNullable() - for potentially null values'
// Safe with non-null
String value = "Hello";
Optional<String> optional1 = Optional.ofNullable(value);
System.out.println(optional1.isPresent());  // true

// Safe with null
String nullValue = null;
Optional<String> optional2 = Optional.ofNullable(nullValue);
System.out.println(optional2.isPresent());  // false
System.out.println(optional2.isEmpty());     // true (Java 11+)

// Common pattern
public Optional<User> findUserById(String id) {
    User user = database.find(id);  // May return null
    return Optional.ofNullable(user);
}
```

## empty()
Creates an ==empty== Optional.

```Java title='Optional.empty()'
Optional<String> empty = Optional.empty();
System.out.println(empty.isPresent());  // false

// Used in repository pattern
public Optional<User> findUserByEmail(String email) {
    if (!isValidEmail(email)) {
        return Optional.empty();  // No user for invalid email
    }
    // Search logic
    return Optional.ofNullable(database.find(email));
}
```

# Checking for Value

## isPresent()
Returns ==true== if value is present.

```Java title='isPresent() check'
Optional<String> optional = Optional.of("Hello");

if (optional.isPresent()) {
    System.out.println("Value: " + optional.get());
} else {
    System.out.println("No value");
}

// Anti-pattern: defeats purpose of Optional
if (optional.isPresent()) {
    String value = optional.get();  // BAD: use ifPresent() or orElse() instead
}
```

## isEmpty() (Java 11+)
Returns ==true== if value is absent.

```Java title='isEmpty() check'
Optional<String> empty = Optional.empty();

if (empty.isEmpty()) {
    System.out.println("No value present");
}

// More readable than !isPresent()
if (!optional.isPresent()) { }  // Before Java 11
if (optional.isEmpty()) { }     // Java 11+
```

# Retrieving Value

## get()
Returns value if present, otherwise throws ==NoSuchElementException==. Use with caution.

```Java title='get() - use carefully'
Optional<String> optional = Optional.of("Hello");
String value = optional.get();  // "Hello"

Optional<String> empty = Optional.empty();
// String invalid = empty.get();  // NoSuchElementException

// Safe usage: only after isPresent() check
if (optional.isPresent()) {
    String safeValue = optional.get();  // But prefer orElse(), orElseGet()
}
```

## orElse()
Returns value if present, otherwise returns ==default value==.

```Java title='orElse() for default values'
Optional<String> optional = Optional.of("Hello");
String value1 = optional.orElse("Default");  // "Hello"

Optional<String> empty = Optional.empty();
String value2 = empty.orElse("Default");     // "Default"

// Practical usage
public String getUserName(String userId) {
    return findUserById(userId)
        .map(User::getName)
        .orElse("Guest");
}

// Note: default value is ALWAYS evaluated
String result = optional.orElse(expensiveOperation());  // Called even if present
```

## orElseGet()
Returns value if present, otherwise invokes ==supplier== and returns result.

```Java title='orElseGet() with lazy evaluation'
Optional<String> optional = Optional.of("Hello");
String value1 = optional.orElseGet(() -> "Default");  // "Hello"

Optional<String> empty = Optional.empty();
String value2 = empty.orElseGet(() -> "Default");     // "Default"

// Advantage: supplier is only invoked if Optional is empty
String result = optional.orElseGet(() -> expensiveOperation());  // NOT called

// Use case: expensive default value computation
public User getUser(String id) {
    return findUserById(id)
        .orElseGet(() -> {
            logger.info("User not found, creating default");
            return createDefaultUser();
        });
}
```

## orElseThrow()
Returns value if present, otherwise ==throws exception==.

```Java title='orElseThrow() for validation'
Optional<String> optional = Optional.of("Hello");
String value = optional.orElseThrow();  // "Hello" (Java 10+)

Optional<String> empty = Optional.empty();
// String invalid = empty.orElseThrow();  // NoSuchElementException

// With custom exception
public User getUserById(String id) {
    return findUserById(id)
        .orElseThrow(() -> new UserNotFoundException("User not found: " + id));
}

// Java 8 style
value = optional.orElseThrow(() -> new IllegalStateException("No value"));

// Java 10+ without supplier
value = optional.orElseThrow();  // Throws NoSuchElementException
```

# Functional Operations

## ifPresent()
Performs ==action== if value is present.

```Java title='ifPresent() for conditional execution'
Optional<String> optional = Optional.of("Hello");

// Execute action if present
optional.ifPresent(value -> System.out.println("Value: " + value));

// Method reference
optional.ifPresent(System.out::println);

// Empty Optional - nothing happens
Optional.empty().ifPresent(System.out::println);  // No output

// Practical example
findUserById(userId)
    .ifPresent(user -> {
        user.setLastLogin(LocalDateTime.now());
        repository.save(user);
    });

// Anti-pattern: don't use with get()
if (optional.isPresent()) {
    String value = optional.get();  // BAD
}
// Use instead:
optional.ifPresent(value -> { /* use value */ });  // GOOD
```

## ifPresentOrElse() (Java 9+)
Performs ==action== if present, otherwise performs ==empty action==.

```Java title='ifPresentOrElse() for both cases'
Optional<String> optional = Optional.of("Hello");

optional.ifPresentOrElse(
    value -> System.out.println("Value: " + value),
    () -> System.out.println("No value")
);

// Practical usage
findUserById(userId).ifPresentOrElse(
    user -> sendWelcomeEmail(user),
    () -> logger.warn("User not found: " + userId)
);
```

## map()
Transforms value if present using ==function==.

```Java title='map() for transformation'
Optional<String> optional = Optional.of("Hello");

// Transform to uppercase
Optional<String> upper = optional.map(String::toUpperCase);
System.out.println(upper.orElse(""));  // "HELLO"

// Chain multiple transformations
Optional<Integer> length = optional
    .map(String::toUpperCase)
    .map(String::length);
System.out.println(length.orElse(0));  // 5

// Practical: extract nested property
class User {
    String name;
    Address address;
    // getters
}

class Address {
    String city;
    String zipCode;
    // getters
}

Optional<User> userOpt = findUserById("123");

// Extract city
Optional<String> city = userOpt
    .map(User::getAddress)  // Returns Address or null
    .map(Address::getCity); // Returns String or null

String cityName = city.orElse("Unknown");
```

## flatMap()
Transforms value and ==flattens== the result (avoids Optional<Optional<T>>).

```Java title='flatMap() for nested Optionals'
class User {
    String name;
    Optional<Address> address;  // Already Optional

    Optional<Address> getAddress() {
        return address;
    }
}

Optional<User> userOpt = findUserById("123");

// Wrong: Returns Optional<Optional<String>>
// Optional<Optional<String>> wrong = userOpt.map(User::getAddress);

// Correct: flatMap flattens to Optional<String>
Optional<String> city = userOpt
    .flatMap(User::getAddress)  // Flattens Optional<Optional<Address>>
    .map(Address::getCity);

System.out.println(city.orElse("Unknown"));

// Another example
public Optional<Order> findOrderByUser(String userId) {
    return findUserById(userId)
        .flatMap(user -> findOrderByUserId(user.getId()));
}

Optional<Order> findOrderByUserId(String userId) {
    // returns Optional<Order>
    return Optional.ofNullable(database.findOrder(userId));
}
```

## filter()
Filters value based on ==predicate==.

```Java title='filter() for conditional logic'
Optional<String> optional = Optional.of("Hello");

// Filter keeps value if predicate matches
Optional<String> filtered = optional.filter(s -> s.length() > 3);
System.out.println(filtered.isPresent());  // true

Optional<String> filtered2 = optional.filter(s -> s.length() > 10);
System.out.println(filtered2.isPresent());  // false

// Practical: validation
public Optional<User> findAdultUser(String userId) {
    return findUserById(userId)
        .filter(user -> user.getAge() >= 18);
}

// Chain filters
Optional<User> validUser = findUserById(userId)
    .filter(user -> user.getAge() >= 18)
    .filter(user -> user.isActive())
    .filter(user -> user.hasRole("USER"));

// Use filtered value
validUser.ifPresent(user -> grantAccess(user));
```

## or() (Java 9+)
Returns Optional if present, otherwise returns ==alternative Optional== from supplier.

```Java title='or() for fallback Optional'
Optional<String> optional = Optional.empty();

// Fallback to another Optional
Optional<String> result = optional.or(() -> Optional.of("Fallback"));
System.out.println(result.get());  // "Fallback"

// Practical: try multiple sources
public Optional<User> findUser(String email) {
    return findUserInCache(email)
        .or(() -> findUserInDatabase(email))
        .or(() -> findUserInBackupDatabase(email));
}

// Compare with orElse/orElseGet (returns value, not Optional)
String value1 = optional.orElse("Fallback");  // Returns String
Optional<String> value2 = optional.or(() -> Optional.of("Fallback"));  // Returns Optional
```

# Stream Integration

## stream() (Java 9+)
Converts Optional to ==Stream==.

```Java title='Optional to Stream'
Optional<String> optional = Optional.of("Hello");

// Convert to stream
Stream<String> stream = optional.stream();
stream.forEach(System.out::println);  // "Hello"

// Empty Optional creates empty stream
Optional<String> empty = Optional.empty();
Stream<String> emptyStream = empty.stream();
long count = emptyStream.count();  // 0

// Practical: flatten list of Optionals
List<Optional<String>> optionals = Arrays.asList(
    Optional.of("A"),
    Optional.empty(),
    Optional.of("B"),
    Optional.empty(),
    Optional.of("C")
);

List<String> values = optionals.stream()
    .flatMap(Optional::stream)  // Filters out empties
    .collect(Collectors.toList());
System.out.println(values);  // [A, B, C]

// Filtering with Optionals
List<String> userIds = Arrays.asList("1", "2", "3", "invalid", "4");

List<User> users = userIds.stream()
    .map(this::findUserById)      // Stream<Optional<User>>
    .flatMap(Optional::stream)    // Stream<User> (empties filtered)
    .collect(Collectors.toList());
```

# Practical Examples

## Repository Pattern
```Java title='Optional in repository layer'
public interface UserRepository {
    Optional<User> findById(String id);
    Optional<User> findByEmail(String email);
    Optional<User> findByUsername(String username);
}

public class UserService {
    private UserRepository repository;

    public User getUser(String id) {
        return repository.findById(id)
            .orElseThrow(() -> new UserNotFoundException("User not found: " + id));
    }

    public Optional<User> findUserByEmailOrUsername(String emailOrUsername) {
        return repository.findByEmail(emailOrUsername)
            .or(() -> repository.findByUsername(emailOrUsername));
    }

    public boolean isEmailTaken(String email) {
        return repository.findByEmail(email).isPresent();
    }

    public void updateUserEmail(String userId, String newEmail) {
        repository.findById(userId)
            .filter(user -> !newEmail.equals(user.getEmail()))
            .ifPresent(user -> {
                user.setEmail(newEmail);
                repository.save(user);
            });
    }
}
```

## Configuration Properties
```Java title='Optional for configuration'
public class Configuration {
    private Properties properties;

    public Optional<String> getProperty(String key) {
        return Optional.ofNullable(properties.getProperty(key));
    }

    public int getIntProperty(String key, int defaultValue) {
        return getProperty(key)
            .map(Integer::parseInt)
            .orElse(defaultValue);
    }

    public <T> Optional<T> getPropertyAs(String key, Function<String, T> converter) {
        return getProperty(key)
            .map(converter);
    }
}

// Usage
Configuration config = new Configuration();

String dbHost = config.getProperty("db.host").orElse("localhost");
int dbPort = config.getIntProperty("db.port", 5432);

Optional<Duration> timeout = config.getPropertyAs("timeout", Duration::parse);
timeout.ifPresent(t -> System.out.println("Timeout: " + t));
```

## Nested Property Access
```Java title='Safely accessing nested properties'
class Order {
    private Customer customer;
    Customer getCustomer() { return customer; }
}

class Customer {
    private Address address;
    Address getAddress() { return address; }
}

class Address {
    private String city;
    String getCity() { return city; }
}

// Traditional approach - verbose
public String getOrderCity(Order order) {
    if (order != null) {
        Customer customer = order.getCustomer();
        if (customer != null) {
            Address address = customer.getAddress();
            if (address != null) {
                return address.getCity();
            }
        }
    }
    return "Unknown";
}

// With Optional - clean chain
public String getOrderCity(Order order) {
    return Optional.ofNullable(order)
        .map(Order::getCustomer)
        .map(Customer::getAddress)
        .map(Address::getCity)
        .orElse("Unknown");
}
```

## Combining Multiple Optionals
```Java title='Working with multiple Optionals'
public class UserProfile {
    public Optional<String> buildProfile(String userId) {
        Optional<User> user = findUserById(userId);
        Optional<Preferences> prefs = findPreferences(userId);
        Optional<Settings> settings = findSettings(userId);

        // All must be present
        if (user.isPresent() && prefs.isPresent() && settings.isPresent()) {
            return Optional.of(createProfile(
                user.get(),
                prefs.get(),
                settings.get()
            ));
        }
        return Optional.empty();
    }

    // Better: using map and flatMap
    public Optional<String> buildProfileFunctional(String userId) {
        return findUserById(userId)
            .flatMap(user -> findPreferences(userId)
                .flatMap(prefs -> findSettings(userId)
                    .map(settings -> createProfile(user, prefs, settings))));
    }
}
```

## Optional in Method Parameters

```Java title='Optional method parameters (generally avoided)'
// ANTI-PATTERN: Optional as parameter
public void updateUser(Optional<User> user) {  // BAD
    user.ifPresent(u -> repository.save(u));
}

// BETTER: Overload or use null check
public void updateUser(User user) {
    if (user != null) {
        repository.save(user);
    }
}

// Optional is designed for RETURN types, not parameters
```

# Common Pitfalls

## Using get() Without Check
```Java title='Avoid unsafe get()'
// BAD: No guarantee value is present
Optional<String> optional = findValue();
String value = optional.get();  // May throw NoSuchElementException

// GOOD: Use orElse, orElseGet, or orElseThrow
String value = optional.orElse("default");
String value = optional.orElseGet(() -> computeDefault());
String value = optional.orElseThrow(() -> new CustomException());
```

## Optional as Field
```Java title='Avoid Optional as class field'
// BAD: Optional is not Serializable
public class User implements Serializable {
    private Optional<String> middleName;  // BAD
}

// GOOD: Use nullable field
public class User implements Serializable {
    private String middleName;  // Can be null

    public Optional<String> getMiddleName() {
        return Optional.ofNullable(middleName);
    }
}
```

## Overusing isPresent() and get()
```Java title='Avoid imperative style'
// BAD: Defeats purpose of Optional
Optional<User> userOpt = findUser(id);
if (userOpt.isPresent()) {
    User user = userOpt.get();
    sendEmail(user.getEmail());
}

// GOOD: Use functional approach
findUser(id)
    .map(User::getEmail)
    .ifPresent(this::sendEmail);

// Or with explicit check
findUser(id).ifPresent(user -> sendEmail(user.getEmail()));
```

## Creating Unnecessary Optionals
```Java title='Avoid wrapper clutter'
// BAD: Wrapping and immediately unwrapping
public String getUsername(User user) {
    return Optional.ofNullable(user)
        .map(User::getName)
        .orElse("Guest");
}

// BETTER: Simple null check for single property
public String getUsername(User user) {
    return user != null ? user.getName() : "Guest";
}

// Optional shines with CHAINS
public String getUserCity(User user) {
    return Optional.ofNullable(user)
        .map(User::getAddress)        // Chain multiple
        .map(Address::getCity)        // potentially null
        .orElse("Unknown");           // properties
}
```

## Using orElse with Expensive Operations
```Java title='Prefer orElseGet for expensive defaults'
// BAD: Always evaluates expensive operation
String value = optional.orElse(expensiveComputation());

// GOOD: Only evaluates if empty
String value = optional.orElseGet(() -> expensiveComputation());

// Example
User user = findUser(id).orElse(createNewUser());  // BAD: Always creates
User user = findUser(id).orElseGet(this::createNewUser);  // GOOD: Lazy
```

# Best Practices

## Use Optional as Return Type
```Java title='Optional for potentially absent results'
// Good: Clearly indicates result may be absent
public Optional<User> findUserByEmail(String email) {
    User user = database.query(email);
    return Optional.ofNullable(user);
}

// Caller knows to handle absence
Optional<User> userOpt = findUserByEmail("test@example.com");
userOpt.ifPresentOrElse(
    user -> System.out.println("Found: " + user),
    () -> System.out.println("Not found")
);
```

## Prefer Functional Methods
```Java title='Functional over imperative'
// Instead of isPresent() + get()
if (optional.isPresent()) {
    process(optional.get());
}

// Use ifPresent()
optional.ifPresent(this::process);

// Instead of isPresent() check for default
String value = optional.isPresent() ? optional.get() : "default";

// Use orElse()
String value = optional.orElse("default");
```

## Chain Operations
```Java title='Leverage Optional chaining'
// Chain transformations and filters
String result = findUserById(userId)
    .filter(user -> user.isActive())
    .map(User::getProfile)
    .map(Profile::getDisplayName)
    .map(String::toUpperCase)
    .orElse("GUEST");
```

## Avoid Optional<Collection>
```Java title='Return empty collection instead'
// BAD: Optional of collection
public Optional<List<String>> getUserRoles(String userId) {
    List<String> roles = findRoles(userId);
    return Optional.ofNullable(roles);
}

// GOOD: Return empty collection
public List<String> getUserRoles(String userId) {
    List<String> roles = findRoles(userId);
    return roles != null ? roles : Collections.emptyList();
}
```

***
# References
1. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 55: Return optionals judiciously
2. Java 8 in Action - Raoul-Gabriel Urma, Mario Fusco, Alan Mycroft
   1. Chapter 10: Using Optional as a better alternative to null
3. https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html for Optional documentation
4. https://www.oracle.com/technical-resources/articles/java/java8-optional.html for Oracle's Optional guide
