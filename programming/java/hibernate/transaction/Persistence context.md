#spring #spring-jpa #dbms #query #java #jakarta-ee  #hibernate  #annotation #entity-manager 

- Equivalent to [Entity manager](programming/java/jakarta-ee/Entity%20manager.md).
# Persistence context
- A persistence context is a set of entity instances in which ==for any persistent entity identity there is a unique entity instance==. 
- Manages the entity instances and their lifecycle. 
- The persistence context is the ==first cache== where all the entities are queried.
# Transaction-scoped Persistence context
- ![](Pasted%20image%2020240722103235.png)
- The persistence context is bound to a particular transation. As soon as the transaction finishes, the entities present in the persistence context ==will be flushed into database==.
- Annotate `entityManager` with `PersistenceContextType.TRANSACTION` (or leave it as by default).
```java
@PersistenceContext
private EntityManager entityManager;
```

# Extended-scoped Persistence context
- ![](Pasted%20image%2020240722103555.png)
- The extended-scoped persistence context spans aross multiple transactions. We can ==persist the entity without any transation but cannot flush it without a transation==.
- If the session bean is stateless, the extended-scoped persistence context in one component is ==unware of that of another componen==t. Even if the two components in a same transation, this still holds true.
- Annotate `entityManager` with `@PersistenceContext(type = PersistenceContextType.EXTENDED)` annotation
```java
@Component
public class ExtendedPersistenceContextUserService {

    @PersistenceContext(type = PersistenceContextType.EXTENDED)
    private EntityManager entityManager;

    // Remaining code same as above
}
```
---
# References
1. https://www.baeldung.com/jpa-hibernate-persistence-context for persistenc context