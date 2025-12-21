#spring #java #spring-boot  #hibernate  #spring-jpa #dbms #query #configuration
#jakarta-ee #quarkus #orm 
# Set up JDBC for Spring
- In `pom.xml`:
	- Add `mysql-connector-j` and `spring-data-jpa` dependencies
```xml
<dependency>  
  <groupId>com.mysql</groupId>  
  <artifactId>mysql-connector-j</artifactId>  
  <version>8.3.0</version>  
  <scope>runtime</scope>  
</dependency>  
  
<dependency>  
  <groupId>org.springframework.boot</groupId>  
  <artifactId>spring-boot-starter-data-jpa</artifactId>  
</dependency>
```

- In `application.properties`, specify datasource and database url:
```bash
spring.datasource.url=jdbc:<dbms>://localhost:3306/football_manager  
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver  
spring.jpa.generate-ddl=true  
spring.datasource.username=root  
spring.datasource.password=12022002
```
-  where as`<dbms>` can be: 
	- `mysql` for MySQL $\implies$ port 3306.
	- postgresql for PostgreSQL $\implies$ port 5402, driver `org.postgresql.Driver`
- Create an entity in Java (using ORM) ![800](Pasted%20image%2020240717121244.png)                                                    using `@Entity` annotation and `@Table` annotation.
- Add `@EntityScan` to scan persistence class in the main Spring boot class.
- Add the DAO class and annotate it with `@Repository` . Inject `entityManager` to save the entity into the database.  ![800](Pasted%20image%2020240717121509.png)
# Hibernate DDL mode
- Specify ``spring.jpa.hibernate.ddl-auto`` in `applicaton.properties` file.
- Influences ==how the schema tool management manipulates data== when starting up the application:
	- `none`: Nothing happens.
	- `create-only`: Database tables are only created.
	- `drop`: Database tables are dropped $\implies$ all data is lost.
	- `create`: Database tables are dropped, then create new tables. $\implies$ all data is lost.
	- `create-drop`: Database tables are dropped, then create new tables. When application is shut down, drop the tables. $\implies$ all data is lost.
	- `validate`: Validate the database tables schema.
	- `update`: Update the database tables schema. $\implies$ alter table schema on the latest update.
***
# References
1. 