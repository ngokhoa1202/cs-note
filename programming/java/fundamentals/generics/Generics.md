#java #polymorphism #object-oriented-programming #java8 #java17

- Generics in Java is a kind of [Parametric Polymorphism][[Polymorphism#Parametric polymorphism].
# Generic type
- A _generic_ type is a generic class or interface that is <mark class="hltr-yellow">parameterized over types</mark>.
```Java title='Java Generic type syntax'
class name<T1, T2, ..., Tn> { /* ... */ }
```

```Java title='Define a generic class in Java and instantiate its instance'
/**
 * Generic version of the Box class.
 * @param <T> the type of the value being boxed
 */
public class Box<T> {
    // T stands for "Type"
    private T t;

    public void set(T t) { this.t = t; }
    public T get() { return t; }
}

// ...
Box<Integer> integerBox = new Box<Integer>(); // full form
Box<Integer> integerBox = new Box<>(); // short form
```

>[!Important]+ Type parameter naming convention
>`E` - Element (used extensively by the Java Collections Framework).
> `K` - Key.
> `N` - Number
> `T` - Type.
> `V` - Value.
> `S`, `U`, `V` - 2nd, 3rd, 4th types.
# Raw type
- If a generic type's object is instantiated without any type arguments, its type become <mark class="hltr-yellow">a raw type</mark>.  The type arguments are automatically assigned to `Object`. 
```Java title='Raw type examples'
Box box = new Box(); //
// Box<Object> box = new Box<Object>(); // behind the scene
```
- A parameterized type is allowed to be assigned to its raw type.
```Java title='Assigning parameterized type to raw type is acceptable'
Box<String> stringBox = new Box<>();
Box rawBox = stringBox;               // OK
```
- However, assigning a raw type to a parameterized type or invoking methods of raw type causes unchecked conversion or unchecked invocation warnings.
```Java title='Assigning a raw type to a parameterized type causes warning'
Box rawBox = new Box();           // rawBox is a raw type of Box<T>
Box<Integer> intBox = rawBox;     // warning: unchecked conversion
```

```Java title='Method invocation via raw type causes warning'
Box<String> stringBox = new Box<>();
Box rawBox = stringBox;
rawBox.set(8);  // warning: unchecked invocation to set(T)
```

# Generic methods
- Generic methods are method whose <mark class="hltr-yellow">parameter types are parameterized</mark>.
```Java title='Generic methods in Java'
public class Util {
    public static <K, V> boolean compare(Pair<K, V> p1, Pair<K, V> p2) {
        return p1.getKey().equals(p2.getKey()) &&
               p1.getValue().equals(p2.getValue());
    }
}

public class Pair<K, V> {

    private K key;
    private V value;

    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public void setKey(K key) { this.key = key; }
    public void setValue(V value) { this.value = value; }
    public K getKey()   { return key; }
    public V getValue() { return value; }
}

```

# Bounded type parameter
- Java types are in-variances. which means that that `class A` extends `class B` does not imply `Container<A>` is a subtype of `Container<B>`
- Bounded type parameter restricts  the type boundary to the type parameters.
```Java title='Bounded type parameter example in Java'
// T must be Number or its subtype
public class NumberBox<T extends Number> {
    private T value;
    
    public NumberBox(T value) {
        this.value = value;
    }
    
    // Can use Number methods because T extends Number
    public double getDoubleValue() {
        return value.doubleValue();  // Safe - all Numbers have this method
    }
    
    public int getIntValue() {
        return value.intValue();     // Safe - all Numbers have this method
    }
}

// Usage
public class BoundedExample1 {
    public static void main(String[] args) {
        NumberBox<Integer> intBox = new NumberBox<>(42);          // ✓ OK
        NumberBox<Double> doubleBox = new NumberBox<>(3.14);     // ✓ OK
        NumberBox<Long> longBox = new NumberBox<>(100L);         // ✓ OK
        
        // NumberBox<String> stringBox = new NumberBox<>("Hi");  // ✗ Compile error!
        // String doesn't extend Number
        
        System.out.println(intBox.getDoubleValue());  // 42.0
    }
}
```
## Multiple bounds
- A type parameter can extend one class and implement multiple interfaces.
```Java title='Multiple bounds for multiple inheritance of type parameter'
// T must extend Animal AND implement Comparable and Serializable
// Note: class must come first, then interfaces
public class Zoo<T extends Animal & Comparable<T> & Serializable> {
    private List<T> animals = new ArrayList<>();
    
    public void addAnimal(T animal) {
        animals.add(animal);
    }
    
    // Can use methods from all bounds
    public void sortAnimals() {
        Collections.sort(animals);  // Works because T implements Comparable
    }
    
    public void feedAll() {
        for (T animal : animals) {
            animal.eat();  // From Animal class
        }
    }
    
    public T getYoungest() {
        return animals.stream()
            .min(Comparator.comparing(Animal::getAge))  // Can access Animal methods
            .orElse(null);
    }
}

// Example implementation
class Dog extends Animal implements Comparable<Dog>, Serializable {
    private String name;
    
    @Override
    public void eat() { System.out.println("Dog eating"); }
    
    @Override
    public int compareTo(Dog other) {
        return this.name.compareTo(other.name);
    }
}
```
# References
1. https://dev.java/learn/generics/intro/
2. [[Polymorphism]] for Polymorphism principle.
3. https://docs.oracle.com/en/java/javase/17/language/local-variable-type-inference.html.
4. [[Co-variance, Contra-variance and In-variance]] for in-variance concepts.
5. https://docs.oracle.com/javase/tutorial/java/generics/bounded.html for Java bounded type parameters official documentation.
6. https://docs.oracle.com/javase/tutorial/java/generics/inheritance.html for Java inheritance of generics official documentation.