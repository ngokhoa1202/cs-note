#go #data-type #data-structure 
# Definition
- Slices represent <mark class="hltr-yellow">variable-length sequences</mark> whose elements all have the <mark class="hltr-yellow">same type</mark>. A slice type is written `[]T`, where the elements have type `T`; it looks like an array type without a size.
- A slice is an <mark class="hltr-yellow">indirect reference</mark> that gives access to a sub sequence of the elements of its underlying array, which is actually a shallow copy of that array.
- A slice has three properties: a pointer, a length and a capacity.
```Go title='Slice structure in Go'
months := [...]string{1: "January", /* ... */, 12: "December"}

Q2 := months[4:7]
summer := months[6:9]
fmt.Println(Q2)
// ["April" "May" "June"]
fmt.Println(summer) // ["June" "July" "August"]
```
- ![](Pasted%20image%2020250608100757.png)
- Slicing beyond the capacity throws runtime error; slicing beyond the length but within the capacity, however, automatically extends the slice.
```Go title='That slicing throws runtime error or extends the length depends on the current length of the slice'
fmt.Println(summer[:20]) // panic: out of range
endlessSummer := summer[:5] // extend a slice (within capacity)
fmt.Println(endlessSummer) // "[June July August September October]"
```
# Allocation
## `make` function
- `make` function allocates an ==underlying array== on the heap and ==returns a slice== header that points to it.

```Go title='Array allocation as slice with make function'
// make([]Type, length, capacity)
s := make([]int, 10, 20)
```
# Slicing
- Derive a new <mark class="hltr-yellow">in-place</mark> slice from another (base) slice or a base addressable array.
```Go title='Slice an array or another slice'
arrayOrSlice[low : high]       // two-index form: exclusive high
arrayOrSlice[low : high : max] // three-index form: exclusive high
```

```Go title='Slicing examples'


package main

import "fmt"

func main() {
	a := [...]int{0, 1, 2, 3, 4, 5, 6}
	s0 := a[:]     // <=> s0 := a[0:7:7]
	s1 := s0[:]    // <=> s1 := s0
	s2 := s1[1:3]  // <=> s2 := a[1:3]
	s3 := s1[3:]   // <=> s3 := s1[3:7]
	s4 := s0[3:5]  // <=> s4 := s0[3:5:7]
	s5 := s4[:2:2] // <=> s5 := s0[3:5:5]
	s6 := append(s4, 77)
	s7 := append(s5, 88)
	s8 := append(s7, 66)
	s3[1] = 99
	fmt.Println(len(s2), cap(s2), s2) // 2 6 [1 2]
	fmt.Println(len(s3), cap(s3), s3) // 4 4 [3 99 77 6]
	fmt.Println(len(s4), cap(s4), s4) // 2 4 [3 99]
	fmt.Println(len(s5), cap(s5), s5) // 2 2 [3 99]
	fmt.Println(len(s6), cap(s6), s6) // 3 4 [3 99 77]
	fmt.Println(len(s7), cap(s7), s7) // 3 4 [3 4 88]
	fmt.Println(len(s8), cap(s8), s8) // 4 4 [3 4 88 66]
}
```
- ![[assets/Pasted image 20260103075506.png]]
# Append function
```Go title='A small implementation of append function'
func appendInt(x []int, y int) []int {
	var z []int
	zlen := len(x) + 1
	if zlen <= cap(x) {
		// There is room to grow. Extend the slice.
		z = x[:zlen]
	} else {
		// There is insufficient space. Allocate a new array.
		// Grow by doubling, for amortized linear complexity.
		zcap := zlen
		if zcap < 2*len(x) {
			zcap = 2 * len(x)
		}
		z = make([]int, zlen, zcap)
		copy(z, x) // a built-in function; see text
	}
	z[len(x)] = y
	return z
}

func main() {
	var x, y []int
	for i := 0; i < 10; i++ {
		y = appendInt(x, i)
		fmt.Printf("%d cap=%d\t%v\n", i, cap(y), y)
		x = y
	}
}
```
- The `append` function checks whether the slice has sufficient capacity to hold the new element in the underlying array. 
	- If it does, the slice will be extended into a larger slice and the new element's content will be copied into the new space, which is still within the original array.
	- Otherwise,`append` must allocate the new larger array to hold the new element. The elements of the old array and the new element are copied into the new array. The slice new references to the newly allocated array. 
- ![](Pasted%20image%2020250608120018.png)
- ![](Pasted%20image%2020250608120104.png)
- ![](Pasted%20image%2020250608120112.png)
# Copy slice
- The two slices must share the same underlying type.
```Go title='Copy slice via built-in copy function'
package main

import "fmt"

func main() {
	type Ta []int
	type Tb []int
	dest := Ta{1, 2, 3}
	src := Tb{5, 6, 7, 8, 9}
	n := copy(dest, src)
	fmt.Println(n, dest) // 3 [5 6 7]
	n = copy(dest[1:], dest)
	fmt.Println(n, dest) // 2 [5 5 6]

	a := [4]int{} // an array
	n = copy(a[:], src)
	fmt.Println(n, a) // 4 [5 6 7 8]
	n = copy(a[:], a[2:])
	fmt.Println(n, a) // 2 [7 8 7 8]
}

```
***
# References
1. Programming languages, principles and practice - Louden K.C., Lambert K.A. - Course Technology, 3th Edition 2011.
	1. Chapter 14. Data type.
2. [Copy operation](Copy%20operation.md) for Shallow copy and Deep copy.
3. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
	1. Chapter 4. Composite Types.
		1. Section 4.2 Slice
		2. Section 4.1 Array
4. [Parameter-passing mechanism](programming/go/fundamentals/composite-type/Parameter-passing%20mechanism.md) for parameter-passing mechanism in Go.