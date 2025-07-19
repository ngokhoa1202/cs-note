#data-type #go 

- Go does not fully support enum type as Java or C++, but employs type declaration followed by multiple constant initialization. 
# Ordinary enum
```Go title='Enum'
package main

import (
	"fmt"
)

type HttpStatus int

const (
	OK                    HttpStatus = 200
	BAD_REQUEST           HttpStatus = 400
	INTERNAL_SERVER_ERROR HttpStatus = 500
)

var statusCode = map[HttpStatus]string{
	OK:                    "200 OK",
	BAD_REQUEST:           "400 BAD REQUEST",
	INTERNAL_SERVER_ERROR: "500 INTERNAL SERVER ERROR",
}

func (status HttpStatus) String() string {
	return statusCode[status]
}

func main() {
	status := OK
	fmt.Println(status) /* automatically call String() method */

}
```

# Constant generator
- `iota` constant generator is utilized to create a sequence of related values without explicitly repeating their types and values.
```Go title='Constant generator in enum'
type WeekDay int

const (
	Monday WeekDay = iota // = 0
	Tuesday // = 1
	Wednesday  // = 2
	Thursday // ...
	Friday
	Saturday
	Sunday
)

```

---
# References
1. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
2. https://gobyexample.com/enums