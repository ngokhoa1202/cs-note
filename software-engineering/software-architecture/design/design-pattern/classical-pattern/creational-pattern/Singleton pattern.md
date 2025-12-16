#design-pattern #object-oriented-programming #solid #software-engineering #creational-pattern #operating-system #parallel-programming  #software-architecture 
# Purpose
- Ensure a class has ==one single instance== and provide a ==global access== to it.
# Application
- There is a ==single instance of a class==s and client can ==globally access== to it.
- If the single instance should be extensible by subclassing, and client can use ==that extended instance== without modification.
# Components
- ![](Pasted%20image%2020240606094529.png)
## Singleton
- Has only one single instance.
- Define a ==global method to access to its single Instance==.
## Client
- Access to the Singleton instance via that global method.
# Design
- ==Restrict instance creation and access==:
	- Singleton constructor must not be made public and only called when we do need to create a new instance (e.g: multi-threaded programming).
	- Subclassing or inheritance is not allowed.
	- Expose a method to access that Singleton instance.

### Single instance Holder
- Employ a `static class Holder` inside Singleton class, which has only one `static` variable holding our Singleton instance.
- JVM only creates that variable when the `atatic class Holder` is ==used the first time== $\implies$ avoid race condition.
```Java
public class Database {  
  private static Database connection = null;  
  private String name;  
  private Database(String name) {  
    this.name = name;  
  }  
  
  private static class DatabaseHolder {  
    static final Database database = new Database("PostgreSQL"); // static field declaration
  }  
  
  public static Database getDatabaseConnection(String name) {  
    return DatabaseHolder.database;  
  }  
  
  public String getDatabaseName() {  
    return DatabaseHolder.database.name;  
  }  
}
```

# Real example
- `java.lang.Runtime#getRuntime())
- `java.awt.Desktop#getDesktop()
- `java.lang.System#getSecurityManager()`
- Application configuration (environment variable, database connection) usually uses Singleton pattern.
# Advantage
- Only one instance and one access entry created during runtime execution $\implies$ simple.
# Disadvantage
- Violates [Single responsibility principle](SOLID.md#Single%20responsibility%20principle).
- Violates [Dependency inversion principle](SOLID.md#Dependency%20inversion%20principle) because the client needs to know about the Singleton class and instance.
- Requires thread synchronization in multi-threaded environment.
- Hard to mock the Singleton instance to write unit test.
***
# References
1. https://en.wikipedia.org/wiki/Initialization-on-demand_holder_idiom for `static class Holder`
2. 1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Singleton pattern.