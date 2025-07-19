#object-oriented-programming #go #data-type #c #cpp

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
- [Method](Method.md)
---
# References
1. https://gobyexample.com/struct-embedding for Struct embedding.
2. [UML Class diagram](UML%20Class%20diagram.md) for composition concept.
3. [Method](Method.md) for Method in Go.