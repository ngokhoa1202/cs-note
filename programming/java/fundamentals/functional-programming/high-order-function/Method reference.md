#java #java8 #functional-programming #high-order-function 

- Short syntax for [Lambda expression](Lambda%20expression.md)
# Reference to static method
```Java
(args) -> Class.staticMethod(args)
```
equivalent to 
```Java
Class::staticMethod
```

- Example:
```Java
import java.util.LinkedList;  
import java.util.List;  
import java.util.Random;  
import java.util.function.*;  
  
public class Main {  
  public static void main(String[] args) {  
    Function<Integer, List<Integer>> initRandomNumberListGivenSize = (n) -> {  
      Random random = new Random();  
      List<Integer> numList = new LinkedList<Integer>();  
      while (n > 0) {  
        numList.add(random.nextInt());  
        n--;  
      }  
      return numList;  
    };  
  
    List<Integer> numList = initRandomNumberListGivenSize.apply(10);  
    int sum = 0;  
    numList.stream().map(Math::abs).toList().forEach(System.out::println);  
  }  
}
```

## Reference to an instance method of an object
```Java
(args) -> obj.instanceMethod(args)
```
equivalent to 
```Java
obj::instanceMethod
```

- `class Car`
```Java
public class Car {  
  
  public String name;  
  public Integer releaseYear;  
  
  public Car(String name, Integer releaseYear) {  
    this.name = name;  
    this.releaseYear = releaseYear;  
  }  
  
  @Override  
  public String toString() {  
    return STR."Car(\{this.name}, \{this.releaseYear}).";  
  }  
}
```

- `class CarComparison`
```Java
public class CarComparison {  
  
  public int compareByName(Car c1, Car c2) {  
    return c1.name.compareTo(c2.name);  
  }  
  
  public int compareByReleaseYear(Car c1, Car c2) {  
    return c1.releaseYear.compareTo(c2.releaseYear);  
  }  
}
```
- `class Main`
```Java
import java.util.Collections;  
import java.util.LinkedList;  
import java.util.List;  
import java.util.Random;  
import java.util.function.*;  
  
public class Main {  
  public static void main(String[] args) {  
    Supplier<List<Car>> initCarList = () -> {  
      List<Car> carList = new LinkedList<Car>();  
      carList.add(new Car("Mercedes", 2010));  
      carList.add(new Car("Ford", 2020));  
      carList.add(new Car("Ford", 2023));  
      carList.add(new Car("Suzuki", 2018));  
      carList.add(new Car("Ferrari", 2015));  
      return carList;  
    };  
  
    CarComparison comparator = new CarComparison();  
    List<Car> myCarList = initCarList.get();  
    Collections.sort(myCarList, comparator::compareByReleaseYear);  
    myCarList.forEach(System.out::println);  
  }  
}
```

# Reference to constructor
```Java
(args) -> new ClassName(args)
```
equivalent to
```Java
ClassName::new
```

- `class Main`
```Java
import java.util.Collections;  
import java.util.LinkedList;  
import java.util.List;  
import java.util.Random;  
import java.util.function.*;  
  
public class Main {  
  public static void main(String[] args) {  
  
    BiFunction<Integer, BiFunction<String, Integer, Car>, List<Car>> initMyCarList = (n, carBiFunction) -> {  
      List<Car> carList = new LinkedList<Car>();  
      Random random = new Random();  
      while (n > 0) {  
        carList.add(carBiFunction.apply("Khoa", random.nextInt(15) + 2010));  
        n--;  
      }  
  
      return carList;  
    };  
  
  
    CarComparison comparator = new CarComparison();  
    List<Car> myCarList = initMyCarList.apply(10, Car::new);  
    Collections.sort(myCarList, comparator::compareByReleaseYear);  
    myCarList.forEach(System.out::println);  
  }  
}
```

# References
1. https://www.geeksforgeeks.org/method-references-in-java-with-examples/?ref=lbp for method reference.
2. 
