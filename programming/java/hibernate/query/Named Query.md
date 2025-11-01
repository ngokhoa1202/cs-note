#hibernate  #dbms #jpql #spring #spring-boot #jakarta-ee #java #entity-manager #spring-jpa #jpa 
#query-hint 
# Entity manager
- Understood as a ==labelled query== and that query can be ==reusable==.
- Use `@NamedQueries({...})` and `@NamedQuery` annotation right above the entity class.
```java
package org.hospital.appointment.employee.role;  
  
import jakarta.persistence.*;  
import lombok.*;  
  
import java.util.UUID;  
  
@Entity  
@Table(name = "employee_roles")  
@NoArgsConstructor  
@AllArgsConstructor // remember this one to employ builder  
@Getter  
@Setter  
@Builder  
@NamedQueries({  
  @NamedQuery(  
    name = "findById",  
    query = "SELECT role FROM EmployeeRole role WHERE role.uuid = :id"  
  ),  
  @NamedQuery(  
    name = "findByName",  
    query = "SELECT role FROM EmployeeRole role WHERE role.name LIKE :name"  
  )  
})  
  
  
public class EmployeeRole {  
  
  @Id  
  @GeneratedValue(strategy = GenerationType.UUID)  
  @Column(name = "employee_role_uuid")  
  private UUID uuid;  
  
  @Column(name = "name")  
  private String name;  
  
  @Column(name = "abbr")  
  private String abbreviation;  
  
  @Column(name = "description")  
  private String description;  
  
}
```

- Reuse that query by calling `createNamedQuery` method of `entityManager` instance.
```java
package org.hospital.appointment.employee.role.dao;  
  
import jakarta.persistence.*;  
import org.hibernate.annotations.QueryHints;  
import org.hibernate.jpa.HibernateHints;  
import org.hospital.appointment.employee.role.EmployeeRole;  
import org.springframework.stereotype.Repository;  
  
import java.util.List;  
import java.util.UUID;  
  
@Repository  
public class EmployeeRoleDAOImpl implements EmployeeRoleDAO {  
  public static final int MAX_ROWS = 20;  
  public static final int TIMEOUT = 1000;  
  
  @PersistenceContext(type = PersistenceContextType.TRANSACTION)  
  private EntityManager entityManager;  
  
  public List<EmployeeRole> listAll() {  
    String jpql = "SELECT role FROM EmployeeRole role";  
    TypedQuery<EmployeeRole> query = this.entityManager.createQuery(jpql, EmployeeRole.class);  
    return query.getResultList();  
  }  
  
  
  public EmployeeRole findById(UUID employeeRoleId) throws NoResultException {  
    TypedQuery<EmployeeRole> query = this.entityManager.createNamedQuery("findById", EmployeeRole.class)  
      .setParameter("id", employeeRoleId)  
      .setMaxResults(MAX_ROWS)  
      .setHint(HibernateHints.HINT_READ_ONLY, true)  
      .setHint(HibernateHints.HINT_TIMEOUT, TIMEOUT);  
    return query.getSingleResult();  
  }  
  
  @Override  
  public List<EmployeeRole> findByName(String name) throws NoResultException {  
    TypedQuery<EmployeeRole> query = this.entityManager.createNamedQuery("findByName", EmployeeRole.class)  
      .setParameter("name", name + "%")  
      .setMaxResults(MAX_ROWS)  
      .setHint(HibernateHints.HINT_READ_ONLY, true)  
      .setHint(HibernateHints.HINT_TIMEOUT, TIMEOUT);  
    return query.getResultList();  
  }  
  
}
```

# Query Hints
## Annotation-based query hints
- Employ `@QueryHints({...})` and `@QueryHint()` annotation right above entity class in case of `EntityManager`.
- If use `Repository` pattern, annotate right above the method or right above repository class.
- Refers to https://www.baeldung.com/spring-data-jpa-query-hints
## Programmatic query hints
- Employe the `setHint()` method of `entityManger` instance.
- Use `HibernateHints.<HINT_...>` to specify query hint property we want to set.

# Repository
- Refers to https://docs.spring.io/spring-data/jpa/reference/jpa/query-methods.html

# References
1. https://www.baeldung.com/spring-data-jpa-query-hints for query hints guide.
2. https://hibernate.org/orm/documentation/7.0/ for hibernate docs.
3. https://www.objectdb.com/java/jpa/query/named for named query guide.
4. 
