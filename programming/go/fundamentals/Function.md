#functional-programming #go #data-type #high-order-function #structured-programming 
# Function declaration
```Go title='Function declaration form in Go'
func name(parameter-list) (result-list) {
	body
}
```

```Go title='Function declaration example'
func SquaresOfSumAndDiff(a int64, b int64) (s int64, d int64) {
	x, y := a + b, a - b
	s = x * x
	d = y * y
	return // <=> return s, d
}
```
- A function can *return multiple values* respectively.
- *Default parameters are not supported*.
- Function whose body has the last statement as a terminating statement does not have to return a value.
```Go title='Function example do not return a value'
func fa() int {
	a:
	goto a
}

func fb() bool {
	for{}
}
```
# Function call
- All function arguments are <mark class="hltr-yellow">passed by value</mark>. If the callee needs to change an instance argument, a pointer as a parameter is required and the address of the instance needs passing into that pointer.
- The functions of the `unsafe` standard package are always evaluated at compile time.
- If the return results of a call to a multi-result function are not discarded, then the call can only be used as a multi-value expression in two scenarios:
	- The call can be used in an assignment as source values. But the call <mark class="hltr-yellow">can't mix with other source values</mark> in the assignment.
	- The call can be nested in another function call as arguments. But the call <mark class="hltr-yellow">can't mix with other arguments</mark>.
```Go title='Function calls as expressions notice' 
package main

func HalfAndNegative(n int) (int, int) {
	return n/2, -n
}

func AddSub(a, b int) (int, int) {
	return a+b, a-b
}

func Dummy(values ...int) {}

func main() {
	// These lines compile okay.
	AddSub(HalfAndNegative(6))
	AddSub(AddSub(AddSub(7, 5)))
	AddSub(AddSub(HalfAndNegative(6)))
	Dummy(HalfAndNegative(6))
	_, _ = AddSub(7, 5)

	// The following lines fail to compile.
	/*
	_, _, _ = 6, AddSub(7, 5)
	Dummy(AddSub(7, 5), 9)
	Dummy(AddSub(7, 5), HalfAndNegative(6))
	*/
}
```
# Function signature
- Function signature is also <mark class="hltr-yellow">function type</mark> in Go because function is *first-class*  value in Go.
```Go title='Equivalent representation of unamed function signature'
func (int, string, string) (int, int, bool) // the standard form
func (a int, b string, c string) (int, int, bool)
func (x int, _ string, z string) (int, int, bool)
func (int, string, string) (x int, y int, z bool)
func (int, string, string) (a int, b int, _ bool)
```
- Function types are *incomparable*.
# Function prototype
- Function prototype is composed of function name and function signature, but has no body.
```Go title='Function prototype'
func Double(n int) (result int)
```
# Variadic function
- The variadic parameter must the last parameter of the function signature.
```Go title='Variadic function'
// Sum and return the input numbers.
package main

import "fmt"

func Sum(values ...int64) (sum int64) {
	sum = 0
	for _, v := range values {
		sum += v
	}
	return
}

func main() {
	a0 := Sum()
	a1 := Sum(2)
	a3 := Sum(2, 3, 5)
	// The above three lines are equivalent to
	// the following three respective lines.
	b0 := Sum([]int64{}...) // <=> Sum(nil...)
	b1 := Sum([]int64{2}...) 
	b3 := Sum([]int64{2, 3, 5}...)
	fmt.Println(a0, a1, a3) // 0 2 10
	fmt.Println(b0, b1, b3) // 0 2 10
}
```

```Go title='Print, Printf, Println of fmt package employ variadic function'
func Print(a ...interface{}) (n int, err error)
func Printf(format string, a ...interface{}) (n int, err error)
func Println(a ...interface{}) (n int, err error)
```
- The variadic argument must be passed either in these two manners:
	- Pass a slice value as the only argument. The slice must be assignable to values of type `[]T`, and the slice must be followed by three dots `...`. The passed slice is called as a variadic argument.
	- Pass zero or more arguments which are assignable to values of type `T`. These arguments will be copied (or converted) as the elements of a new allocated slice value of type `[]T`, then the new allocated slice will be passed to the variadic parameter.
# Function value
- Function type is one of the type in Go.  Function value is a value of a function type. Function value is<mark class="hltr-yellow"> first-class value</mark> in Go.
```Go title='Function type and function value in Go'
package main

import "fmt"

func Double(n int) int {
	return n + n
}

func Apply(n int, f func(int) int) int {
	return f(n) // the type of f is "func(int) int"
}

func main() {
	fmt.Printf("%T\n", Double) // func(int) int
	// Double = nil // error: Double is immutable.

	var f func(n int) int // default value is nil.
	f = Double
	g := Apply // let compile deduce the type of g
	fmt.Printf("%T\n", g) // func(int, func(int) int) int

	fmt.Println(f(9))         // 18
	fmt.Println(g(6, Double)) // 12
	fmt.Println(Apply(6, f))  // 12
}
```

>[!Note]
>Function value is a first-class function. Function type is the type of that first-class function.
- Anonymous function is also supported.
```Go title='Anonymous function'
package main

import "fmt"

func main() {
	// This function returns a function (a closure).
	isMultipleOfX := func (x int) func(int) bool { // return a predicate n % x = 0
		return func(n int) bool {
			return n%x == 0
		}
	}

	var isMultipleOf3 = isMultipleOfX(3) // -> n % 3 = 0 => predicate
	var isMultipleOf5 = isMultipleOfX(5) // -> n % 5 = 0 => predicate
	fmt.Println(isMultipleOf3(6))  // true
	fmt.Println(isMultipleOf3(8))  // false
	fmt.Println(isMultipleOf5(10)) // true
	fmt.Println(isMultipleOf5(12)) // false

	isMultipleOf15 := func(n int) bool {
		return isMultipleOf3(n) && isMultipleOf5(n)
	}
	fmt.Println(isMultipleOf15(32)) // false
	fmt.Println(isMultipleOf15(60)) // true
}
```
***
# References
1. https://go101.org/article/function.html for Function Signature in Go.
2. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
	1. Chapter 5. Functions.
3. https://go101.org/article/function-declarations-and-calls.html for Function Declaration in Go.
4. https://go101.org/article/summaries.html#compile-time-evaluation for compile-time evaluated function.
5. 