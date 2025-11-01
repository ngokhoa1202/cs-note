#javascript #java #design-pattern #behavioral-pattern #software-engineering #software-architecture #oop #solid #typescript #behavioral-pattern #spring #jakarta-ee 

# Purpose
- Define a skeleton for a complex algorithm, deferring some of its steps to sub classes.
- Allows sub classes to redefine certain steps of an algorithm without breaking the algorithm's structure.
# Application
- Implement the invariant parts of a complex algorithm and leave the behavior to subclasses.
- Generalize the common behavior among subclasses to template method in super class and leave the difference of implementations to subclasses.
- Control subclass extensions - a template method that calls hooks $\implies$ Dependency inversion principle.

# Components
- ![](Pasted%20image%2020250228162059.png)
- ![](Pasted%20image%2020250228162723.png)
## Abstract Class
- Defines abstract primitive operations which concrete sub classes define to implement steps of an algorithm.
- Implements a template method defining the skeleton of an algorithm. The template method invokes primitive operations defined in Abstract Class or those of its sub classes.
## Concrete Class
- Implements the primitive operations to carry out <mark class="hltr-yellow">subclass-specific steps</mark> of the algorithm. 
# Example
- ![](Pasted%20image%2020250228163901.png)
- `abstract class StealingMethod` is the Abstract Class defines `steal()` template method and  delegates steps of the template method to its sub classes.
```Java title='Abstract class in template method'
@Slf4j
public abstract class StealingMethod {

  protected abstract String pickTarget();

  protected abstract void confuseTarget(String target);

  protected abstract void stealTheItem(String target);

  public final void steal() {
    var target = pickTarget();
    LOGGER.info("The target has been chosen as {}.", target);
    confuseTarget(target);
    stealTheItem(target);
  }
}
```

- `class HitAndRunMethod` and `class SubtleMethod` is the two Concrete Classes. Each class implements some of the steps of the template method on its own.
```Java title='Concrete class in template method'
@Slf4j
public class SubtleMethod extends StealingMethod {

  @Override
  protected String pickTarget() {
    return "shop keeper";
  }

  @Override
  protected void confuseTarget(String target) {
    LOGGER.info("Approach the {} with tears running and hug him!", target);
  }

  @Override
  protected void stealTheItem(String target) {
    LOGGER.info("While in close contact grab the {}'s wallet.", target);
  }
}


@Slf4j
public class HitAndRunMethod extends StealingMethod {

  @Override
  protected String pickTarget() {
    return "old goblin woman";
  }

  @Override
  protected void confuseTarget(String target) {
    LOGGER.info("Approach the {} from behind.", target);
  }

  @Override
  protected void stealTheItem(String target) {
    LOGGER.info("Grab the handbag and run away fast!");
  }
}
```

- `class HalflingThief` composes an object of `StealingMethod` and is able to switch to multiple `StealingMethod` at runtime.
```Java title='Client class in Template method'
public class HalflingThief {

  private StealingMethod method;

  public HalflingThief(StealingMethod method) {
    this.method = method;
  }

  public void steal() {
    method.steal();
  }

  public void changeMethod(StealingMethod method) {
    this.method = method;
  }
}
```

- `class Main`
```Java title='Main class'
public static void main(String[] args) {
    var thief = new HalflingThief(new HitAndRunMethod());
    thief.steal();
    thief.changeMethod(new SubtleMethod());
    thief.steal();
}
```

# Benefits
- Promote code reusability because the common behavior is generalized in the super class. Some libraries implements it as hooks.
# Trade-offs
- Liskov substitution principle may be violated by suppressing a default step implementation via a subclass.
- Some clients may be limited by the provided skeleton of an algorithm.
# References
1. https://refactoring.guru/design-patterns/observer for observer pattern.
2. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
		1. Template method.
3. https://java-design-patterns.com/patterns/template-method/ for Template method.
4. [SOLID](SOLID.md)
5. https://react.dev/reference/react/hooks for React hooks.