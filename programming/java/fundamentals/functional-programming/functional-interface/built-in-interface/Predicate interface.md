#functional-programming  #java #high-order-function #api 

- `Predicate` accepts any input type built return `boolean`.
# `Predicate`
- `boolean test(T t)`: passes the variable `t` as the first parameter of lambda function and tests the predicate.
- `default Predicate<T> and(Predicate<? super T> other)`: passes another `Predicate` `other` as a high-order function and returns a composed `Predicate` after performing `and` logical operation with the return value of calling `Predicate`.
- `default Predicate<T> negate()`: return a composed `Predicate` after negating the return value of calling `Predicate`.
- `default Predicate<T> or(Predicate<? super T> other)`: passes another `Predicate` `other` as parameter of lambda function and returns a composed `Predicate` after performing `or` logical operation with the return value of calling `Predicate`.
```Java
import java.util.Linked List;  
import java.util.List;  
import java.util.function.BiPredicate;  
import java.util.function.Predicate;  
  
public class Main {  
  
  @FunctionalInterface  
  private interface ListDisplay {  
    void display(List<Integer> numList);  
  }  
  
  @FunctionalInterface  
  private interface ListTransformation {  
    void transform(List<Integer> list, Transformation transformation);  
  }  
  
  @FunctionalInterface  
  private interface Transformation {  
    Integer calculate(Integer n);  
  }  
  
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
  
    Predicate<List<Integer>> isPalidromeList = (List<Integer> list) -> {  
      int size = list.size();  
      for (int i = 0; i < size / 2; ++i) {  
        if (list.get(i) != list.get(size - 1 - i)) {  
          return false;  
        }  
      }      return true;  
    };  
  
    Predicate<List<Integer>> isNonNegativeList = (List<Integer> list) -> {  
      int size = list.size();  
      for (int i = 0; i < size; ++i) {  
        if (list.get(i) < 0) {  
          return false;  
        }  
      }      return true;  
    };  
  
    System.out.println(isPalidromeList.and(isNonNegativeList).test(numList));  
    System.out.println(isPalidromeList.negate().test(numList));  
    System.out.println(isPalidromeList.or(isNonNegativeList).test(numList));  
  
  }  
}
```
# `BiPredicate`
- `boolean test(T t, U u)`: passes two variables `t` and `u` and as the parameters of lambda function and tests the predicate.
- `default BiPredicate<T, U> and(BiPredicate<? super T, ? super U> other)`: passes another `BiOPredicate` `other` as a high-order function and returns a composed `Predicate` after performing `and` logical operation with the return value of calling `Predicate`.
- `default BiPredicatePredicate<T, U> negate()`: return a composed `Predicate` after negating the return value of calling `Predicate`.
- `default BiPredicate<T, U> or(BiPredicate<? super T, ? super U> other)`: passes another `BiPredicate` `other` as an high-order function and returns a composed `Predicate` after performing `or` logical operation with the return value of calling `Predicate`.

```Java title='listGreaterThan and listLessThan implements BiPredicate interface' hl=38,46,54-56
import java.util.LinkedList;  
import java.util.List;  
import java.util.function.BiPredicate;  
import java.util.function.Predicate;  
  
public class Main {  
  
  @FunctionalInterface  
  private interface ListDisplay {  
    void display(List<Integer> numList);  
  }  
  
  @FunctionalInterface  
  private interface ListTransformation {  
    void transform(List<Integer> list, Transformation transformation);  
  }  
  
  @FunctionalInterface  
  private interface Transformation {  
    Integer calculate(Integer n);  
  }  
  
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
  
    BiPredicate<List<Integer>, Integer> listGreaterThan = (List<Integer> list, Integer n) -> {  
      for (Integer ele: list) {  
        if (ele > n) {  
          return false;  
        }  
      }      return true;  
    };  
  
    BiPredicate<List<Integer>, Integer> listLessThan = (List<Integer> list, Integer n) -> {  
      for (Integer ele: list) {  
        if (ele < n) {  
          return false;  
        }  
      }      return true;  
    };  
  
    System.out.println(listLessThan.and(listGreaterThan).test(numList, -7));  
    System.out.println(listLessThan.or(listGreaterThan).test(numList, -7));  
    System.out.println(listLessThan.and(listGreaterThan).negate().test(numList, -7));  
  }  
}
```
***
# References
1. 