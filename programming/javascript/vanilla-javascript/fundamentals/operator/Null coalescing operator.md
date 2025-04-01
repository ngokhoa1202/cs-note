#operator #javascript #vanilla-javascript #abstract-syntax-tree 

# Null coalescing operator
- Denoted by `??`.
- Null coalescing operator is equivalent to 
```javascript title='Null coalescing operator'
result = (a !== null && a !== undefined) ? a : b;
```

# Null coalescing vs Or operator
- Both operators are implied from short circuit evaluation.
- Or operator `||` in Javascript returns the <mark style="background: #e4e62d;">first truthy value</mark>. While null coalescing operator returns the <mark style="background: #e4e62d;">first defined value</mark>.
	- This implies that their side effect remains almost the same.
```javascript title='|| vs ?? in Javascript'
let height = 0;

/* Consider height = 0 a valid case? */
// use only when 0 is invalid
alert(height || 100); // 100 
// use 0 is either valid or invalid
alert(height ?? 100); // 0 

```
---
# References
1. https://javascript.info/nullish-coalescing-operator for Null coalescing operator.
2. https://en.wikipedia.org/wiki/Short-circuit_evaluation for Short circuit evaluation mechanism.