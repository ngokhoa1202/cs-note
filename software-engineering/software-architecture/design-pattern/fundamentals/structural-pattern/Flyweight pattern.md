#oop #software-engineering  #design-pattern  #software-architecture  #structural-pattern 

# Purpose
- Share a large number of small objects to reduce memory usage.
- Represents ==many-to-one mappings==.
# Application
- Memory optimization is vital.
# Components
## Intrinsic vs extrinsic state
- ==Intrinsic== state is stored in Flyweight and is ==independent== of flyweight's context. $\implies$ ==sharable==
- ==Extrinsic== state is passed as argument to Flyweight and ==dependent== on the context (client) $\implies$ ==not sharable==.
## How Flyweight objects are shared
- ![700](Pasted%20image%2020240619090430.png)
## Structure
- ![700](Pasted%20image%2020240619084045.png)
- ![](Pasted%20image%2020240713203155.png)
- In my opinion, ==Flyweight inheritance here is a bad idea==. The Unshared Concrete Flyweight should compose a Concrete Flyweight instead and we should briefly eliminate the Flyweight.
### Flyweight
- Declares ==interfaces that receive extrinsic state==.
- Enables sharing state, but does not enforce.
- Optional.
### Shared Concrete Flyweight
- Implements ==interfaces declared in Flyweight that receive extrinsic state== with respect to its behavior.
- ==Stores intrinsic state==.
- Must be sharable.
### Unshared Concrete Flyweight
- May be unsharable.
- May aggregate a ==collection of other Shared Concrete Flyweight objects==.
### Flyweight Factory
- Optional. If exists, used to create and ==manage a pool of Flyweight objects==.
- Implements logic to determine when to reuse existing objects and when to instantiate a new object. $\implies$ ==ensure object sharing==.
### Client - Context
- Stores either a FlyweightFactory (if exists) or a Flyweight object.
- Knows how to instantiate a Flyweight object by ==passing extrinsic state== to Flyweight methods.

# Example
- ![700](Pasted%20image%2020240619132407.png)
- `class GoldenType` is a Shared Concrete Flyweight class which represents a Flyweight in Flyweight pool which has intrinsic states `name`, `color`, `goldenRatio`
```Java
public class GoldenType {  
  private String name;  
  private String color;  
  private Double goldenRatio;  
  
  @Override  
  public String toString() {  
    return "GoldenType{" +  
      "name='" + name + '\'' +  
      ", color='" + color + '\'' +  
      ", goldenRatio=" + goldenRatio +  
      ", price=" + price +  
      '}';  
  }  
  
  private Double price;  
  
  public GoldenType(String name, String color, Double goldenRatio, Double price) {  
    this.name = name;  
    this.color = color;  
    this.goldenRatio = goldenRatio;  
    this.price = price;  
  }  
  
  @Override  
  public int hashCode() {  
    return super.hashCode();  
  }  
  
  @Override  
  public boolean equals(Object obj) {  
    if (this == obj) {  
      return true;  
    }  
    if (obj == null || this.getClass() != obj.getClass()) {  
      return false;  
    }  
    GoldenType target = (GoldenType) obj;  
    return this.name.equals(target.name);  
  }  
}
```
- `class GoldenObject` is a Unshared Concrete Flyweight which composs a `GoldenType` object and has extrinsic states like `weight`, `producer`. 
```Java
public class GoldenObject {  
  private String producer;  
  private Double weight;  
  private GoldenType type;  
  
  public GoldenObject(String producer, Double weight, GoldenType type) {  
    this.producer = producer;  
    this.weight = weight;  
    this.type = type;  
  }
  
  @Override  
  public String toString() {  
    return "GoldenObject{" +  
      "producer='" + producer + '\'' +  
      ", weight=" + weight +  
      ", type=" + type +  
      '}';  
  }  
}
```
- `class GoldenTypeFactory` composes a list of `GoldenType` objects, which is Flyweight pool. It implements `add` and `remove` method to manages the pool.
```Java
import java.util.HashSet;  
import java.util.Set;  
  
public class GoldenTypeFactory {  
  private static Set<GoldenType> goldenTypeSet = new HashSet<GoldenType>();  
  
  public boolean add(String name, String color, Double goldenRatio, Double price) {  
    GoldenType type = new GoldenType(name, color, goldenRatio, price);  
    if (GoldenTypeFactory.goldenTypeSet.contains(type)) {  
      return false;  
    }  
    GoldenTypeFactory.goldenTypeSet.add(type);  
    return true;  
  }  
  
  public static GoldenType retrieve(String name, String color, Double goldenRatio, Double price) {  
    for (GoldenType type: GoldenTypeFactory.goldenTypeSet) {  
      if (type.getName().equals(name)) {  
        return type;  
      }  
    }  
    GoldenType type = new GoldenType(name, color, goldenRatio, price);  
    GoldenTypeFactory.goldenTypeSet.add(type);  
    return type;  
  }  
  
  public static GoldenType remove(String typeName) {  
    for (GoldenType type: GoldenTypeFactory.goldenTypeSet) {  
      if (type.getName().equals(typeName)) {  
        GoldenTypeFactory.goldenTypeSet.remove(type);  
        return type;  
      }  
    }  
    return null;  
  }  
  
  public static void display() {  
    System.out.println("Golden type factory has");  
    for (GoldenType type: GoldenTypeFactory.goldenTypeSet) {  
      System.out.println(type);  
    }  
  }  
}
```

- `class JewelryStore` is a Client - Context class which composes a list of `GoldenObject` objects. When it needs a `GoldeType` object, it delegates responsibility to `GoldenTypeFactory` to access Flyweight pool.
```Java
import java.util.LinkedList;  
import java.util.List;  
  
public class JewelryStore {  
  private List<GoldenObject> goldenObjectList;  
  public JewelryStore() {  
    this.goldenObjectList = new LinkedList<GoldenObject>();  
  }  
  
  public void add(String name, String color, Double goldenRatio, Double price, String producer, Double weight) {  
    GoldenType type = GoldenTypeFactory.retrieve(name, color, goldenRatio, price);  
    GoldenObject object = new GoldenObject(producer, weight, type);     this.goldenObjectList.add(object);
  }  
  
  public void display() {  
     for (GoldenObject obj: this.goldenObjectList) {  
       System.out.println(obj);  
     }  
  }
  
}
```

- `class Main` receives a `JelweryStore` object.
```Java
public class Main {  
  public static void main(String[] args) {  
    JewelryStore store = initJewelryStore();  
    GoldenTypeFactory.display();  
  }  
  
  private static JewelryStore initJewelryStore() {  
    JewelryStore store = new JewelryStore();  
    for (int i = 0; i < 10000; ++i) {  
      store.add("SJC 24", "lighten gold", 0.99, 400.0, "Government", 0.04);  
      store.add("Ring 18", "gold", 0.75, 240.0, "Heart company", 0.027);  
      store.add("Ring 24", "very lighten gold", 0.99, 360.0, "Golden Ring company", 0.04);  
    }  
    return store;  
  }  
}
```

# Design
- Intrinsic state $\equiv$ ==duplicated, immutable== state for every objects $\neq$ Extrinsic $\equiv$ ==contextual, mutable==, unique ==per object==.
- Extrinsic state should be passed as ==external arguments==. $\implies$ minimize extrinsic state $\equiv$ minimize mutability.
- Flyweight Factory is optional or incorporated into Flyweight.
# Real example
- ==Enumerate type== follows Flyweight design pattern.
- `java.lang.Integer#valueOf(int)` $\implies$ Java wrapper class.
- Immutable object caching.
# Advantages
- ==Reduces memory usage== when there are a huge number of small objects.
# Disadvantages
- ==More execution time== for computing extrinsic state.
- Complicated.

# References
1. https://refactoring.guru/design-patterns/flyweight/java/example

