#design-pattern #object-oriented-programming #solid #software-engineering #creational-pattern #operating-system #parallel-programming #software-architecture
# Intent

Ensure a class has ==only one instance== and provide a ==global point of access== to it.

# Applicability

Use the Singleton pattern when:

- There must be ==exactly one instance== of a class, and it must be accessible to clients from a well-known access point
- The sole instance should be ==extensible by subclassing==, and clients should be able to use an extended instance without modifying their code
- You need to control access to shared resources (database connections, file systems, configuration)

# Structure

![](Pasted%20image%2020240606094529.png)

## Participants

### Singleton
- Defines an `getInstance()` operation that lets clients access its unique instance
- May be responsible for creating its own unique instance

### Client
- Accesses a Singleton instance solely through Singleton's `getInstance()` method

# Collaborations

Clients access a Singleton instance through its static `getInstance()` method.

# Consequences

## Controlled access to sole instance

The Singleton class encapsulates its sole instance, so it has strict control over how and when clients access it.

## Reduced namespace pollution

The Singleton pattern avoids polluting the namespace with global variables that store sole instances. This is better than using global variables because the Singleton pattern makes the system more modular.

## Permits refinement of operations and representation

The Singleton class may be ==subclassed==, and it's easy to configure an application with an instance of this extended class. You can configure the application with an instance of the class you need at run time.

## Permits a variable number of instances

The pattern makes it easy to change your mind and allow more than one instance of the Singleton class. Moreover, you can use the same approach to control the number of instances that the application uses.

## Violates Single Responsibility Principle

The Singleton pattern solves two problems at once: ensuring a single instance and providing global access. This violates the [Single responsibility principle](../../../principles/SOLID.md#Single%20responsibility%20principle) because the class has more than one reason to change.

## Difficult to test

Singletons make it hard to write unit tests because they introduce global state into an application. It's difficult to mock a Singleton instance for testing, and tests may interfere with each other due to shared state.

# Implementation

## Variants

### Eager initialization

The instance is created when the class is loaded. Simple but wastes resources if the instance is never used.

```java
public class Singleton {
    private static final Singleton INSTANCE = new Singleton();

    private Singleton() {}

    public static Singleton getInstance() {
        return INSTANCE;
    }
}
```

**Consequences:**
- Thread-safe without synchronization
- Instance created even if never used
- Simple implementation
- Cannot handle exceptions during construction

### Lazy initialization with synchronized method

Instance created when first requested. Thread-safe but synchronization overhead on every access.

```java
public class Singleton {
    private static Singleton instance;

    private Singleton() {}

    public static synchronized Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }
}
```

**Consequences:**
- Thread-safe
- Poor performance due to synchronization on every call
- Instance created only when needed
- Simple to understand

### Double-checked locking

Reduces synchronization overhead by checking if instance exists before acquiring lock.

```java
public class Singleton {
    private static volatile Singleton instance;

    private Singleton() {}

    public static Singleton getInstance() {
        if (instance == null) {
            synchronized (Singleton.class) {
                if (instance == null) {
                    instance = new Singleton();
                }
            }
        }
        return instance;
    }
}
```

**Consequences:**
- Thread-safe with better performance
- Requires `volatile` keyword (Java 5+) for correctness
- Complex and error-prone
- Good for high-concurrency scenarios

### Bill Pugh Singleton (Initialization-on-demand holder)

Uses static inner class to achieve lazy initialization without synchronization. The JVM guarantees that the inner class is loaded only when referenced.

```java
public class Singleton {
    private Singleton() {}

    private static class SingletonHolder {
        private static final Singleton INSTANCE = new Singleton();
    }

    public static Singleton getInstance() {
        return SingletonHolder.INSTANCE;
    }
}
```

**Consequences:**
- Thread-safe without synchronization
- Lazy initialization
- Simple and elegant
- Recommended approach for most cases
- JVM handles initialization guarantees

### Enum Singleton

Using Java enums provides serialization and thread-safety guarantees.

```java
public enum Singleton {
    INSTANCE;

    public void doSomething() {
        // Business logic
    }
}
```

**Consequences:**
- Thread-safe and serialization-safe by default
- Prevents reflection attacks
- Cannot be lazily initialized
- Most concise implementation
- Recommended by Joshua Bloch in Effective Java

# Sample Code

## Configuration Manager Example

```java
public class ConfigurationManager {
    private final Properties config;

    private ConfigurationManager() {
        config = new Properties();
        try (InputStream input = getClass().getResourceAsStream("/config.properties")) {
            config.load(input);
        } catch (IOException e) {
            throw new RuntimeException("Failed to load configuration", e);
        }
    }

    private static class ConfigHolder {
        private static final ConfigurationManager INSTANCE = new ConfigurationManager();
    }

    public static ConfigurationManager getInstance() {
        return ConfigHolder.INSTANCE;
    }

    public String getProperty(String key) {
        return config.getProperty(key);
    }

    public String getProperty(String key, String defaultValue) {
        return config.getProperty(key, defaultValue);
    }
}

// Usage
public class Application {
    public static void main(String[] args) {
        ConfigurationManager config = ConfigurationManager.getInstance();
        String dbUrl = config.getProperty("database.url");
        System.out.println("Database URL: " + dbUrl);
    }
}
```

## Database Connection Pool Example

```java
public class DatabaseConnectionPool {
    private final List<Connection> availableConnections;
    private final List<Connection> usedConnections;
    private final int maxPoolSize;

    private DatabaseConnectionPool() {
        this.maxPoolSize = 10;
        this.availableConnections = new ArrayList<>();
        this.usedConnections = new ArrayList<>();

        // Initialize connection pool
        for (int i = 0; i < 5; i++) {
            availableConnections.add(createConnection());
        }
    }

    private static class PoolHolder {
        private static final DatabaseConnectionPool INSTANCE = new DatabaseConnectionPool();
    }

    public static DatabaseConnectionPool getInstance() {
        return PoolHolder.INSTANCE;
    }

    private Connection createConnection() {
        try {
            return DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/mydb",
                "user",
                "password"
            );
        } catch (SQLException e) {
            throw new RuntimeException("Failed to create connection", e);
        }
    }

    public synchronized Connection getConnection() {
        if (availableConnections.isEmpty()) {
            if (usedConnections.size() < maxPoolSize) {
                availableConnections.add(createConnection());
            } else {
                throw new RuntimeException("Maximum pool size reached");
            }
        }

        Connection connection = availableConnections.remove(availableConnections.size() - 1);
        usedConnections.add(connection);
        return connection;
    }

    public synchronized void releaseConnection(Connection connection) {
        usedConnections.remove(connection);
        availableConnections.add(connection);
    }
}

// Usage
Connection conn = DatabaseConnectionPool.getInstance().getConnection();
try {
    // Use connection
} finally {
    DatabaseConnectionPool.getInstance().releaseConnection(conn);
}
```

## Logger Example

```java
public class Logger {
    private final String logFile;

    private Logger() {
        this.logFile = "application.log";
        // Initialize file writer
    }

    private static class LoggerHolder {
        private static final Logger INSTANCE = new Logger();
    }

    public static Logger getInstance() {
        return LoggerHolder.INSTANCE;
    }

    public synchronized void log(String message) {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String logEntry = String.format("[%s] %s%n", timestamp, message);

        try (FileWriter fw = new FileWriter(logFile, true)) {
            fw.write(logEntry);
        } catch (IOException e) {
            System.err.println("Failed to write log: " + e.getMessage());
        }
    }

    public void info(String message) {
        log("INFO: " + message);
    }

    public void error(String message) {
        log("ERROR: " + message);
    }

    public void warn(String message) {
        log("WARN: " + message);
    }
}

// Usage
Logger.getInstance().info("Application started");
Logger.getInstance().error("Failed to connect to database");
```

# Known Uses

- `java.lang.Runtime#getRuntime()` - access to the runtime environment
- `java.awt.Desktop#getDesktop()` - access to desktop integration features
- `java.lang.System#getSecurityManager()` - security manager instance
- Application configuration managers
- Database connection pools
- Logging frameworks
- Cache managers

# Related Patterns

- [Abstract Factory pattern](Abstract%20Factory%20pattern.md), [Builder pattern](Builder%20pattern.md), and [Prototype pattern](Prototype%20pattern.md) can use Singleton to ensure only one instance of the factory/builder exists
- [Facade pattern](../structural-pattern/Facade%20pattern.md) objects are often singletons because only one Facade object is required
- [State pattern](../behavioral-pattern/State%20pattern.md) and [Strategy pattern](../behavioral-pattern/Strategy%20pattern.md) objects are often implemented as singletons

***
# References

1. Design Patterns: Elements of Reusable Object-Oriented Software - Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides - 1994 - Addison-Wesley
   1. Chapter 3: Creational Patterns
   2. Singleton pattern
2. Effective Java - Joshua Bloch - 3rd Edition - 2017 - Addison-Wesley
   1. Item 3: Enforce the singleton property with a private constructor or an enum type
3. https://en.wikipedia.org/wiki/Initialization-on-demand_holder_idiom for Bill Pugh Singleton pattern
