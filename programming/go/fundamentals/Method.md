#object-oriented-programming #go #data-type #c #cpp 

# Method declaration
- In Go, a method declaration is similar to a function declaration, but it has an <mark class="hltr-yellow">extra parameter</mark> declaration part. The extra parameter part can contain one and only one parameter of the <mark class="hltr-yellow">receiver</mark> type $T$ (value receiver) or type ${}^*T$ of the method.
- The receiver's type $T$ must satisfy four these conditions:
	- $T$ must be a defined type (type alias is acceptable).
	- $T$ is defined in the same package as the method declaration.
	- $T$ is not a pointer type.
	- $T$ must not be an interface type.
```Go title='Method declaration example in Go'
// Age and int are two distinct types. We
// can't declare methods for int and *int,
// but can for Age and *Age.
type Age int
func (age Age) LargerThan(a Age) bool {
	return age > a
}
func (age *Age) Increase() {
	*age++
}

// Receiver of custom defined function type.
type FilterFunc func(in int) bool
func (ff FilterFunc) Filte(in int) bool {
	return ff(in)
}

// Receiver of custom defined map type.
type StringSet map[string]struct{}
func (ss StringSet) Has(key string) bool {
	_, present := ss[key]
	return present
}
func (ss StringSet) Add(key string) {
	ss[key] = struct{}{}
}
func (ss StringSet) Remove(key string) {
	delete(ss, key)
}

// Receiver of custom defined struct type.
type Book struct {
	pages int
}

func (b Book) Pages() int {
	return b.pages
}

func (b *Book) SetPages(pages int) {
	b.pages = pages
}
```
- Each method is <mark class="hltr-yellow">implicitly</mark> understood as a function by the Go compiler.
```Go title='Method is implicit function in Go'
package main

import "fmt"

type Book struct {
	pages int
}

func (b Book) Pages() int {
	return b.pages
}

func (b *Book) SetPages(pages int) {
	b.pages = pages
}

func main() {
	var book Book
	// Call the two implicit declared functions.
	(*Book).SetPages(&book, 123)
	fmt.Println(Book.Pages(book)) // 123
}
```
# Method receiver
- There are two types of method receivers in Go:
	- Value receiver for  type $T$.
	- Pointer receiver for type type ${}^*T$ 
- [Method value normalization](#Method%20value%20normalization) makes the method invocation looks as if methods of the both receivers could be interchangeably used but actually dereferencing and address taking are implicitly employed behind the scene.
- Receiver arguments are passed by copy, which means that all **value-type fields** (e.g., `int`, `bool`, `float`, structs without pointers) are **copied** and all **reference-type fields** (e.g., `slices`, `maps`, `pointers`, `channels`, `interfaces`, `functions`) are **copied by reference** — the underlying data is shared.
```Go title='Receiver arguments are passed by copy in Go'
type Book struct {
	pages int
	notes []string
}

func (b Book) Modify() {
	b.pages = 123        // modifies a copy — does NOT affect original
	b.notes[0] = "edit"  // modifies shared slice — affects original!
}

func main() {
	book := Book{
		pages: 100,
		notes: []string{"original", "note"},
	}
	book.Modify()
	fmt.Println(book.pages)      // 100 (unchanged)
	fmt.Println(book.notes[0])   // "edit" (changed!)
}

```

# Method specification & method set
- A method specification is the same as a function prototype without `func` keyword.
```Go title='Method declaration'
Pages() int
SetPages(pages int)
```
- Each type has a <mark class="hltr-yellow">method set</mark>. The method set of a non-interface type is composed of all the <mark class="hltr-yellow">method specifications</mark> of the methods declared, either explicitly or implicitly, for the type, except the ones whose names are the blank identifier `_`.
```Go title='Method set examples'
// Method set for Book type
Pages() int

// Method set for *Book type
Pages() int
SetPages(pages int)
```
- The method set of type $T$ is always a subset of the method set of type $^*T$.
- <mark class="hltr-yellow">Non-exported method names</mark>, which start with lower-case letters, from different packages will be always viewed as <mark class="hltr-yellow">two different method names</mark>, even if the two method names are the same in literal.
- The method sets of the following types are always empty:
	- built-in basic types.
	- defined pointer types.
	- pointer types whose base types are interface or pointer types.
	- unnamed array, slice, map, function and channel types.
# Method values & method calls
```Go title='Method calls in Go'
ackage main

import "fmt"

type Book struct {
	pages int
}

func (b Book) Pages() int {
	return b.pages
}

func (b *Book) SetPages(pages int) {
	b.pages = pages
}

func main() {
	var book Book

	fmt.Printf("%T \n", book.Pages)       // func() int
	fmt.Printf("%T \n", (&book).SetPages) // func(int)
	// &book has an implicit method.
	fmt.Printf("%T \n", (&book).Pages) // func() int

	// Call the three methods.
	(&book).SetPages(123)
	book.SetPages(123) // equivalent to the last line
	fmt.Println(book.Pages())    // 123
	fmt.Println((&book).Pages()) // 123
}
```
- That the call to `book.SetPages()` is still valid despite a lack `(*Book).SetPages()` definition  is because the <mark class="hltr-yellow">address of the addressable value</mark> `book` is <mark class="hltr-yellow">implicitly passed as a receiver argument</mark> of `SetPages()` method call.
- In case only the $(*T).A()$ method is defined, if the addressable $t$ of type $T$ calls method $A$ at runtime, its address is implicitly passed as a receiver argument into method $A$.
# Method value normalization
- At compile time, compilers will normalize each method value expression, by implicitly taking its address or dereferencing it if necessary.
- Assume `v` is a value of type `T` and `v.m` is a legal method value expression,
	- if `m` is a method explicitly declared for type `*T`, then compilers will normalize it as `(&v).m`;
	- if `m` is a method explicitly declared for type `T`, then the method value expression `v.m` is already normalized.
- Assume `p` is a value of type `*T` and `p.m` is a legal method value expression,
	- if `m` is a method explicitly declared for type `T`, then compilers will normalize it as `(*p).m`;
	- if `m` is a method explicitly declared for type `*T`, then the method value expression `p.m` is already normalized.
```Go title='Method value normalization in Go'
package main

import "fmt"

type Book struct {
	pages int
}

func (b Book) Pages() int {
	return b.pages
}

func (b *Book) Pages2() int {
	return (*b).Pages()
}

func main() {
	var b = Book{pages: 123}
	var p = &b
	var f1 = b.Pages // already normalized
	var f2 = p.Pages // normalized as (*p).Pages
	var g1 = p.Pages2 // already normalized
	var g2 = b.Pages2 // normalized as (&b).Pages2
	b.pages = 789
	fmt.Println(f1()) // 123
	fmt.Println(f2()) // 123
	fmt.Println(g1()) // 789
	fmt.Println(g2()) // 789
}
```

# References
1. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
	1. Chapter 6. Methods
		1. Section 6.1. Method Declarations.
		2. Section 6.2. Methods with a Pointer Receiver.
2. *https://go101.org/article/method.html for Method in Go.*
3. [Parameter-passing mechanisms](Parameter-passing%20mechanisms.md)
4. [[programming/go/fundamentals/Interface|Interface]]