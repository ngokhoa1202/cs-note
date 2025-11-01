#go #data-type 

- All parameters in Go is passed by value.
```Go title='Pass by value in Go'
func increment(x int) {
    x++  // Modifies the local copy, not the original variable
}

func main() {
    a := 5
    increment(a)
    // a is still 5 here
}
```
- When a pointer is passed, its content, which is a memory address, is copied into the new memory block and bound to the function parameter. As a result, the original value can be changed by dereferencing.
# Slice
- When a slice is passed into a function, the parameter copies only the slice header such as pointer, length and capacity, not the underlying array data. If that parameter is <mark class="hltr-yellow">resliced</mark> within the callee, the change is only reflected in the <mark class="hltr-yellow">local environment</mark>. 
```Go title='Slice is passed as a parameter'
func main() {
    numbers := []int{1, 2, 3, 4, 5}
    
    fmt.Println("Before:", numbers)         // [1 2 3 4 5]
    fmt.Println("Length:", len(numbers))    // 5
    
    resliceInFunction(numbers)
    
    fmt.Println("After:", numbers)          // [1 2 3 4 5] (unchanged)
    fmt.Println("Length:", len(numbers))    // 5 (unchanged)
}

func resliceInFunction(s []int) {
    // This reslicing only affects the local copy of the slice header
    s = s[0:2]
    fmt.Println("Inside function:", s)       // [1 2]
    fmt.Println("Inside length:", len(s))    // 2
}
```
- 
# References
1. [Parameter-passing mechanisms](Parameter-passing%20mechanisms.md) for pass by value.
2. 