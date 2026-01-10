#solid #software-engineering #design-pattern #creational-pattern #java #software-architecture
# Intent

Specify the kinds of objects to create using a ==prototypical instance==, and create new objects by ==copying this prototype==.

# Applicability

Use the Prototype pattern when:

- A system should be ==independent of how its products are created==, composed, and represented
- The classes to instantiate are ==specified at run-time==
- Avoiding building a class hierarchy of factories that parallels the class hierarchy of products
- Instances of a class can have only ==one of a few different combinations of state==

# Structure

![](Pasted%20image%2020240604153209.png)

## Participants

### Prototype
- Declares an interface for cloning itself

### ConcretePrototype
- Implements an operation for cloning itself

### Client
- Creates a new object by asking a prototype to clone itself

# Collaborations

A client asks a prototype to clone itself to create a new object.

# Consequences

## Hides concrete product classes from the client

Prototype lets a client work with application-specific classes without modification. The client manipulates objects through a common Prototype interface.

## Adds and removes products at run-time

Prototypes let you incorporate a new concrete product class into a system simply by registering a prototypical instance with the client. This is more flexible than other creational patterns because a client can install and remove prototypes at run-time.

## Specifying new objects by varying values

You can define new behavior by specifying values for an existing object's variables rather than defining new classes. Effectively, you clone an object and change its state.

## Specifying new objects by varying structure

Many applications build objects from parts and subparts. You can instantiate complex structures by cloning a prototype and customizing it, rather than instantiating the classes manually.

## Reduced subclassing

Prototype pattern allows you to clone objects instead of asking a factory method to make a new one. This eliminates the need for a Creator class hierarchy parallel to the Product class hierarchy.

## Implementing the clone operation

The main difficulty with the Prototype pattern is implementing the clone operation correctly, particularly when object structures include circular references or require deep copying.

# Implementation

## Variants

### Shallow copy

Copies all fields of an object. If a field is a reference type, only the reference is copied, not the referenced object.

```java
@Override
protected Object clone() throws CloneNotSupportedException {
    return super.clone(); // Shallow copy
}
```

**Consequences:**
- Fast and simple
- Shared mutable state between original and clone
- Can lead to unexpected side effects
- Suitable for immutable objects only

### Deep copy

Recursively copies all objects referenced by the fields. The cloned object is completely independent of the original.

```java
@Override
protected GameUnit clone() throws CloneNotSupportedException {
    GameUnit cloned = (GameUnit) super.clone();
    // Deep copy for mutable fields
    cloned.position = this.position.clone();
    cloned.equipment = new ArrayList<>(this.equipment);
    return cloned;
}
```

**Consequences:**
- Complete independence from original
- More complex to implement
- Slower performance
- Required for objects with mutable state

### Prototype registry (Prototype Manager)

A registry maintains a set of prototypical instances. Clients retrieve prototypes by key and clone them.

```java
public class PrototypeRegistry {
    private Map<String, Prototype> prototypes = new HashMap<>();

    public void registerPrototype(String key, Prototype prototype) {
        prototypes.put(key, prototype);
    }

    public Prototype getPrototype(String key) throws CloneNotSupportedException {
        Prototype prototype = prototypes.get(key);
        if (prototype != null) {
            return (Prototype) prototype.clone();
        }
        return null;
    }
}
```

**Consequences:**
- Centralized prototype management
- Clients don't need to know concrete classes
- Easy to add new prototypes at runtime
- Additional layer of indirection

# Sample Code

## Game Unit Example

```java
// Prototype interface
public abstract class GameUnit implements Cloneable {
    private Point3D position;

    public GameUnit() {
        this.position = Point3D.ZERO;
    }

    public GameUnit(float x, float y, float z) {
        this.position = new Point3D(x, y, z);
    }

    public void move(Point3D direction, float distance) {
        Point3D finalMove = direction.normalize().multiply(distance);
        position = position.add(finalMove);
    }

    public Point3D getPosition() {
        return position;
    }

    @Override
    public GameUnit clone() throws CloneNotSupportedException {
        GameUnit unit = (GameUnit) super.clone();
        unit.initialize();
        return unit;
    }

    protected void initialize() {
        this.position = Point3D.ZERO;
        this.reset();
    }

    protected abstract void reset();
}

// ConcretePrototype: Swordsman
public class Swordsman extends GameUnit {
    private String state = "idle";

    public void attack() {
        this.state = "attacking";
    }

    @Override
    protected void reset() {
        this.state = "idle";
    }

    @Override
    public String toString() {
        return "Swordsman " + state + " @ " + getPosition();
    }
}

// ConcretePrototype: General
public class General extends GameUnit {
    private String state = "idle";
    private List<GameUnit> army;

    public General() {
        super();
        this.army = new ArrayList<>();
    }

    public void addUnit(GameUnit unit) {
        army.add(unit);
    }

    @Override
    protected void reset() {
        this.state = "idle";
        this.army = new ArrayList<>();
    }

    @Override
    public General clone() throws CloneNotSupportedException {
        General cloned = (General) super.clone();
        // Deep copy for mutable collection
        cloned.army = new ArrayList<>(this.army);
        return cloned;
    }

    @Override
    public String toString() {
        return "General " + state + " @ " + getPosition() + " with " + army.size() + " units";
    }
}

// Client
public class Client {
    public static void main(String[] args) throws CloneNotSupportedException {
        Swordsman original = new Swordsman();
        original.move(new Point3D(1, 2, 3), 25);
        original.attack();
        System.out.println("Original: " + original);

        // Clone and reset to initial state
        Swordsman cloned = (Swordsman) original.clone();
        System.out.println("Cloned: " + cloned);
    }
}
```

**Output:**
```
Original: Swordsman attacking @ Point3D(25.0, 50.0, 75.0)
Cloned: Swordsman idle @ Point3D(0.0, 0.0, 0.0)
```

## Document Template Example

```java
// Prototype
public abstract class DocumentTemplate implements Cloneable {
    private String title;
    private String content;
    private List<String> sections;
    private Map<String, String> metadata;

    public DocumentTemplate() {
        this.sections = new ArrayList<>();
        this.metadata = new HashMap<>();
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void addSection(String section) {
        sections.add(section);
    }

    public void addMetadata(String key, String value) {
        metadata.put(key, value);
    }

    @Override
    public DocumentTemplate clone() {
        try {
            DocumentTemplate cloned = (DocumentTemplate) super.clone();
            // Deep copy for mutable fields
            cloned.sections = new ArrayList<>(this.sections);
            cloned.metadata = new HashMap<>(this.metadata);
            return cloned;
        } catch (CloneNotSupportedException e) {
            throw new RuntimeException("Clone not supported", e);
        }
    }

    public abstract void format();

    @Override
    public String toString() {
        return String.format("Title: %s%nContent: %s%nSections: %d%nMetadata: %s",
            title, content, sections.size(), metadata);
    }
}

// ConcretePrototype: Resume
public class ResumeTemplate extends DocumentTemplate {
    public ResumeTemplate() {
        super();
        addSection("Personal Information");
        addSection("Work Experience");
        addSection("Education");
        addSection("Skills");
        addMetadata("type", "resume");
    }

    @Override
    public void format() {
        System.out.println("Formatting as professional resume");
    }
}

// ConcretePrototype: Report
public class ReportTemplate extends DocumentTemplate {
    public ReportTemplate() {
        super();
        addSection("Executive Summary");
        addSection("Introduction");
        addSection("Analysis");
        addSection("Conclusion");
        addMetadata("type", "report");
    }

    @Override
    public void format() {
        System.out.println("Formatting as business report");
    }
}

// Prototype Registry
public class DocumentTemplateRegistry {
    private Map<String, DocumentTemplate> templates = new HashMap<>();

    public DocumentTemplateRegistry() {
        // Pre-register common templates
        templates.put("resume", new ResumeTemplate());
        templates.put("report", new ReportTemplate());
    }

    public void addTemplate(String key, DocumentTemplate template) {
        templates.put(key, template);
    }

    public DocumentTemplate getTemplate(String key) {
        DocumentTemplate template = templates.get(key);
        return template != null ? template.clone() : null;
    }
}

// Usage
public class DocumentEditor {
    public static void main(String[] args) {
        DocumentTemplateRegistry registry = new DocumentTemplateRegistry();

        // Create document from template
        DocumentTemplate myResume = registry.getTemplate("resume");
        myResume.setTitle("John Doe - Software Engineer");
        myResume.setContent("Experienced software engineer...");

        DocumentTemplate myReport = registry.getTemplate("report");
        myReport.setTitle("Q4 2024 Performance Report");
        myReport.setContent("This report analyzes...");

        System.out.println(myResume);
        System.out.println("\n" + myReport);
    }
}
```

## Configuration Prototype Example

```java
public class DatabaseConfig implements Cloneable {
    private String host;
    private int port;
    private String database;
    private String username;
    private String password;
    private Map<String, String> properties;

    public DatabaseConfig(String host, int port) {
        this.host = host;
        this.port = port;
        this.properties = new HashMap<>();
    }

    public DatabaseConfig withDatabase(String database) {
        this.database = database;
        return this;
    }

    public DatabaseConfig withCredentials(String username, String password) {
        this.username = username;
        this.password = password;
        return this;
    }

    public DatabaseConfig withProperty(String key, String value) {
        this.properties.put(key, value);
        return this;
    }

    @Override
    public DatabaseConfig clone() {
        try {
            DatabaseConfig cloned = (DatabaseConfig) super.clone();
            cloned.properties = new HashMap<>(this.properties);
            return cloned;
        } catch (CloneNotSupportedException e) {
            throw new RuntimeException("Clone not supported", e);
        }
    }

    public String getConnectionString() {
        return String.format("jdbc:postgresql://%s:%d/%s", host, port, database);
    }
}

// Usage
DatabaseConfig baseConfig = new DatabaseConfig("localhost", 5432)
    .withCredentials("admin", "admin123")
    .withProperty("ssl", "true")
    .withProperty("timeout", "30");

// Clone for different databases
DatabaseConfig usersDb = baseConfig.clone().withDatabase("users_db");
DatabaseConfig ordersDb = baseConfig.clone().withDatabase("orders_db");
DatabaseConfig analyticsDb = baseConfig.clone().withDatabase("analytics_db");
```

# Known Uses

- `java.lang.Object#clone()` - base method for cloning in Java
- `java.util.Date` - implements Cloneable
- `java.util.ArrayList` - implements Cloneable for copying lists
- Graphical editors - cloning shapes and objects
- Game development - spawning entities from prototypes

# Related Patterns

- [Abstract Factory pattern](Abstract%20Factory%20pattern.md) - can use Prototype to implement factories that create products by cloning prototypes
- [Composite pattern](../structural-pattern/Composite%20pattern.md) and [Decorator pattern](../structural-pattern/Decorator%20pattern.md) benefit from Prototype for cloning complex structures
- Designs that make heavy use of Composite and Decorator patterns often benefit from Prototype as well

***
# References

1. Design Patterns: Elements of Reusable Object-Oriented Software - Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides - 1994 - Addison-Wesley
   1. Chapter 3: Creational Patterns
   2. Prototype pattern
2. https://refactoring.guru/design-patterns/prototype for prototype registry pattern
