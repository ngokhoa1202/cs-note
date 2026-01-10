#solid #software-engineering #design-pattern #creational-pattern #software-architecture
# Purpose
- Provide an interface for creating ==families of related or dependent objects without specifying their concrete classes==.
# Applicability
- A system should be ==independent of how its products are created==, composed, and represented
- A system should be ==configured with one of multiple families of products==
- A ==family of related product objects is designed to be used together==, and you need to enforce this constraint
- You want to provide a ==class library of products==, and you want to reveal just their interfaces, not their implementations
# Structure
- ![](Pasted%20image%2020240605152529.png)

## Participants

### `AbstractFactory`
- Declares an interface for operations that ==create abstract product objects==
### `ConcreteFactory`
- Implements the operations to ==create concrete product objects==

### `AbstractProduct`
- Declares an interface for a ==type of product object==
### `ConcreteProduct`
- Defines a product object to be ==created by the corresponding concrete factory==
- Implements the `AbstractProduct` interface
### `Client`
- Uses ==only interfaces declared by AbstractFactory and AbstractProduct== classes
- Does not know about concrete factories and concrete products
- Receives a ==concrete factory at runtime==
# Collaborations

- Normally a ==single instance of a ConcreteFactory class is created at run time==. This concrete factory creates product objects having a particular implementation. To create different product objects, clients should use a different concrete factory.
- AbstractFactory ==defers creation of product objects to its ConcreteFactory subclass==.

# Consequences
## It isolates concrete classes
- The Abstract Factory pattern helps you control the classes of objects that an application creates. Because a factory ==encapsulates the responsibility and the process of creating product objects==, it isolates clients from implementation classes. Clients manipulate instances through their abstract interfaces. Product class names are isolated in the implementation of the concrete factory; they do not appear in client code.

- This supports the [Single responsibility principle](../../../principles/SOLID.md#Single%20responsibility%20principle) by extracting product creation into dedicated factories.

## It makes exchanging product families easy

The class of a concrete factory appears only once in an application—that is, where it's instantiated. This makes it easy to ==change the concrete factory an application uses==. It can use different product configurations simply by changing the concrete factory. Because an abstract factory creates a complete family of products, the whole product family changes at once.

This supports the [Open-closed principle](../../../principles/SOLID.md#Open-closed%20principle) by allowing new product families without modifying client code.

## It promotes consistency among products

When product objects in a family are designed to work together, it's important that an application use objects from only one family at a time. AbstractFactory makes this easy to enforce. Each concrete factory ==ensures that products are compatible== because it creates them all.

## Supporting new kinds of products is difficult

Extending abstract factories to produce new kinds of products isn't easy. That's because the AbstractFactory interface ==fixes the set of products that can be created==. Supporting new kinds of products requires extending the factory interface, which involves changing the AbstractFactory class and all of its subclasses.

# Implementation
## Factories as singletons
- An application typically needs ==only one instance of a ConcreteFactory per product family==. So it's usually best implemented as a [Singleton](Singleton%20pattern.md).
## Creating the products

- AbstractFactory only declares an interface for creating products. It's up to ConcreteProduct subclasses to actually create them. The most common way to do this is to define a ==factory method== (see [Factory Method pattern](Factory%20Method%20pattern.md)) for each product. A concrete factory will specify its products by overriding the factory method for each. While this implementation is simple, it requires a new concrete factory subclass for each product family, even if the product families differ only slightly.
### Variant: Using Prototype pattern

If many product families are possible, the concrete factory can be implemented using the [Prototype pattern](Prototype%20pattern.md). The concrete factory is initialized with a ==prototypical instance of each product== in the family, and it creates a new product by cloning its prototype. The Prototype-based approach eliminates the need for a new concrete factory class for each new product family.

**Consequences of Prototype variant:**
- Reduces the number of concrete factory classes needed
- Makes adding new product families easier
- Requires products to implement a cloning operation
- May be complex if products contain circular references or require deep copying

## Defining extensible factories

AbstractFactory usually defines a different operation for each kind of product it can produce. The kinds of products are encoded in the operation signatures. Adding a new kind of product requires changing the AbstractFactory interface and all the classes that depend on it.

### Variant: Parameterized factory methods

A more flexible but less safe design is to add a parameter to operations that create objects. This parameter ==specifies the kind of object to be created==. It could be a class identifier, an integer, a string, or anything else that identifies the kind of product. With this approach, AbstractFactory only needs a single "make" operation with a parameter indicating the kind of object to create.

```java
interface AbstractFactory {
    Product create(String productType);
}
```

**Consequences of parameterized variant:**
- More flexible - easier to add new product types
- Less type-safe - compiler cannot verify that product types are valid
- Requires runtime checking or type casting
- May violate the [Interface segregation principle](../../../principles/SOLID.md#Interface%20segregation%20principle) by forcing all factories to know about all product types

# Sample Code

Here's a complete practical example demonstrating the Abstract Factory pattern for creating database connection components:

```java
// AbstractProduct: Database Connection
public interface DatabaseConnection {
    void connect();
    void disconnect();
}

// AbstractProduct: Query Builder
public interface QueryBuilder {
    void select(String table);
    void where(String condition);
    String build();
}

// AbstractFactory
public interface DatabaseFactory {
    DatabaseConnection createConnection();
    QueryBuilder createQueryBuilder();
}

// ConcreteProduct: PostgreSQL Connection
public class PostgreSQLConnection implements DatabaseConnection {
    @Override
    public void connect() {
        System.out.println("Connecting to PostgreSQL database");
    }

    @Override
    public void disconnect() {
        System.out.println("Disconnecting from PostgreSQL database");
    }
}

// ConcreteProduct: PostgreSQL Query Builder
public class PostgreSQLQueryBuilder implements QueryBuilder {
    private StringBuilder query = new StringBuilder();

    @Override
    public void select(String table) {
        query.append("SELECT * FROM ").append(table);
    }

    @Override
    public void where(String condition) {
        query.append(" WHERE ").append(condition);
    }

    @Override
    public String build() {
        query.append(";");
        return query.toString();
    }
}

// ConcreteProduct: MySQL Connection
public class MySQLConnection implements DatabaseConnection {
    @Override
    public void connect() {
        System.out.println("Connecting to MySQL database");
    }

    @Override
    public void disconnect() {
        System.out.println("Disconnecting from MySQL database");
    }
}

// ConcreteProduct: MySQL Query Builder
public class MySQLQueryBuilder implements QueryBuilder {
    private StringBuilder query = new StringBuilder();

    @Override
    public void select(String table) {
        query.append("SELECT * FROM `").append(table).append("`");
    }

    @Override
    public void where(String condition) {
        query.append(" WHERE ").append(condition);
    }

    @Override
    public String build() {
        query.append(";");
        return query.toString();
    }
}

// ConcreteFactory: PostgreSQL Factory
public class PostgreSQLFactory implements DatabaseFactory {
    @Override
    public DatabaseConnection createConnection() {
        return new PostgreSQLConnection();
    }

    @Override
    public QueryBuilder createQueryBuilder() {
        return new PostgreSQLQueryBuilder();
    }
}

// ConcreteFactory: MySQL Factory
public class MySQLFactory implements DatabaseFactory {
    @Override
    public DatabaseConnection createConnection() {
        return new MySQLConnection();
    }

    @Override
    public QueryBuilder createQueryBuilder() {
        return new MySQLQueryBuilder();
    }
}

// Client
public class DatabaseClient {
    private DatabaseConnection connection;
    private QueryBuilder queryBuilder;

    public DatabaseClient(DatabaseFactory factory) {
        // Client only knows about abstract interfaces
        this.connection = factory.createConnection();
        this.queryBuilder = factory.createQueryBuilder();
    }

    public void executeQuery(String table, String condition) {
        connection.connect();

        queryBuilder.select(table);
        queryBuilder.where(condition);
        String query = queryBuilder.build();

        System.out.println("Executing: " + query);

        connection.disconnect();
    }

    public static void main(String[] args) {
        // Configuration - choose database at runtime
        DatabaseFactory factory;
        String dbType = System.getProperty("db.type", "postgresql");

        if (dbType.equals("mysql")) {
            factory = new MySQLFactory();
        } else {
            factory = new PostgreSQLFactory();
        }

        // Client uses factory without knowing concrete types
        DatabaseClient client = new DatabaseClient(factory);
        client.executeQuery("users", "id > 100");
    }
}
```

**Output with PostgreSQL:**
```
Connecting to PostgreSQL database
Executing: SELECT * FROM users WHERE id > 100;
Disconnecting from PostgreSQL database
```

**Output with MySQL:**
```
Connecting to MySQL database
Executing: SELECT * FROM `users` WHERE id > 100;
Disconnecting from MySQL database
```

## UI Components Example

Here's the classic GUI example demonstrating cross-platform UI components:

```Java
// AbstractProduct interfaces
public interface Button {
    void paint();
    void onClick();
}

public interface CheckBox {
    void paint();
    void onCheck();
}

// AbstractFactory
public interface GUIFactory {
    Button createButton();
    CheckBox createCheckBox();
}

// Windows concrete products
public class WinButton implements Button {
    @Override
    public void paint() {
        System.out.println("Rendering Windows-style button");
    }

    @Override
    public void onClick() {
        System.out.println("Windows button clicked");
    }
}

public class WinCheckBox implements CheckBox {
    @Override
    public void paint() {
        System.out.println("Rendering Windows-style checkbox");
    }

    @Override
    public void onCheck() {
        System.out.println("Windows checkbox checked");
    }
}

// MacOS concrete products
public class MacButton implements Button {
    @Override
    public void paint() {
        System.out.println("Rendering MacOS-style button");
    }

    @Override
    public void onClick() {
        System.out.println("MacOS button clicked");
    }
}

public class MacCheckBox implements CheckBox {
    @Override
    public void paint() {
        System.out.println("Rendering MacOS-style checkbox");
    }

    @Override
    public void onCheck() {
        System.out.println("MacOS checkbox checked");
    }
}

// Concrete factories
public class WinFactory implements GUIFactory {
    @Override
    public Button createButton() {
        return new WinButton();
    }

    @Override
    public CheckBox createCheckBox() {
        return new WinCheckBox();
    }
}

public class MacFactory implements GUIFactory {
    @Override
    public Button createButton() {
        return new MacButton();
    }

    @Override
    public CheckBox createCheckBox() {
        return new MacCheckBox();
    }
}

// Client
public class Application {
    private Button button;
    private CheckBox checkBox;

    public Application(GUIFactory factory) {
        button = factory.createButton();
        checkBox = factory.createCheckBox();
    }

    public void render() {
        button.paint();
        checkBox.paint();
    }
}
```
# Usage
## Java Standard Library
- `javax.xml.parsers.DocumentBuilderFactory` - creates XML parsers for different implementations (though it includes static factory methods, which is a hybrid approach)
- `javax.xml.transform.TransformerFactory` - creates XSLT transformers
- `java.sql.DriverManager#getConnection()` - returns different database connection implementations
## Practical Applications
- **Database access layers** - creating database connections, query builders, and transaction managers for different database vendors
- **UI toolkits** - creating platform-specific widgets (buttons, windows, menus) for different operating systems
- **Document formats** - creating readers and writers for different file formats (PDF, Word, Excel)
- **Cloud providers** - creating storage, compute, and network resources for different cloud platforms (AWS, Azure, GCP)
# Related Patterns

- [Factory Method pattern](Factory%20Method%20pattern.md) - AbstractFactory classes are often implemented with factory methods, but they can also be implemented using [Prototype pattern](Prototype%20pattern.md)
- [Singleton pattern](Singleton%20pattern.md) - A concrete factory is often a singleton because an application typically needs only one instance of a concrete factory per product family
- [Prototype pattern](Prototype%20pattern.md) - Can be used to implement concrete factories, especially when there are many product families. The factory stores prototypical instances and creates products by cloning them

***
# References

1. Design Patterns: Elements of Reusable Object-Oriented Software - Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides - 1994 - Addison-Wesley
   1. Chapter 3: Creational Patterns
   2. Abstract Factory pattern
2. https://refactoring.guru/design-patterns/abstract-factory for visual examples and variations
3. https://www.udemy.com/course/design-patterns-in-java-concepts-hands-on-projects/learn/lecture/9758788#overview for practical implementation guidance
