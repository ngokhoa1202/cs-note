#solid #software-engineering #design-pattern #creational-pattern #software-architecture 

# Purpose
- Provides an interface for creating ==families of related objects without specifying their concrete classes==.
# Application
- We have multiple families of related concrete products, and these families are orthogonal = independent.
- 
# Components
- ![800x400](Pasted%20image%2020240605152529.png)
## Abstract Factory
- Provides an interface for ==methods which create Abstract Product objects==.
## Concrete Factories
- Implement the methods declared in Abstract Factory to ==create a Concrete Product object==.
## Abstract Products
- Abstracts a family of Concrete Products.
- Provide an interface ==for a type of a Concrete Product object==.
## Concrete Products
- Implement a specific Abstract Product.
- Identify a Concrete Product object created in a particular Concrete Factory (one-to-one mapping).
## Client
- Given  a r==un-time Concrete Factory object== but ==only knows Abstract Factory interface and Abstract Product classes==.
- Does not know Concrete Factories and Concrete Products.
# Example
- ![800x500](Pasted%20image%2020240605164039.png)
- `class GUIFactory`: our abstract factory, declares two method `createButton` and `createCheckbox`
```Java
public interface GUIFactory {  
  Button createButton();  
  CheckBox createCheckBox();  
}
```
- `class MacFactory` and `class WinFactory`: two concrete factories implement `GUIFactory`. Each of them has overrides `GUIFactory` method and return its corresponding concrete object.
```Java
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

# Design
- If object creation is complicated, we can implement [Prototype pattern](software-engineering/software-architecture/software-design/design-pattern/fundamentals/creational-pattern/Prototype%20pattern.md) or [Singleton](Singleton.md) for an instance of a concrete product.
- Categorize concrete products into families to create abstract product factory.
# Characteristics
- Employ [Factory Method pattern](software-engineering/software-architecture/software-design/design-pattern/fundamentals/creational-pattern/Factory%20Method%20pattern.md)
- One Abstract Factory for one family of concrete products.
# Advantages
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle) $\implies$ provide product isolation because we can ==extract a Product creation in its corresponding Factory== $\implies$ maintainable.
- Ensure [Open-Closed Principle.](SOLID.md#Open-Closed%20Principle.) because we can a==dd product without modifying client code==.
# Disadvantages
- Hard to categorize families of products.
- Adding a new product means ==adding new interfaces and factories== $\implies$ identifies which families the new product belongs to $\implies$ complicated.
# Real examples
- `javax.xml.parsers.DocumentBuilderFactory`:
	- does not match 100% because it has  static method`createInstance()` returning a concrete product.
# References
1. https://www.udemy.com/course/design-patterns-in-java-concepts-hands-on-projects/learn/lecture/9758788#overview for review.
2. 







