#design-pattern #software-engineering  #software-architecture #oop #behavioral-pattern  #solid #functional-programming #high-order-function #dbms #transaction #java 

# Purpose
- Defines an object which <mark class="hltr-yellow">encapsulates</mark> and <mark class="hltr-yellow">thus reduce the complexity </mark>of how a collection of related objects interact.
- Promotes loose coupling by keeping objects from explicitly referring to each other.
# Applicability
- There is a collection of objects which have complicated interaction and interdependencies.
- Object reusability is difficult because of complex interaction.
- There is a common behavior among classes which should be customizable without much subclassing.
# Components
- ![](Pasted%20image%2020250219132923.png)
## Mediator
- Defines an interface for communicating with Colleague objects.
## Concrete Mediator
- Implements cooperative behavior by coordinating Colleague objects.
- Knows and maintains its colleagues.
## Colleague classes
- Each Colleague class knows its responding object.
- Each Colleague communicates with its mediator whenever it would have otherwise communicated with another colleague.
# Example
- ![](Pasted%20image%2020250219135311.png)
- `interface PartyMember` and `abstract class PartyMemberBase` are respectively the common interface and abstract class for the Colleagues.
```Java title='Colleagues interface example'
package com.iluwatar.mediator;
/**
 * Party interface.
 */
public interface Party {

  void addMember(PartyMember member);

  void act(PartyMember actor, Action action);

}

```

```Java title='Colleagues interface example'
package com.iluwatar.mediator;

import java.util.ArrayList;
import java.util.List;

/**
 * Party implementation.
 */
public class PartyImpl implements Party {

  private final List<PartyMember> members;

  public PartyImpl() {
    members = new ArrayList<PartyMember>();
  }

  @Override
  public void act(PartyMember actor, Action action) {
    for (var member : members) {
      if (!member.equals(actor)) {
        member.partyAction(action);
      }
    }
  }

  @Override
  public void addMember(PartyMember member) {
    members.add(member);
    member.joinedParty(this);
  }
}
```

- `class Hobbit`, `Hunter`, `Rogue`, `Wizard` are the Concrete Colleagues which aggregate a `Party` object and delegating interaction responsibility to that object.
```Java title='Concrete Colleagues examples'
package com.iluwatar.mediator;

/**
 * Rogue party member.
 */
public class Rogue extends PartyMemberBase {

  @Override
  public String toString() {
    return "Rogue";
  }

}
```

```Java title='Concrete Colleagues examples'
package com.iluwatar.mediator;

/**
 * Wizard party member.
 */
public class Wizard extends PartyMemberBase {

  @Override
  public String toString() {
    return "Wizard";
  }
}
```

```Java title='Concrete Colleagues example'
package com.iluwatar.mediator;

/**
 * Hunter party member.
 */
public class Hunter extends PartyMemberBase {

  @Override
  public String toString() {
    return "Hunter";
  }
}
```

```Java title='Concrete Colleages example'
package com.iluwatar.mediator;

/**
 * Hobbit party member.
 */
public class Hobbit extends PartyMemberBase {

  @Override
  public String toString() {
    return "Hobbit";
  }
}
```

- `interface Party` is the Mediator interface which defines interaction behavior between Colleagues.
```Java title='Mediator interface example'
public interface Party {

  void addMember(PartyMember member);

  void act(PartyMember actor, Action action);
}
```

- `class PartImpl` which implements `interface Party` and connects two Colleagues.
```Java title='Mediator implementation'

public class PartyImpl implements Party {

  private final List<PartyMember> members;

  public PartyImpl() {
    members = new ArrayList<>();
  }

  @Override
  public void act(PartyMember actor, Action action) {
    for (var member : members) {
      if (!member.equals(actor)) {
        member.partyAction(action);
      }
    }
  }

  @Override
  public void addMember(PartyMember member) {
    members.add(member);
    member.joinedParty(this);
  }
}
```

```Java title='Helper class'
package com.iluwatar.mediator;

import lombok.Getter;

/**
 * Action enumeration.
 */
public enum Action {
  HUNT("hunted a rabbit", "arrives for dinner"),
  TALE("tells a tale", "comes to listen"),
  GOLD("found gold", "takes his share of the gold"),
  ENEMY("spotted enemies", "runs for cover"),
  NONE("", "");

  private final String title;
  
  @Getter
  private final String description;

  Action(String title, String description) {
    this.title = title;
    this.description = description;
  }

  public String toString() {
    return title;
  }
}
```

# Real examples
- `java.util.concurrent.Executor#execute`
- Java Message Service.
# Benefits
- Reduce tight coupling between components of a program.
- Centralizes control and interaction between objects.
# Trade-offs
- Mediator object can become a god object.
---
# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Mediator pattern.
2. https://github.com/iluwatar/java-design-patterns/tree/master/mediator for Java examples.
3. 
