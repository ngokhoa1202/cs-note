#object-oriented-programming #javascript #vanilla-javascript #typescript #ecmascript 

- Inherits and extends feature of Javascript [Class](programming/javascript/vanilla-javascript/fundamentals/Class.md).
- Typescript classes end up being compiled into equivalent <mark style="background: #e4e62d;">Javascript classes</mark>.
# Readonly properties
- Readonly attributes do not need initializing when being declared; however, after being initialized, their value is unchanged.
```typescript title='readonly attributes in Typescript'
class Point {
	#x: number = 0;
	#y: number = 0;
	readonly dimension: number;
	
	constructor(x: number, y: number) {
		this.#x = x;
		this.#y = y;
		this.dimension = 2;
	}

	static of(_x?: number, _y?: number): Point {
		const x = (_x) ? _x : 0;
		const y = (_y) ? _y : 0;
		return new Point(x, y);
	}

	getDistance(): number {
		return Math.sqrt((this.#x * this.#x) + (this.#y * this.#y));
	}

}

const p: Point = new Point(3.5, 4.6);
console.log(p);
```

# <span style="font-family: 'JetBrains Mono';">this</span> pointer
- `this` pointer in Typescript extends from [<span style="font-family: 'JetBrains Mono';">this</span> pointer](programming/javascript/vanilla-javascript/fundamentals/Class.md#<span%20style="font-family%20'JetBrains%20Mono';">this</span>%20pointer) in Javascript.
- `this` pointer can be explicitly declared in the signature of the method.
```typescript title='this pointer in method declaration'
  
class Point {

	x: number = 0;
	y: number = 0;
	readonly dimension: number;

  

	constructor(x: number, y: number) {
		this.x = x;
		this.y = y;
		this.dimension = 2;
	}

	static of(_x?: number, _y?: number): Point {
		const x = (_x) ? _x : 0;
		const y = (_y) ? _y : 0;
		return new Point(x, y);
	}

	#getDistance(this: Point): number {
		return Math.sqrt((x * this.x) + (this.y * this.y));
	}

	distance(this: Point): number {
		return this.#getDistance();
	}

	toString(this: Point): string {
		return `Point(${this.x}, ${this.y})`;
	}
}
```
- This feature raises an error if the object having invoked the method is not the original instance owning that method.
```typescript title='this pointer in method signature raises error'

class Point {
	x: number = 0;
	y: number = 0;
	readonly dimension: number;

	constructor(x: number, y: number) {
		this.x = x;
		this.y = y;
		this.dimension = 2;
	}

	static of(_x?: number, _y?: number): Point {
		const x = (_x) ? _x : 0;
		const y = (_y) ? _y : 0;
		return new Point(x, y);
	}

	#getDistance(this: Point): number {
		return Math.sqrt((x * this.x) + (this.y * this.y));
	}

	distance(this: Point): number {
		return this.#getDistance();
	}

	toString(this: Point): string {
		return `Point(${this.x}, ${this.y})`;
	}
}

const point: Point = new Point(2.5, 4.8);
const copiedPoint = {
	x: point.x,
	y: point.y,
	distance: point.distance
}

// throw compilation error 
// because copiedPoint is not the original method

console.log(copiedPoint.distance());

```

# Access modifier
```typescript title='access modifier'
class Foo {

	public bar: number = 1;
	far: number = 2; // public by default
	protected boo: string = '';
	private goo: number = 1;
	
	constructor(){}
}
```

## Short constructor
- Equivalent to constructor property promotion in PHP.
```typescript
class Point {

   private z: number;
	constructor(public x: number, public y: number) {
		this.z = 0;
	}
	
	distance(this: Point): number {
		return Math.sqrt(this.x * this.x + this.y * this.y);
	}
}
```

# Setter - getter
```typescript title='setter, getter'
class C {  
  _length = 0;  
  get length() {    
    return this._length; 
  }  
  
  set length(value) {    
    this._length = value;  
  }
}
```

- Since Typescript 4.3, setters and getters can accept and return different types, respectively.
```typescript title='setter, getter'
class Thing {
  _size = 0;
 
  get size(): number {
    return this._size;
  }
 
  set size(value: string | number | boolean) {
    let num = Number(value);
 
    // Don't allow NaN, Infinity, etc
 
    if (!Number.isFinite(num)) {
      this._size = 0;
      return;
    }
    this._size = num;
  }
}

class Employee {

}

class Manager extends Employee {

}

class Director {
	constructor(private _manager: Manager) {}
	get manager(): Employee {
		return this._manager;
	}

}
```
---
# References
1. [Class](programming/javascript/vanilla-javascript/fundamentals/Class.md) for classes in Javascript.
2. https://www.typescriptlang.org/docs/handbook/2/classes.html for Class in Typescript.
3. https://www.php.net/manual/en/language.oop5.decon.php#language.oop5.decon.constructor.promotion for PHP constructor property promotion.