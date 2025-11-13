#functional-programming #java #high-order-function  
# Functional Interface
- Functional interface in Java is an interface has only one <mark class="hltr-yellow">single abstract method</mark> (SAM).
- Every implementation of a functional interface can be treated as a lambda expression. 
- A functional interface is annotated by `{Java} @FunctionalInterface`.
```Java title='Functional interface in Java'import java.util.LinkedList;  
import java.util.List;  
  
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
  
    ListDisplay listDisplay = (List<Integer> list) -> {  
      for (Integer element: list) {  
        System.out.print(element + " ");  
      };  
      System.out.println();  
    };  
  
    Transformation squareTransformation = (Integer n) -> {  
    return n*n;  
    };  
  
    Transformation cubeTransformation = (Integer n) -> {  
      return n * n * n;  
    };  
  
    ListTransformation listTransformation = (List<Integer> list, Transformation transformation) -> {  
      for (int i = 0; i < list.size(); ++i) {  
        list.set(i, transformation.calculate(list.get(i)));  
      };  
    };  
  
    listTransformation.transform(numList, squareTransformation);  
    listDisplay.display(numList);  
  }  
}
```
# Built-in functional interface
## Consumer
- [Consumer interface](Consumer%20interface.md)
## Supplier
- [Supplier interface](Supplier%20interface.md)
## Predicate
- [Predicate interface](Predicate%20interface.md)
## Function
- [Function interface](Function%20interface.md)
***
# References
1. [[Consumer interface|Consumer interface]] for Consumer interface in Java.
2. [[Supplier interface|Supplier interface]] for Supplier interface in Java.
3. [[Predicate interface|Predicate interface]] for Predicate interface in Java.
4. [[Function interface|Function interface]] for Function interface in Java.






