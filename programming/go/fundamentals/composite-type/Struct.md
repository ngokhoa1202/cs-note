#oop #go #data-type #c #cpp

- Go does not support full features of Object-oriented programming such as class and access modifier.
# Struct
- A struct is an aggregate data type that <mark class="hltr-yellow">groups</mark> together zero or more named values of arbitrary types <mark class="hltr-yellow">as a single entity</mark>.
- A struct cannot contain itself but can declare a field of the pointer to itself.
```Go title='struct is used to implement tree data structure'
type tree struct {
	value
	int
	left, right *tree
}
```

```Go title='Struct example in Go'
package main

import (
	"fmt"
	"time"

	"github.com/google/uuid"
)

type CrediCard struct {
	Id             uuid.UUID
	CardNumber     string
	CardHolder     string
	ExpirationDate time.Time
	Amount         uint64
}

func add(card *CrediCard, amount uint64) {
	card.Amount += amount
}

func deposit(card CrediCard, amount uint64) {
	card.Amount += amount
}

func main() {
	// card := CrediCard{ // Name-based struct literal
	// 	Id:             uuid.New(),
	// 	CardNumber:     "0822 0201 3779 3999",
	// 	CardHolder:     "Vu Anh Khoa",
	// 	ExpirationDate: time.Now(),
	// 	Amount:         15000,
	// }

	// card := CrediCard{ // order-based struct literal
	// 	uuid.New(),
	// 	"2341 2322 3123",
	// 	"Anh Khoa",
	// 	time.Now(),
	// 	200000,
	// }

	// fmt.Printf("%v\n", card)
	// add(&card, 1000)
	// fmt.Printf("%v\n", card)

	cardPtr := &CrediCard{
		uuid.New(),
		"2341 2322 3123",
		"Anh Khoa",
		time.Now(),
		2000,
	}
	fmt.Printf("%v\n", cardPtr)
	add(cardPtr, 1000)
	fmt.Printf("%v\n", cardPtr)

	deposit(*cardPtr, 2000)
	fmt.Printf("%v\n", cardPtr)
}
```

# Struct literal
- Struct literal is used to initialize a struct, similarly to constructor in Java and C++.
- There are two forms of struct literal:
	- Order-based struct literal.
	- Name-based struct literal.
```Go title='Struct literal'
card := CrediCard{ // Name-based struct literal
	Id:             uuid.New(),
	CardNumber:     "0822 0201 3779 3999",
	CardHolder:     "Vu Anh Khoa",
	ExpirationDate: time.Now(),
	Amount:         15000,
}

card := CrediCard { // order-based struct literal
	uuid.New(),
	"2341 2322 3123",
 	 "Anh Khoa",
  	time.Now(),
  	200000, 
}
```

# Struct embedding
- Struct embedding represents <mark class="hltr-yellow">seamless composition</mark> relationship in object-oriented programming.
```Go title='Struct embedding without anonymous field'
/* Without struct embedding */
type Point struct {
	X, Y int
}
type Circle struct {
	Center Point
	Radius int
}
type Wheel struct {
	Circle Circle
	Spokes int
}

// driver code
// more verbose
var w Wheel
w.Circle.Center.X = 8
w.Circle.Center.Y = 8
w.Circle.Radius = 5
w.Spokes = 20
```

- Anonymous field is required in case properties of the embedded struct should be promoted to the container struct, thereby making property access more concise.
```Go title='Struct embedding with anonymous field'
type Point struct {
	X, Y int
}
type Circle struct {
	Point
	Radius int
}
type Wheel struct {
	Circle
	Spokes int
}

// driver code
var w Wheel
w.X = 8 // equivalent to w.Circle.Point.X = 8
w.Y = 8 // equivalent to w.Circle.Point.Y = 8
w.Radius = 5 // equivalent to w.Circle.Radius = 5
w.Spokes = 20
```

# Method
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
1. For each method declared for value receiver type `T`, a corresponding method with the same name will be implicitly declared by compiler for type `*T`
```Go title='An equivalent method for pointer receiver is implicitly generated whenever a method for value receiver is defined'
// Note: this is not a legal Go syntax.
// It is shown here just for explanation purpose.
// It indicates that the expression (&aBook).Pages
// is evaluated as aBook.Pages (see below sections).
func (b *Book) Pages = (*b).Pages
```
---
# References
1. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
	1. Chapter 4. Composite Types.
		1. Section 4.2 Slice
2. https://gobyexample.com/struct-embedding for Struct embedding.
3. [UML Class diagram](UML%20Class%20diagram.md)
4. 