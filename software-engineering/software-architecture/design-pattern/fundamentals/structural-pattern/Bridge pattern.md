#structural-pattern  #design-pattern  #oop #software-engineering #software-architecture 

- Bridge means that Abstraction methods are implemented using ==primitive methods declared in Implementator interface==.
# Purpose
- ==Divide a class into two inheritance hierachies: abstraction and implementation== so that both of them can be independently developed.
# Application
- Divide a monolithic class that has ==variants of platform-specific functionalities==. (e.g: database server, OS, domain,...).
- Switch among many implementations (= Concrete Implementors) at run time.
- Extends a class ==in multiple independent dimensions==.

# Components
- ![800x](Pasted%20image%2020240609151717.png)
## Abstraction
- Defines abstraction's interface based on Implementator method invocation.
- ==Composes an Implementor object==.
## Implementor
- ==Declares implementation interfaces== for other Concrete Implementor.
- Its methods should be primitive.
## Refined Abstraction
- Extends Abstraction interface.
- Optional.
## Concrete Implementors
- Implements the Implementor interface.
## Client
- Given an run-time Abstraction object and only knows about Abstraction.
# Example
- ![](Pasted%20image%2020240609165113.png)
- ![](Pasted%20image%2020240609163524.png)
- `class Remote`: is an Abstraction class which aggregates an Device object and defines some Abstraction's interface `turnOn()`, `turnOff()` and `increaseVolume`.
```Java
public class Remote {  
  private Device device;  
  
  public Remote(Device device) {  
    this.device = device;  
  }  
  public void turnOn() {  
    if (! this.device.isActive()) {  
      this.device.togglePower();  
      System.out.println("Turn on " + this.device.toString());  
      return;  
    }
    System.out.println(this.device.toString() + " is already on");  
  }  
  public void turnOff() {  
    if (this.device.isActive()) {  
      this.device.togglePower();  
      System.out.println("Turn off " + this.device.toString());  
      return;  
    }  
    System.out.println(this.device.toString() + " is already off");  
  }  
  public void increaseVolume() {  
    if (this.device.volumeUp()) {  
      System.out.println("Successfully increase volume");  
      return;  
    }  
    System.out.println("Volume has already reached maximum");  
  }  
}
```

- `interface Device` is an Implementor interface that declares implementation interfaces for `class Remote` to call via `Device` object and for other concrete Implementor to implement.
```Java
public interface Device {  
  
  public boolean isActive();  
  public boolean reachMaximumVolume();  
  public boolean volumeUp();  
  public void togglePower();  
}
```

- `class Television` and `class Radio` is the two concrete Implementors that implement `Device` interface.
```Java
public class Television implements Device {  
  private boolean isActive;  
  private int volume;  
  public Television() {  
    this.isActive = false;  
    this.volume = 30;  
  }  
  
  public void setIsActive(boolean active) {  
    isActive = active;  
  }  
  
  public int getVolume() {  
    return volume;  
  }  
  
  public void setVolume(int volume) {  
    this.volume = volume;  
  }  
  
  @Override  
  public boolean isActive() {  
    return this.isActive;  
  }  
  
  @Override  
  public boolean volumeUp() {  
    if (this.reachMaximumVolume()) {  
      return false;  
    }  
    this.volume += 10;  
    return true;  
  }  
  
  @Override  
  public void togglePower() {  
    this.isActive = !this.isActive;  
  }  
  
  @Override  
  public boolean reachMaximumVolume() {  
    return (this.volume > 100);  
  }  
}
```
```Java
public class Radio implements Device {  
  private boolean isActive;  
  private int volume;  
  public Radio() {  
    this.isActive = false;  
    this.volume = 5;  
  }  
  
  public void setIsActive(boolean active) {  
    isActive = active;  
  }  
  
  public int getVolume() {  
    return volume;  
  }  
  
  public void setVolume(int volume) {  
    this.volume = volume;  
  }  
  
  @Override  
  public boolean isActive() {  
    return this.isActive;  
  }  
  
  @Override  
  public boolean volumeUp() {  
    if (this.reachMaximumVolume()) {  
      return false;  
    }  
    this.volume += 1;  
    return true;  
  }  
  
  @Override  
  public void togglePower() {  
    this.isActive = !this.isActive;  
  }  
  
  @Override  
  public boolean reachMaximumVolume() {  
    return (this.volume > 10);  
  }  
}
```

# Design
- Determine and define ==common operations== in Abstraction.
- Implementor method do not have to match exact Abstraction methods.
- May employ [Abstract Factory pattern](Abstract%20Factory%20pattern.md) to create Concrete Implementor object.
# Real example
- JDBC API, more specifically `java.mysql.Driver` makes up of a Bridge pattern.
- `Collection.newSetFromMap()`
# Advantages
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle) because Abstraction are separate from Implementation.
- Ensure [Open-Closed Principle.](SOLID.md#Open-Closed%20Principle.) because we can easily add a concrete implementors without client modification.
- Ensure [Dependency inversion principle](SOLID.md#Dependency%20inversion%20principle) because client only depends on Abstraction.
- Modularity.
# Disadvantages
- ==Complicated== because we have to introduct new Abstraction class and Implementor interfaces.
- Need to design in advance:
	- It's difficult to add bridge to legacy architecture.
# References
1. https://refactoring.guru/design-patterns/bridge for Bridge pattern.


