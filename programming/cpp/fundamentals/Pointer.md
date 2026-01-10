#c #cpp #memory-management #operating-system #garbage-collector #cpp-11  

# Raw pointer
- A _raw pointer_ is a pointer whose lifetime isn't controlled by an encapsulating object; as a result, its lifetime must be manually handled.
- Raw pointers must be carefully managed to preclude garbage and dangling reference.
```c title='Garbage example'
#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

void cause_garbage(int* p) {
  p = NULL;
  // free(p);
}

int main() {
  int* p = malloc(sizeof(int));
  cause_garbage(p);
  return 0;
}

```

```c title='Dangling reference'
#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

int* cause_dangling() {
  int v = 3;
  int* p = &v;
  return p;
}

int main() {
  int* p = cause_dangling();
  return 0;
}
```

```cpp title='Raw pointer usage'
#include <format>
#include <iostream>
#include <list>
#include <memory>
#include <vector>
#include "adt/LinkedList.h"
#include "adt/Node.h"
#include "shape/Circle.h"
#include "shape/Shape.h"
#include "shape/Square.h"
#include "shape/Triangle.h"

using namespace std;

int main() {
  Shape** shapes = new Shape*[3];
  shapes[0] = new Circle(3.2);
  shapes[1] = new Triangle(2.4, 3.5, 2.1);
  shapes[2] = new Square(2.5);

  std::cout << shapes[0]->getArea() << std::endl;
  return 0;
}

```
## Void pointer
- Void pointer is also known as generic pointer, which is actually pointer to an object of unknown type.
```c title='void pointer'
#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

void* get_void_ptr() {
  int* p = malloc(sizeof(int));
  *p = 3;
  return (void*)p;
}

int main() {
  // int* p = malloc(sizeof(int));
  // cause_garbage(p);

  // int* p = cause_dangling();

  void* p = get_void_ptr();
  printf("%d\n", *((int*)p));
  return 0;
}

```
- Void pointer is able to hold any address of memory location without knowing the content type.
# Smart pointer
- Ownership of a pointer is that the pointer is responsible for<mark class="hltr-yellow"> managing the lifecycle of the object it references</mark>.
- Smart pointer is a data structure which <mark class="hltr-yellow">encapsulates raw pointer</mark> and <mark class="hltr-yellow">automatically</mark> performs garbage collection and null checks.
## Unique pointer
### Characteristics
- Unique pointer represents *exclusive ownership*.
- A unique pointer and only itself owns the object to which it holds a pointer. 
- A unique pointer cannot be copied but can be moved.
- A unique pointer stores a pointer and deletes the referenced object using the associated deleter (if any) when it is itself destroyed.
- ![](Pasted%20image%2020250518093923.png)
- When a unique pointer is destroyed, its <mark class="hltr-yellow">deleter</mark> is called to destroy the owned object. The deleter represents what it means to destroy an object:
	- A deleter for a local variable should do nothing.
	- A deleter for a memory pool should return the object to the memory pool and destroy it or not, depending on how that pool is defined.
	- The default (‘‘no deleter’’) version of unique pointer uses `delete`. It doesn’t even store the default deleter. It can be a specialization or rely on the empty-base optimization.
### Usage
- Provides exception safety for dynamically allocated memory.
- Passes ownership of dynamically allocated memory to a function.
- Returns dynamically allocated memory from a function.
- Stores pointers in containers.
### Example
```cpp title='unique pointer example'
#include <format>
#include <iostream>
#include <list>
#include <memory>
#include <vector>
#include "shape/Circle.h"
#include "shape/Shape.h"
#include "shape/Triangle.h"

using namespace std;

int main() {
  std::unique_ptr<Shape> p{new Triangle(3, 4, 5)};
  std::cout << std::format("Area of shape: {:.2f}\n", p->getArea());
  std::cout << std::format("Address of p: {:p}\n", static_cast<void*>(p.get()));
}
```

- `std::make_unique(...args)` automatically invokes the concrete class 's proper constructor to instantiate the object
```cpp title='unique pointer does not allow to share reference'
#include <format>
#include <iostream>
#include <list>
#include <memory>
#include <vector>
#include "shape/Circle.h"
#include "shape/Shape.h"
#include "shape/Triangle.h"

using namespace std;

int main() {
  const std::unique_ptr<Shape> p{new Triangle(3, 4, 5)};
  std::cout << std::format("Area of shape: {:.2f}\n", p->getArea());
  std::cout << std::format("Address of p: {:p}\n", static_cast<void*>(p.get()));

  std::unique_ptr<Shape> q{p};  // throws compile time error because unique pointer does not allow to share reference to an object
  std::cout << std::format("Area of shape: {:.2f}\n", p->getArea());
  std::cout << std::format("Address of q: {:p}\n", static_cast<void*>(q.get()));
  
  std::unique_ptr<Shape> shape = std::make_unique<Circle>(3.4);
  std::cout << shape->getArea() << std::endl;
}
```

```cpp title='unique pointer does not allow to share references'
#include <format>
#include <iostream>
#include <list>
#include <memory>
#include <vector>
#include "shape/Circle.h"
#include "shape/Shape.h"
#include "shape/Triangle.h"

std::unique_ptr<int> getUniquePointer(std::unique_ptr<int>& p) {
  *p = *p + 3;
  return p;
}

int main() {
  std::unique_ptr<int> p {new int(3)};
  std::unique_ptr<int> q = getUniquePointer(p);
  std::cout << *q << std::endl;
}
```

- Unique pointer may not work in `std::initializer_list` because unique pointer is non-copyable but initializer list prefers copy.
```cpp title='Unique pointer may not work in initializer list'
#include <format>
#include <iostream>
#include <list>
#include <memory>
#include <vector>

#include "adt/LinkedList.h"
#include "adt/Node.h"
#include "shape/Circle.h"
#include "shape/Shape.h"
#include "shape/Square.h"
#include "shape/Triangle.h"

using namespace std;

int main() {
  // does not work because vector initializer list lacks allow move constructor of unique pointer
  std::vector<std::unique_ptr<Shape>> shapes{std::make_unique<Circle>(3.5)}; 
  std::cout << shapes[0]->getArea() << std::endl;

  std::vector<std::unique_ptr<Shape>> shapes{};
  shapes.push_back(std::make_unique<Circle>(3.5));  // works properly because push_back allows move semantics
  std::cout << shapes[0]->getArea() << std::endl;


  // std::unique_ptr<Shape> shape = std::make_unique<Circle>(3.4);
  // std::cout << shape->getArea() << std::endl;

  // std::shared_ptr<Shape[]> shapePtrs{{Circle(3.2), Triangle(2.3, 4.5, 3.1), Square(3.8)}};
  // std::cout << shapePtrs.get()[1].getArea() << std::endl;

  return 0;
}

```

- To make things work properly, use `std::move` for unique pointer, but only once.
```cpp title='std::move to transfer ownership of unique pointer'
#include <format>
#include <iostream>
#include <list>
#include <memory>
#include <vector>
#include "shape/Circle.h"
#include "shape/Shape.h"
#include "shape/Triangle.h"

std::unique_ptr<int> getUniquePointer(std::unique_ptr<int>& p) {
  *p = *p + 3;
  return p;
}

int main() {
  std::unique_ptr<int> p {new int(3)};
  std::unique_ptr<int> q = getUniquePointer(std::move(p)); // changes this
  std::cout << *q << std::endl;
}
```
- Refers to [Usage](Move%20semantics.md#Usage).
- Because unique pointer represent exclusive ownership, internal raw pointer must be employed to perform specific tasks.
```cpp title='traverse by raw pointer which is encapsulated by unique pointer'
#include <memory>

template <class T>
class Node {
private:
  T value;
  std::unique_ptr<Node<T>> next;

public:
  explicit Node(const T& value) noexcept;
  explicit Node(T&& value) noexcept;
  Node& operator=(const Node<T>& other) noexcept;
  Node& operator=(Node<T>&& other) noexcept;
  Node(const T& value, std::unique_ptr<Node<T>> next) noexcept;
  void setNext(std::unique_ptr<Node<T>> next) noexcept;
  [[nodiscard]] T getValue() const noexcept;
  [[nodiscard]] Node<T>* getNext() const noexcept;
  void setValue(const T& value) noexcept;
};


template <class T>
Node<T>::Node(const T& value) noexcept : value{value}, next{nullptr} {
  std::cout << "Constructor 1" << std::endl;
}

template <class T>
Node<T>::Node(T&& value) noexcept : value{std::move(value)}, next{nullptr} {
  std::cout << "Constructor 2" << std::endl;
}

template <class T>
Node<T>::Node(const T& value, std::unique_ptr<Node<T>> next) noexcept : value{value}, next{std::move(next)} {
  std::cout << "Constructor 3" << std::endl;
}

template <class T>
T Node<T>::getValue() const noexcept {
  return this->value;
}

template <class T>
void Node<T>::setNext(std::unique_ptr<Node<T>> next) noexcept {
  std::cout << "setNext by next unique pointer" << std::endl;
  this->next = std::move(next);
}

template <class T>
void Node<T>::setValue(const T& value) noexcept {
  this->value = value;
}

template <class T>
Node<T>* Node<T>::getNext() const noexcept {
  return this->next.get();
}


template <class T>
Node<T>& Node<T>::operator=(const Node<T>& other) noexcept {
  *this = other;
  return *this;
}

template <class T>
Node<T>& Node<T>::operator=(Node<T>&& other) noexcept {
  *this = std::move(other);
  return *this;
}
```

## Shared pointer
### Characteristics
- Share pointer represents <mark class="hltr-yellow">shared ownership</mark>.
- Multiple shared pointers are able to share the ownership of the object to which they point.
- A shared pointer is a counted pointer where the object pointed to is deallocated when the use count goes to 0.
- ![](Pasted%20image%2020250518101506.png)
### Implications
- A circular linked structure of share pointers can cause a <mark class="hltr-yellow">resource leak</mark>.
- Shared pointers in a multi-threaded environment can be <mark class="hltr-yellow">expensive</mark> because of data races.
- A destructor for a shared object does not execute at a predictable time, so the algorithms/logic for the update of any shared object are <mark class="hltr-yellow">easier to get wrong</mark> than for an object that’s not shared.
- If a single node keeps a large data structure alive, the cascade of destructor calls triggered by its deletion can cause a significant garbage collection <mark class="hltr-yellow">overhead</mark>.

## Weak pointer
- Weak pointer represents <mark class="hltr-yellow">non-owning relationship</mark>.
- A weak pointer refers to an object managed by a shared pointer. To access the object, a weak pointer can be converted to a shared pointer using the member function `lock()`. A weak pointer allows access to an object, owned by someone else, that:
	- can be accessed only if it exists.
	- get deleted by someone at any time.
	- must have its destructor called after its last use.
- ![](Pasted%20image%2020250522162715.png)
- Weak pointers are used to break circular references in data structures managed using share pointers.
```cpp title='Weak pointer to break circular references example'
// Company.h

#ifndef COMPANY_H
#define COMPANY_H

#include <memory>
#include <string>
#include <vector>

struct Tariff;

struct Company {
  std::string name;
  std::vector<std::weak_ptr<Tariff>> tariffs;

  Company(std::string name) : name{name}, tariffs{} {}

  void showTaxes();
};

#endif


// tariff.h
#ifndef TARIFF_H
#define TARIFF_H

#include <memory>
#include <string>

struct Company;

struct Tariff : public std::enable_shared_from_this<Tariff> {
  std::string type;
  std::shared_ptr<Company> company;

  Tariff(std::string type) : type{type}, company{} {}

  void setCompany(const std::shared_ptr<Company>& company);
};

#endif

// Tariff.cpp

#include "Tariff.h"

#include "Company.h"

void Tariff::setCompany(const std::shared_ptr<Company>& company) {
  company->tariffs.push_back(shared_from_this());
  this->company = company;
}


// Company.cpp
#include "Company.h"

#include <iostream>

#include "Tariff.h"

void Company::showTaxes() {
  for (const auto& tariff : tariffs) {
    if (auto t = tariff.lock()) {
      std::cout << t->type << " ";
    }
  }
}
```
***
# References
1. The C++ Programming Language - Bjarne Stroustrup - 4th Edition.
	1. Section 7. Pointers, Arrays and References.
	2. Section 34. Memory and resources.
2. www.gnu.org/software/c-intro-and-ref/manual/html_node/Void-Pointers.html for Void pointer.
3. https://learn.microsoft.com/en-us/cpp/cpp/raw-pointers?view=msvc-170 for Raw pointer.
4. [Alias, dangling references and garbage](Alias,%20dangling%20references%20and%20garbage.md)
5. https://www.php.net/manual/en/features.gc.refcounting-basics.php for reference counting garbage collection in PHP.