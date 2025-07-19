#functional-programming #high-order-function #name-binding #compiler 

# Definition
- Currying is the technique of translating a a function that takes multiple arguments into a sequence of families of functions, <mark class="hltr-yellow">each taking a single argument</mark>:
	- Give a function $f: (X \times Y) \to Z$.
	- Currying function $f$ constructs a new function $g$ so that $g: X \to (Y \to Z)$.
	- The implication is $f(x,y)=g(x)(y)$.
- A curried function is a function that takes multiple arguments one at a time, returning a new function for each argument until all arguments have been provided.
- A curried function is also known as <mark class="hltr-yellow">partially applied function</mark> and the invocation of it is also known as *partial application*.
```Javascript title='Example for curried function'
// Regular function
function multiply(a, b, c) {
    return a * b * c;
}

// Curried version
function curriedMultiply(a) {
    return function(b) {
        return function(c) {
            return a * b * c;
        };
    };
}

// Usage comparison
console.log(multiply(2, 3, 4));           // 24
console.log(curriedMultiply(2)(3)(4));    // 24
```
# Usage
## Javascript
```Javascript title='Curried function to process data in Javascript'
// Curried filter function
const filter = predicate => array => array.filter(predicate);

// Create specialized filters
const getPositiveNumbers = filter(x => x > 0);
const getEvenNumbers = filter(x => x % 2 === 0);

// Apply to different arrays
const numbers = [-2, -1, 0, 1, 2, 3, 4];
console.log(getPositiveNumbers(numbers));  // [1, 2, 3, 4]
console.log(getEvenNumbers(numbers));      // [-2, 0, 2, 4]
```
## Java
```Java title='Simple curried function in Java'
import java.util.function.Function;

public class FunctionalUtil {
  // (Integer, Integer) -> Integer: f(a, b) = a + b
  // (Integer) -> (Integer -> Integer): g(a) = (b) -> a + b
  public static Function<Integer, Function<Integer, Integer>> add() {
    return a -> b -> a + b;
  }
}

// Driver code
System.out.println(FunctionalUtil.add().apply(3).apply(4)); // 7
```

```Java title='Curried function to validate data in Java'
import java.util.function.Function;
import java.util.function.Predicate;

public class ValidationCurrying {
    static class ValidationResult {
        boolean isValid;
        String message;
        
        ValidationResult(boolean isValid, String message) {
            this.isValid = isValid;
            this.message = message;
        }
    }
    
    // Curried validation function
    public static Function<Predicate<String>, Function<String, Function<String, ValidationResult>>>
        validate = predicate -> errorMessage -> value ->
            new ValidationResult(predicate.test(value), 
                predicate.test(value) ? "Valid" : errorMessage);
    
    public static void main(String[] args) {
        // Create specific validators
        Function<String, ValidationResult> validateNonEmpty = 
            validate.apply(s -> !s.isEmpty())
                   .apply("Field cannot be empty")
                   .apply("");
        
        Function<String, ValidationResult> validateEmail = 
            validate.apply(s -> s.contains("@"))
                   .apply("Invalid email format")
                   .apply("");
        
        Function<String, ValidationResult> validateLength = 
            validate.apply(s -> s.length() >= 8)
                   .apply("Minimum length is 8 characters")
                   .apply("");
        
        // Test validators
        String password = "pass123";
        ValidationResult lengthResult = validateLength.apply(password);
        System.out.println(lengthResult.message); // Minimum length is 8 characters
        
        String email = "user@example.com";
        ValidationResult emailResult = validateEmail.apply(email);
        System.out.println(emailResult.message); // Valid
    }
}
```
---
# References
1. Functional Programming in Java: How functional techniques improve your Java programs - Pierre-Yves Saumont - Manning Publications 2017.
	1. Chapter 2. Using Functions in Java.