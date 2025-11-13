#java-generic #java #data-type #compiler #jvm 
# Definition
- Heap pollution occurs when a variable of a parameterized type refers to an object that is *not of that parameterized type*.
- The potential error is normally detected during compilation and indicated with an *unchecked warning*. Later, heap pollution will cause a `{Java}ClassCastExeception` during runtime.
```Java title='Heap pollution in a varargs context'
static void unsafe(List<String>... stringLists) {
  Object[] array = stringLists;          // Array of List<String> treated as Object[]
  array[0] = List.of(42);                //<- inserts List<Integer> into List<String>[]
  String s = stringLists[0].get(0);      // Runtime ClassCastException
}
```

```Java title='Heap pollution in a non-varargs context'
public class HeapPollutionDemo {
    public static void main(String[] args) {
        Set s = new TreeSet<Integer>();
        Set<String> ss = s;              // unchecked warning
        s.add(new Integer(42));          // another unchecked warning
        Iterator<String> iter = ss.iterator();

        while (iter.hasNext()) {
            String str = iter.next();    // ClassCastException thrown
            System.out.println(str);
        }
    }
}

```
***
# References
1. https://en.wikipedia.org/wiki/Heap_pollution for Heap pollution definition and example.
2. 