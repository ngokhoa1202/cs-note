#jpa #spring-jpa #quarkus #jakarta-ee #java #annotation #dbms #sql
#relational-model  #relational-mapping #relational-model #relational-algebra
#software-engineering #software-architecture 
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
### Bi-directional association
#### The N-side
- `@ManyToOne` annotation is used to specify the cardinality of the association
	- Its `fetch` attribute specifies the 1-side entity should be either *eagerly* loaded or *lazily* loaded. The default value is `FetchType.EAGER`.
	- Its `optional` attribute specifies whether the 1-side entity, which is represented by the *foreign key* column on the owner side's table, is *nullable* or not.
- Because only the entity on the N-side can keep the foreign key, the *join operation*  is specified with `@JoinColumn` annotation to join the two entities using the foreign key.
```Java title='Many-to-one mapping on N-side class'
@Entity
public class OrderItem {
    @ManyToOne
    @JoinColumn(name = “fk_order”, referencedColumnName = "order_id")
    private Order order;
    ...
}
```
#### The 1-side
- Because the owner side has already specified the relationship mapping, the entity on the 1-side only has to be specified with `{Java} @OneToMany` annotation.
	- The `mappedBy` attribute specifies the *property* defined on the N-side entity to complete the mapping.
	- The `orphanRemoval` attribute specifies whether the child entity, which is represented by a record on the 1-side table, will be removed or not in case the child entity is removed from its parental collection or the parent-child link is set to `null`.
- The attribute annotated `{Java}@OneToMany` must be of type `Collection` 
```Java title='Many-to-one mapping on 1-side class' hl=1,3-4,7-8
@Entity
public class Order {
	 @OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
	 private Set<OrderItem> items = new HashSet<>();
	 
	public void removeItem(OrderItem item) {
        this.items.remove(employee);
        item.setOrder(null);
    }
}
```
#### Update relationship
- When an entity is added or removed from the relationship, the classes of both sides need to be updated.
```Java title='Guideline to update the relationship' hl=5-6
Order o = em.find(Order.class, 1L);

OrderItem i = new OrderItem();

i.setOrder(o);
o.getItems().add(i);

em.persist(i);
```
### Uni-directional association
#### Uni-directional many-to-one association
##### Mechanism
- The child entity holds a foreign key pointing to a parent entity, but the *parent does not reference the child*.
- The parent entity can be navigated from the child entity, but not vice versa.
```Java title='Uni-directional many-to-one association specified only on N-side'
@Entity
public class OrderItem {
    @ManyToOne(optional = false) // an item must belong to a specific order
    @JoinColumn(name = “fk_order”, referencedColumnName = "order_id")
    private Order order;
    ...
}
```
##### Usage
- The parent class is lightweight or unaware of its child classes.
- The domain should stay simple.
#### Uni-directional one-to-many association
##### Mechanism
- The parent entity holds multiple foreign keys pointing to the child entities, but these child entities do not reference to its parent.
- A `{Java}@JoinColumn` annotation must be specified on the parent class while the foreign key remains on the child table, which is unusual.
- The child entities can be navigated from its parental entity, but not vice versa.
```Java title='Uni-directional one-to-many association on the 1-side' hl=4
@Entity
public class Order {
	 @OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
	 @JoinColumn(name = "fk_order") // foreign key column in order_item table
	 private Set<OrderItem> items = new HashSet<>();
	 
}
```
##### Usage
- The child entities do not need to know its parent.
# Many-to-many mapping
- On the database layer, a new *lookup table* is required to represent the many-to-many relationship. JPA, however, is able to map the relationship using *two entities* only.
- The `Set` data structure is recommended to store a collection of entities in many-to-many mapping because `Set` stores duplicate elements more efficiently than `List`.
## Scenario
- One store sells many products.
- One product can be sold in many different stores.
$\implies$ *Many* stores to *many* products.
## Usage
### Bi-directional association
- Because the role of both sides is equivalent in many-to-many relationship, we can select an arbitrary side to define the association and the other side just has to reference it.
#### The owner side
- The cardinality needs specifying in the two classes using `{Java}@ManyToMany` annotation.
- The many-to-many mapping is specified on *one arbitrary side* using the `@JoinTable` annotation.
	- The`joinColumns` attribute specifies the foreign key column of the *owner* and its reference column.
	- The`inverseJoinColumns` attribute specifies the foreign key column of the *other side entity* and its reference column.
```Java title='Bi-directional many-to-many mapping on the owner side' hl=4-7,8,10-11,14
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
- The attribute annotated with `{Java}@JoinTable` must be of type `Collection`.
#### The reference side
- Because the relationship has already been defined on the owner side, the reference only has to be specified with`@ManyToMany` annotation using `mappedBy` attribute.
- The attribute annotated with `@ManyToMany` must be of type `Collection`.
```Java title='Bi-directional many-to-many mapping on the reference side' hl=4-5
@Entity
public class Product{

    @ManyToMany(mappedBy=”products”)
    private Set<Store> stores = new HashSet<Store>();

}
```
### Uni-directional association
- 
***
# References
1. [EER-to-Relational Mapping](EER-to-Relational%20Mapping.md) for SQL relational mappings.
2. Jakarta EE 10 Specification.
3. https://thorben-janssen.com/ultimate-guide-association-mappings-jpa-hibernate/ 
