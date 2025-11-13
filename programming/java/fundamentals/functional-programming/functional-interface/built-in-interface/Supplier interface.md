#java #functional-programming   #high-order-function #api  

- `interface Suppiler`requires no parameter and returns any type except `Void`.
# `Supplier`
- `T get()`: executes the high-order function and returns its return value.
```Java
import java.util.LinkedList;  
import java.util.List;  
import java.util.Random;  
import java.util.function.BiPredicate;  
import java.util.function.Consumer;  
import java.util.function.Predicate;  
import java.util.function.Supplier;  
  
public class Main {  
  public static void main(String[] args) {  
  
    Consumer<List<Integer>> displayList = (List<Integer> l) -> {  
      for (int i = 0; i < l.size(); ++i) {  
        System.out.print(l.get(i) + " ");  
      }  
      System.out.println();  
    };  
  
    Supplier<List<Integer>> generateRandomIntegerList = () -> {  
      List<Integer> numList = new LinkedList<Integer>();  
      Random random = new Random();  
      int size = random.nextInt(20) + 1;  
      for (int i = 0; i < size; ++i) {  
        numList.add(random.nextInt());  
      }  
      return numList;  
    };  
    displayList.accept(generateRandomIntegerList.get());  
  }  
}
```
***
# References
1. 

