#solid #software-engineering #design-pattern #creational-pattern #java  #software-architecture 

# Purpose
- Specify the type of object to create ==using a prototypical instance==.
- Create new object by ==copying this instance==.

# When to use
- The system ==avoids large parallel subclasses== in class hierachy because only use `clone` method for simplicity.
- ==Specify type of class at run-time== when instantiating (use explicit type casting in Java).
- Each class has a ==limited number of states==.
# Components
- ![](Pasted%20image%2020240604153209.png)
## `abstract Prototype`
- Declare an interface for ==cloning itself==.
## `class ConcretePrototype`
- Implement `Clone()` method to clone itself.
## `class Client`
- Makes `Prototype` object to clone itself to create a new object.

# Example
- ![](Pasted%20image%2020240604183258.png)
- `abstract class GameUnit`:
	- Implements `Clonable` interface, overrides `clone` method as it returns a `GameUnit`. 
	- Declares an abstract method `reset` and leaves the implementation to subclasses.
```Java
package com.coffeepoweredcrew.prototype;

public abstract class GameUnit implements Cloneable {

	private Point3D position;
	
	public GameUnit() {
		position = Point3D.ZERO;
	}

	public GameUnit(float x, float y, float z) {
		position = new Point3D(x, y, z);
	}

	public void move(Point3D direction, float distance) {
		Point3D finalMove = direction.normalize();
		finalMove = finalMove.multiply(distance);
		position = position.add(finalMove);
	}

	public Point3D getPosition() {
		return position;
	}
	
	@Override
	protected GameUnit clone() throws CloneNotSupportedException {
		GameUnit gameUnit = (GameUnit) super.clone();
		gameUnit.initialize();
		return gameUnit;
	}

	protected void initialize() {
		/* shallow copy */
		this.position = Point3D.ZERO;
		this.reset();
		
	}

	protected abstract void reset();
	
}
```
- Two concrete Protoypes `Swordsman` and `General` overrides method `reset`.
```Java
package com.coffeepoweredcrew.prototype;

public class Swordsman extends GameUnit {

	private String state = "idle";

	public void attack() {
		this.state = "attacking";
	}

	@Override
	public String toString() {
		return "Swordsman "+state+" @ "+getPosition();
	}

	@Override
	protected void reset() {
		this.state = "idle";
	}
}
```
- `class Client`
```Java
package com.coffeepoweredcrew.prototype;

public class Client {
	public static void main(String[] args) throws CloneNotSupportedException {
		Swordsman sm1 = new Swordsman();
		sm1.move(new Point3D(1, 2, 3), 25);
		sm1.attack();
		System.out.println(sm1);
		Swordsman sm2 = (Swordsman) sm1.clone();
		System.out.println(sm2);
	}
}
```
# Design
- Which type of copy should be employed?:
	- ==Deep copy== for immutable object.
	- ==Shallow copy== for mutable object.
- Always delare a `reset` method to ==reset mutable state== of object and leave it to subclasses to implement.
- For Java, parent class can:
	- Implement `Cloneable` interface.
	- Override `clone` method.
- Maybe makes use of a ==subclass constructor== to implement deep copy.
- May implement a centralized ==prototype manager== (prototype registry) to store cloned objects.
- Sometimes, we have to ==perform an explicit type casting== to clone the object.
# Advantages
- Avoid duplicate constructor.
- Save memory and computation if necessary.
# Disadvantages
- Circular references if use shallow copy.
- Too many mutable objects to manage.
# References
1. https://refactoring.guru/design-patterns/prototype for protype manager.
2. 