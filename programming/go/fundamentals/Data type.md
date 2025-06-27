#data-type #go #compilation 

- Go is a <mark class="hltr-yellow">strongly typed</mark> programming language.
# Basic data type
- Built-in string type: `string`.
- Built-in boolean type: `bool`.
- Built-in numeric types:
	- `int8`, `uint8` (`byte`), `int16`, `uint16`, `int32` (`rune`), `uint32`, `int64`, `uint64`, `int`, `uint`, `uintptr`.
	- `float32`, `float64`.
	- `complex64`, `complex128`.
```Go title='Go primitive data types'
bool

string

int  int8  int16  int32  int64
uint uint8 uint16 uint32 uint64 uintptr

byte // alias for uint8

rune // alias for int32
     // represents a Unicode code point

float32 float64

complex64 complex128
```

# Constant
## Enum
- Enum is not officially considered a type in Go because it is declared as a series of constants.
- [Enum](Enum.md)
# Composite type
## Pointer
- [[programming/go/fundamentals/Pointer|Pointer]]
## Container
### Slice
- [Slice](Slice.md)
### Map
- [Map](Map.md)
### Array
- [[Array]]
## Struct
- [[Struct]]
## Function
- [[Function]]
- [[Method]]
## Interface
- [[Interface]]
## Channel

# Type declaration
- There are two forms of type declaration.
## Type definition (declaration)
- A type definition does not have any assignment operator (`=`).
```Go title='Type definition declaration syntax'
type NewTypeName SourceType

// Define multiple new types together.
type (
	NewTypeName1 SourceType1
	NewTypeName2 SourceType2
)
```
- A new defined type and its respective source type in type definitions are <mark class="hltr-yellow">two distinct types</mark>.
- Two types defined in two type definitions are always <mark class="hltr-yellow">two distinct types</mark>.
- The new defined type and the source type will share the <mark class="hltr-yellow">same underlying type</mark>; hence, their values can be converted to each other.
```Go title='Type definition examples'
// The following new defined and source types are all
// basic types. The source types are all predeclared.
// MyInt and Age are distinct types but do share the same underlying type, which is int
type (
	MyInt int 
	Age   int
	Text  string
)

// The following new defined and source types are all
// composite types. The source types are all unnamed.
type IntPtr *int
type Book struct{author, title string; pages int}
type Convert func(in0 int, in1 bool)(out0 int, out1 string)
type StringArray [5]string
type StringSlice []string

func f() {
	// The names of the three defined types
	// can be only used within the function.
	type PersonAge map[string]int
	type MessageQueue chan string
	type Reader interface{Read([]byte) int}
}
```
## Type alias (declaration)
- There is an assignment operator (`=`)  in each type alias specification.
```Go title='Type alias declaration examples'
type (
	Name = string
	Age  = int
)

type table = map[string]int
type Table = map[Name]Age
```
- Other type of values are unnamed type.
- An unnamed type must be a composite type, but the vice versa is not true.
```Go title='An unnamed type must be a composited type'
var config struct { // config is an in-place type
    Host string
    Port int
    TLS  bool
}

config.Host = "localhost"
config.Port = 8080
```

```Go title='A composite type is not always an unnamed type'
type Point struct {
    X int
    Y int
}

// The variable 'p' has the NAMED type 'Point'.
var p Point
p.X = 10
p.Y = 20
```
# Named type
- A named type must be one of the followings:
	- a pre-declared type but excluding type alias.
	- a defined but non-custom-generic type.
	- an instantiated type of a generic type.
	- a typed parameter type.
---
# References
1. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
	1. Chapter 3. Basic Data Types.
2. https://go.dev/tour/basics/11
3. [[Enum]]
4. [[Array]]
5. [[Struct]]
6. [[Slice]]
7. [[Function]]
8. [[Method]]
9. [[programming/go/fundamentals/Pointer|Pointer]]
10. https://go101.org/article/type-system-overview.html