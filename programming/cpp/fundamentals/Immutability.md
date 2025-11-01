#cpp 

# Constant expression
- Denoted by `constexpr` keyword.
- Used to allow placement of data in memory where it is unlikely to be corrupted, and for performance.
## Constant expression variable
- Constant expression variable specifies the variable value to be evaluated at <mark class="hltr-yellow">compile time</mark>.
```cpp title='Constant expression variable'
const int dmv = 17; // dmv is a named constant
int var = 17; // var is not a constant
constexpr double max1 = 1.4∗square(dmv); // OK if square(17) is a constant expression
constexpr double max2 = 1.4∗square(var); // error : var is not a constant expression
const double max3 = 1.4∗square(var); // OK, may be evaluated at run time
```
- A compile-time error will be thrown if a constant expression variable cannot be evaluated at compile time.
## Constant expression function
- Constant expression function can accept both constant and non-constant arguments and will be evaluated at compile time in case all of its arguments are constant.
```cpp title='Constant expression function'
constexpr double square(double x) { return x∗x; }

square(17); // computed at compile time because 17 is a constant
const int a = 100;
square(100); // computed at compile time
int b = 10;
square(b); // computed at run time, does not raise error.
```

# Constant
## Constant variable
- Constant variable is a variable that cannot be changed after initialization.
## Constant function
- Constant function is a function which does not cause any side effect to its arguments.
```cpp title='constant function'
double square(double x) const {
  return x * x;
}
```
# References
1. The C++ Programming Language - Bjarne Stroustrup -4th Edition.
	1. Part 1. Introductory Material.
		1. Section 2. A Tour of C++: The Basics.
			1. Section 2.2: The Basics.
				1. Section 2.2.3. Constants.
