#exception #dbms #transaction #hibernate #software-architecture #software-engineering #object-oriented-programming #java #jakarta-ee #jdbc 

# Exception hierarchy
```mermaid
classDiagram
    java.lang.Object <|-- org.hibernate.exception.CacheSQLStateConverter
    java.lang.Object <|-- org.hibernate.exception.ExceptionUtils
    java.lang.Object <|-- org.hibernate.exception.JDBCExceptionHelper
    java.lang.Object <|-- org.hibernate.exception.NestableDelegate
    java.lang.Object <|-- org.hibernate.exception.SQLExceptionConverterFactory
    java.lang.Object <|-- org.hibernate.exception.SQLStateConverter
    java.lang.Object <|-- org.hibernate.exception.TemplatedViolatedConstraintNameExtracter

    java.lang.Throwable <|-- java.lang.Exception
    java.lang.Throwable <|-- java.lang.RuntimeException

    java.lang.Exception <|-- org.hibernate.exception.NestableException
    java.lang.RuntimeException <|-- org.hibernate.exception.NestableRuntimeException

    org.hibernate.exception.NestableRuntimeException <|-- org.hibernate.HibernateException
    org.hibernate.HibernateException <|-- org.hibernate.JDBCException

    org.hibernate.JDBCException <|-- org.hibernate.exception.ConstraintViolationException
    org.hibernate.JDBCException <|-- org.hibernate.exception.DataException
    org.hibernate.JDBCException <|-- org.hibernate.exception.GenericJDBCException
    org.hibernate.JDBCException <|-- org.hibernate.exception.JDBCConnectionException
    org.hibernate.JDBCException <|-- org.hibernate.exception.LockAcquisitionException
    org.hibernate.JDBCException <|-- org.hibernate.exception.SQLGrammarException
```
***
# References
1. https://drive.google.com/file/d/1GP3TrBzG7xUD72qHfFqmbVJRxvSV_t-X/view?usp=sharing
2. 



