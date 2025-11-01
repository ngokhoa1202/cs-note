#operator #functional-programming #high-order-function #javascript #typescript #ecmascript 

# Spread operator
- Spread operator (`...`) allows an iterable object to be <mark style="background: #e4e62d;">expanded</mark> in places where arguments (for function calls) or elements (for array literals) are expected.
- For object literal, spread operator enumerates the properties of an object and adds the <mark style="background: #e4e62d;">key-value pairs</mark> to the object being created.
```javascript
function sum(...a) {
  let sum = 0;
  a.forEach((e, i) => {
    sum += e;
  });
  return sum;
}

const numbers = [1, 2, 3];

console.log(sum(4, ...numbers));
// Expected output: 10

console.log(sum.apply(null, [4, ...numbers]));
// Expected output: 10

```

>[!Important]
>Spread operator performs a shallow copy on every attribute of the source object without the source's encapsulation. While without spread operator, these attributes are encapsulated by a new object with the same name in the target object.

```javascript title='Spread operator vs normal copy'
const obj = {
    id: '23',
    name: 'khoango'
  };

  const changes = {
    name: 'khoango-change'
  };

  const finalObj1 = {obj, changes};
  const finalObj2 = {obj, ...changes};
  console.log(finalObj1, finalObj2);
```
# Use cases
## Function invocation
```javascript
function myFunction(x, y, z) {}
const args = [0, 1, 2];
myFunction(...args);

// constructor
const dateFields = [1970, 0, 1]; // 1 Jan 1970
const d = new Date(...dateFields);
```
## Array literal
- Spread operator can be used for <mark style="background: #e4e62d;">passing array arguments</mark> to function to make the expression declarative and succinct.
```javascript
const parts = ["shoulders", "knees"];
const lyrics = ["head", ...parts, "and", "toes"];
//  ["head", "shoulders", "knees", "and", "toes"]
```
- The elements of the source array is <mark style="background: #e4e62d;">shallowly copied</mark> into the target array.
## Object literal
- Spread operator can be used to copy the properties of an object literal.
```javascript title='Spread operator for object literal'
const student = {
	studentId: "2",
	gpa: 8.5,
	major: "Computer Science"
}

  

const employee = {
	employeeId: "3",
	department: {
		name: "IT",
		location: "Ho Chi Minh city"
	}
}

const employedStudent = {...student, ...employee};
console.log(employedStudent);
```
- The copy is shallow copy by default.
- The properties of the copied object can be overriden.
```javascript title='Properties are overriden'
const student = {
	studentId: "2",
	gpa: 8.5,
	major: "Computer Science"
}

  

const employee = {
	employeeId: "3",
	department: {
		name: "IT",
		location: "Ho Chi Minh city"
	}
}

const employedStudent = {...student, ...employee};
console.log(employedStudent);
```
# References
1. https://en.wikipedia.org/wiki/Variadic_function for variadic function concepts.
2. *https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax for Spread operator.*
3. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters for Rest operator.
4. ECMAScript ® 2020 Language Specification - 11th June, 2020.
