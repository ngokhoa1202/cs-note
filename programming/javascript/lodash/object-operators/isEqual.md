#operator #data-type #javascript #lodash #vanilla-javascript 

# Syntax
```Javascript title='isEqual method in lodash'
_.isEqual(value, other)
```
# Behavior
- Performs a <mark class="hltr-yellow">deep comparison</mark> between two values to determine if they are equivalent.
- This method supports comparing arrays, array buffers, booleans, date objects, error objects, maps, numbers, `Object` objects, regexes, sets, strings, symbols, and typed arrays.
- `Object` objects are compared by their own, not inherited, enumerable properties. 
- Functions and DOM nodes are compared by strict equality `===`.
# Usage
```Javascript title='_.isEqual to compare two complex objects'
const foo = {
  a: 'hi',
  b: [1, 2, 3],
  c: {
    d: new Date(),
    e: BigInt(3),
    g: [
      {
        e: 1,
        f: 'a'
      },
      {
        e: 2,
        f: 'b'
      }
    ]
  }
};

const bar = {
  a: 'hi',

  c: {
    g: [
      {
        e: 1,
        f: 'a'
      },
      {
        e: 2,
        f: 'b'
      }
    ],
    d: new Date(),
    e: BigInt(3),
  },
  b: [1, 2, 3],
};
```
---
# References
1. https://lodash.com/docs/4.17.15#isEqual