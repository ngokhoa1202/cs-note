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
- A new defined type and its respective source type in type definitions are <mark class="hltr-yellow">two distinct types</mark>.
- Two types defined in two type definitions are always <mark class="hltr-yellow">two distinct types</mark>.
- The new defined type and the source type will share the <mark class="hltr-yellow">same underlying type</mark>; hence, their values can be explicitly converted to each other.
- A type definition does not have any assignment operator (`=`).
```Go title='Type definition declaration syntax'
type NewTypeName SourceType

// Define multiple new types together.
type (
	NewTypeName1 SourceType1
	NewTypeName2 SourceType2
)
```

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
- The alias and the original type are completely <mark class="hltr-yellow">interchangeable</mark> and identical without any additional conversion.
- There is an assignment operator (`=`)  in each type alias specification.
```Go title='Type alias declaration examples'
type (
	Name = string
	Age  = int
)

type table = map[string]int
type Table = map[Name]Age
```

# Named type vs unnamed type
## Named type
- A named type must be one of the followings:
	- a pre-declared type but excluding type alias.
	- a defined but non-custom-generic type.
	- an instantiated type of a generic type.
	- a type parameter type (use in custom generics).
```Go title='Named type examples in Go: a pre-declared type but excluding type alias'
/* A pre-declared type but excluding type alias */
// Named type based on int
type UserID int

// Named type based on string  
type EmailAddress string

// Named type based on float64
type Temperature float64

// Named type based on bool
type IsActive bool

// Named type based on byte
type ASCII byte
```

```Go title='Named type example in Go: a defined but non-custom-generic type'
/*  A defined but non-custom-generic type */
// Named type based on a slice
type UserList []string

// Named type based on a map
type ProductInventory map[string]int

// Named type based on a channel
type EventStream chan Event

// Named type based on an array
type IPv4Address [4]byte

// Named type based on a struct
type Coordinates struct {
    Latitude  float64
    Longitude float64
}

// Named type based on an interface
type Storage interface {
    Save(key string, value []byte) error
    Load(key string) ([]byte, error)
}

// Named type based on a function type
type Validator func(input string) error
```

```Go title='Named type example in Go: an instantiated type of a generic type'
// First, define a generic type

/* An instantiated type of a generic type. */
type Stack[T any] struct {
    items []T
}

// Create a named type based on an instantiated generic type
type IntStack Stack[int]

// Another example with a generic map type
type Cache[K comparable, V any] map[K]V

// Named type based on the instantiated generic
type UserCache Cache[string, User]
```

```Go title='Named type example in Go: a type parameter type (use in custom generics).'
/* A type parameter type (use in custom generics). */
// Generic collection type
type Collection[T any] struct {
    items []T
}

// Generic processor that works with collections
type Processor[T comparable] struct {
    // We can use instantiated generics with our type parameter
    primary   Collection[T]
    secondary Collection[T]
    cache     map[string]T
}

// Function that demonstrates named types from instantiated generics
func ProcessItems[T comparable](items []T) {
    // Within this generic function, we work with instantiated types
    type ItemSet map[T]bool
    type ItemPair struct {
        First  T
        Second T
    }
    
    // Create instances using the type parameter
    uniqueItems := make(ItemSet)
    for _, item := range items {
        uniqueItems[item] = true
    }
    
    // Use the named types in processing
    pairs := make([]ItemPair, 0)
    for i := 0; i < len(items)-1; i++ {
        pairs = append(pairs, ItemPair{
            First:  items[i],
            Second: items[i+1],
        })
    }
}
```
## Unnamed type (anonymous type)
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

```Go title='Unnamed type examples'
// [] string slice as an unnamed type
func processUsernames(names []string) []string {
    filtered := make([]string, 0, len(names))
    for _, name := range names {
        if len(name) > 3 {
            filtered = append(filtered, name)
        }
    }
    return filtered
}

// map[string]int map as an unnamed type
func countWordFrequency(text string) map[string]int {
    frequency := make(map[string]int)
    words := strings.Fields(text)
    for _, word := range words {
        frequency[word]++
    }
    return frequency
}
// struct{ lat, lon float64 } as an unnamed type
func getCoordinates() struct{ lat, lon float64 } {
    return struct{ lat, lon float64 }{
        lat: 40.7128,
        lon: -74.0060,
    }
}

// Common in table-driven tests
tests := []struct {
    input    string
    expected int
}{
    {"hello", 5},
    {"world", 5},
    {"", 0},
}

// Interface, including empty interface as an anonymous type
func printAnyValue(v interface{}) {
    fmt.Printf("Value: %v, Type: %T\n", v, v)
}

// More specific anonymous interface
func processEntity(entity interface{ GetID() string }) {
    id := entity.GetID()
    fmt.Printf("Processing entity with ID: %s\n", id)
}
```

# Underlying types
- Each type has its own underlying type. The rules of underlying type are:
	- for *built-in* types, the respective underlying types are *themselves*. 
	- for the `Pointer` type defined in the `unsafe` standard code package, its underlying type is itself (`*T`).
	- for an unnamed type, which is a composite type, its underlying type is itself.
	- in a type declaration, the newly declared type and the source type share the same underlying type.
- The rule is, when a <mark class="hltr-yellow">built-in basic type</mark> or an <mark class="hltr-yellow">unnamed</mark> type is met, the underlying type tracing should be stopped.
```Go title='Newly declared type and source type share the same underlying type in type declaration'
// The underlying types of the following ones are both int.
type (
	MyInt int
	Age   MyInt
)

// The following new types have different underlying types.
type (
	IntSlice   []int   // underlying type is []int
	MyIntSlice []MyInt // underlying type is []MyInt
	AgeSlice   []Age   // underlying type is []Age
)

// The underlying types of []Age, Ages, and AgeSlice
// are all the unnamed type []Age.
type Ages AgeSlice
```
- The underlying types in the example:
	- `MyInt`  $\to$ `int` (stopped because `int` is built-in type).
	- `Age` $\to$ `MyInt` $\to$ `int`
	- `IntSlice` $\to$ `[] int` (stopped because slice `[] int` is unnamed type).
	- `MyIntSlice` $\to$ `[]MyInt` $\to$ ~~`[] int`~~ (stopped because slice `[]MyInt` is unnamed type).
	- `AgeSlice` $\to$ `[]Age` (stopped because `[]Age` is unnamed type).
	- `Ages` $\to$ `[]Age`

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
11. https://claude.ai/share/7a73cba0-7dbd-4bfb-ba6c-47507b1536b5