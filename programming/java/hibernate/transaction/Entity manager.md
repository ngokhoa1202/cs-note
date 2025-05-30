#hibernate #sql #dbms #java #spring-jpa #entity-manager  #jakarta-ee #jpa #transaction #entity-manager #nosql 

- Hibernate implements [Entity manager](programming/java/jakarta-ee/Entity%20manager.md) API on top of Database vendor drivers (PostgreSQL, Oracle, MySQL, ...)  and obviously ==creates an abstract layer.==

# Handle database vendor driver exception
- In some case, the mutable operations are only committed to the database at the end of the current transaction. As a result, `try catch` does not work. To resolve this, call `EntityManager.flush()`  to <mark style="background: #e4e62d;">force the application to commit</mark> the database layer.
- If the operation fails, there will be an ==exception== which is automatically ==thrown from the Database Driver layer== and that exception will ==propagate== to the Hibernate layer.
- Check out the ==database vendor documentation== to know what has happened to your entity instance.
- For example:
	- `org.postgresql.util.PSQLException(<logging-message>, org.postgresql.util.PSQLState.<State>)` is encapsulated into `org.hibernate.exception.ConstraintViolationException` with its constraint name in database.

# Make entity instance persistent
- ![](Pasted%20image%2020240822175607.png)
- The field with `@Id` annotation is automatically generated by the Persistence Context.
# Retrieve and update persistent entity instance
- ![800x500](Pasted%20image%2020240822181659.png)
- During the duration that the entity instance is being updated, Hibernate performs database necessary database locking.
# Retrieve a reference to entity instance
- If it is unnecessary to fully initialize the entity instance after being queried from database, call `EntityManager.getReference()` 
	- If the entity instance has ==already existed== in the persistence context, Hibernate will automatically return a reference to that object ==without hitting the database==.
	- Or Hibernate only ==initializes a shallow proxy== and defers the `SELECT` query statement. It lazily executes the query only if you access the entity instance.
## Advantages
- Slightly boost your performance because of I/O minimization.
# Make entity instance transient
- ![800](Pasted%20image%2020240823095707.png)
- Only when the transaction ends or the `flush` method is explicitly called, the entity instance is certainly in transient state and will be garbage collected.
# Refresh the entity instance
- Performs a `SELECT`query from the database and overwrites all of the changes having been made to the current entity instance.
- Understood as "undo" operation.
# Replicate the entity instance (ongoing)
- Takes an detached entity instance loaded in one persistence context and makes them ==persistent in another persistent context==.
- Used to replicate data in multiple databases.
- `ReplicationMode`
# Hibernate caching in persistence context
- The [Hibernate dirty checking](Hibernate%20dirty%20checking.md) mechanism can lead to memory exhaustion because Hibernate allows caching entity instance within a Persistence Context.
- Use `queryHints` to disable caching mechanism
# Flush the persistence context
- Flushing means that you make a <mark style="background: #e4e62d;">commit</mark> from the transient$^{1}$ application instance stored on RAM to the <mark style="background: #e4e62d;">persistent record</mark> stored on disk, which implies that Hibernate is explicitly forced to <mark class="hltr-yellow">synchronize all of its changes with the database</mark>.
- The result ends up either one of the two cases:
	- The entity instance is successfully stored on disk $\implies$ synchronized.
	- Hibernate failed to update the record and automatically rollback transaction $\implies$ nothing has changed.
- Hibernate, as a JPA implementation, synchronizes when:
	- A joined JTA system transaction is committed.
	- Before a query is executed — a query with `javax.persistence.Query` or the similar Hibernate API.
	- When the application calls `flush()` explicitly.
```java title='Flush mode for the entity manager'
tx.begin();

EntityManager em = JPA.createEntityManager();  
Item item = em.find(Item.class, ITEM_ID); // Loads Item instance
item.setName("New Name"); // Changes instance name
em.setFlushMode(FlushModeType.COMMIT); // Disables flushing before queries
assertEquals(
	em.createQuery("select i.name from Item i where i.id = :id")
		.setParameter("id", ITEM_ID).getSingleResult(),
	"Original Name"
	Gets instance name
);
tx.commit(); // flush
em.close();
```
- There are two flush mode:
	- `FlushModeType.AUTO` is the default flush mode: Hibernate recognizes that data has changed in memory and <mark class="hltr-yellow">synchronizes</mark> these modifications with the database <mark class="hltr-yellow">before the query</mark>.
	- `FlushModeType.COMMIT` disables flushing before queries. The synchronization does not occurs until the transaction commits. As a result, different data can be returned by the query than what is in memory.
# Working with detached entity instance
## Check equality
- Explicitly implements `equals` method and `hashCode` to check equality for detached entity instance.
```Java title='Equality checking and hash code implementation for entity class'
package com.hrm.leavemanagement.persistence.category.region;

import com.hrm.leavemanagement.persistence.leave.request.career.CareerLeaveRequest;
import com.hrm.leavemanagement.persistence.leave.request.health.HealthLeaveRequest;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.proxy.HibernateProxy;
import org.hibernate.type.NumericBooleanConverter;

import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;
import java.util.UUID;

@Entity
@Table(name = "countries", schema = "category")
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Country {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer id;

  @Column(name = "name", nullable = false, length = 255, columnDefinition = "VARCHAR(255)")
  private String name;

  @Column(name = "iso_code", nullable = false, length = 255, columnDefinition = "VARCHAR(255)")
  private String isoCode;

  @Column(name = "is_active", columnDefinition = "TINYINT")
  @Convert(converter = NumericBooleanConverter.class)
  @Builder.Default
  private Boolean isActive = true;

  @OneToMany(mappedBy = "country",
    fetch = FetchType.LAZY,
    cascade = {CascadeType.DETACH, CascadeType.REFRESH},
    orphanRemoval = false)
  @Builder.Default
  private Set<CareerLeaveRequest> careerLeaveRequests = new TreeSet<>();

  @OneToMany(mappedBy = "country",
    fetch = FetchType.LAZY,
    cascade = { CascadeType.DETACH, CascadeType.REFRESH },
    orphanRemoval = false)
  @Builder.Default
  private Set<HealthLeaveRequest> healthLeaveRequests = new TreeSet<>();

  @OneToMany(mappedBy = "country",
    fetch = FetchType.LAZY,
    cascade = { CascadeType.DETACH, CascadeType.REFRESH },
    orphanRemoval = true)
  @Builder.Default
  private Set<City> cities = new TreeSet<>();

  @Column(name = "batch_id", nullable = true, updatable = false, unique = false)
  @Builder.Default
  private UUID batchId = null;

  @Override
  public final boolean equals(Object o) {
    if (this == o) return true;
    if (o == null) return false;
    Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
    Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
    if (thisEffectiveClass != oEffectiveClass) return false;
    Country country = (Country) o;
    return getId() != null && Objects.equals(getId(), country.getId());
  }

  @Override
  public final int hashCode() {
    return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
  }
}

```
## Merge entity instances
- ![](Pasted%20image%2020240823140026.png)
- Hibernate first checks whether there is a persistent entity instance having the same identifier as the detached entity instance's identifier within the current persistence context or not.
- If not, Hibernate therefore ==finds== an instance with that identifier from the database. If there exists, the `merge`  overwrites the detached entity instance onto the loaded persistent entity instance.
- If the `merge` performs on a ==transient== entity instance without identifier field, Hibernate will ==instantiate== a fresh entity instance, ==copy== the value of the transient object onto it and ==make it persistent==.
## Remove a detached entity instance
- Merge the entity instance first, then remove it from the persistent context.
---
# Auxiliary
1. For me, for this context, the word "volatile" sounds more technical for the hardware.
---

# References
1. https://www.codejava.net/frameworks/spring-boot/spring-data-jpa-entitymanager-examples for implementation reference.
2. [Persistence lifecycle](Persistence%20lifecycle.md) 
3. Java Persistence with Hibernate - Christian Bauer, Gavin King, Gary Gregory - 2th edition - Manning Publisher.
	1. Part 3: Transactional data processing.
		1. Chapter 10. Managing data.
