#jpa #spring-jpa #quarkus #jakarta-ee #java #annotation #dbms #sql #relational-model  #relational-mapping #spring #spring-framework #spring-boot 
# Category
- Categorized by relational mappings:
	- One-to-one relationship $\equiv 1:1$ .
	- Many-to-one relationship $\equiv N : 1$ .
	- Many-to-many relationship $\equiv M : N$ .
- Categorized by the direction of mappings:
	- Uni-directional relationship $\equiv$ only <mark style="background: #e4e62d;">one</mark> entity holds the reference to the other entity in a relationship $\implies$ only <mark style="background: #e4e62d;">update one</mark> of the entities if the relationship changes
	- Bi-directional relationship $\equiv$ <mark style="background: #e4e62d;">both</mark> entities in a relationship must hold a reference to the other entity. $\implies$ <mark style="background: #e4e62d;">update two of the entities</mark> if the relationship changes.
# One-to-one mapping
## Scenario
- One person either has one personal tax identification or not.
- One personal tax identification belongs to only one person.
## Usage

# Many-to-one mapping
## Scenario
- One item belongs to one order.
- One order manages many items.
$\implies$ <mark style="background: #e4e62d;">Many</mark> items to <mark style="background: #e4e62d;">One</mark> order.
## Usage
### Uni-directional association

### Bi-directional association
#### The N-side
- Specify the cardinality of the association using `@ManyToOne` annotation:
	- The default fetch type is `FetchType.EAGER` $\implies$ the entity on the 1-side is eagerly fetchted.
- Because only the entity on the N-side can keep the foreign key, specify the<mark style="background: #e4e62d;"> join operation</mark> using `@JoinColumn` annotation to join the two entities using the foreign key.
```Java
@Entity
public class OrderItem {
    @ManyToOne
    @JoinColumn(name = “fk_order”, referencedColumnName = "order_id")
    private Order order;
    ...
`}`
```

#### The 1-side
- Because the owner side has already specified the relationship mapping, we only have to specify `@OneToMany` annotation on the entity on the 1-side:
	- Specify the <mark style="background: #e4e62d;">property</mark> defined on the N-side entity using `mappedBy` attribute to complete the mapping.
#### Update relationship
- When adding or removing an entity from the relationship, we have to <mark style="background: #e4e62d;">update on the both sides</mark>:
```java
Order o = em.find(Order.class, 1L);

OrderItem i = new OrderItem();

i.setOrder(o);

o.getItems().add(i);

em.persist(i);
```

# Many-to-many mapping
- On the database layer, a new lookup table is required to represent the many-to-many relationship. But JPA is able to map the relationship <mark style="background: #e4e62d;">using two entities</mark> only.
- Always opt for `Set` data structure to store a collection of entities in many-to-many mapping because `Set` stores duplicate elements more efficiently than `List`.
## Scenario
- One store sells many products.
- One product belongs many different stores.
$\implies$ Many stores to many products.
## Usage
### Uni-directional mapping

### Bi-directional mapping
- Because the role of both sides is equivalent in many-to-many relationship, we can select an arbitrary side to define the association and the other side just has to reference it.
#### The owner side
- Specify the cardinality using `@ManyToMany`
- Specify the mapping using the `@JoinTable` annotation:
	- Specify the foreign key column of the owner itself and its reference column using `joinColumns` attribute.
	- Specify the foreign key column of the other side entity and its reference column using `inverseJoinColumns` attribute.
```java
@Entity
public class Store {

    @ManyToMany
    @JoinTable(
	    name = “store_product”,`
		joinColumns = {
			@JoinColumn(name = “fk_store”, referencedColumnName="store_id") 
		},
		inverseJoinColumns = {
			@JoinColumn(name = “fk_product”, referencedColumnName="id") 
		}
	)
    private Set<Product> products = new HashSet<Product>();
}
```
- The `name` and `referencedColumnName` are the names of column on database side, not on the application side Hibernate.

#### The reference side
- Specify the cardinality using `@ManyToMany` annotation.
- Reference to the owner side's relationship definition using `mappedBy` attribute.
```java
@Entity

public class Product{

    @ManyToMany(mappedBy=”products”)
    private Set<Store> stores = new HashSet<Store>();

}
```
---
# References
1. [EER-to-Relational Mapping](EER-to-Relational%20Mapping.md) for Sql relational mappings.
2. Jakarta EE 10 Specification.
3. https://thorben-janssen.com/ultimate-guide-association-mappings-jpa-hibernate/ 
