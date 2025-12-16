#design-pattern #java #thread #parallel-programming #jvm 
# Double-check locking
- The singleton instance is protected from multi thread access and initialized by one thread *only once for the first time*.
- Specifies the singleton instance as `volatile` and employ a *Double-checked locking* mechanism.
- `class ThreadBar` and `class ThreadFoo` implements `Runnable` interface
```Java title='Two threads can acquire two different database connection'
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
```Java hl=11-18
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
# Eager singleton
- A static single instance is created right after the class has been loaded by JVM.
```Java title='Eager singleton implementation' hl=2,9-11,17-19
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
# Lazy singleton
- The creation of the singleton instance is *delayed* and performed only when needed.
- `class Database` is a singleton class containing a singleton instance `connection`. It only creates a single `connection` when receiving an explicit call from `class Main`.
```Java title='Lazy singleton implementation' hl=2,9-11,17-19
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

```Java title='Driver class'
public class Main {  
  public static void main(String[] args) {  
    Database db = Database.getDatabaseConnection("PostgreSQL");  
    System.out.println(db.getDatabaseName());  
  }  
}
```
# Bill Pugh singleton

***
# References
1. https://refactoring.guru/design-patterns/singleton/java/example#example-2 for thread-safe singleton.
2. https://www.baeldung.com/java-bill-pugh-singleton-implementation
3. 