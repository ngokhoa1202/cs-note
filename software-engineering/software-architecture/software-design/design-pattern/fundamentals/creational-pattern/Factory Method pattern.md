#design-pattern #object-oriented-programming #creational-pattern #software-engineering #solid  #software-architecture 

# Purpose
- Define an ==interface for creating object== and let ==subclasses determine which class should be instantiated==.
# Application
- We ==don't know the exact type== of object should be created $\implies$ abstraction.
- A class wants to let its subclasses determine which type of object should be created $\implies$ parent class can ==delegate its responsibility== to its child classes $\implies$ isolation.
# Components
- ![](Pasted%20image%2020240603190330.png)
## Abstract Product
- ==Abstracts== other `ConcreteProduct` objects.
## Concrete Product
- Implements `Product` interface.
## Abstract Creator
- Declares a ==consumer method== that needs an object of type `Product` and performs some additional operations.
- Declares an ==abstract `FactoryMethod`== which returns an object of type `Product` and will ==be overriden== by other `ConcreteCreator`.
## Concrete Creator
- ==Overrides== the `FactoryMethod` to return a `ConcreteProduct` object. But the type is still `Product` for generalization.
# Example
- ![](Pasted%20image%2020240603191959.png)
- `abstract class MessageCreator` has consumer method `getMessage()` and abstract factory method `createMessage` which will be overriden.
```Java
package com.coffeepoweredcrew.factorymethod;
import com.coffeepoweredcrew.factorymethod.message.Message;

public abstract class MessageCreator {

	/* Consumer method */
	public Message getMessage() {
	
		Message msg = createMessage();
		msg.addDefaultHeaders();
		msg.encrypt();
		return msg;
	
	}

	/* Factory method will be overriden in ConcreteCreator */
	public abstract Message createMessage();
}
```

- Two concrete `Creator`: `TextMessageCreator` and `JSONMessageCreator` overrides `createMessage()`
```Java
package com.coffeepoweredcrew.factorymethod;

import com.coffeepoweredcrew.factorymethod.message.JSONMessage;
import com.coffeepoweredcrew.factorymethod.message.Message;

/**
 * Provides implementation for creating JSON messages
 */
public class JSONMessageCreator extends MessageCreator {

	@Override
	public Message createMessage() {
		return new JSONMessage();
	}
	
}

```

```Java
package com.coffeepoweredcrew.factorymethod;

import com.coffeepoweredcrew.factorymethod.message.Message;
import com.coffeepoweredcrew.factorymethod.message.TextMessage;

/**
 * Provides implementation for creating Text messages
 */
public class TextMessageCreator extends MessageCreator {

	@Override
	public Message createMessage() {
		return new TextMessage();
	}

}
```

- `class Client`: pass a concrete `Creator` as argument
```Java
package com.coffeepoweredcrew.factorymethod;

import com.coffeepoweredcrew.factorymethod.message.Message;

public class Client {

  
	public static void main(String[] args) {
	
		Client.printMessage(new TextMessageCreator());
	
	}

	public static void printMessage(MessageCreator creator) {
	
		Message msg = creator.getMessage();
		
		System.out.println(msg);

	}

}
```

# Characteristics
- Reflects `Product` hierarchy: one concrete `Creator` class per concrete `Product`.
- Allows a class to delegate its responsibility to a `concrete` class because only ==subclasses create actual instance==.

# Design
- In some cases, `Creator` can implement a `FactoryMethod` which returns a default `ConcreteProduct` or it can invoke a `FactoryMethod` to create a `Product` object.
# Real examples
- `java.util.Collection` has abstract method `iterator` employing Factory Method pattern.
# Advantages
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle)
- Ensure [Open-Closed Principle.](SOLID.md#Open-Closed%20Principle.)
# Disadvantages
- Many subclassess $\implies$ more complicated to test.
- Require class hierachy $\implies$ hard to refactor.
# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Factory method pattern.
2. https://refactoring.guru/design-patterns/factory-method 