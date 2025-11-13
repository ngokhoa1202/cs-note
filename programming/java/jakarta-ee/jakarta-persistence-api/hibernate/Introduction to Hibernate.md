#dbms #sql #hibernate #java  #jdbc  #spring #spring-boot #mysql #postgresql #query #spring-jpa #jpa 

# Introduction
## JPA
- Stands for Jakarta Persistence API $\equiv$ query builder in PHP.
## Hibernate
- Hibernate is a vendor that ==implements JPA and provides JPA service== for developers. $\implies$ JPA = interface, Hibernate = implementation of JPA.
## JDBC
- Stands for ==Java DataBase Connectivity==.
- Underlies JPA.
- Usually provided by big vendors like Oracle.
- Understood as drivers that connects Java application and a DBMS software (MySQL, Oracle DB, MS SQL Server...).
# Set up Hibernate
- [Set up Hibernate](programming/java/jakarta-ee/jakarta-persistence-api/hibernate/Set%20up%20Hibernate.md)
# Persistence context
- [Persistence context](programming/java/jakarta-ee/jakarta-persistence-api/hibernate/Persistence%20context.md) 
# Persistence lifecycle
- [Persistence lifecycle](programming/java/jakarta-ee/jakarta-persistence-api/hibernate/Persistence%20lifecycle.md)
# JPQL
- Stands for JPA Query Language ($\equiv$ query builder in Laravel).
- Refers to  https://docs.jboss.org/hibernate/orm/6.5/quickstart/html_single/ .
# Named Query
- [Named Query](programming/java/jakarta-ee/jakarta-persistence-api/hibernate/Named%20Query.md)

# References
1. https://www.geeksforgeeks.org/introduction-to-jdbc/ for JPA, JDBC.
2. https://docs.jboss.org/hibernate/orm/6.5/quickstart/html_single/ for Hibernate.
3. https://www.baeldung.com/spring-boot-failed-to-configure-data-source for configure data source.
4. https://stackoverflow.com/questions/51513289/unknownentitytypeexception-unable-to-locate-persister for fixing `unable to locate persister` error in Spring boot.
5. https://hackernoon.com/using-postgres-effectively-in-spring-boot-applications for PostgreSQL configuration.

\

