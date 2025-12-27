    #data-type #go 
# Type conversion
- Go's type conversion syntax is different from that of Java and C++.
```Go title='Type conversion syntax'
var i int = 42
var f float64 = float64(i)
var u uint = uint(f)
```
# Untyped constant
- Constants can be initialized as a group of sequence in Go.
```Go title='Constant initialization as a group of sequence'
const (
  a = 1,
  b = 2,
  c = 50
)
```
- Untyped constants are constants whose *type is <mark class="hltr-yellow">not explicitly specified</mark> until until they’re assigned to a variable or used* in a context that requires a specific type.
- Also known as uncommitted constants.
- Untyped constants not only retain their <mark class="hltr-yellow">higher precision</mark> until later, but they can<mark class="hltr-yellow"> participate in many more expressions</mark> than committed constants without requiring conversions.
```Go title='Untyped constant example in Go'
package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func main() {

	const PI = 3.14159 // untyped float
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("Enter a radius: ")
	str, _ := reader.ReadString('\n')
	radius, _ := strconv.ParseFloat(strings.TrimSpace(str), 64)
	area := PI * math.Pow(radius, 2) // PI is implicitly coverted to float64 here for computation
	fmt.Println(area)
}
```

```Go title='Legal conversion of untyped constants'
// Rounding happens in the following 3 lines.
complex128(1 + -1e-1000i)  // 1.0+0.0i
float32(0.49999999)        // 0.5
float32(17000000000000000)
// No rounding in the these lines.
float32(123)
uint(1.0)
int8(-123)
int16(6+0i)
complex128(789)

string(65)          // "A"
string('A')         // "A"
string('\u68ee')    // "森"
string(-1)          // "\uFFFD"
string(0xFFFD)      // "\uFFFD"
string(0x2FFFFFFFF) // "\uFFFD"
```

```Go title='Illegal conversion of untyped constants'
// 1.23 is not representable as a value of int.
int(1.23)
// -1 is not representable as a value of uint8.
uint8(-1)
// 1+2i is not representable as a value of float64.
float64(1+2i)

// Constant -1e+1000 overflows float64.
float64(-1e1000)
// Constant 0x10000000000000000 overflows int.
int(0x10000000000000000)

// The default type of 65.0 is float64,
// which is not an integer type.
string(65.0)
// The default type of 66+0i is complex128,
// which is not an integer type.
string(66+0i)
```
***
# References
1. https://go.dev/tour/basics/11
2. https://go101.org/article/constants-and-variables.html