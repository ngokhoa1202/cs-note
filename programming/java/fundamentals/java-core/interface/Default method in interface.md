#java8 #java #api 

- Known as defender method or <mark class="hltr-yellow">virtual function method</mark>.
# Default method
- An interface has ==its own implementation== of `default` method.
- Default methods are implicitly public.
- `interface Car`
```Java
public interface Car {  
  
  default void run() {  
    System.out.println("Car is running");  
  }  
  
  public void refill();  
}
```
- `class ElectricCar`
```Java
public class ElectricCar implements  Car {  
  
  @Override  
  public void refill() {  
    System.out.println("Go to charging station");  
  }  
}
```
- `class FuelCar`
```Java
public class FuelCar implements Car {  
  
  @Override  
  public void refill() {  
    System.out.println("Go to gas station");  
  }  
}
```
- `class Main`
```Java
import java.util.LinkedList;  
import java.util.List;  
import java.util.Random;  
import java.util.function.*;  
  
public class Main {  
  public static void main(String[] args) {  
    Car electricCar = new ElectricCar();  
    Car fuelCar = new FuelCar();  
    electricCar.run();
    electricCar.refill();  
  }  
}
```

- Default methods incrementally provide additional functionality to a given type without breaking down the implementing classes.
# References
1. https://www.baeldung.com/java-static-default-methods for default methods in Java.
