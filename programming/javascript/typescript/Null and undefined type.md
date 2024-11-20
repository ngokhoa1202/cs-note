#typescript  #javascript #operator  #compilation 

# Null and undefined type
- In Typescript, `null` and `undefined` are considered special type and not in the domain of any other types.
- By default, Typescript enables <mark style="background: #e4e62d;">strict null checking</mark> mode:
	- `T` and `T | null` are different.
	- `T` and `T | undefined` are different.
- Employ optional operator in Typescript whenever performing operators on the object.
```typescript
// Compiled with --strictNullChecks
declare function f(x: number): string;
let x: number | null | undefined;

if (x) {
	f(x); // Ok, type of x is number here
} else {
	f(x); // Error, type of x is number? here
}

let a = x != null ? f(x) : ""; // Type of a is string
let b = x && f(x); // Type of b is string | 0 | null | undefined
```

---
# References
1. https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-0.html for Typescript official documentation about strict null checking mode.
2. 