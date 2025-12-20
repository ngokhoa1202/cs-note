#java #java8 #functional-programming #high-order-function 
- Method reference is a shortened syntax of lambda expression by implicitly passing necessary arguments.
# Reference to static method
## Syntax
```Java
(args) -> Class.staticMethod(args)
```
equivalent to 
```Java
Class::staticMethod
```
## Example
```Java title='Math::abs is used as a static method reference' hl=20
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
# Reference to an instance method of an object
```Java
(args) -> obj.instanceMethod(args)
```
is equivalent to 
```Java
obj::instanceMethod
```

```Java title='class Car'
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

```Java title='class CarComparison'
public class CarComparison {  
  
  public int compareByName(Car c1, Car c2) {  
    return c1.name.compareTo(c2.name);  
  }  
  
  public int compareByReleaseYear(Car c1, Car c2) {  
    return c1.releaseYear.compareTo(c2.releaseYear);  
  }  
}
```

```Java title='Method compareByReleaseYear is used as a method reference' hl=21
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
# Reference to an instance method of an arbitrary object of a particular type
## Syntax
- The semantic is identical to [[#Reference to an instance method of an object]], but without having to create a custom object to perform the operation.
```Java
(T1 arg1, T2, arg2, ...) -> arg1.instanceMethod(arg2, arg3,...)
```
is equivalent to
```Java
T1::instanceMethod
```
## Example
```Java title=''
import java.util.List;

public class Main {
	public static void main(String[] args) {
	  List<Integer> numbers = Arrays.asList(5, 3, 50, 24, 40, 2, 9, 18);
	  numbers.stream().sorted((a, b) -> a.compareTo(b)); 
	  numbers.stream().sorted(Integer::compareTo);
	}
}
```
# Reference to constructor
## Syntax
```Java title='Normal lambda expression'
(args) -> new ClassName(args)
```
 is equivalent to
```Java title='Method reference to constructor'
ClassName::new
```
## Example
```Java title='Constructor of class Car is used as a method reference' hl=23
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
***
# References
1. https://www.geeksforgeeks.org/method-references-in-java-with-examples/?ref=lbp for method reference tutorial.
2. https://www.baeldung.com/java-method-references for Method reference tutorial.
