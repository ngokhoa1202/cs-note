#c #cpp #gnu #llvm 

# Class essential operations
## Constructors, destructors, copy and move
- Every class in C++ should define these functions:
```cpp title='C++ class'
class X {
public:
  X(Sometype); // ‘‘ordinary constructor’’: create an object
  X();         // default constructor
  X(const X&); // copy constructor
  X(X&&);      // move constructor
  X& operator=(const X&); // copy assignment: clean up target and copy
  X& operator=(X&&); // move assignment: clean up target and move
˜ X(); // destructor: clean up
  // ...
};
```
- There are 5 situations in which an object can be copied or moved, also known as rule of five:
	- As the source of an assignment. (`target = source`).
	- As an object initializer.
	- As a function argument.
	- As a function return value. 
	- As an exception.
- Except for the ordinary constructor, these special member function will be automatically generated by the compiler as needed. If it is necessary to explicitly declare these default generation, specify the method with `default` keyword:
```cpp
class Y {
public:
	Y(Sometype);
	Y(const Y&) = default; // I really do want the default copy constructor
	Y(Y&&) = default;  // and the default move constructor
	// ...
};
```
- Explicitly suppressing the default generation is also feasible with `delete` keyword.
```cpp title='Suppress default generation with delete keyword'
class Shape {
public:
	Shape(const Shape&) = delete; // no more copying
	Shape& operator=(const Shape&) = delete; // no more alias via assignment operation
// ...
};

void copy(Shape& s1, const Shape& s2)
{
	s1 = s2; // error: Shape copy is deleted
}
```

### Copy constructor
- Copy constructor should conform to Deep copy mechanism.
```cpp title='Interface class for later implementation'
class ArrayList {  
  int size;  
  int* numbers;  
  
 public:  
  ArrayList(int);  // normal constructor
  ArrayList() = default; // empty constructor
  ArrayList(const ArrayList&);  // copy constructor  
  ArrayList& operator=(const ArrayList&);  // copy assignment  
  ArrayList(ArrayList&&); // move constructor
  ArrayList& operator=(ArrayList&&); // move assignment
  int& operator[](int) const;  
  int getSize() const;  
  std::string toString() const;  
  
  ~ArrayList();  
};
```

```cpp title='Copy constructor using Deep copy'
ArrayList::ArrayList(int size) : numbers{new int[size]}, size{size} {}

ArrayList::ArrayList(const ArrayList& list) : numbers{new int[list.size]}, size{list.size} {
  for (auto i = 0; i < this->size; ++i) {
    this->numbers[i] = list[i];
  }
}
```

### Copy assignment
-  Copy assignment should conform to Deep copy mechanism.
```cpp title='Copy assignment using Deep copy'
ArrayList& ArrayList::operator=(const ArrayList& list) {
  delete[] this->numbers;  // deallocate old number

  this->numbers = new int[list.size];  // reallocate new number
  for (auto i = 0; i < this->size; ++i) {  // perform deep copy
    this->numbers[i] = list[i];
  }
  this->size = list.size;
  return *this;
}
```

### Move constructor
- Move constructor operation is to <mark class="hltr-yellow">transfer</mark> the <mark class="hltr-yellow">resources</mark> held by a temporary object to the new object. 
- A move operation is applied when an <mark class="hltr-yellow">rvalue reference</mark> is used as an initializer (constructor) or as the right-hand side of an assignment.
- `std::move` function converts a value to a rvalue
```cpp title='Move constructor example'
ArrayList::ArrayList(ArrayList&& list) : numbers{list.numbers}, size{list.size} {
  list.numbers = nullptr;
  list.size = 0;
}

...
// driver code
// std::move converts a value to rvalue
const ArrayList list4{std::move(ArrayList{4})}; // move constructor
```
- According to the C++17 standard (§12.8), copy elision is guaranteed when:
	- A temporary object is used to initialize a variable of the same type
	- And the temporary is not otherwise used.
### Move assignment
- Move assignment operation is to <mark class="hltr-yellow">transfer</mark> the <mark class="hltr-yellow">resources</mark> held by a temporary object to the existing object.
```cpp title='Move assignment example'
ArrayList& ArrayList::operator=(const ArrayList& list) {
  delete[] this->numbers;  // deallocate old number

  this->numbers = new int[list.size];  // reallocate new number
  for (auto i = 0; i < this->size; ++i) {  // perform deep copy
    this->numbers[i] = list[i];
  }
  this->size = list.size;
  return *this;
}
```
### Destructor
- Destructor must perform garbage collection if necessary to prevent memory leaks.
```cpp title='Destructor does the task of garbage collection'
ArrayList::~ArrayList() { delete[] this->numbers; }
```
## Explicit type conversion
- A constructor is by default able to accept a single argument and implicitly converts from its argument to the object itself.
```cpp title='Implicit type conversion with constructor by default'

#ifndef CIRCLE_H
#define CIRCLE_H
#include "Shape.h"

class Circle : public Shape
{
private:
  double radius;

public:
  Circle(double radius);
  double getArea() const override;
  double getPerimeter() const override;
  ~Circle() final = default;
  Circle(const Circle&) = delete;
  Circle& operator=(const Circle&) = delete;
};


#endif // CIRCLE_H


// driver code
Circle circle = 3.2; // possible
```

- Suppress this default behavior by declaring the constructor with `explicit` keyword. All constructor declared with `explicit` cannot implicitly convert from an argument to the object itself.
```cpp title='explicit keyword suppress implicit type conversion'
...
class Circle : public Shape
{
private:
  double radius;

public:
  explicit Circle(double radius);
  ...
};

// driver code
Circle circle = 3.2; // unacceptable anymore
...
```

## Member initializer
- Employs the member initializer list to simplify constructor in C++.
```cpp title='Member initializer with initializer list'
class Complex {
	double re = 0;
	double im = 0; // representation: two doubles with default value 0.0
public:
	complex(double r, double i) :re{r}, im{i} {}
	// construct complex from two scalars: {r,i}
	complex(double r) :re{r} {}
	// construct complex from one scalar: {r,0}
	complex() {}
	// default complex: {0,0}
	// ...
}
```


---
# References
1. A Tour of C++ - Bjarne Stroustrup - Addison Wesley Professional (2022).
	1. Chapter 6. Essential Operations.
		1. Section 1. Essential operations.
2. https://www.learncpp.com/cpp-tutorial/constructor-member-initializer-lists/
3. [Copy operation](Copy%20operation.md)
4. [Value category](Value%20category.md)
5. [Move semantics](Move%20semantics.md)
6. 