#functional-programming #high-order-function #name-binding 

# Closure
- A closure is a <mark class="hltr-yellow">persistent scope</mark> which holds on to local variables even after the code execution has moved out of that block.
- The scope object and all its local variables are tied to the function and will persist as long as that function persists.
- Languages which support closure will help <mark class="hltr-yellow">keep a reference to a scope</mark> (including its parent scopes), even after the block in which those variables were declared has finished executing.
```Javascript title='Closure in Javascript example'
outer = function() {
  var a = 1;
  var inner = function() {
    console.log(a);
  }
  return inner; // this returns a function
}

var fnc = outer(); // execute outer to get inner 
fnc();
```
---
# References
1. https://stackoverflow.com/questions/36636/what-is-a-closure