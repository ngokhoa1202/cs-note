#javascript #java #design-pattern #behavioral-pattern #software-engineering #software-architecture #oop #solid #typescript #behavioral-pattern 

- Also known as <mark style="background: #e4e62d;">Publish-Subcribe</mark> or Dependents.
# Purpose
- Define a one-to-many dependency between objects so that whenever one object has <mark style="background: #e4e62d;">changed its state,</mark> all of <mark style="background: #e4e62d;">its dependents </mark>are notified and <mark style="background: #e4e62d;">automatically updated</mark>.

# Application
- When one object's change leads to the <mark style="background: #e4e62d;">change of all of its dependent objects</mark> and the dependents are unknown at run time.
# Components

- Theoretical diagram ![](Pasted%20image%2020240830100420.png)

- Practical diagram ![](Pasted%20image%2020240830101239.png)

## Subject - Publisher
- Aggregates a collection of its Observers which relies on the Subject.
- Provides an <mark style="background: #e4e62d;">interface for both attaching and detaching</mark> an Observer object (also known as subscribe and unsubscribe).
## Concrete subject - Concrete publisher
- Stores the <mark style="background: #e4e62d;">state</mark> on which its Concrete Object rely.
- Implement its own logic and <mark style="background: #e4e62d;">notify</mark> to all of its observers <mark style="background: #e4e62d;">whenever that state is changed</mark> .
## Observer - Subscriber
- Provides an interface for <mark style="background: #e4e62d;">updating Concrete Observer objects</mark> which should be notified by the Publisher if Concrete Subjects' state are changed.
## Concrete Observer - Concrete Subscriber
- Aggregates a Concrete Subject object to <mark style="background: #e4e62d;">access Concrete Subject' state</mark>.
- Stores its own state and  <mark style="background: #e4e62d;">implement</mark> the <mark style="background: #e4e62d;">updating interface</mark> to keep its state <mark style="background: #e4e62d;">synchronized with Concrete Subject's state</mark>
## Client
- Instantiates a Concrete Observer.
- Attaches that Concrete Observer to a Subject.
# Flowchart
- ![](Pasted%20image%2020240830101513.png)
1. A Concrete Subject has to change its state.
2. It notifies that change to all of the Subject's Observer by calling the Observer's update method.
3. The Observer delegates the update responsibility to its Concrete Observer to update its child's state.
# Example
## Each Concrete Observer aggregates its Concrete Subject
- ![600x400](Pasted%20image%2020240831193258.png)
- `abstract class Environment` is the Subject:
	- Composes a set of `Sensor` objects which are Observers registering to obeserve the Subject.
	- The method `attach` and `detach` to add or remove a new observer. The implementation of `attach` method is left to its child for the reason that categorizing the correct Observers.
	- Essentially, implements the `notifyObservers` to <mark class="hltr-yellow">update the state of its Oberver whenever there is a change</mark>. 

```java
package org.observer;  
  
import java.util.HashSet;  
import java.util.Set;  
  
public abstract class Environment {  
  
  protected Set<Sensor> sensors;  
  
  public Environment() {  
    this.sensors = new HashSet<Sensor>();  
  }  
  
  public abstract void attach(Sensor sensor);  
  
  public void detach(Sensor sensor) {  
    this.sensors.remove(sensor);  
  }  
  
  protected void notifyObservers() {  
    this.sensors.forEach(Sensor::update);  
  }  
}
```


- `class Temperature` and `class Light` are the Concrete Subjects:
	- Each class has its own particular state.
	- Whenever it updates its state, it calls the `notifyObservers` method and <mark class="hltr-yellow">pass the context</mark> to notify all of its Observer stored in the parent `Environment` class.
```java
package org.observer;  
  
public final class Light extends Environment {  
  
  private Integer intensity;  
  
  public Light() {  
  
  }  
  
  public Integer getIntensity() {  
    return this.intensity;  
  }  
  
  public void setIntensity(Integer intensity) {  
    this.intensity = intensity;  
    super.notifyObservers();  
  }  
  
  @Override  
  public void attach(Sensor sensor) {  
    if (sensor instanceof LightSensor) {  
      super.sensors.add(sensor);  
      return;    }  
    System.out.println("Light sensor can be used only for measure brightness");  
  }  
}
```

```java
package org.observer;  
  
public final class Temperature extends Environment {  
  
  private Double degreeInCelsius;  
  
  public Temperature() {  
  
  }  
  
  public Double getDegree() {  
    return degreeInCelsius;  
  }  
  
  public void setDegree(Double degreeInCelsius) {  
    this.degreeInCelsius = degreeInCelsius;  
    super.notifyObservers();  
  }  
  
  @Override  
  public void attach(Sensor sensor) {  
    if (sensor instanceof ThermalSensor) {  
      super.sensors.add(sensor);  
      return;    }  
    System.out.println("Thermal sensor can be used only for measure temperature");  
  }  
}
```

- `interface Sensor` is the Observer:
	- Provides the `update` interface for the Subject.

```java
package org.observer;  
  
public interface Sensor {  
  void update();  
}
```

- `class LightSensor` and `class ThermalSensor` is the Conrete Observers:
	- Each class aggregates its corresponding Concrete Subject object.
	- Implement the `update` interface to update its state from the information provided by that Concrete Subject instance.

```java
package org.observer;  
  
public class LightSensor implements Sensor {  
  
  protected Integer brightness;  
  private Light light;  
  
  public LightSensor(Light light) {  
    this.light = light;  
  }  
  
  @Override  
  public void update() {  
    System.out.println("Update light sensor state");  
    this.brightness = this.light.getIntensity();  
  }  
  
}
```

```java
package org.observer;  
  
public class ThermalSensor implements Sensor {  
  
  private Double degreeInFahrenheit;  
  private Temperature temperature;  
  
  private Double covertToDegreeInFahrenheit(Double degreeInCelsius) {  
    return degreeInCelsius * 1.8 + 32;  
  }  
  
  @Override  
  public void update() {  
    System.out.println("Update the thermal sensor state");  
    this.degreeInFahrenheit = this.covertToDegreeInFahrenheit(this.temperature.getDegree());  
  }  
}
```

- `class Main`
```java
package org.observer;  
  
public class Main {  
  public static void main(String[] args) {  
  
    Light light = new Light();  
  
    Sensor sensor1 = new LightSensor(light);  
    Sensor sensor2 = new LightSensor(light);  
    Sensor sensor3 = new LightSensor(light);  
  
    light.attach(sensor1);  
    light.attach(sensor3);  
  
    light.setIntensity(100);  
    light.setIntensity(200);  
  }  
}
```
# Design
- <mark style="background: #e4e62d;">Either the Subject or the Client</mark> is able to trigger the update method:
	- If the Subject assumes this responsibility, it has to unintentionally notify all of its Observers whenever there is a change of its state $\implies$ more consecutive updates $\implies$ overhead.
	- If the Client assumes this reponsibility instead, there is less overhead because the Client can manually notify the Observers only when it is necessary. $\implies$ more manual tasks.
- Each of the Subject class should be <mark style="background: #e4e62d;">self-consistent</mark>. (tự lưu state của nó).
# Real example
- RxJs library in Typescript.
- Mutiny library in Java.
# Advantages
- Ensure [Open-closed principle.](SOLID.md#Open-closed%20principle.) because we can add new Observer without changing client code.
- Establish a relation between objects at run time $\implies$ Observer.
# Disadvantage
- <mark style="background: #e4e62d;">Unexpected updates</mark> may occur in case the Subject takes control of the notifications.
- The order of notification to observers are not specified.
- 
# References
1. https://refactoring.guru/design-patterns/observer for observer pattern.
2. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Observer pattern.
3. 