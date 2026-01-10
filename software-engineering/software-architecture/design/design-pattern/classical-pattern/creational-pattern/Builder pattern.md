#object-oriented-programming #solid #design-pattern #software-engineering #creational-pattern #software-architecture
# Intent

Separate the ==construction of a complex object from its representation== so that the same construction process can create different representations.

# Applicability

Use the Builder pattern when:

- The algorithm for creating a complex object should be ==independent of the parts== that make up the object and how they're assembled
- The construction process must allow ==different representations== for the object that's constructed
- You need to construct objects with ==numerous optional parameters== (telescoping constructor problem)

# Structure

![600x200](Pasted%20image%2020240602203427.png)

## Participants

### Director
- Constructs an object using the Builder interface
- Knows the steps required to build the product

### Builder
- Specifies an abstract interface for creating parts of a Product object

### ConcreteBuilder
- Constructs and assembles parts of the product by implementing the Builder interface
- Defines and keeps track of the representation it creates
- Provides an interface for retrieving the product

### Product
- Represents the complex object under construction
- Includes classes that define the constituent parts

# Collaborations

- The client creates the Director object and configures it with the desired Builder object
- Director notifies the builder whenever a part of the product should be built
- Builder handles requests from the director and adds parts to the product
- The client retrieves the product from the builder

# Consequences

## Lets you vary a product's internal representation

The Builder object provides the director with an abstract interface for constructing the product. The interface lets the builder hide the representation and internal structure of the product. Because the product is constructed through an abstract interface, changing the product's internal representation requires defining a new kind of builder.

## Isolates code for construction and representation

The Builder pattern improves modularity by ==encapsulating the way a complex object is constructed and represented==. Clients don't need to know about the classes that define the product's internal structure; such classes don't appear in Builder's interface.

This supports the [Single responsibility principle](../../../principles/SOLID.md#Single%20responsibility%20principle) by separating construction logic from business logic.

## Gives you finer control over the construction process

Unlike creational patterns that construct products in one shot, the Builder pattern constructs the product ==step by step== under the director's control. Only when the product is finished does the director retrieve it from the builder. Hence the Builder interface reflects the process of constructing the product more than other creational patterns.

# Implementation

## Variants

### Classic Builder with Director

The traditional pattern with a separate Director class that orchestrates the building process.

```java
public class Director {
    private Builder builder;

    public Director(Builder builder) {
        this.builder = builder;
    }

    public Product construct() {
        builder.buildPartA();
        builder.buildPartB();
        builder.buildPartC();
        return builder.getResult();
    }
}
```

### Fluent Builder without Director

Modern implementations often eliminate the Director and use ==method chaining== for a fluent interface. This variant is common in Java and returns `this` from each builder method.

```java
public class Product {
    private String partA;
    private String partB;

    private Product() {} // Private constructor

    public static class Builder {
        private String partA;
        private String partB;

        public Builder withPartA(String partA) {
            this.partA = partA;
            return this;
        }

        public Builder withPartB(String partB) {
            this.partB = partB;
            return this;
        }

        public Product build() {
            Product product = new Product();
            product.partA = this.partA;
            product.partB = this.partB;
            return product;
        }
    }
}
```

**Consequences:**
- More concise and easier to use
- Eliminates need for separate Director class
- Creates ==immutable objects== when product constructor is private
- Client controls the building process directly

### Nested Static Builder

Implementing Builder as a ==static nested class== within the Product class provides better encapsulation and allows the builder to access private members.

**Consequences:**
- Builder can set private fields of Product directly
- Product class and its builder are co-located
- Ensures Product is only created through Builder
- Common pattern in modern Java APIs

# Sample Code

## Classic DTO Builder Example

```java
// Product
public class UserDTO {
    private String name;
    private String address;
    private String age;

    // Getters
    public String getName() { return name; }
    public String getAddress() { return address; }
    public String getAge() { return age; }

    // Setters - package private for builder access
    void setName(String name) { this.name = name; }
    void setAddress(String address) { this.address = address; }
    void setAge(String age) { this.age = age; }
}

// Builder interface
public interface UserDTOBuilder {
    UserDTOBuilder withFirstName(String fname);
    UserDTOBuilder withLastName(String lname);
    UserDTOBuilder withBirthday(LocalDate date);
    UserDTOBuilder withAddress(Address address);
    UserDTO build();
}

// ConcreteBuilder
public class UserWebDTOBuilder implements UserDTOBuilder {
    private String firstName;
    private String lastName;
    private String age;
    private String address;

    @Override
    public UserDTOBuilder withFirstName(String fname) {
        this.firstName = fname;
        return this;
    }

    @Override
    public UserDTOBuilder withLastName(String lname) {
        this.lastName = lname;
        return this;
    }

    @Override
    public UserDTOBuilder withBirthday(LocalDate date) {
        this.age = String.valueOf(Period.between(date, LocalDate.now()).getYears());
        return this;
    }

    @Override
    public UserDTOBuilder withAddress(Address address) {
        this.address = address.getHouseNumber() + ", " + address.getStreet() +
                       "\n" + address.getCity() + ", " + address.getState() +
                       " " + address.getZipcode();
        return this;
    }

    @Override
    public UserDTO build() {
        UserDTO dto = new UserDTO();
        dto.setName(firstName + " " + lastName);
        dto.setAddress(address);
        dto.setAge(age);
        return dto;
    }
}

// Client usage
public class Client {
    public static void main(String[] args) {
        User user = createUser();
        UserDTOBuilder builder = new UserWebDTOBuilder();

        UserDTO dto = builder
            .withFirstName(user.getFirstName())
            .withLastName(user.getLastName())
            .withAddress(user.getAddress())
            .withBirthday(user.getBirthday())
            .build();

        System.out.println(dto);
    }
}
```

## Modern Fluent Builder Example

```java
public class HttpRequest {
    private final String url;
    private final String method;
    private final Map<String, String> headers;
    private final String body;
    private final int timeout;

    private HttpRequest(Builder builder) {
        this.url = builder.url;
        this.method = builder.method;
        this.headers = builder.headers;
        this.body = builder.body;
        this.timeout = builder.timeout;
    }

    public static Builder builder(String url) {
        return new Builder(url);
    }

    public static class Builder {
        // Required parameter
        private final String url;

        // Optional parameters with defaults
        private String method = "GET";
        private Map<String, String> headers = new HashMap<>();
        private String body = "";
        private int timeout = 30000;

        private Builder(String url) {
            this.url = url;
        }

        public Builder method(String method) {
            this.method = method;
            return this;
        }

        public Builder header(String key, String value) {
            this.headers.put(key, value);
            return this;
        }

        public Builder headers(Map<String, String> headers) {
            this.headers.putAll(headers);
            return this;
        }

        public Builder body(String body) {
            this.body = body;
            return this;
        }

        public Builder timeout(int timeout) {
            if (timeout < 0) {
                throw new IllegalArgumentException("Timeout must be positive");
            }
            this.timeout = timeout;
            return this;
        }

        public HttpRequest build() {
            // Validation
            if (url == null || url.isEmpty()) {
                throw new IllegalStateException("URL cannot be null or empty");
            }
            return new HttpRequest(this);
        }
    }

    // Getters
    public String getUrl() { return url; }
    public String getMethod() { return method; }
    public Map<String, String> getHeaders() { return headers; }
    public String getBody() { return body; }
    public int getTimeout() { return timeout; }
}

// Usage
HttpRequest request = HttpRequest.builder("https://api.example.com/users")
    .method("POST")
    .header("Content-Type", "application/json")
    .header("Authorization", "Bearer token123")
    .body("{\"name\":\"John Doe\"}")
    .timeout(5000)
    .build();
```

## Query Builder Example

```java
public class SqlQuery {
    private final String table;
    private final List<String> columns;
    private final List<String> conditions;
    private final String orderBy;
    private final Integer limit;

    private SqlQuery(Builder builder) {
        this.table = builder.table;
        this.columns = builder.columns;
        this.conditions = builder.conditions;
        this.orderBy = builder.orderBy;
        this.limit = builder.limit;
    }

    public String toSql() {
        StringBuilder sql = new StringBuilder("SELECT ");
        sql.append(columns.isEmpty() ? "*" : String.join(", ", columns));
        sql.append(" FROM ").append(table);

        if (!conditions.isEmpty()) {
            sql.append(" WHERE ").append(String.join(" AND ", conditions));
        }

        if (orderBy != null) {
            sql.append(" ORDER BY ").append(orderBy);
        }

        if (limit != null) {
            sql.append(" LIMIT ").append(limit);
        }

        return sql.toString();
    }

    public static class Builder {
        private String table;
        private List<String> columns = new ArrayList<>();
        private List<String> conditions = new ArrayList<>();
        private String orderBy;
        private Integer limit;

        public Builder from(String table) {
            this.table = table;
            return this;
        }

        public Builder select(String... columns) {
            this.columns.addAll(Arrays.asList(columns));
            return this;
        }

        public Builder where(String condition) {
            this.conditions.add(condition);
            return this;
        }

        public Builder orderBy(String orderBy) {
            this.orderBy = orderBy;
            return this;
        }

        public Builder limit(int limit) {
            this.limit = limit;
            return this;
        }

        public SqlQuery build() {
            if (table == null || table.isEmpty()) {
                throw new IllegalStateException("Table name is required");
            }
            return new SqlQuery(this);
        }
    }
}

// Usage
SqlQuery query = new SqlQuery.Builder()
    .from("users")
    .select("id", "name", "email")
    .where("age > 18")
    .where("status = 'active'")
    .orderBy("name ASC")
    .limit(10)
    .build();

System.out.println(query.toSql());
// Output: SELECT id, name, email FROM users WHERE age > 18 AND status = 'active' ORDER BY name ASC LIMIT 10
```

# Known Uses

- `java.lang.StringBuilder` - builds strings incrementally
- `java.nio.ByteBuffer` and other buffer classes - build buffers step by step
- `java.util.stream.Stream.Builder` - builds streams
- `java.util.Calendar.Builder` - builds calendar instances
- Lombok `@Builder` annotation - generates builder classes

# Related Patterns

- [Abstract Factory pattern](Abstract%20Factory%20pattern.md) - similar in that both construct complex objects, but Builder constructs step-by-step while Abstract Factory emphasizes families of products
- [Composite pattern](../structural-pattern/Composite%20pattern.md) - what Builder often builds

***
# References

1. Design Patterns: Elements of Reusable Object-Oriented Software - Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides - 1994 - Addison-Wesley
   1. Chapter 3: Creational Patterns
   2. Builder pattern
2. Effective Java - Joshua Bloch - 3rd Edition - 2017 - Addison-Wesley
   1. Item 2: Consider a builder when faced with many constructor parameters
3. https://www.udemy.com/course/design-patterns-in-java-concepts-hands-on-projects/learn/ for practical examples
