#go #data-type 
# Variable declaration
- Regular variable declaration
```Go title='General form of variable declaration'
var name type? = expression
```
## Short variable declaration
- Unlike regular variable declarations, a short variable declaration may _redeclare_ variables or parameters provided they were originally declared earlier in the same block with the same type, and at least one of the non-blank variables is new.
- Re-declaration does not introduce a new variable; it just assigns a new value to the original.
```Go title='Short form of variable declaration'
ShortVarDecl = IdentifierList ":=" ExpressionList .
```

```Go title='Variable declaration examples'
package main

import (
	"fmt"
)

// g := 3 // global variable must not use type inference but has to be declared with var keyword
var g = 3

func main() {
	// var i, j, k int                       // variable declaration without initialization
	// var b, f, s = true, 3.4, "capitalist" // variable declaration with initialization

	// var n int
	// _, err := fmt.Scanln(&n) // variable declaration with initialization using type inference

	x := 1
	p := &x // pointer to the space that contains the value of x
	fmt.Println(x)
	*p = 2 // works properly

	// *p = "I love you" // raise syntatic error since p is the pointer to int, not to string
}

// this function works properly in Go because the memory holding n is not destroyed
// when the program gets out of the callee scope
func getPointerToClosureVariable() *int {
	n := 3
	return &n
}
```

```Go title='Redeclaration in short variable declaration'
field1, offset := nextField(str, 0)
field2, offset := nextField(str, offset)  // redeclares offset
x, y, x := 1, 2, 3                        // illegal: x repeated on left side of :=
```
# Constants
- Constants are expressions whose value is known to the compiler and calculated in <mark class="hltr-yellow">compile time</mark>.
## Untyped constants
- [[programming/go/fundamentals/Type conversion#Untyped constant|Type conversion]].
## Typed constants
### Explicit type declaration
```Go title='Type constant with explicit type declaration'
const X float32 = 3.14

const (
	A, B int64   = -3, 5
	Y    float32 = 2.718
)
```
### Explicit type conversion
```Go title='Type constant with explicit type conversion'
const X = float32(3.14)

const (
	A, B = int64(-3), int64(5)
	Y    = float32(2.718)
)
```

```Go title='Illegal type constant with type declaration'
// error: 256 overflows uint8
const a uint8 = 256
// error: 256 overflows uint8
const b = uint8(255) + uint8(1)
// error: 128 overflows int8
const c = int8(-128) / int8(-1)
// error: -1 overflows uint
const MaxUint_a = uint(^0)
// error: -1 overflows uint
const MaxUint_b uint = ^0
```
# Type inference
- If the type is not specified in variable declaration, it is automatically inferred by the Go compiler.
# Tuple assignment
- Tuple assignment allows several variables to be assigned at once. 
- All of the right-hand side expressions are evaluated before any of the variables are updated.
```Go title='Tuple assignment example'
f, err := os.Open("input.txt")
if err != nil {
	fmt.Printf("%s", err)
}
```
***
# References
1. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
2. The Go Programming Language Specification - ## Language version go1.24 (Dec 30, 2024).
3. https://go.dev/ref/spec#Short_variable_declarations
4. 