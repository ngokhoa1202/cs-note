#object-oriented-programming #design-pattern #software-engineering #structural-pattern  #software-architecture 

- Called as Composite because it composes a collection of Component.
# Purpose
- Organize objects as a ==cohesive== tree structure and let clients ==treat them equally==. $\equiv$ client does not know which node is leaf or composite.
# Application
- Represent a ==part-whole==  or ==parent-child== hierachy of objects.
- ==Treat all objects equall==y without knowing whether it is composite or leaf.
# Components
- Class hierachy ![](Pasted%20image%2020240610113525.png)
- Object hierachy can be recursive: ![](Pasted%20image%2020240610152341.png)
## Component
- Provides type interface for Leaf and Composite objects $\equiv$ common type.
- Declares ==interfaces for accessing children==.
- (Optional) Implements interfaces for accessing children.
## Leaf
- Has no children.
- ==Implements methods itself== for its parental interfaces. 
## Composite
- ==Composes a collection of Component children==, 
- ==Delegates responsibility to Leaf== when accessing a Compoennt child.
## Client
- Given a Component object.
# Example
- ![](Pasted%20image%2020240610153004.png)
- `interface Task` is a Component interface that declares four method interfaces.
```Java
public interface Task {  
  String getTitle();  
  Status getStatus();  
  void next();  
  void display();  
}
```
- `class TestingTask`, `class DevelopmentTask` and `class SecurityTask` is Leaf class that implements `interface Task`
```Java
public class DevelopmentTask implements Task {  
  private String title = "Develop ";  
  private Status status;  
  public DevelopmentTask(String title) {  
    this.title += title;  
    this.status = Status.PENDING;  
  }  

  @Override  
  public String getTitle() {  
    return this.title;  
  }  
  
  @Override  
  public Status getStatus() {  
    return this.status;  
  }  
  
  @Override  
  public void next() {  
    if (this.status == Status.PENDING) {  
      this.status = Status.PROCESSING;  
      System.out.println(this.title + " is being processed");  
    } else if (this.status == Status.PROCESSING) {  
      this.status = Status.COMPLETED;  
      System.out.println(this.title + " is completed");  
    } else {  
      this.status = Status.PENDING;  
      System.out.println(this.title + "is pending for new development");  
    }  
  }  
  
  @Override  
  public void display() {  
    System.out.println(this.title + " has status " + this.status.name());  
  }  
}
```

```Java
public class SecurityTask implements Task {  
  private String title = "Secure ";  
  private Status status;  
  public SecurityTask(String title) {  
    this.title += title;  
    this.status = Status.PENDING;  
  }  
  
  @Override  
  public String getTitle() {  
    return this.title;  
  }  
  
  @Override  
  public Status getStatus() {  
    return this.status;  
  }  
  
  @Override  
  public void next() {  
    if (this.status == Status.PENDING) {  
      this.status = Status.PROCESSING;  
      System.out.println(this.title + " is being processed");  
    } else if (this.status == Status.PROCESSING) {  
      this.status = Status.COMPLETED;  
      System.out.println(this.title + " is completed");  
    } else {  
      this.status = Status.PENDING;  
      System.out.println(this.title + "is pending for new security policy");  
    }  
  }  
  
  @Override  
  public void display() {  
    System.out.println(this.title + " has status " + this.status.name());  
  }  
}
```

```Java
public class TestingTask implements Task {  
  private String title = "Test ";  
  
  private Status status;  
  public TestingTask(String title) {  
    this.title += title;  
    this.status = Status.PENDING;  
  }  
  
  @Override  
  public String getTitle() {  
    return this.title;  
  }  
  
  @Override  
  public Status getStatus() {  
    return this.status;  
  }  
  
  @Override  
  public void next() {  
    if (this.status == Status.PENDING) {  
      this.status = Status.PROCESSING;  
      System.out.println(this.title + " is being processed");  
    } else if (this.status == Status.PROCESSING) {  
      this.status = Status.COMPLETED;  
      System.out.println(this.title + " is completed");  
    } else {  
      this.status = Status.PENDING;  
      System.out.println(this.title + " is pending for new testing plan");  
    }  
  }  
  
  @Override  
  public void display() {  
    System.out.println(this.title + " has status " + this.status.name());  
  }  
}
```

- `class TaskList` is a Composite class. `TaskList` composes a list of `Task` which stores Leaf class or another `TaskList`. `class TaskList` also implements method for `interface Task` and delegates call to its children `task in TaskList`.
```Java
import java.util.Calendar;  
import java.util.LinkedList;  
import java.util.List;  
  
public class TaskList implements Task {  
  private String title = "Task list for ";  
  private Status status = Status.PENDING;  
  private List<Task> taskList;  
  public TaskList(String title) {  
    this.title += title;  
    this.taskList = new LinkedList<Task>();  
  }  
  
  public void addTask(Task task) {  
    this.taskList.add(task);  
  }  
  
  @Override  
  public String getTitle() {  
    return this.title;  
  }  
  
  @Override  
  public Status getStatus() {  
    return this.status;  
  }  
  
  public void display() {  
    for (Task task: this.taskList) {  
      task.display();  
    }  
  }  
  
  @Override  
  public void next() {  
    for (Task task: this.taskList) {  
      task.next();  
    }  
  }  
}
```

# Design
- Determine ==which will declare methods for accessing children==: Component or Composite:
	- If Component itself declares methods for accessing children by deafault, other ==Leafs have to unnecessarily implement these interfaces==. $\implies$ more transparent.
	- If Composite implements these methods, ==Client must know about Composite==. $\implies$ safer.
- Client should only know about Component without checking nodes.
# Real example
- `javax.faces.component.UIComponent#getChildren()` (JSF UI Component)
- `java.awt.Container#add(Component)`
# Characteristics
- Composite stores parent references.
- Operations for accessing children declared in Component do not make sense for Leaf because Leaf does not have any children.

# Advantages
- Ensure [Open-Closed Principle.](SOLID.md#Open-Closed%20Principle.) because we can easily add new class in the tree without modifying client code.
- Hides complicated tree structure.
# Disadvantages
- Client must perform runtime check know if the operation is available on a node.
---
# References
1. 1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Composite pattern.
