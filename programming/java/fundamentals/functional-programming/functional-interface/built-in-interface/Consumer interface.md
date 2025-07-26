#java #functional-programming  #api #high-order-function 

- Accept any input type but ==return `void`==.
- Employed to make further side effects the arguments.
# Consumer interface
- `void accept(T t)`: accepts the variable `t` as a ==parameter of lambda function== and ==executes operations== inside the high-order function.
- `default Consumer<T> andThen(Consumer<? super T> after)`: return a composed `Consumer` after executing `Consumer` `after` operations. `after` is passed as a high-order function.
```Java
import java.util.LinkedList;  
import java.util.List;
import java.util.function.Consumer;  
  
public class Main {    
  public static void main(String[] args) {  
    List<Integer> numList = new LinkedList<Integer>();  
    numList.add(3);  
    numList.add(5);  
    numList.add(12);  
    numList.add(32);  
    numList.add(-23);  
  
    Consumer<List<Integer>> displayList = (List<Integer> list) -> {  
      for (Integer element: list) {  
        System.out.print(element + " ");  
      }  
      System.out.println();  
    };  
  
    Consumer<List<Integer>> doubleList = (List<Integer> list) -> {  
      for (int i = 0; i < list.size(); ++i) {  
        list.set(i, list.get(i) * 2);  
      };  
    };  
  
    displayList.andThen(doubleList).andThen(displayList).accept(numList);  
  }  
}
```

# Bi-Consumer interface
- `void accept(T t, U u)`: accepts two variables `t` and `u` as two parameters of lambda function and ==executes operations== inside the high-order function.
- `default BiConsumer<T, U> andThen(BiConsumer<? super T, ? super U> after)`: return a composed `Consumer` after executing `Consumer` `after` operations. `after` is passed as a high-order function..
```Java
import java.util.Arrays;  
import java.util.LinkedList;  
import java.util.List;  
import java.util.function.BiConsumer;  
import java.util.function.Consumer;  
  
public class Main {  
  public static void main(String[] args) {  
    List<Integer> numList = new LinkedList<Integer>();  
    numList.add(3);  
    numList.add(5);  
    numList.add(12);  
    numList.add(32);  
    numList.add(-23);  
  
    List<Integer> otherNumList = new LinkedList<Integer>();  
    numList.add(3);  
    numList.add(5);  
    numList.add(1);  
    numList.add(32);  
    numList.add(-23);  
  
    Consumer<List<Integer>> displayList = (List<Integer> list) -> {  
      for (Integer element: list) {  
        System.out.print(element + " ");  
      }  
      System.out.println();  
    };  
  
    BiConsumer<List<Integer>, List<Integer>> checkEqualLists = (List<Integer> l1, List<Integer> l2) -> {  
      if (l1.size() != l2.size()) {  
        System.out.println("Not equal");  
        return;  
      }  
      for (int i = 0; i < l1.size(); ++i) {  
        if (l1.get(i) != l2.get(i)) {  
          System.out.println("Not equal");  
          return;  
        }  
      }      System.out.println("Equal");  
    };  
  
    checkEqualLists.accept(numList, otherNumList);  
  }  
}
```
