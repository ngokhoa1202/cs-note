#design-pattern #software-engineering  #software-architecture #oop #behavioral-pattern  #solid #functional-programming #high-order-function #dbms #transaction #java 

# Purpose
- Encapsulate a request as an object, thereby letting client ==parameterize requests==, queue or logs.
- Support undoable operations.

# Application
- Object-oriented replacement for callbacks $\equiv$ a Command is simply a high-order function.
	- ==Specify, queue and execute requests at different times== $\implies$ specification, queueing, execution are independent.
- Implement transaction by storing ==reversible commands== to reverse the effect of some specific commands.
- Implement logging changes, schedule.
# Components
- General diagram ![](Pasted%20image%2020240719160004.png)
- More readable diagram: ![](Pasted%20image%2020240719160107.png)
## Command
- Declares a ==common interface== for Concrete Command $\implies$ exposes the `execute` method to the Invoker.
## Invoker
- ==Composes a Command object==, which actually refers to a Concrete Command in runtime execution.
- Exposes the `setCommand`
- Handles the request from Client by ==delegating responsibility to that Command object== (by calling `command.execute(...)`).
- Usually stores a group of commands to execute them as a transaction.
## Concrete Command
- ==Composes a Receiver object==.
- Has its own parameter and helper function to execute the request.
- Implements the `execute` method in Command interface by passing parameters ==deletegating responsibility to that Receiver object==.
## Receiver
- ==Implements the actual request on its own== $\equiv$ does not delegate to any other class.
- May be any class.
## Client
- Must know about Invoker and Receiver.
- ==Initiates a Concrete Command== and set the Command's ==Receiver==.
- Uses an Invoker object to execute that Command.
# Flow
- ![](Pasted%20image%2020240719163015.png)
- Client initiates a Concrete Command.
- Client requests the Invoker to store that Concrete Command as an abstract Command.
- Client makes the Invoker execute a Command:
	- The abstract Command delegates the responsibility to its Concrete Commands.
	- The Concrete Command keeps delegating the responsibility to the Receiver.
	- The Receiver execute the command using its own implementation.


# Examples
## Diagram
- ![](Pasted%20image%2020240822103624.png)
## Components
- `class Television` is an Receiver. It implements the ==actual business logic== and does not delegate the responsibility to any other classes.
	- `turnOn`
	- `turnOff`
	- `increaseVolume`
	- `decreaseVolume`.

```java
public class Television {  
  
  private boolean isOn;  
  private int volume;  
  
  public Television() {  
    this.isOn = false;  
    this.volume = 20;  
  }  
  
  public void turnOff() {  
    this.isOn = false;  
    System.out.println("Turn off TV");  
  }  
  
  public void turnOn() {  
    this.isOn = true;  
    System.out.println("Turn on TV");  
  }  
  
  public void increaseVolume() {  
    this.volume += 1;  
    System.out.println("Increase volume");  
  }  
  
  public void decreaseVolume() {  
    this.volume -= 1;  
    System.out.println("Decrease volume");  
  }  
}
```
command
- `abstract class Command` is a Command interface. It has one abstract method `execute` and let all of its children implement this method. It also composes a `Television` object to allow other Concrete Command call methods from this object.
```java
public abstract class Command {  
  
  protected final Television television;  
  
  public Command(Television television) {  
    this.television = television;  
  }  
  
  public abstract void execute();  
}
```

- `class TurnOnTelevisionCommand`, `class TurnOffTelevisionCommad`, `class IncreaseVolumeCommand`, `class DecreaseVolumeCommand` are the Concrete Commands. Each of class implements the `execute` method on its own by ==delegating the responsibility== to the `Television` instance and ==wrapping== the logic.
```java
public class TurnOffTelevisionCommand extends Command {  
  
  
  public TurnOffTelevisionCommand(Television television) {  
    super(television);  
  }  
  
  @Override  
  public void execute() {  
    this.television.turnOff();  
  }  
}

public class TurnOnTelevisionCommand extends Command {  
  
  
  public TurnOnTelevisionCommand(Television television) {  
    super(television);  
  }  
  
  @Override  
  public void execute() {  
    this.television.turnOn();  
  }  
}

public class DecreaseVolumeTelevisionCommand extends Command {  
  
  
  public DecreaseVolumeTelevisionCommand(Television television) {  
    super(television);  
  }  
  
  @Override  
  public void execute() {  
    this.television.decreaseVolume();  
  }  
}

public class IncreaseVolumeTelevisionCommand extends Command {  
  
  
  public IncreaseVolumeTelevisionCommand(Television television) {  
    super(television);  
  }  
  
  @Override  
  public void execute() {  
    this.television.increaseVolume();  
  }  
}
```

- `class RemoteControl` is an Invoker. It composes a `Command` object and allows Client to set their arbitary Command and to execute it.
```java
public class RemoteControl {  
  
  private Command command;  
  
  public RemoteControl() {  
  
  }  
  
  public RemoteControl(Command command) {  
    this.command = command;  
  }  
  
  public void setCommand(Command command) {  
    this.command = command;  
  }  
  
  public void execute() {  
    this.command.execute();  
  }  
}
```

- `class Main`: is a Client. The Client can instantiate an Invoker and a Concrete Command to execute that Command via a call to the `execute` method of the Invoker.
```java
public class Main {  
  public static void main(String[] args) {  
  
    RemoteControl remoteControl = new RemoteControl();  
    Television television = new Television();  
  
    remoteControl.setCommand(  
      new TurnOnTelevisionCommand(television)  
    );  
  
    remoteControl.execute();  
  }  
}
```

# Real examples
-  [`java.lang.Runnable`](http://docs.oracle.com/javase/8/docs/api/java/lang/Runnable.html)
# Advantages
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle) by decoupling classes that invoke operations from class that perform operations.
- Ensure [Open-closed principle.](SOLID.md#Open-closed%20principle.)  because we can add new concrete command without modify client code.
- Schedule operations (specify $\neq$ queue $\neq$ execute).
# Disadvantages
- Complicated because a new layer is added between invocation and implementation.
---
# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides:
	- Command pattern
2. https://refactoring.guru/design-patterns/command for 