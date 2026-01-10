#java #java-core #java17 #java21 #java8
- Variable assignment is always actually copy-on-value and parameter passing is always pass-by-value in Java.
# Temporary variable
- The logic of variable swapping must be performed in an <mark class="hltr-yellow">inline</mark> manner.
```Java title='Swap two variables with temporary variable'
// This must be inline
final int tmp = a;
a = b;
b = tmp;
```
## Swap two elements in an array
- In case, two elements in the same array need swapping, the logic of swapping can be separated into a method.
```Java title='Swap two elements in the same array with temporary variable'
class Business {
  public void doSomething() {
    
    this.swap(nums, i, j);
  }
  
  private void swap(int[] nums, int i, int j) {"
    final int tmp = nums[i];
    nums[i] = nums[j];
    nums[j] = tmp;
  }
}
```
***
# References
1. [[programming/principles/function/Parameter-passing mechanisms|Parameter-passing mechanisms]]
2. 