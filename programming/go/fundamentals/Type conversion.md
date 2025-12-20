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
***
# References
1. https://go.dev/tour/basics/11