#design-pattern #object-oriented-programming #creational-pattern #software-engineering #solid #software-architecture
# Intent

Define an interface for creating an object, but let ==subclasses decide which class to instantiate==. Factory Method lets a class defer instantiation to subclasses.

# Applicability

Use Factory Method when:

- A class cannot anticipate the type of objects it must create
- A class wants its ==subclasses to specify the objects it creates==
- Classes delegate responsibility to one of several helper subclasses, and you want to localize the knowledge of which helper subclass is the delegate

# Structure

![](Pasted%20image%2020240603190330.png)

## Participants

### Product
- Defines the interface of objects the factory method creates

### ConcreteProduct
- Implements the Product interface

### Creator
- Declares the factory method returning a Product object
- May call the factory method to create a Product object

### ConcreteCreator
- Overrides the factory method to return a ConcreteProduct instance

# Collaborations

Creator relies on its subclasses to define the factory method so that it returns an instance of the appropriate ConcreteProduct.

# Consequences

## Eliminates binding to application-specific classes

The code only deals with the Product interface, so it can work with any user-defined ConcreteProduct classes. This supports the [Dependency inversion principle](../../../principles/SOLID.md#Dependency%20inversion%20principle) by depending on abstractions rather than concrete classes.

## Provides hooks for subclasses

Creating objects inside a class with a factory method is more flexible than creating an object directly. Factory Method gives subclasses a hook for providing an extended version of an object.

## Connects parallel class hierarchies

Factory Method creates a parallel hierarchy where each ConcreteCreator corresponds to a specific ConcreteProduct. This pattern is useful when a class delegates responsibility to a separate hierarchy of classes.

# Implementation

## Variants

### Abstract Creator with no default implementation
The Creator class is abstract and does not provide a default implementation for the factory method. This forces subclasses to define an implementation and ensures there is no default Product.

### Creator with default Product
The Creator provides a default implementation of the factory method that returns a default ConcreteProduct. This is useful when the Creator can work with a default Product but still allows subclasses to override it.

```java
public abstract class Creator {
    // Template method using factory method
    public Product operation() {
        Product product = createProduct();
        product.doSomething();
        return product;
    }

    // Factory method with default implementation
    protected Product createProduct() {
        return new DefaultProduct();
    }
}
```

### Parameterized factory methods

Factory methods can take a parameter that identifies the kind of object to create. All objects created share the Product interface.

```java
public abstract class Creator {
    protected abstract Product createProduct(String type);
}

public class ConcreteCreator extends Creator {
    @Override
    protected Product createProduct(String type) {
        switch(type) {
            case "A": return new ConcreteProductA();
            case "B": return new ConcreteProductB();
            default: throw new IllegalArgumentException("Unknown type");
        }
    }
}
```

**Consequences:**
- More flexible but less type-safe
- Requires runtime checking or switch statements
- May violate [Open-closed principle](../../../principles/SOLID.md#Open-closed%20principle) when adding new product types

# Sample Code

```java
// Product interface
public abstract class Message {
    public abstract String getContent();

    public void addDefaultHeaders() {
        System.out.println("Adding default headers");
    }

    public void encrypt() {
        System.out.println("Encrypting message");
    }
}

// ConcreteProduct: JSON Message
public class JSONMessage extends Message {
    @Override
    public String getContent() {
        return "{\"message\": \"Hello World\"}";
    }
}

// ConcreteProduct: Text Message
public class TextMessage extends Message {
    @Override
    public String getContent() {
        return "Hello World";
    }
}

// Creator
public abstract class MessageCreator {
    // Template method
    public Message getMessage() {
        Message msg = createMessage();
        msg.addDefaultHeaders();
        msg.encrypt();
        return msg;
    }

    // Factory method
    protected abstract Message createMessage();
}

// ConcreteCreator for JSON
public class JSONMessageCreator extends MessageCreator {
    @Override
    protected Message createMessage() {
        return new JSONMessage();
    }
}

// ConcreteCreator for Text
public class TextMessageCreator extends MessageCreator {
    @Override
    protected Message createMessage() {
        return new TextMessage();
    }
}

// Client
public class Client {
    public static void main(String[] args) {
        printMessage(new JSONMessageCreator());
        printMessage(new TextMessageCreator());
    }

    public static void printMessage(MessageCreator creator) {
        Message msg = creator.getMessage();
        System.out.println(msg.getContent());
    }
}
```

## Document Processing Example

```java
// Product
public interface Document {
    void open();
    void save();
    void close();
}

// ConcreteProducts
public class PDFDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening PDF document");
    }

    @Override
    public void save() {
        System.out.println("Saving PDF document");
    }

    @Override
    public void close() {
        System.out.println("Closing PDF document");
    }
}

public class WordDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Word document");
    }

    @Override
    public void save() {
        System.out.println("Saving Word document");
    }

    @Override
    public void close() {
        System.out.println("Closing Word document");
    }
}

// Creator
public abstract class Application {
    private Document document;

    public void createDocument() {
        document = createDocumentInstance();
        document.open();
    }

    public void saveDocument() {
        if (document != null) {
            document.save();
        }
    }

    protected abstract Document createDocumentInstance();
}

// ConcreteCreators
public class PDFApplication extends Application {
    @Override
    protected Document createDocumentInstance() {
        return new PDFDocument();
    }
}

public class WordApplication extends Application {
    @Override
    protected Document createDocumentInstance() {
        return new WordDocument();
    }
}
```

# Known Uses

- `java.util.Collection#iterator()` - returns different iterator implementations depending on the collection type
- `java.text.NumberFormat#getInstance()` - returns locale-specific number formatters
- `javax.xml.parsers.DocumentBuilderFactory#newDocumentBuilder()` - creates XML document builders

# Related Patterns

- [Abstract Factory pattern](Abstract%20Factory%20pattern.md) - often implemented using Factory Methods
- [Template Method pattern](../behavioral-pattern/Template%20method%20pattern.md) - Factory Methods are usually called within Template Methods
- [Prototype pattern](Prototype%20pattern.md) - an alternative to Factory Method that doesn't require subclassing

***
# References

1. Design Patterns: Elements of Reusable Object-Oriented Software - Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides - 1994 - Addison-Wesley
   1. Chapter 3: Creational Patterns
   2. Factory Method pattern
2. https://refactoring.guru/design-patterns/factory-method for visual examples
