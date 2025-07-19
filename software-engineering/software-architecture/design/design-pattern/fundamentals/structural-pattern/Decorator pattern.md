#object-oriented-programming #design-pattern #software-engineering #software-architecture #structural-pattern #java 

- Known as Wrapper because Decorator ==wraps an object of its interface== as well as implements its interface.
# Purpose
- ==Dynamically add functionality== to an object at run time.
- Alternative to subclassing.
# Application
- Extension by subclassing is impossible.
- ==Dynamically add functionality== to objects without modifying other objects.

# Components
- ![900x](Pasted%20image%2020240611191545.png)
## Component
- ==Provide type interface== for dynamically added objects.
- Declares interfaces for methods in Concrete Components
## Concrete Component
- Identifies an ==object that needs adding functionality==.
- Implement interfaces declared in Component.
## Decorator
- Composes a Component object which refers to a Concrete Decorator or a Concrete Component.
- Implement interfaces declared in Component.
- Performs ==addtional operations== and d==elegates responsibility to its Component object==.
## Concrete Decorator
- Implements additinal methods declared in Decorator.
- Adds functionality to the Component.
## Client
- Only given a Component object.
- Creates a Component object by:
	- First, c==reate a Concrete Decorator== object whose type is Component.
	- Then, ==pass the Component== to another Concrete Decorator method which accepts a Component as parameter to wraps it.
	- ...
# Example
- ![](Pasted%20image%2020240611194648.png)
- `interface DataSource`: is a Component that declares one method interface.
```Java
public interface DataSource {  
  void readData();  
}
```
- `class FileDataSource`: is a Concrete Component that implements `readData` method and needs adding decryption and decompression functionality.
```Java
import java.util.Random;  
  
public class FileDataSource implements DataSource {  
  private String fileName;  
  
  public FileDataSource(String fileName) {  
    this.fileName = fileName;  
  }  
  
  @Override  
  public void readData() {  
    System.out.println("Reading data from " + this.fileName);  
  }  
}
```

- `class DataSourceDecorator` is a Decorator that implements `readData` method by delegating responsibility to its Concrete Decorator.
```Java
public class DataSourceDecorator implements DataSource {  
  
  private DataSource dataSource;  
  public DataSourceDecorator(DataSource dataSource) {  
    this.dataSource = dataSource;  
  }  
  
  @Override  
  public void readData() {  
    this.dataSource.readData();  
  }  
}
```
- `class EncryptionDecorator` and `class CompressionDecorator` is two Concrete Decorators. that composes a `DataSource` object. They implement  method `readData` declared in `interface DataSource` by adding its functionality and delegating responsibitility to Component object.
```Java
public class EncryptionDecorator extends DataSourceDecorator {  
  
  public EncryptionDecorator(DataSource dataSource) {  
    super(dataSource);  
  }  
  public void decryptData() {  
    System.out.println("Decrypting data");  
  }  
  @Override  
  public void readData() {  
    super.readData();  
    this.decryptData();  
  }  
}
```

```Java
public class CompressionDecorator extends DataSourceDecorator {  
  
  public CompressionDecorator(DataSource dataSource) {  
    super(dataSource);  
  }  
  
  public void decompressData() {  
    System.out.println("Decompressing data");  
  }  
  
  @Override  
  public void readData() {  
    super.readData();  
    this.decompressData();  
  }  
}
```
\
- `class Main` nests the Concrete Component object and conrete Decorator.
```Java
public class Main {  
  public static void main(String[] args) {  
    DataSourceDecorator dataSourceDecorator = Main.processData();  
    dataSourceDecorator.readData();  
  }  
  
  private static DataSourceDecorator processData() {  
    return new EncryptionDecorator(new CompressionDecorator(new FileDataSource("input.txt")));  
  }  
}
```

# Design
- Concrete Decorator may be lifted up in decorator tree.
- Pay attention to `hashCode` and `equals` method.
- Decorator should not change Component's behaviour [Liskov Substitution principle](SOLID.md#Liskov%20Substitution%20principle).
# Real example
-  [`java.io.InputStream`](http://docs.oracle.com/javase/8/docs/api/java/io/InputStream.html), [`OutputStream`](http://docs.oracle.com/javase/8/docs/api/java/io/OutputStream.html), [`Reader`](http://docs.oracle.com/javase/8/docs/api/java/io/Reader.html) and [`Writer`](http://docs.oracle.com/javase/8/docs/api/java/io/Writer.html)
# Advatanges
- Avoid large subclasess and large states of base class.
- Ensure [Single responsibility principle](SOLID.md#Single%20responsibility%20principle) because we can divide a class into variants of behaviours.
- Dynamically add behaviours to an object ==at run time==.
# Disadvantages
- Employs ==recursive composition== $\implies$ unnatural and many little objects.

