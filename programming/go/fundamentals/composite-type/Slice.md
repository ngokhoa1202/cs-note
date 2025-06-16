#go #data-type #data-structure 

# Slice
- Slices represent <mark class="hltr-yellow">variable-length sequences</mark> whose elements all have the <mark class="hltr-yellow">same type</mark>. A slice type is written `[]T`, where the elements have type `T`; it looks like an array type without a size.
- A slice is an <mark class="hltr-yellow">indirect reference</mark> that gives access to a sub sequence of the elements of its underlying array, which is actually a shallow copy of that array.
- A slice has three components: a pointer, a length and a capacity.
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
- 
---
# References
1. Programming languages, principles and practice - Louden K.C., Lambert K.A. - Course Technology, 3th Edition 2011.
	1. Chapter 14. Data type.
2. [Copy operation](Copy%20operation.md) for Shallow copy and Deep copy.
3. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
	1. Chapter 4. Composite Types.
		1. Section 4.2 Slice