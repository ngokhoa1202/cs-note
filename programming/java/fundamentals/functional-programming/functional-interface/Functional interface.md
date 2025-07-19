#functional-programming #java #high-order-function  
# Functional Interface
- Functional interface is any interface which has only <mark class="hltr-yellow">one single abstract method </mark>(SAM) and serves as a function type for lambda expressions. The lambda expression's signature must conform to that functional interface's abstract method.
- Annotated by `@FunctionalInterface`.
	```Java
import java.util.LinkedList;  
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

# Implementation
## Lambda expression
- [[Lambda expression]]
```Java title='Lambda expression as a functional interface'
@FunctionalInterface
public interface AsyncCallback<T> {
    void onComplete(T result, Exception error);
}

public class AsyncProcessor {
    public void processData(String data, AsyncCallback<String> callback) {
        // Simulate asynchronous processing
        new Thread(() -> {
            try {
                Thread.sleep(1000);
                String result = data.toUpperCase();
                callback.onComplete(result, null);
            } catch (Exception e) {
                callback.onComplete(null, e);
            }
        }).start();
    }
    
    public static void main(String[] args) throws InterruptedException {
        AsyncProcessor processor = new AsyncProcessor();
        
        // Lambda expression for callback handling
        processor.processData("hello world", (result, error) -> {
            if (error != null) {
                System.err.println("Processing failed: " + error.getMessage());
            } else {
                System.out.println("Processing completed: " + result);
            }
        });
        
        Thread.sleep(2000); // Wait for completion
    }
}
```
## Anonymous class
- [[Anonymous class]]
```Java title='Anonymous class instantiation as a functional interface'
public class EmployeeManagementService {
    public List<Employee> sortEmployeesByComplexCriteria(List<Employee> employees) {
        Comparator<Employee> complexComparator = new Comparator<Employee>() {
            @Override
            public int compare(Employee e1, Employee e2) {
                // Sort by department first, then by salary descending
                int departmentComparison = e1.getDepartment().compareTo(e2.getDepartment());
                if (departmentComparison != 0) {
                    return departmentComparison;
                }
                return Double.compare(e2.getSalary(), e1.getSalary());
            }
        };
        
        employees.sort(complexComparator);
        return employees;
    }
}
```

# Built-in functional interface
## Consumer
[Consumer interface](Consumer%20interface.md)

## Suppiler
[Supplier interface](Supplier%20interface.md)

## Predicate
[Predicate interface](Predicate%20interface.md)

## Function
[Function interface](Function%20interface.md)

# References
1. https://www.baeldung.com/java-8-functional-interfaces
2. [[Lambda expression]] for Lambda expression in Java.
3. 




