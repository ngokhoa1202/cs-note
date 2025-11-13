#dbms #hibernate #data-access-object #java #jakarta-ee #software-architecture 
#database-locking 
# Dirty checking mechanism
```Java title='Dirty checking example in Hibernate' hl=8
Session session = sessionFactory.openSession();
session.beginTransaction();

// Load an entity from the database
Employee employee = session.get(Employee.class, 1L);

// Modify the entity
employee.setSalary(60000);

// At this point, no SQL update statement is sent to the database

// Commit the transaction (session will flush automatically)
session.getTransaction().commit();
session.close();
```

- An `Employee` entity is queried from the database. Hibernate automatically ==generates a copy== of that entity instance.
- When that entity instance is ==mutated== by the application, Hibernate does not immediately execute an update operation but ==marks the entity instance as "dirty"==.
- When the session is flushed, Hibernate ==checks== the current entity instance state ==against its original state==. Hibernate knows that the entity instance is ==in "dirty" state== and ==automatically generate== the SQL`UPDATE` statement to synchronize it.

# Disable dirty caching
- To disable dirty caching, set read-only mode for the current transaction.
# Disadvantage
- Incur performance overhead.
- Higher memory usage.
***
# References
1. 