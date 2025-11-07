#solid #software-engineering #design-pattern #creational-pattern #software-architecture 

- Abstract Factory pattern is also known as Kit.
# Purpose
- Provides an interface for creating ==families of related objects without specifying their concrete classes==.
# Application
- There are multiple families of related objects that is designed to be <mark class="hltr-yellow">reciprocally</mark> used.
- The system should be configured with one of multiple families of products.
- The system should be independent of how its products are created, composed, and represented.
# Components
- ![800x400](Pasted%20image%2020240605152529.png)
## Abstract Factory
- Provides an interface for ==methods which create Abstract Product objects==.
## Concrete Factories
- Implements the methods declared in Abstract Factory to ==create a Concrete Product object==.
## Abstract Products
- Each Abstract Product abstracts a <mark class="hltr-yellow">family</mark> of Concrete Products and *provides an interface* for a type of a Concrete Product object.
## Concrete Products
- Implements a specific Abstract Product.
- Identifies a Concrete Product object created in a particular Concrete Factory (one-to-one mapping).
## Client
- Client uses the Abstract Factory object to instantiate an Abstract Product; nevertheless, the actual type of the Concrete Factory and Concrete Product is only given at runtime.
# Example
## Simple example
- ![800x500](Pasted%20image%2020240605164039.png)
- `class GUIFactory`: our abstract factory, declares two method `createButton` and `createCheckbox`
```Java title='interface GUIFactory is an Abstract Factory'
public interface GUIFactory {  
  Button createButton();  
  CheckBox createCheckBox();  
}
```
- `class MacFactory` and `class WinFactory`: two concrete factories implement `GUIFactory`. Each of them has overrides `GUIFactory` method and return its corresponding concrete object.
```Java title='Two classes ManFactory and WinFactory implement interface GUIFactory'
public class WinFactory implements GUIFactory {  
  @Override  
  public Button createButton() {  
    return new WinButton();  
  }  
  
  @Override  
  public CheckBox createCheckBox() {  
    return new WinCheckBox();  
  }  
}
```

```Java
public class MacFactory implements GUIFactory {  
  @Override  
  public Button createButton() {  
    return new MacButton();  
  }  
  
  @Override  
  public CheckBox createCheckBox() {  
    return new MacCheckbox();  
  }  
}
```

- `interface Button` and `interface Checkbox`: two abstract products declare interfaces for concrete product types.
```Java
public interface Button {  
  void paint();  
}
```

```Java
public interface CheckBox {  
  void paint();  
}
```

- `class WinCheckBox` and `class MacCheckBox`: two concrete products implement `interface CheckBox` and is the return types of methods in `class WinFactory` and `class MacFactory`.
```Java
public class WinCheckBox implements CheckBox {  
  @Override  
  public void paint() {  
    System.out.println("Paint a Window checkbox");  
  }  
}
```

```Java
public class MacCheckbox implements CheckBox {  
  @Override  
  public void paint() {  
    System.out.println("Paint a NacOS checkbox");  
  }  
}
```
- `class WinButton` and `class MacButton`: two concrete products implement `interface Button` and is the return types of methods in `class WinFactory` and `class MacFactory`.
```Java
public class WinButton implements Button {  
  
  @Override  
  public void paint() {  
    System.out.println("Paint a Window button");  
  }  
}
```

```Java
public class MacButton implements Button {  
  
  @Override  
  public void paint() {  
    System.out.println("Paint a MacOS button");  
  }  
}
```
## Practical example
- ![[Pasted image 20251105105757.png]]
# Design recommendation
- Related concrete products should be <mark class="hltr-yellow">categorized</mark> into an independent family to create its  correspondent product factory.
# Characteristics
- Abstract Factory pattern is the generalization of [[software-engineering/software-architecture/software-design/design-pattern/fundamentals/creational-pattern/Factory Method pattern|Factory Method pattern]] in case there are categories of related classes. Each Abstract Factory represents for the creation of one family of concrete products.
# Consequences
- Abstract Factory <mark class="hltr-yellow">isolates concrete classes</mark>. The instantiation of objects is more *controllable*   because each Concrete Factory itself encapsulates the responsibility of creating its family objects. This isolation, however, comes at the expense of complexity. 
- The exchange of product families becomes far more <mark class="hltr-yellow">flexible</mark>, simply by changing the concrete factory.
- Abstract Factory promotes <mark class="hltr-yellow">consistency</mark> among products belonging to a family.
- Extending Abstract Factories to produce new families of products is difficult because the Abstract Factory interface has already fixed the set of products.
# Real examples
- `javax.xml.parsers.DocumentBuilderFactory`:
	- does not match 100% because it has  static method`createInstance()` returning a concrete product.
***
# References
1. https://www.udemy.com/course/design-patterns-in-java-concepts-hands-on-projects/learn/lecture/9758788#overview for review.
2. https://java-design-patterns.com/patterns/abstract-factory/#detailed-explanation-of-abstract-factory-pattern-with-real-world-examples for Abstract Factory pattern.
3. https://refactoring.guru/design-patterns/abstract-factory for Abstract Factory pattern.
4. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Abstract Factory pattern.






