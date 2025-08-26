#typescript #data-type #javascript #object-oriented-programming #functional-programming #high-order-function #associative-array #structured-programming 

- A type with `type` keyword in Javascript has <mark style="background: #e4e62d;">runtime behaviour</mark>.
- However, it 
# Primitive type
- `string`
- `number`
- `boolean`
# Array
```typescript
const arr: Array<number> = [1,2,3];
// or
const arr: number[] = [1,2,3];
```
# Object type
- Object type represents an object with its properties.
```typescript
// The parameter's type annotation is an object type
function printCoord(pt: { x: number; y: number }) {  
  console.log("The coordinate's x value is " + pt.x);
  console.log("The coordinate's y value is " + pt.y);
}
printCoord({ x: 3, y: 7 });
```

## Optional properties
- Property of an object value are required by default.
- If an optional property does not exist, that property will receive `undefined` value instead of compiler errors.
```typescript
function printName(obj: { first: string; last?: string }) {
// ...
}
// Both OK
printName({ first: "Bob" });
printName({ first: "Alice", last: "Alisson" });
```

- Always check for `undefined` property before access its internal properties.
```typescript
function printName(obj: { first: string; last?: string }) {
// Error - might crash if 'obj.last' wasn't provided! 
console.log(obj.last.toUpperCase());

// 'obj.last' is possibly 'undefined'.
if (obj.last !== undefined) {    // OK    
  console.log(obj.last.toUpperCase());  
}   // A safe alternative using modern JavaScript syntax:  console.log(obj.last?.toUpperCase());}
```

# Enum
```typescript
enum Role {
  ADMIN = 'admin';
  STUDENT = 'student';
}
```


# Type alias
- Equivalent to assignment operator for a specific type.
```typescript
function greet(user: { name: string; age: number }) {
  console.log('Hi, I am ' + user.name);
}

function isOlder(user: { name: string; age: number }, checkAge: number) {
  return checkAge > user.age;
}
type User = { name: string; age: number };

function greet(user: User) {
 console.log('Hi, I am ' + user.name);
}

function isOlder(user: User, checkAge: number) {
  return checkAge > user.age;
}
```
# Union type
- Represents 'OR' operator in logical expressions.
```ts
type Size = "X" | "XL" | "L";
```

# Type indexing
- A way to extract a subset of data from a type.
```ts
type Account = {  
  accountNumber: string;  
  cardNumber: Array<string>;  
  holder: {  
    ssn: string;  
    address: string;  
    phoneNumber: string;  
  }  
}  
  
type AccountHolder = Account["holder"];
```

# Index signature
- The index signature indicates to TypeScript that any fields on the object which are not mentioned ahead of time will be of a particular types.
```typescript
  
let student: Student = {
	citizenId: "2321",
	studentId: "232",
	gpa: 8.5,
	learningYear: 3
}
// compile successfully
let a = student["a"] = 3;
```
# Type intersection
- Type intersection is the <mark style="background: #e4e62d;">extension</mark> of types.
```ts
type PersonalInfo = {  
  ssn: string;  
  address: string;  
  phoneNumber: string;  
}  
  
type vehicleInfo = {  
  vehicleNumber: string;  
  model: string;  
}  
  
type vehicleRegistration = PersonalInfo & vehicleInfo;  
  
const vehicleRegistration: vehicleRegistration = {  
  ssn: "12";  
  address: "Vietnam";  
  phoneNumber: "09123";  
  vehicleNumber: "63X23";  
  model: "Honda Future";  
}
```

# Conditional type
- The value of a `type` can be determined at runtime by a condition.
```ts
type Student = {  
  name: string;  
  id: number;  
  gpa: number;  
  employmentStatus: boolean;  
}  
  
type EmployedStudent = Student extends {employmentStatus: boolean} ? Student : never;  
  
const employedStudent: EmployedStudent = {  
  name: "Kiet",  
  id: 2012,  
  gpa: 9.1,  
  employmentStatus: false,  
}  
  
console.log(employedStudent);
```
# Special types
## void
- `void` represents the return value of functions which don’t return a value.
- `void` is inferred from a function doesn’t have any `return` statements, or doesn’t return any explicit value from those return.
```typescript
// The inferred return type is void
function noop() { 
  return;
}

function f() {
  console.log("Void type");
}
```
-  If the return type of a function is void, the return value of that function is considered `undefined`
```typescript
function add(a: number, b: number): void {
  console.log( a + b );
}

console.log(add(2, 3)); // print undefined
```

## any 
- `any` keyword.
- Represents any object, any type $\implies$ most generic.
- If an expression is of type `any`, any properties of it are accessible. $\implies$ static checking of type is disabled.
```typescript
let obj: any = { x: 0 };
// None of the following lines of code will throw compiler errors.
// Using `any` disables all further type checking, and it is assumed
// you know the environment better than TypeScript.
obj.foo();
obj();
obj.bar = 100;
obj = "hello";
const n: number = obj;


  
// compile sucessfully
let userInput: any;
userInput = 'Bob';
let username: string = userInput;
```

## unknown
- `unknown` type represents any value, but an expression of unknown type is not allowed to access its property.
```typescript
function subtract(a: unknown, b: number): void {
  const result: any = a + b; // errors
}

// compile successfully
let userInput: unknown = 3;
userInput = 'Bob';
console.log(userInput)
```

## never
- `never` type specifies that the function never returns a value.
```typescript
function foo(): never {
  throw ("This is an error");
}Error
```

## Function
- `Function` type represents a type of a high-order function in TypeScript.
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

# Tuple type
- Tuple is an array with known type at specific index.
```ts
type House = [  
  color: string,  
  startDate: Date,  
  host: string  
];  
  
const house: House = [  
  "green",  
  new Date(),  
  "Pham Thi Kim Dung"  
];  
  
console.log(house[1]);
```

# Mapped type


# Examples
## Example 1
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
2. https://www.typescriptlang.org/docs/handbook/2/mapped-types.html
3.  https://www.typescriptlang.org/docs/handbook/2/everyday-types.html#the-primitives-string-number-and-boolean for type.
4. https://basarat.gitbook.io/typescript/future-javascript/destructuring for object destructuring.
5. [Property](Property.md) for property in Javascript.
6. [in keyword](Property.md#in%20keyword) for `in` keyword in Javascript.