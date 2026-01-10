#object-oriented-programming #structural-pattern #solid #software-engineering #diamond-problem #java #python #software-architecture
# Intent

Convert the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of ==incompatible interfaces==.

# Also Known As

Wrapper

# Applicability

Use the Adapter pattern when:

- You want to use an existing class, but its ==interface doesn't match the one you need==
- You want to create a reusable class that cooperates with unrelated or unforeseen classes with incompatible interfaces
- You need to use several existing subclasses, but it's impractical to adapt their interface by subclassing every one. An object adapter can adapt the interface of its parent class

# Structure

## Class Adapter (Multiple Inheritance)
![](Pasted%20image%2020240608094057.png)

## Object Adapter (Composition - Recommended)
![](Pasted%20image%2020240608102427.png)

## Participants

### Target
- Defines the domain-specific interface that Client uses

### Client
- Collaborates with objects conforming to the Target interface

### Adaptee
- Defines an existing interface that needs adapting

### Adapter
- Adapts the interface of Adaptee to the Target interface

# Collaborations

Clients call operations on an Adapter instance. In turn, the adapter calls Adaptee operations that carry out the request.

# Consequences

## Class adapter consequences

**Uses multiple inheritance** to adapt one interface to another.

- Adapter can override some of Adaptee's behavior since Adapter is a subclass of Adaptee
- Only one object created - no additional pointer indirection
- Won't work when you want to adapt a class and all its subclasses
- Introduces tight coupling with Adaptee

## Object adapter consequences

**Uses object composition** to combine classes with different interfaces.

- Lets a single Adapter work with many Adaptees (the Adaptee itself and all of its subclasses)
- Makes it harder to override Adaptee behavior - requires subclassing Adaptee and making Adapter refer to the subclass
- Additional level of indirection
- More flexible - follows [Open-closed principle](../../../principles/SOLID.md#Open-closed%20principle)

## General consequences

- Adds transparency to Client code - Client works with the Target interface without knowing about the adaptation
- Provides decoupling between Client and Adaptee
- Supports the [Single responsibility principle](../../../principles/SOLID.md#Single%20responsibility%20principle) by separating interface conversion from business logic

# Implementation

## Variants

### Object Adapter (Recommended)

Uses composition to delegate calls to the Adaptee. This is the preferred approach in most cases.

```java
public class Adapter extends Target {
    private Adaptee adaptee;

    public Adapter(Adaptee adaptee) {
        this.adaptee = adaptee;
    }

    @Override
    public void request() {
        // Adapt the interface
        adaptee.specificRequest();
    }
}
```

**Consequences:**
- More flexible - can adapt multiple Adaptees
- Follows composition over inheritance principle
- Looser coupling
- Recommended for most scenarios

### Class Adapter

Uses multiple inheritance to inherit from both Target and Adaptee. Only available in languages supporting multiple inheritance.

```python
class Adapter(Target, Adaptee):
    def request(self):
        # Can directly call inherited method
        self.specific_request()
```

**Consequences:**
- No additional object creation
- Can override Adaptee behavior
- Tight coupling to specific Adaptee class
- Diamond problem in languages like C++
- Not available in Java (single inheritance only)

### Two-way Adapter

Implements both interfaces to allow the Adapter to be used as either type.

```java
public class TwoWayAdapter implements Target, Adaptee {
    private Target target;
    private Adaptee adaptee;

    // Can adapt in both directions
}
```

**Consequences:**
- Adapter can be used in systems expecting either interface
- More complex implementation
- Useful for gradual migration scenarios

# Sample Code

## Stock Analysis Service Example

```java
// Target - What client expects
public abstract class StockService {
    protected void receive() {
        System.out.println("Receive JSON data from stock manager");
    }

    public abstract void process();
}

// Adaptee - Existing incompatible service
public class StockStorage {
    public void store() {
        System.out.println("Store XML data");
    }
}

// Adapter - Object Adapter approach
public class StockAnalysisService extends StockService {
    private StockStorage storage;

    public StockAnalysisService() {
        this.storage = new StockStorage();
    }

    @Override
    public void process() {
        super.receive();
        convertToXML();
        storage.store();
    }

    private void convertToXML() {
        System.out.println("Convert JSON data to XML data");
    }
}

// Client
public class Main {
    public static void main(String[] args) {
        StockService service = createService();
        service.process();
    }

    private static StockService createService() {
        return new StockAnalysisService();
    }
}
```

## Payment Gateway Example

```java
// Target interface expected by client
public interface PaymentProcessor {
    void processPayment(double amount, String currency);
    PaymentStatus getStatus();
}

// Adaptee - Third-party payment library with different interface
public class StripePaymentService {
    public void makePayment(int cents, String currencyCode) {
        System.out.println("Processing " + cents + " cents via Stripe in " + currencyCode);
    }

    public StripeTransactionStatus checkTransactionStatus() {
        return new StripeTransactionStatus("SUCCESS", "txn_123");
    }
}

// Another Adaptee - Different third-party service
public class PayPalService {
    public boolean sendPayment(String amount, String curr) {
        System.out.println("Sending payment of " + amount + " " + curr + " via PayPal");
        return true;
    }
}

// Adapter for Stripe
public class StripeAdapter implements PaymentProcessor {
    private StripePaymentService stripeService;

    public StripeAdapter(StripePaymentService stripeService) {
        this.stripeService = stripeService;
    }

    @Override
    public void processPayment(double amount, String currency) {
        // Adapt: convert dollars to cents
        int cents = (int) (amount * 100);
        stripeService.makePayment(cents, currency);
    }

    @Override
    public PaymentStatus getStatus() {
        StripeTransactionStatus stripeStatus = stripeService.checkTransactionStatus();
        // Adapt Stripe status to our PaymentStatus
        return new PaymentStatus(
            stripeStatus.getStatus().equals("SUCCESS"),
            stripeStatus.getTransactionId()
        );
    }
}

// Adapter for PayPal
public class PayPalAdapter implements PaymentProcessor {
    private PayPalService payPalService;

    public PayPalAdapter(PayPalService payPalService) {
        this.payPalService = payPalService;
    }

    @Override
    public void processPayment(double amount, String currency) {
        // Adapt: convert double to string
        String amountStr = String.format("%.2f", amount);
        boolean success = payPalService.sendPayment(amountStr, currency);
        System.out.println("PayPal payment " + (success ? "successful" : "failed"));
    }

    @Override
    public PaymentStatus getStatus() {
        // Simplified - PayPal doesn't provide status in this example
        return new PaymentStatus(true, "paypal_txn");
    }
}

// Client code - works with any payment processor
public class CheckoutService {
    private PaymentProcessor paymentProcessor;

    public CheckoutService(PaymentProcessor paymentProcessor) {
        this.paymentProcessor = paymentProcessor;
    }

    public void checkout(double amount, String currency) {
        paymentProcessor.processPayment(amount, currency);
        PaymentStatus status = paymentProcessor.getStatus();
        System.out.println("Payment status: " + status);
    }

    public static void main(String[] args) {
        // Can switch between payment providers easily
        CheckoutService stripeCheckout = new CheckoutService(
            new StripeAdapter(new StripePaymentService())
        );
        stripeCheckout.checkout(99.99, "USD");

        CheckoutService paypalCheckout = new CheckoutService(
            new PayPalAdapter(new PayPalService())
        );
        paypalCheckout.checkout(149.99, "EUR");
    }
}
```

## Legacy Database Adapter Example

```java
// Target - Modern interface
public interface DatabaseConnection {
    void connect(String connectionString);
    ResultSet executeQuery(String sql);
    void disconnect();
}

// Adaptee - Legacy database library
public class LegacyDatabaseDriver {
    public void openConnection(String host, int port, String dbName) {
        System.out.println("Legacy: Opening connection to " + host + ":" + port);
    }

    public LegacyResultSet runQuery(String query) {
        System.out.println("Legacy: Running query: " + query);
        return new LegacyResultSet();
    }

    public void closeConnection() {
        System.out.println("Legacy: Closing connection");
    }
}

// Adapter
public class LegacyDatabaseAdapter implements DatabaseConnection {
    private LegacyDatabaseDriver legacyDriver;

    public LegacyDatabaseAdapter() {
        this.legacyDriver = new LegacyDatabaseDriver();
    }

    @Override
    public void connect(String connectionString) {
        // Parse connection string and adapt to legacy format
        // Example: "jdbc:legacy://localhost:5432/mydb"
        String[] parts = connectionString.split("//")[1].split(":|/");
        String host = parts[0];
        int port = Integer.parseInt(parts[1]);
        String dbName = parts[2];

        legacyDriver.openConnection(host, port, dbName);
    }

    @Override
    public ResultSet executeQuery(String sql) {
        LegacyResultSet legacyResult = legacyDriver.runQuery(sql);
        // Convert LegacyResultSet to modern ResultSet
        return new ResultSetAdapter(legacyResult);
    }

    @Override
    public void disconnect() {
        legacyDriver.closeConnection();
    }
}
```

# Known Uses

- `java.util.Arrays#asList()` - adapts arrays to List interface
- `java.util.Collections#list()` - adapts Enumeration to List
- `java.util.Collections#enumeration()` - adapts Collection to Enumeration
- `java.io.InputStreamReader(InputStream)` - adapts byte stream to character stream
- `java.io.OutputStreamWriter(OutputStream)` - adapts byte stream to character stream
- `javax.xml.bind.annotation.adapters.XmlAdapter` - adapts Java types to XML

# Related Patterns

- [Bridge pattern](Bridge%20pattern.md) - similar structure but different intent. Bridge separates interface from implementation, while Adapter changes the interface of an existing object
- [Decorator pattern](Decorator%20pattern.md) - enhances an object without changing its interface. Adapter changes the interface
- [Proxy pattern](Proxy%20pattern.md) - provides the same interface. Adapter provides a different interface

***
# References

1. Design Patterns: Elements of Reusable Object-Oriented Software - Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides - 1994 - Addison-Wesley
   1. Chapter 4: Structural Patterns
   2. Adapter pattern
2. https://refactoring.guru/design-patterns/adapter for visual examples
