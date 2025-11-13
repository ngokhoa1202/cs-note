#java #high-order-function #functional-programming #java8 
# Lambda expression
- An lambda expression may or may not specify type in Java.
- Every lambda expression is an instance of a [Function interface](Function%20interface.md).
```Java title='Lambda expression syntax in Java'
(T1? param1, T2? param2, ...) -> {
  ...
}
```

```Java title='Lambda expression example in Java'
() -> {} // No parameters; result is void
() -> 42 // No parameters, expression body
() -> null // No parameters, expression body
() -> { return 42; } // No parameters, block body with return
() -> { System.gc(); } // No parameters, void block body

() -> {
	// Complex block body with returns
	if (true) return 12;
	else {
	int result = 15;
	for (int i = 1; i < 10; i++){
		result *= i;
		return result;
	}
}
(int x) -> x+1 // Single declared-type parameter
(int x) -> { return x+1; } // Single declared-type parameter
(x) -> x+1 // Single inferred-type parameter
x -> x+1 // Parentheses optional for single inferred-type parameter
(String s) -> s.length() // 
(Thread t) -> { t.start(); } // Single declared-type parameter
s -> s.length() // Single inteferred-type parameter
t -> { t.start(); } // Single inferred-type parameter

(int x, int y) -> x+y // Multiple declared-type parameters
(x, y) -> x+y // Multiple inferred-type parameters

(x, int y) -> x+y // Illegal: can't mix inferred and declared types
(x, final y) -> x+y // Illegal: no modifiers with inferred types
```
***
# References
1. The Java® 21 Language Specification.
	1. Chapter 15. Expressions
		1. Section 27. Lambda expression.

