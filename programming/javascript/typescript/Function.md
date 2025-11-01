#javascript #vanilla-javascript #typescript #functional-programming #high-order-function 

# Function type
- A function type can be specified when a function is defined.
- Either arrow function expression or `Function` interface can be used to define a function type.
```typescript title='Function type'
function add(x: number, y: number): number {
  return x + y;
}

// arrow function
let myAdd: (x: number, y: number) => number = function (
  x: number, 
  y: number
): number { 
  return x + y;
};

let otherAdd: Function = add;
```
- Type script can implicitly infer the function type without explicit declaration.
# Optional parameter
- A parameter can be specified to be optional by adding `?` symbol.
```typescript
function buildName(firstName: string, lastName?: string)  {  
  if (lastName) return firstName + " " + lastName; 
  else return firstName;
}
let result1 = buildName("Bob"); // works correctly now
```

# Default parameter
- A parameter can be by default assigned to a compile-time expression.
```typescript title='Default parameters'
function buildName(firstName: string, lastName: string = "Smith") {  
  // ...  
} 
```

# Rest parameter
- Rest parameter is a built-in feature of Javascript used to <mark style="background: #e4e62d;">collect multiple elements</mark> and represent them into a single variable, which makes the function variadic.
- Conversely, spread operator allows an iterable object to be expanded  in places where arguments (for function calls) or elements (for array literals) are expected.
```typescript title='Rest parameter and Spread operator'

// Rest operator for function parameters
function buildName(firstName: string, ...restOfName: string[]) {  
  return firstName + " " + restOfName.join(" ");
} // employeeName will be "Joseph Samuel Lucas MacKinzie"

let employeeName = buildName("Joseph", "Samuel", "Lucas", "MacKinzie");

// Spread operators for arguments
const names: string[] = ["John", "Bob", "Smith", "Peterson"]
let result: string = buildName("Thomas", "Jack", ...names);

```

# References
1. https://en.wikipedia.org/wiki/Variadic_function for variadic function concepts.
2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax for Spread operator.
3. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters for Rest operator.