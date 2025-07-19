#algebra #functional-programming #high-order-function #lodash #vanilla-javascript #javascript #typescript #operator 

# Syntax
```Javascript title='Difference function in Lodash'
_.difference(array, [values])
```
# Behavior
- `Difference` creates an array of `array` values <mark class="hltr-yellow">not included</mark> in the other given arrays. The order and references of result values are determined by the first array.
- `Difference` is equivalent to the difference operator of the two sets.
# Usage
```Javascript title='find permission that user is not granted'
// All available permissions in the system
const allPermissions = [
  'read', 
  'write', 
  'delete', 
  'admin', 
  'export', 
  'import', 
  'share'
];

// Permissions assigned to a specific user
const userPermissions = ['read', 'write', 'share'];

// Find permissions the user doesn't have
const missingPermissions = _.difference(allPermissions, userPermissions);
console.log('Permissions not granted:', missingPermissions);
// Permissions not granted: ['delete', 'admin', 'export', 'import']

// Use case: Show available permissions to add in UI
const renderAvailablePermissions = () => {
  return missingPermissions.map(perm => 
    `<option value="${perm}">${perm}</option>`
  );
};
```

---
# References
1. https://lodash.com/docs/4.17.15#difference

