#software-engineering #software-architecture #javascript #nodejs #vanilla-javascript
# Overview
- CommonJS is the <mark class="hltr-yellow">original module system</mark> for Node.js that enables modular JavaScript code organization.
- Each file in Node.js is treated as a separate module with its own scope.
- CommonJS modules load ==synchronously==, making them suitable for server-side applications but not for browser environments.
# Exports and Imports
## Exporting module members
- Functions and objects are exported by adding properties to the `JavaScript exports` object.
- Individual members can be exported by assigning them to `JavaScript exports.propertyName`.
```JavaScript title='circle.js exports multiple functions'
const { PI } = Math;
exports.area = (r) => PI * r ** 2;
exports.circumference = (r) => 2 * PI * r;
```
- The entire module can be replaced by assigning a new value to `JavaScript module.exports`.
```JavaScript title='square.js exports a constructor function'
module.exports = class Square {
  constructor(width) {
    this.width = width;
  }
  area() {
    return this.width ** 2;
  }
};
```
- Variables declared in the module scope remain private unless explicitly exported.
## Importing modules
- Modules are imported using the `JavaScript require()` function, which returns the exported object.
```JavaScript title='main.js imports and uses circle module'
const circle = require('./circle.js');
console.log(`The area of a circle of radius 4 is ${circle.area(4)}`);
```
```JavaScript title='main.js imports and uses square module'
const Square = require('./square.js');
const mySquare = new Square(2);
console.log(`The area of mySquare is ${mySquare.area()}`);
```
- The `JavaScript require()` function caches modules after the first load, subsequent calls return the cached instance.
# File format
## File extensions
- Files with `.cjs` extension are always treated as CommonJS modules.
- Files with `.js` extension are treated as CommonJS modules when:
	- The nearest parent `package.json` contains `"type": "commonjs"`.
	- No `package.json` exists in any parent folder.
	- The nearest parent `package.json` does not contain a `"type"` field.
- Files without extensions or with custom extensions (not `.mjs`, `.cjs`, `.json`, `.node`, `.js`) are treated as CommonJS when:
	- They are loaded via `JavaScript require()`.
	- The nearest parent `package.json` contains `"type": "module"`.
## File resolution
- Node.js resolves module paths by searching for exact filenames first.
- If the exact filename is not found, Node.js attempts to append extensions in order: `.js`, `.json`, `.node`.
- Custom extensions like `.cjs` must include the full filename in `JavaScript require()` calls.
```JavaScript title='Requiring a file with custom extension'
require('./file.cjs');
```
# Module wrapper
- Node.js wraps each module's code in a function wrapper before execution.
```JavaScript title='Module wrapper function'
(function(exports, require, module, __filename, __dirname) {
// Module code actually lives in here
});
```
- The wrapper provides module-scoped variables:
	- `JavaScript exports`: Alias to `JavaScript module.exports` for convenience.
	- `JavaScript require`: Function to import other modules.
	- `JavaScript module`: Reference to the current module object.
	- `JavaScript __filename`: Absolute path to the current module file.
	- `JavaScript __dirname`: Absolute path to the directory containing the module.
- Variables declared with `JavaScript var`, `JavaScript const`, or `JavaScript let` remain scoped to the module rather than polluting the global namespace.
# Behavior
- CommonJS modules execute ==synchronously== during the `JavaScript require()` call.
- Module loading blocks execution until the module is fully loaded and executed.
- Circular dependencies are supported through partial exports.
```JavaScript title='Circular dependency example'
// a.js
exports.loaded = false;
const b = require('./b.js');
console.log('in a, b.loaded =', b.loaded);
exports.loaded = true;
// b.js
exports.loaded = false;
const a = require('./a.js');
console.log('in b, a.loaded =', a.loaded);
exports.loaded = true;
```
- The module cache prevents infinite loops by returning partially constructed exports during circular dependencies.
***
# References
1. https://nodejs.org/docs/latest-v22.x/api/modules.html for CommonJS modules in Node.js version 22.
2. https://nodejs.org/docs/latest-v22.x/api/modules.html#the-module-wrapper for module wrapper implementation.
3. https://nodejs.org/api/packages.html#type for `type` property in `package.json`.
4. https://nodejs.org/docs/latest-v22.x/api/modules.html#cycles for circular dependency handling.
