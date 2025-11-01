#cpp #cpp-11 #cpp-98

# Definition
- Move semantics allows an object, under certain conditions, to <mark class="hltr-yellow">take ownership of some other object's external resources</mark>. 
# Purpose
- Move semantic turns expensive copies into cheap moves. If an object does not directly or indirectly manage any external resource, move semantics will not offer any advantages over copy semantics. In that case, copying an object and moving an object means the exact same thing.
```cpp title='Class that does not benefit from move semantics'
class cannot_benefit_from_move_semantics {
     int a;        // moving an int means copying an int
     float b;      // moving a float means copying a float
     double c;     // moving a double means copying a double
     char d[64];   // moving a char array means copying a char array

     // ...
 };
```
- Move semantics implements safe "move-only" types; that is, types for which copying does not make sense, but moving does. Examples include locks, file handles, and smart pointers with unique ownership semantics.
# Dangerous and harmless moves
## Dangerous moves
- The dangerous thing about `auto_ptr` is that <mark class="hltr-yellow">what syntactically looks like a copy is actually a move</mark>.

```cpp title='Dangerous move using deprecated std::auto_ptr in C++ 98'
#include <format>
#include <iostream>
#include <list>
#include <memory>
#include <vector>

#include "shape/Circle.h"
#include "shape/Shape.h"
#include "shape/Triangle.h"


int main() {
  
  std::auto_ptr<Shape> p{new Circle(4.0)};
  std::auto_ptr q{p};  // transfer the new Circle(4.0) 's ownership to q
  std::cout << p->getArea() << std::endl;  // cause segmenetation fault
}
```

- ![](Pasted%20image%2020250518135956.png)
# Operation
- Moving from a lvalue is potentially dangerous because the resource which was held be that lvalue is transferred to another pointer. Later access via the former pointer ends up segmentation fault.
- Moving from a rvalue is harmless because a rvalue is temporary and not reusable. Under normal circumstances, no other expression inside the same scope denotes the same temporary object.
## Move constructor
- The move constructor transfers ownership of a managed resource into the current object.
```cpp title='Move constructor in C++'
unique_ptr<Shape> a(new Triangle);
unique_ptr<Shape> b(a);                 // error
unique_ptr<Shape> c(make_triangle());   // okay
```
## Move assignment
- The move assignment operator transfers ownership of a managed resource into the current object, releasing the old resource. The move-and-swap idiom simplifies the implementation.
```cpp title='Move assignment example'
unique_ptr& operator=(unique_ptr&& source) {  // note the rvalue reference
	if (this != &source)    // beware of self-assignment
	{
			delete ptr;         // release the old resource

			ptr = source.ptr;   // acquire the new resource
			source.ptr = nullptr;
	}
	return *this;
}
```
- Or follows move-and-swap idiom.
```cpp title='Move assignment conforms to copy-and-swap idiom'
unique_ptr& operator=(unique_ptr source) {  // note the missing reference
	std::swap(ptr, source.ptr);
	return *this;
}
```

# Usage
## Moving from lvalue
- Employs `std::move()`, which simply performs static cast from a lvalue expression to rvalue.
```cpp title='Moving from lvalue using std::move'
unique_ptr<Shape> a(new Triangle);
unique_ptr<Shape> b(a);              // still an error
unique_ptr<Shape> c(std::move(a));   // okay
```
## Moving out of function
- Never use `std::move` to move automatic objects out of functions because it is a pessimization.
```cpp title='Misuse of std::move to force move'
std::string makeString() {
    std::string s = "Hello, world!";
    return std::move(s);    // Bad: disables RVO, forces move
}
```
- Never return automatic objects, which are non-static local variables, by rvalue reference. Moving is exclusively performed by the move constructor, not by `std::move`, and not by merely binding an rvalue to an rvalue reference.
	- `std::move` only performs casting from lvalue to rvalue.
	- Returning `T&&` binds a reference to a local temporary that’s about to be destroyed.
```cpp title='Never return automatic objects by rvalue reference'
unique_ptr<Shape>&& flawed_attempt()   // DO NOT DO THIS!
{
    unique_ptr<Shape> very_bad_idea(new Square);
    return std::move(very_bad_idea);   // WRONG!
}
```
## Moving into members
- A named rvalue reference is an lvalue, just like any other variable, and thus `std::move` must be employed to enable move semantic.
```cpp title='Moving into members practice'
class Foo
{
    unique_ptr<Shape> member;

public:

    Foo(unique_ptr<Shape>&& parameter)
    : member(std::move(parameter))   // note the std::move or the compiler will raise error
    {}
};
```
# References
1. [Value category](Value%20category.md)
2. https://stackoverflow.com/questions/3106110/what-is-move-semantics
3. 