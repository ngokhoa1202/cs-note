#typescript #data-type #javascript #oop #functional-programming #high-order-function #associative-array 

- A type with `type` keyword in Javascript has <mark style="background: #e4e62d;">runtime behaviour</mark>.
# Union type
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

# Type intersection
- Extends a type.
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

# Tuple type
- An array with known type at specific index.
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
- 
# Typescript's type cheatsheet
- ![TypeScript Types](TypeScript%20Types.pdf)
---
# References
1. https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-0.html for Typescript official documentation about strict null checking mode.
2. https://www.typescriptlang.org/docs/handbook/2/mapped-types.html
3.  