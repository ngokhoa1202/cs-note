#go #data-type 

# Variable declaration
- Regular variable declaration
```Go title='General form of variable declaration'
var name type? = expression
```
## Short variable declaration
- Unlike regular variable declarations, a short variable declaration may _redeclare_ variables or parameters provided they were originally declared earlier in the same block with the same type, and at least one of the non-blank variables is new.
- Redeclaration does not introduce a new variable; it just assigns a new value to the original.
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
---
# References
1. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
2. The Go Programming Language Specification - ## Language version go1.24 (Dec 30, 2024).
3. https://go.dev/ref/spec#Short_variable_declarations
4. 