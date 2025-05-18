#c #cpp #memory #os #garbage-collector #cpp-11  

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
## Shared pointer
- Share pointer represents shared ownership.
- Multiple shared pointers are able to share the ownership of the object to which they point.
- A shared pointer is a counted pointer where the object pointed to is deleted when the use count goes to 0.
- ![](Pasted%20image%2020250518101506.png)
## Weak pointer
---
# References
1. The C++ Programming Language - Bjarne Stroustrup - 4th Edition.
	1. Section 7. Pointers, Arrays and References.
2. www.gnu.org/software/c-intro-and-ref/manual/html_node/Void-Pointers.html for Void pointer.
3. https://learn.microsoft.com/en-us/cpp/cpp/raw-pointers?view=msvc-170 for Raw pointer.
4. [Alias, dangling references and garbage](Alias,%20dangling%20references%20and%20garbage.md)