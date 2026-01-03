#go #data-structure #data-type #array #unix 
# Definition
- An array is a <mark class="hltr-yellow">fixed-length</mark> sequence of zero or more elements of a particular type.
```Go title='Array in Go'
var a [3]int
// array of 3 integers
fmt.Println(a[0])
// print the first element
fmt.Println(a[len(a)-1]) // print the last element, a[2]

// Print the indices and elements.
for i, v := range a {
  fmt.Printf("%d %d\n", i, v)
}
// Print the elements only.
for _, v := range a {
  fmt.Printf("%d\n", v)
}

const Size = 32

type Person struct {
	name string
	age  int
}

/* Array types */

[5]string
[Size]int
// Element type is a slice type: []byte
[16][]byte
// Element type is a struct type: Person
[100]Person
```
# Allocation
## `make` function
 - `make` function allocates an <mark class="hltr-yellow">underlying array</mark> on the heap and <mark class="hltr-yellow">returns a slice</mark> header that points to it.
```Go title='Array allocation as slice with make function'
// make([]Type, length, capacity)
s := make([]int, 10, 20)
```

***
# References
1. Programming languages, principles and practice - Louden K.C., Lambert K.A. - Course Technology, 3th Edition 2011.
	1. Chapter 14. Data type.
2. 3. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
	1. Chapter 4. Composite Types.
		1. Section 4.1 Array.
3. [[programming/go/fundamentals/composite-type/Slice|Slice]]
4. https://go101.org/article/container.html for Array in Go.
5. 