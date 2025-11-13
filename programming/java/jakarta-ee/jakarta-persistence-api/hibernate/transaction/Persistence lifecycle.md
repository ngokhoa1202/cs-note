#hibernate #jakarta-ee #java #java8 #dbms #query #software-engineering  #software-architecture #garbage-collector #constructor 
#transaction #jpa #spring-jpa #orm 

# Entity instance states
- The overview relationship graph:
- ![800](Pasted%20image%2020240822164219.png)
## Transient state
- The entity instance is created with the `new` operator and ==volatile==.
- When an object is no longer referenced, it is destroyed by the garbage collector.
- To transit to the Persistent state, `EntityManager.persist()` or `Entity.merge()` is required.
## Persistent state
- The entity instance now has ==its representation in the database==:
	- It has been stored in the database within the current transaction.
	- It will be definitely stored in the database right after the transaction finishes.
	- Or the entity instance has been retrieved from the database using query.
- The entity instance in the Persistent is always managed by a Persistence Context.
- To check whether the object is in persistent state, call `EntityManger.contains(o)`.
## Removed state
- The entity instance is completely removed from the database:
	- It is removed by calling the method `EntityManager.remove()`. and will be actually right after the current transaction ends.
	- Its reference is removed from the mapped collection when *orphan removal* is enabled.
## Detached state
- The entity instance is ==no longer managed by the Persitence Context== as the transaction has already ended.
- The entity instance can be intentionally modified and return to the Persistent state when calling `EntityManager.merger`

# Entity manager
- The API provided by Hibernate to manage entity instance.
- [Entity manager](programming/java/jakarta-ee/jakarta-persistence-api/hibernate/transaction/Entity%20manager.md) 

# References
1. Java Persistence with Hibernate - 2th edition - Chapter 10: Managing data.
2. [Persistence context](programming/java/jakarta-ee/jakarta-persistence-api/hibernate/transaction/Persistence%20context.md) for Jakarta Persistence Context.           
3. [Entity manager](programming/java/jakarta-ee/jakarta-persistence-api/Entity%20manager.md) for entity manager.
4. 