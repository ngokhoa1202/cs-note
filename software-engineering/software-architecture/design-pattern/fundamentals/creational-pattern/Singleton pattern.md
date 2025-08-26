#design-pattern #oop #solid #software-engineering #creational-pattern #os #parallel-programming  #software-architecture 

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
	- Singleton constructor must not be made public and only called when we do need to create a new instance (e.g: multithreaded programming).
	- Subclassing or inheritance is not allowed.
	- Expose a method to access that Singleton instance.
## Eager singleton
- Create a singleton instance ==right after loading class==.
- `class Database`
```Java
public final class Database {  
  private static Database connection = new Database();  
  private String name;  
  private Database() {  
    this.name = "PostgreSQL";  
  }  
  
  public static Database getDatabaseConnection() {  
    if (Database.connection == null) {  
      Database.connection = new Database();  
    }  
    return Database.connection;  
  }  
  
  public String getDatabaseName() {  
    try {  
      if (Database.connection == null) {  
        throw new RuntimeException("Database has not been connected");  
      }  
    } catch (RuntimeException ex) {  
      ex.printStackTrace();  
    }  
  
    return Database.connection.name;  
  }  
}
```

## Lazy singleton
- Delay creating single instance, only create singleton instance ==when needed==.
- `class Database` is a singleton class containing a singleton instance `connection`. It only creates a single `connection` when ==receiving an explicit call== from `class Main`.
```Java
public final class Database {  
  private static Database connection = null;  
  private String name;  
  private Database(String name) {  
    this.name = name;  
  }  
  
  public static Database getDatabaseConnection(String name) {  
    if (Database.connection == null) {  
      Database.connection = new Database(name);  
    }  
    return Database.connection;  
  }  
  
  public String getDatabaseName() {  
    try {  
      if (Database.connection == null) {  
        throw new RuntimeException("Database has not been connected");  
      }  
    } catch (RuntimeException ex) {  
      ex.printStackTrace();  
    }  
  
    return Database.connection.name;  
  }  
}
```
- `class Main`
```Java
public class Main {  
  public static void main(String[] args) {  
    Database db = Database.getDatabaseConnection("PostgreSQL");  
    System.out.println(db.getDatabaseName());  
  }  
}
```

### Thread-safe singleton
- Implement locking to prevent race condition.
### Double-check locking
- In Java, specify Singleton instance as `volatile` and employ a ==DCL cheking==
- `class ThreadBar` and `class ThreadFoo` implements `Runnable` interface
```Java
public class ThreadFoo implements Runnable {  
  
  @Override  
  public void run() {  
    Database db = Database.getDatabaseConnection("PostgreSQL");  
    System.out.println("Query " + db.getDatabaseName());  
  }  
}

public class ThreadBar implements Runnable {  
  
  @Override  
  public void run() {  
    Database db = Database.getDatabaseConnection("MySQL");  
    System.out.println("Query " + db.getDatabaseName());  
  }  
}
```
- `class Database`: modify method `getDatabaseConnection` for thread synchronization.
```Java
public class Database {  
  private static volatile Database connection = null;  
  private String name;  
  private Database(String name) {  
    this.name = name;  
  }  
  
  public static Database getDatabaseConnection(String name) {  
    Database dbRef = Database.connection;  
    if (dbRef != null) {  
      return dbRef;  
    }  
    synchronized (Database.class) {  
      if (Database.connection == null) {  
        Database.connection = new Database("PostgreSQL");  
      }  
      return Database.connection;  
    }  
  }  
  
  public String getDatabaseName() {  
    try {  
      if (Database.connection == null) {  
        throw new RuntimeException("Database has not been connected");  
      }  
    } catch (RuntimeException ex) {  
      ex.printStackTrace();  
    }  
  
    return Database.connection.name;  
  }  
}
```
- Can employ `Enum` but requires hard coding.
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
    static final Database database = new Database("PostgreSQL");  
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
# Disadvange
- Violates [Single responsibility principle](SOLID.md#Single%20responsibility%20principle).
- Violates [Dependency inversion principle](SOLID.md#Dependency%20inversion%20principle) because the client needs to know about the Singleton class and instance.
- Requires thread synchronization in multithreaded environment.
- Hard to mock the Singleton instance to write unit test.
# References
1. https://refactoring.guru/design-patterns/singleton/java/example#example-2 for thread-safe singleton.
2. https://en.wikipedia.org/wiki/Initialization-on-demand_holder_idiom for `static class Holder`
3. 