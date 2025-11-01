#algebra #functional-programming #high-order-function #lodash #vanilla-javascript #javascript #typescript #operator 

# Syntax
```Javascript title='Lodash uniq function'
_.uniq(array)
_.uniqBy(array, [iteratee=_.identity])
```
# Behavior
- Creates a <mark class="hltr-yellow">duplicate-free</mark> version of an array, in which only the *first occurrence* of each element is kept. The order of result values is determined by the order they occur in the array.
## Variant
### Unique By
- `uniqBy` is similar to `uniq` except that it accepts `iteratee` which is invoked for each element in `array` to compute the uniqueness criterion, which is either a high-order function or an attribute.
- The order of result values is determined by the order they occur in the array. The iteratee is invoked with one argument.
# Usage
```Javascript title='Basic example of unique methods in Lodash'
_.uniqBy([2.1, 1.2, 2.3], Math.floor);
// => [2.1, 1.2]
 
// The `_.property` iteratee shorthand.
_.uniqBy([{ 'x': 1 }, { 'x': 2 }, { 'x': 1 }], 'x');
// => [{ 'x': 1 }, { 'x': 2 }]
```

```Javascript title='Product catalog deduplication'
const products = [
  { sku: 'LAPTOP-001', name: 'Dell Laptop', price: 999, supplier: 'Supplier A' },
  { sku: 'MOUSE-002', name: 'Wireless Mouse', price: 29, supplier: 'Supplier B' },
  { sku: 'LAPTOP-001', name: 'Dell Laptop Pro', price: 1099, supplier: 'Supplier C' }, // Same SKU
  { sku: 'KEYBOARD-003', name: 'Mechanical Keyboard', price: 89, supplier: 'Supplier A' },
  { sku: 'MOUSE-002', name: 'Wireless Mouse v2', price: 35, supplier: 'Supplier D' } // Same SKU
];

// Remove duplicate products by SKU (keep first/cheapest)
const uniqueProducts = _.uniqBy(products, 'sku');
console.log('Unique products:', uniqueProducts);

// Alternative: Sort by price first, then deduplicate to keep cheapest
const cheapestUniqueProducts = _.uniqBy(
  _.sortBy(products, 'price'),
  'sku'
);
console.log('Cheapest unique products:', cheapestUniqueProducts);
```
# References
1. https://lodash.com/docs/4.17.15#uniq