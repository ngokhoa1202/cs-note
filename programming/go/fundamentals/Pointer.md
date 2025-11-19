#memory #operator #operating-system #garbage-collector #go 

# Pointer
- Pointer in Go holds the address of some memory space.
- A pointer is able to be dereferenced to access its referenced content, which is similar the pointer in C++. Go, however, insulates it from perform pointer arithmetic operator for memory safety.
```Go title='Pointer in Go example'
func incr(p *int) int {
	*p++ // increments what p points to; does not change p
	return *p
}
...
v := 1
incr(&v)
// side effect: v is now 2
fmt.Println(incr(&v)) // "3" (and v is 3)
```

```Go title='Pointer arithmetic is not allowed in Go'
int x = 2;
int* p = &x;
p++; // not allowed
```
- Pointer is automatically garbage collected by the Go compiler.

# New function
- Similarly to `new` keyword in C++, `new` in Go allocates a heap memory space for the unamed variable, returns its address as a pointer.
```Go title='new function in Go'
p := new(int)
fmt.Println(*p) // prints 0
*p = 12
fmt.Println(*p) // prints 12
```
# Heap escape
- Distinctly from C/C++, Go compiler is smart enough to **escape** the variable to the heap if needed.
```Go title='Heap escape to avoid dangling reference in Go'
func newInt() *int {
	dummy := 3
	return &dummy
}
```
-  `dummy` would normally be allocated on the stack, but because its address is returned, Go <mark class="hltr-yellow">automatically allocates it on the heap</mark>. This ensures that the memory remains valid after the function returns.
--- 
# References
1. The Go Programming Language - Alan A. A. Donovan, Brian W. Kernighan - Addison-Wesley Professional Computing Series - 2015.
2. [Pointer](programming/cpp/fundamentals/Pointer.md) for Pointer in C/C++.
3. [[Alias, dangling references and garbage]]

