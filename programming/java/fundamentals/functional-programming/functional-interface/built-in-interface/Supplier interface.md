#java #functional-programming   #high-order-function #api 
- Requires ==no parameter== and return any type ==except `void`==.
# Supplier
- `T get()`: return the value of the high-order function.
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


