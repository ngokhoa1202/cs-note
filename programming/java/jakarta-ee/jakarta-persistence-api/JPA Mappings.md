#jpa #spring-jpa #quarkus #jakarta-ee #java #annotation #dbms #sql #relational-model #relational-mapping #relational-algebra #software-engineering #software-architecture
# Overview
- Jakarta Persistence API (JPA) provides object-relational mapping (ORM) annotations to map entity classes to relational database tables.
- JPA mappings define the relationships between entities, corresponding to foreign key constraints in the underlying database schema.
- Relationship mappings preserve referential integrity and enable navigation between related entities in the object model.
# Mapping Categories
## Classification by Cardinality
- Mappings are classified by the cardinality of relationships between entities:
	- One-to-one relationship ($1:1$): Each entity instance relates to at most one instance of another entity
	- Many-to-one relationship ($N:1$): Multiple instances of one entity relate to a single instance of another entity
	- Many-to-many relationship ($M:N$): Multiple instances of one entity relate to multiple instances of another entity
## Classification by Directionality
- Mappings are classified by the directionality of navigation between entities:
	- Uni-directional relationship: Only one entity holds a reference to the other entity
		- Navigation is possible in only one direction
		- Only the owning entity must be updated when the relationship changes
		- Simpler to maintain but less flexible for queries
	- Bi-directional relationship: Both entities hold references to each other
		- Navigation is possible in both directions
		- Both entities must be updated when the relationship changes
		- More complex to maintain but provides greater query flexibility
# One-to-One Mapping
## Characteristics
- Each entity instance on one side relates to at most one entity instance on the other side.
- The foreign key can reside in either table, determining which entity is the owner.
- The owning side contains the `Java` `@JoinColumn` annotation.
- The inverse side uses the `mappedBy` attribute to reference the owning side.
## Scenario
- One person has at most one personal tax identification.
- One personal tax identification belongs to exactly one person.
## Bi-directional One-to-One Mapping
### Owner Side
- The owner side contains the foreign key column in the database.
- The `Java` `@OneToOne` annotation declares the relationship cardinality.
- The `Java` `@JoinColumn` annotation specifies the foreign key column and its referenced column.
```Java
@Entity
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "person_id")
    private Long id;

    @Column(name = "name")
    private String name;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "fk_tax_id", referencedColumnName = "tax_id")
    private TaxIdentification taxIdentification;

    public void setTaxIdentification(TaxIdentification taxId) {
        this.taxIdentification = taxId;
        if (taxId != null) {
            taxId.setPerson(this);
        }
    }
}
```
### Inverse Side
- The inverse side uses the `mappedBy` attribute to reference the property name on the owner side.
- The `mappedBy` attribute indicates this side does not own the relationship.
```Java
@Entity
@Table(name = "tax_identification")
public class TaxIdentification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tax_id")
    private Long id;

    @Column(name = "tax_number")
    private String taxNumber;

    @OneToOne(mappedBy = "taxIdentification")
    private Person person;

    public void setPerson(Person person) {
        this.person = person;
    }
}
```
### Maintaining Bi-directional Consistency
- When establishing a bi-directional one-to-one relationship, both sides must be updated.
- Helper methods should synchronize both sides of the relationship automatically.
```Java
Person person = new Person();
person.setName("John Doe");

TaxIdentification taxId = new TaxIdentification();
taxId.setTaxNumber("123-45-6789");

person.setTaxIdentification(taxId); // Sets both sides

em.persist(person);
```
## Uni-directional One-to-One Mapping
- Only the owner side holds a reference to the related entity.
- Navigation is possible only from the owner to the owned entity.
```Java
@Entity
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "person_id")
    private Long id;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "fk_tax_id", referencedColumnName = "tax_id")
    private TaxIdentification taxIdentification;
}
```

```Java
@Entity
@Table(name = "tax_identification")
public class TaxIdentification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tax_id")
    private Long id;

    @Column(name = "tax_number")
    private String taxNumber;

    // No reference back to Person
}
```
# Many-to-One and One-to-Many Mapping
## Characteristics
- Multiple instances of one entity relate to a single instance of another entity.
- The many side (child) contains the foreign key in the database.
- The many side is always the owner of the relationship.
- The one side (parent) uses the `mappedBy` attribute for bi-directional relationships.
## Scenario
- One order contains many order items.
- Each order item belongs to exactly one order.
- This represents a *many-to-one* relationship from the perspective of order items.
- This represents a *one-to-many* relationship from the perspective of orders.
## Bi-directional Many-to-One Mapping
### Many Side (Owner)
- The `Java` `@ManyToOne` annotation declares the many-to-one relationship.
- The `Java` `@JoinColumn` annotation specifies the foreign key column and its referenced column.
- The `fetch` attribute controls the loading strategy:
	- `FetchType.EAGER`: The related entity is loaded immediately with the owning entity (default for `Java` `@ManyToOne`)
	- `FetchType.LAZY`: The related entity is loaded only when accessed
- The `optional` attribute specifies whether the foreign key column is nullable:
	- `optional = false`: The foreign key column is `NOT NULL` (default is `true`)
	- `optional = true`: The foreign key column is nullable
```Java
@Entity
@Table(name = "order_item")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "item_id")
    private Long id;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "quantity")
    private Integer quantity;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "fk_order", referencedColumnName = "order_id")
    private Order order;

    public void setOrder(Order order) {
        this.order = order;
    }
}
```
### One Side (Inverse)
- The `Java` `@OneToMany` annotation declares the one-to-many relationship.
- The `mappedBy` attribute references the property name on the many side that owns the relationship.
- The `orphanRemoval` attribute controls whether orphaned entities are deleted:
	- `orphanRemoval = true`: Child entities removed from the collection are deleted from the database
	- `orphanRemoval = false`: Child entities removed from the collection remain in the database (default)
- The collection type should be `Java` `Set`, `Java` `List`, or other `Java` `Collection` implementations.
- Using `Java` `Set` prevents duplicate entries and improves performance for large collections.
```Java
@Entity
@Table(name = "order_table")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long id;

    @Column(name = "order_date")
    private LocalDateTime orderDate;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<OrderItem> items = new HashSet<>();

    public void addItem(OrderItem item) {
        items.add(item);
        item.setOrder(this);
    }

    public void removeItem(OrderItem item) {
        items.remove(item);
        item.setOrder(null);
    }
}
```
### Maintaining Bi-directional Consistency
- When adding or removing entities from a bi-directional relationship, both sides must be updated.
- Helper methods should synchronize both sides automatically to prevent inconsistencies.
```Java
Order order = em.find(Order.class, 1L);

OrderItem item = new OrderItem();
item.setProductName("Laptop");
item.setQuantity(2);

order.addItem(item); // Updates both sides

em.persist(item);
```
## Uni-directional Many-to-One Mapping
- The child entity holds a foreign key to the parent entity.
- The parent entity does not reference its children.
- Navigation is possible only from child to parent.
```Java
@Entity
@Table(name = "order_item")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "item_id")
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "fk_order", referencedColumnName = "order_id")
    private Order order;
}
```
```Java
@Entity
@Table(name = "order_table")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long id;

    @Column(name = "order_date")
    private LocalDateTime orderDate;

    // No reference to OrderItem collection
}
```
### Use Cases
- The parent entity is lightweight and does not need to track its children.
- The domain model should remain simple without bidirectional navigation complexity.
- Queries primarily navigate from child to parent rather than parent to children.
## Uni-directional One-to-Many Mapping
- The parent entity holds references to its children.
- The child entities do not reference their parent.
- The foreign key resides in the child table, but the relationship is declared on the parent entity.
- The `Java` `@JoinColumn` annotation on the parent specifies the foreign key column in the child table.
```Java
@Entity
@Table(name = "order_table")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long id;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "fk_order")
    private Set<OrderItem> items = new HashSet<>();
}
```
```Java
@Entity
@Table(name = "order_item")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "item_id")
    private Long id;

    @Column(name = "product_name")
    private String productName;

    // No reference to Order
}
```
### Use Cases
- Child entities do not need to know their parent entity.
- The parent entity fully controls the lifecycle of its children.
# Many-to-Many Mapping
## Characteristics
- Multiple instances of one entity relate to multiple instances of another entity.
- Requires a join table (also called lookup table or junction table) in the database schema.
- JPA maps the relationship using two entities and manages the join table automatically.
- The `Java` `Set` collection type is recommended over `Java` `List` to prevent duplicate entries and improve performance.
## Scenario
- One store sells many products.
- One product is sold in many stores.
- This represents a *many-to-many* relationship between stores and products.
## Bi-directional Many-to-Many Mapping
### Owner Side
- One side is designated as the owner and defines the join table structure.
- The `Java` `@ManyToMany` annotation declares the many-to-many relationship.
- The `Java` `@JoinTable` annotation specifies the join table and its columns:
	- `name`: The join table name
	- `joinColumns`: The foreign key column(s) referencing the owner entity
	- `inverseJoinColumns`: The foreign key column(s) referencing the inverse entity
```Java
@Entity
@Table(name = "store")
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id")
    private Long id;

    @Column(name = "store_name")
    private String name;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
        name = "store_product",
        joinColumns = @JoinColumn(name = "fk_store", referencedColumnName = "store_id"),
        inverseJoinColumns = @JoinColumn(name = "fk_product", referencedColumnName = "product_id")
    )
    private Set<Product> products = new HashSet<>();

    public void addProduct(Product product) {
        products.add(product);
        product.getStores().add(this);
    }

    public void removeProduct(Product product) {
        products.remove(product);
        product.getStores().remove(this);
    }
}
```
### Inverse Side
- The inverse side uses the `mappedBy` attribute to reference the property name on the owner side.
- The `mappedBy` attribute indicates this side does not define the join table structure.
```Java
@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long id;

    @Column(name = "product_name")
    private String name;

    @ManyToMany(mappedBy = "products")
    private Set<Store> stores = new HashSet<>();

    public Set<Store> getStores() {
        return stores;
    }
}
```
### Maintaining Bi-directional Consistency
- When adding or removing entities from a many-to-many relationship, both sides must be updated.
- Helper methods on the owner side should synchronize both sides automatically.
```Java
Store store = em.find(Store.class, 1L);
Product product = em.find(Product.class, 10L);

store.addProduct(product); // Updates both sides and join table

em.merge(store);
```
## Uni-directional Many-to-Many Mapping
- Only one entity holds references to the related entities.
- The other entity does not reference back.
- Navigation is possible in only one direction.
```Java
@Entity
@Table(name = "store")
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id")
    private Long id;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
        name = "store_product",
        joinColumns = @JoinColumn(name = "fk_store", referencedColumnName = "store_id"),
        inverseJoinColumns = @JoinColumn(name = "fk_product", referencedColumnName = "product_id")
    )
    private Set<Product> products = new HashSet<>();
}
```
```Java
@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long id;

    @Column(name = "product_name")
    private String name;

    // No reference to Store
}
```
### Use Cases
- One entity needs to navigate to related entities, but the inverse navigation is unnecessary.
- Simplifies the domain model by reducing bidirectional coupling.
# Fetch Strategies
## Eager Fetching
- The related entity is loaded immediately when the owning entity is loaded.
- Specified with `FetchType.EAGER`.
- Default for `Java` `@ManyToOne` and `Java` `@OneToOne` relationships.
- Can cause performance issues if the related entity has many associations (N+1 query problem).
```Java
@ManyToOne(fetch = FetchType.EAGER)
@JoinColumn(name = "fk_order")
private Order order;
```
## Lazy Fetching
- The related entity is loaded only when it is accessed for the first time.
- Specified with `FetchType.LAZY`.
- Default for `Java` `@OneToMany` and `Java` `@ManyToMany` relationships.
- Requires an active persistence context to load the entity.
- Accessing a lazy-loaded entity outside the persistence context throws `LazyInitializationException`.
```Java
@OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
private Set<OrderItem> items = new HashSet<>();
```
## Best Practices
- Use `FetchType.LAZY` as the default to avoid loading unnecessary data.
- Override with `FetchType.EAGER` only for frequently accessed associations.
- Use JPQL or Criteria API with `JOIN FETCH` for query-specific eager loading.
```Java
TypedQuery<Order> query = em.createQuery(
    "SELECT o FROM Order o JOIN FETCH o.items WHERE o.id = :id", Order.class);
query.setParameter("id", orderId);
Order order = query.getSingleResult();
```
# Cascade Operations
## Purpose
- Cascade operations propagate persistence operations from parent entities to related child entities.
- The `cascade` attribute on relationship annotations specifies which operations should cascade.
## Cascade Types
- `CascadeType.PERSIST`: Cascades the persist operation to related entities
- `CascadeType.MERGE`: Cascades the merge operation to related entities
- `CascadeType.REMOVE`: Cascades the remove operation to related entities
- `CascadeType.REFRESH`: Cascades the refresh operation to related entities
- `CascadeType.DETACH`: Cascades the detach operation to related entities
- `CascadeType.ALL`: Cascades all operations to related entities
## Example
```Java
@OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
private Set<OrderItem> items = new HashSet<>();
```
- When the `Java` `Order` entity is persisted, all `Java` `OrderItem` entities in the collection are persisted automatically.
- When the `Java` `Order` entity is removed, all `Java` `OrderItem` entities are removed automatically.
- When an `Java` `OrderItem` is removed from the collection and `orphanRemoval = true`, the removed item is deleted from the database.
## Best Practices
- Use `CascadeType.ALL` carefully as it can lead to unintended deletions.
- Use specific cascade types (`PERSIST`, `MERGE`) instead of `ALL` for better control.
- Combine `CascadeType.REMOVE` with `orphanRemoval = true` for parent-controlled child lifecycle management.
- Avoid cascading `REMOVE` on many-to-many relationships to prevent accidental deletion of shared entities.
# Orphan Removal
- The `orphanRemoval` attribute specifies whether child entities should be deleted when removed from the parent's collection.
- Only applicable to `Java` `@OneToOne` and `Java` `@OneToMany` relationships where the parent owns the child's lifecycle.
- Not applicable to `Java` `@ManyToOne` or `Java` `@ManyToMany` relationships.
```Java
@OneToMany(mappedBy = "order", orphanRemoval = true)
private Set<OrderItem> items = new HashSet<>();
```
- When an `Java` `OrderItem` is removed from the `items` collection, it is deleted from the database.
- When the parent-child link is set to `null`, the orphaned child is deleted.
```Java
order.getItems().remove(item); // Deletes item from database
item.setOrder(null); // Also deletes item if orphanRemoval is true
```
# Best Practices
## Choose Appropriate Directionality
- Use uni-directional mappings when navigation is needed in only one direction.
- Use bi-directional mappings when queries frequently require navigation in both directions.
- Bi-directional mappings add complexity and require synchronization helper methods.
## Use Appropriate Collection Types
- Use `Java` `Set` for `Java` `@OneToMany` and `Java` `@ManyToMany` to prevent duplicates.
- Use `Java` `List` when order matters and duplicates are allowed.
- Initialize collections to avoid `NullPointerException`.
```Java
private Set<OrderItem> items = new HashSet<>();
```
## Synchronize Bi-directional Relationships
- Provide helper methods to update both sides of bi-directional relationships automatically.
- Prevents inconsistent object states and ensures proper persistence.
```Java
public void addItem(OrderItem item) {
    items.add(item);
    item.setOrder(this);
}

public void removeItem(OrderItem item) {
    items.remove(item);
    item.setOrder(null);
}
```
## Avoid Circular References in toString and hashCode
- Do not include bi-directional associations in `Java` `toString()`, `Java` `hashCode()`, or `Java` `equals()` methods.
- Circular references cause infinite recursion and `StackOverflowError`.
```Java
@Override
public String toString() {
    return "Order{id=" + id + ", orderDate=" + orderDate + "}";
    // Do not include items collection
}
```
## Use Lazy Loading by Default
- Set `fetch = FetchType.LAZY` for collections and non-essential associations.
- Use query-specific eager loading with `JOIN FETCH` when needed.
- Reduces memory consumption and improves performance.
***
# References
1. Jakarta Persistence API Specification
	1. https://jakarta.ee/specifications/persistence/
2. Hibernate ORM User Guide - Association Mappings
	1. https://thorben-janssen.com/ultimate-guide-association-mappings-jpa-hibernate/
3. EER-to-Relational Mapping
	1. [[EER-to-Relational Mapping]]
4. Entity Manager
	1. [[Entity manager]]
5. JPA Best Practices
	1. https://docs.jboss.org/hibernate/orm/current/userguide/html_single/Hibernate_User_Guide.html
