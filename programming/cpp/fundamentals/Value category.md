#cpp #data-type #memory-management 

- Every C++ expression has a type, and belongs to a _value category_. The value categories are the basis for rules that compilers must follow when <mark class="hltr-yellow">creating, copying, and moving temporary objects</mark> during expression evaluation.
- ![](Pasted%20image%2020250518140455.png)
- ![](Pasted%20image%2020250511181522.png)
# Glvalue
- Also known as <mark class="hltr-yellow">generalized lvalue</mark>.
- A glvalue is a lvalue or xvalue.
# Prvalue
- Also known as <mark class="hltr-yellow">pure rvalue</mark>.
- Prvalue is a value which does <mark class="hltr-yellow">not have a <strong>persistent</strong> memory address</mark>. As a result, its address cannot be taken.
- Prvalue is only used to initialize objects or compute values.
```cpp title='Prvalue example'
int x = 5 + 3; // '5 + 3' is a prvalue
std::string s = "hello"; // "hello" is a prvalue of type const char[6]
int z = f(3) + 2; // f(3) + 2 is a prvalue
```
# Xvalue
- Also known as <mark class="hltr-yellow">expiring value</mark>.
- Xvalue is a value which occupies a <mark class="hltr-blue">memory location</mark>, but it is <mark class="hltr-yellow">movable</mark> and <mark class="hltr-yellow">about to be moved</mark> from or <mark class="hltr-yellow">destroyed</mark>.
```cpp title='xvalue example'
std::string getString() {
    return "temp";
}

std::string s = std::move(getString());

std::vector<int> v = {1, 2, 3};
std::vector<int> v2 = std::move(v); // 'std::move(v)' is an xvalue
```
# Lvalue
- Also known as <mark class="hltr-yellow">locator value</mark>.
- Lvalue is an instance that occupies some <mark class="hltr-yellow">identifiable location</mark> in memory, but not movable.
- Lvalue can appear on the left hand side of an assignment operation.
```cpp title='lvalue example'
int a = 10;
int& ref = a; // 'a' is an lvalue

int* ptr = &a;
int arr[] = {1, 2, 3};
a[0] = 1; // a[0] is lvalue
```
# Rvalue
- Also known as <mark class="hltr-yellow">right value</mark>.
- An rvalue is a prvalue or an xvalue.

# References
1. C++ 20 Draft International Standard - 2020.
2. https://learn.microsoft.com/en-us/cpp/cpp/lvalues-and-rvalues-visual-cpp?view=msvc-170
3. https://en.cppreference.com/w/cpp/language/value_category
4. https://stackoverflow.com/questions/3106110/what-is-move-semantics