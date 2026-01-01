#go #array 
# Slice
- Use built-in`make` function to allocate memory with given size.
- Iterate to assignment the default to each element. 
```Go title='Initialize an array with given size and value by using slice and loop'
// Create a slice of size 10, all initialized to 0
nums := make([]int, 10)

defaultValue := 100
for i := range nums {
    nums[i] = defaultValue
}
```
# Buffer
- `copy` is highly optimized at the assembly level (often using SIMD instructions), making it much faster than a standard `for` loop for massive buffers.
```Go title='Initialize an array with given size and value by using slice and loop by using a Buffer'
func FillSlice(s []int, val int) {
    if len(s) == 0 {
        return
    }
    s[0] = val
    for i := 1; i < len(s); i *= 2 {
        copy(s[i:], s[:i])
    }
}
```
***
# References
1. https://go.dev/blog/slices-intro for Slice.
2. https://pkg.go.dev/slices for slice package.