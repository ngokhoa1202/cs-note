#functional-programming #go #data-type #high-order-function #structured-programming 

# Interface type
- There are two elements in an interface definition:
	- Method element which is similar to method specification.
	- Type element which may be a type name (interface embedding), type literal (inline interface definition), an approximation type or a type union.
```Go title='Method elements in interface'
type Stringer interface {
    String() string // method element
}
```

```Go title='Type name element (interface embedding) in interface'
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

// Type element examples:
type ReadWriter interface {
    Reader // type element (embeds Reader interface)
    Writer // type element (embeds Writer interface)
}
```

```Go title='Type literal element in interface'
type Closer interface {
    Close() error
}

type ReadWriteCloser interface {
    Read([]byte) (int, error)
    Write([]byte) (int, error)
    Closer // type element (type name)
    interface { Reset() } // type literal element
}
```

```Go title='Type union element in interface'
type Number interface { // match any type whose the underlying type is int or float64
    ~int | ~float64 // ~int is also called approximation type
    // int | float // match any type whose type is explicitly int or float64
}


```
# Method set
- For a non-interface type, its method set is composed of the specifications of all the methods for it.
- For an interface type, its method set is composed of all the method specifications it specifies, either directly or indirectly through embedding other types.
# Implementation
- The type set of an interface type contains all non-interface types which implement the interface.
- If the type set of an interface type is a subset of another interface type, then we say the former one implements the latter one.
- If a type `T` implements an interface type `X`, then the method set of `T` must be superset of `X`, whether `T` is an interface type or an non-interface type.
- Implementation are all <mark class="hltr-yellow">implicit</mark> in Go and not explicitly specified.
```Go title='Implementation of interfaces is implicit in Go'
type Aboutable interface {
	About() string
}

type Book struct {
	name string
	// more other fields ...
}

func (book *Book) About() string {
	return "Book: " + book.name
}

type MyInt int

func (MyInt) About() string {
	return "I'm a custom integer value"
}
```
# Value boxing



# Reference
1. https://go101.org/article/interface.html for Interface in Go.
2. https://gobyexample.com/interfaces
3. [[Method]]