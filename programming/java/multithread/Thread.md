#java #parallel-programming 

# Thread
- Must implement `interface Runnable` or extend `class Thread`.
- `synchronized` for protecting critical section.
- File `ThreadDemo.java`
```Java
public class ThreadDemo implements Runnable {  
  public static Long sum = (long) 0;  
  @Override  
  public void run() {  
    for (int i = 1; i <= 100_000_000; ++i) {  
      synchronized (this) {  
        sum += (long) i;  
      }  
    }  
  }
}
```
- File `Main.java`
```Java
import java.util.Collections;  
import java.util.LinkedList;  
import java.util.List;  
import java.util.Random;  
import java.util.function.*;  
  
public class Main {  
  private static int THREADS = 2;  
  public static void main(String[] args) {  
    List<Thread> threadDemoList = new LinkedList<Thread>();  
    for (int i = 0 ; i < THREADS; ++i) {  
      threadDemoList.add(new Thread(new ThreadDemo()));  
    }  
  
    for (int i = 0; i < THREADS; ++i) {  
      threadDemoList.get(i).start();  
    }  
  
    try {  
      for (int i = 0; i < THREADS; ++i) {  
        threadDemoList.get(i).join();  
      }  
    } catch (Exception ex) {  
      System.out.println("Interrupt");  
    }  
  
    System.out.println(ThreadDemo.sum);  
  }  
}
```


# References
1. https://medium.com/@seungbae2/understanding-the-synchronized-keyword-in-java-ensuring-thread-safety-and-synchronization-4d8f84622a77#:~:text=A%20synchronized%20method%20is%20a,synchronized%20method%20at%20a%20time. 
2. https://www.geeksforgeeks.org/synchronization-in-java/ 
3. 