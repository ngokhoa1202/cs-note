#design-pattern  #software-engineering  #software-architecture #behavioral-pattern #solid #oop 

# Purpose
- ==Avoids tightly coupling== the Client to the Concrete Handler. ==Chain each request and let a specific Concrete Handler handles== it along the chain.
# Application
- Many Handlers can handle a request from the Client but ==their order and their type is unknown beforehand== and can change dynamically.
# Component
- General diagram: ![800](Pasted%20image%2020240717172829.png)
- More specific diagram: ![900x800](Pasted%20image%2020240717173021.png)
## Handler
- Defines a common interface to handle request from client.
- Defines a common interface for Concrete Handler in the chain of requests.
- Can ifself implement the successor link ($\equiv$ the next handler in the chain).
## Concrete Handler
- Handle a particular request that it is responsible for. ($\equiv$ ==concrete service==).
- Must be able to access ($\equiv$ the next Handler in the chain) and ==forward the request to its successor==. (this feature may be inherited from the parent Handler).
## Client
- ==Initialize a chain of requests== without knowing the details of Concrete Handlers.

# Example
- Class diagram ![](Pasted%20image%2020240717180608.png)
- ![](Pasted%20image%2020240717195622.png)
- `interface IMiddleware`: is the Handler interface,:
	- Declares `setNextMiddleware` method to update the successor link.
	- Declares `handle`  method to handle a request with many requests from clients.
	- Declares `handleNextMiddleware` method to handle next request specified from client.
```java
package org.tutorial.middleware;  
  
public interface IMiddleware {  
  void setNextMiddleware(IMiddleware middleware);  
  boolean handle(String username, String password, String token);  
  boolean handleNextMiddleware(String username, String password, String token);  
}
```

- `abstract class Middleware` composes the `nextMiddleware` reference as ==its successor link== to perform a chain of requests:
	- Leave the `handle` method implemetation to its children.
	- Itself implements `handleNextMiddle` by simply ==delegating the task to its Concrete Middleware children==.
	- (Optional) `static IMiddleware link` method is used to create a chain of middlewares nested inside an `IMiddleware` to handle a chain of requests.
```java
package org.tutorial.middleware;  
  
public abstract class Middleware implements IMiddleware {  
  
  private IMiddleware nextMiddleware;  
  
  @Override  
  public void setNextMiddleware(IMiddleware middleware) {  
    this.nextMiddleware = middleware;  
  }  
  
  public static IMiddleware link(IMiddleware firstMiddleware, IMiddleware ...chainMiddlewares) {  
    IMiddleware middlewareIterator = firstMiddleware;  
    for (IMiddleware nextMiddleware: chainMiddlewares) {  
      middlewareIterator.setNextMiddleware(nextMiddleware);  
      middlewareIterator = nextMiddleware;  
    }  
    return firstMiddleware;  
  }  
  
  public abstract boolean handle(String username, String password, String token);  
  
  public boolean handleNextMiddleware(String username, String password, String token) {  
    if (this.nextMiddleware == null) {  
      return true;  
    }  
    return this.nextMiddleware.handle(username, password, token);  
  }  
}
```
- `class Authentication` , `class TokenVerification` , `class Encryption` is the three Concrete Handlers that implements the `handle` method in the `Middleware` abstract class:
	- When it finishes its current request, it ends up calling `handleNextMiddleware` method to handle the next request.
```java
package org.tutorial.middleware;  
  
import java.nio.charset.StandardCharsets;  
import java.security.MessageDigest;  
import java.security.NoSuchAlgorithmException;  
import java.util.Arrays;  
  
public class Authentication extends Middleware {  
  private static final String USERNAME = "khoango";  
  private final static String PASSWORD;  
  
  static {  
    try {  
      PASSWORD = Arrays.toString(MessageDigest.getInstance("SHA-256").digest("123456".getBytes(StandardCharsets.UTF_8)));  
    } catch (NoSuchAlgorithmException e) {  
      throw new RuntimeException(e);  
    }  
  }  
  
  @Override  
  public boolean handle(String username, String password, String token) {  
    if (username.equals(USERNAME) && password.equals(PASSWORD)) {  
      return this.handleNextMiddleware(username, password, token);  
    }  
    return false;  
  }  
  
}
```

```java
package org.tutorial.middleware;  
  
import java.nio.charset.StandardCharsets;  
import java.security.MessageDigest;  
import java.security.NoSuchAlgorithmException;  
import java.util.Arrays;  
  
public class Encryption extends Middleware {  
  
  @Override  
  public boolean handle(String username, String password, String token) {  
    try {  
      MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");  
      byte[] encodedHash = messageDigest.digest(password.getBytes(StandardCharsets.UTF_8));  
      return this.handleNextMiddleware(username, Arrays.toString(encodedHash), token);  
    } catch (NoSuchAlgorithmException ex) {  
      return false;  
    }  
  }  
}
```

```java
package org.tutorial.middleware;  
  
public class TokenVerification extends Middleware {  
  
  
  
  @Override  
  public boolean handle(String username, String password, String token) {  
    if (token.equals("jwt")) {  
      return true;  
    }  
    return this.handleNextMiddleware(username, password, token);  
  }  
}
```

- `class Main` is our Client. It initiates the three requests and put them into a `IMiddleware` as a chain.
```java
package org.tutorial;  
  
import org.tutorial.middleware.*;  
  
public class Main {  
  public static void main(String[] args) {  
    IMiddleware serverMiddleware = Middleware.link(  
      new Encryption(),  
      new TokenVerification(),  
      new Authentication()  
    );  
    boolean loggedIn = serverMiddleware.handle("khoango", "123456", "jwt");  
    System.out.println(loggedIn);  
  }  
}
```

# Real example
- `Middleware` in Laravel PHP.

# Advantages
- Loose coupling between Client and Handler. $\implies$ the order, the types of Concrete Handlers can change during run time.
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle) because each Handler has its way to handle request.
- Ensure [Open-closed principle.](SOLID.md#Open-closed%20principle.) because we can add new Concrete Handler without modifying Client code.
# Disadvantages
- Some request may end up not being handled because there is ==no specific receiver== ($\equiv$ loose coupling).

---
# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Chain of responsibility pattern.