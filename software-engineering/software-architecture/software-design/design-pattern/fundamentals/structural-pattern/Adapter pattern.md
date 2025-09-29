#object-oriented-programming #structural-pattern #solid #software-engineering #diamond-problem #java #python #software-architecture 

- Known as ==Wrapper== because Adapter wraps an Adaptee object.
# Purpose
- Convert an incompatible interface into another ==interface which is compatible with client interface==.

# Application
- Use an existing class, but its interface is not compatible with client class.

# Components
## Client
- Given a a run-time Adapter object but only knows about Target interface.
## Target
- Provides a ==specific interface for client's business== which is ==incompatible with Adaptee interface==.
## Adaptee - Existing Service
- Exposes the interface for methods or objects that needs adapting.
## Adapter
- Defines a method to perform adaptation $\equiv$ convert Target data into Adaptee data.
- ==Implement the incompatible interface== in Target:
	- Call the adaptation method to convert incompatible data $\equiv$ adapt
	- Call the Adaptee method to perform its task.

## Multiple inheritance - class adapter
- Only available in programming language that allows multiple inheritance.
- Adapter ==inherits both Target and Adaptee==.
- Adapter can implement Target interface and call Adaptee method via inheritance.
- ![](Pasted%20image%2020240608094057.png)
## *Object composition - object adapter* 
- Adapter inherits Target but ==aggregates an Adaptee object==.
- Adapter can implement Target interface and call Adaptee method v==ia Adaptee object==.
- ![](Pasted%20image%2020240608102427.png)
# Real example

## Object adapter
- ![](Pasted%20image%2020240609154731.png)
- `class StockStorage`: is an Adaptee class. It only stores XML data but `class StockService` which is a Target class only accepts JSON data.
```Java
public abstract class StockService {  
  protected void receive() {  
    System.out.println("Receive json data from stock manager");  
  }  
  public abstract void process();  
}
```

```Java
public class StockStorage {  
  public void store() {  
    System.out.println("Store XML data");  
  }  
}
```
- `class StockAnalysisService` is an Adapter class. It extends `class StockService` and composes a `StockStorage` object. It also defines adaptation method for data conversion.
```Java
public class StockAnalysisService extends StockService {  
  private StockStorage storage;  
  public StockAnalysisService() {  
    this.storage = new StockStorage();  
  }  
  @Override  
  public void process() {  
    super.receive();  
    this.convertToXML();  
    this.storage.store();  
  }  
  
  private void convertToXML() {  
    System.out.println("Convert JSON data to XML data");  
  }  
}
```
- `class Main`: our client
```Java
public class Main {  
  public static void main(String[] args) {  
    StockService service = offer();  
    service.process();  
  }  
  
  private static StockService offer() {  
    return new StockAnalysisService();  
  }  
}
```

## Class adapter
- `class StockStorage` and `class StockService` is Adaptee and Target class.
```Python
from abc import ABC, abstractmethod

class StockStorage(ABC):

	def __init__(self) -> None:
		super().__init__()
	
	def store(self) -> None:
		print("Store xml data")
```

```Python
from abc import ABC, abstractmethod

class StockService(ABC):
	def __init__(self) -> None:
		super().__init__()
	
	def receive(self) -> None:
		print("Receive data from stock manager")
	
	@abstractmethod
	def process(self) -> None:
		pass
```

- `class StockAnalysis` inherits both `class StockService` and `class StockStorage`
```Python
from StockService import StockService
from StockStorage import StockStorage

class StockAnalysisService(StockService, StockStorage):

	def __init__(self) -> None:
		super().__init__()
	
	def process(self) -> None:
		super().receive()
		self.convertToXML()
		super().store()
		
	def convertToXML(self) -> None:
		print("Convert JSON data to XML data")
```

# Design
- Identify Adaptee and Target:
	- Target class is exposed to Client.
	- Adaptee has methods which need adapting.
- The workload of Adapter:
	- Just adapts Target interface to Adaptee interface.
	- Or do more...

# Real examples
- `java.util.Arrays#asList()`
- `java.util.Collections#list()`
- `java.util.Collections#enumeration()`
- `java.io.InputStreamReader(InputStream)` extends Reader and composes `StreamDecoder` object
- [`java.io.OutputStreamWriter(OutputStream)`](https://docs.oracle.com/javase/8/docs/api/java/io/OutputStreamWriter.html#OutputStreamWriter-java.io.OutputStream-) (returns a `Writer` object)
- [`javax.xml.bind.annotation.adapters.XmlAdapter#marshal()`](https://docs.oracle.com/javase/8/docs/api/javax/xml/bind/annotation/adapters/XmlAdapter.html#marshal-BoundType-)


# Advatanges
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle) because Adapter separates interface adaptation from Adaptee or Target.
- Ensure [Open-Closed Principle.](SOLID.md#Open-Closed%20Principle.) because we can define new Adapters without modifying client code.
# Disadvantages
- Class adapter has many disavantages $\implies$ prefer object adapter:
	- Allows subclass to override its behaviour.
	- Force subclasses to implement its unrelated interfaces.
- Complicated because we have to define new interfaces and Adapter class.
---
# References
1. Design Patterns: Elements of Reusable Object-Oriented Software -  Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides.
	1. Adapter pattern.
