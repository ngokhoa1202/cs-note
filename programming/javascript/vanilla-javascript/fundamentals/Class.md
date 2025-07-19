#object-oriented-programming #javascript #vanilla-javascript #typescript #ecmascript #structured-programming #software-architecture 

- JavaScript is a <mark style="background: #e4e62d;">prototype-based</mark> language — an object's behaviors are specified by <mark style="background: #e4e62d;">its own properties</mark> and <mark style="background: #e4e62d;">its prototype's properties</mark>.
# Class definition
- There are two ways to define a class in Javascript.
## Class declaration
```javascript title='Class definition with traditional class declaration'
// Declaration

class Rectangle {

	#scale = 1 // private attribute
	/**
		*
		* @param {number} height
		* @param {number} width
	*/
	
	constructor(height, width) {
		this.height = height;
		this.width = width;
	}
	/**
		*
		* @returns {number}
	*/

	getArea() { // public method
		this.#performCeiling();
		return this.width * this.height;
	}

  

	#performCeiling() { // private method
		this.width = Math.ceil(this.width);
		this.height = Math.ceil(this.height);
	}

	/**
	*
	* @param {number} scale
	*/

	#setScale(scale) { // private method
		this.#scale = scale;
	}

	/**
		*
		* @param {Rectangle} rect
		* @returns {boolean}
	*/

	static isSquare(rect) { // static method
		return rect.width === rect.height;
	}
}
```

## Class expression
```javascript title='Class definition with class expression'
// Expression; the class is anonymous but assigned to a variable
const Rectangle = class {
  constructor(height, width) {
    this.height = height;
    this.width = width;
  }
};

// Expression; the class has its own name
const Rectangle = class Rectangle2 {
  constructor(height, width) {
    this.height = height;
    this.width = width;
  }
};
```

# Class body
- The body of a class is always executed in strict mode without `use strict` directive.
# <span style="font-family: 'JetBrains Mono';">this</span> pointer
- `this` pointer must be explicitly used to access the object's property, even inside the class definition.
```javascript title='this pointer to access internal properties'
// Declaration
class Rectangle {

	#scale = 1 // private attribute
	/**
	*
	* @param {number} height
	* @param {number} width
	*/
	constructor(height, width) {
		this.height = height;
		this.width = width;
	}

	/**
	*
	* @returns {number}
	*/
	getArea() {
		this.#performCeiling();
		// when this pointer is not used, width variable refers to global variables, if exist
		return width * this.height;
	}

	#performCeiling() { // private method
		this.width = Math.ceil(this.width);
		this.height = Math.ceil(this.height);
	}
}
```

# Class inheritance
- `interface` is not supported by Javascript.
```javascript title='Inheritance in Javascript'
class Point {
	constructor(private x: number, private y: number) {
	
	}

	distance(this: Point): number {
		return Math.sqrt(this.x * this.x + this.y * this.y);
	}
}
```
- Inheritance in Javascript is Prototypal inheritance.
---
# References
1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes for official classes documentation.
2. ECMAScript ® 2020 Language Specification - 11th June, 2020.
3. 