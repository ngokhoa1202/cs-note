#software-engineering #software-architecture #javascript #nodejs #vanilla-javascript 

# CommonJS module
- CommonJS modules are the <mark class="hltr-yellow">original</mark> way to package JavaScript source code for Node.js.
- In Node.js, each file is treated as a separate module.
```Javascript title='circle.js is separate module'
const { PI } = Math; // variable PI is private to circle.js module

exports.area = (r) => PI * r ** 2;

exports.circumference = (r) => 2 * PI * r;
```

```Javascript title='File main.js is using circle.js module'
const circle = require('./circle.js');
console.log(`The area of a circle of radius 4 is ${circle.area(4)}`);
```
- The module `circle.js` has exported the functions `area()` and `circumference()`. Functions and objects are *added to the root of a module* by specifying additional properties on the special `{javascript} exports` object.
- The local variables in each module are private to that module because the module is wrapped by [[#Module wrapper]].
- The `module.exports` property can be assigned a new value (such as a function or object).
```Javascript title='Change the module name via module.exports in Node.js'
const Square = require('./square.js');
const mySquare = new Square(2);
console.log(`The area of mySquare is ${mySquare.area()}`);
```

# File format
- Files with a `.cjs` extension.
- Files with a `.js` extension when the nearest parent `package.json` file contains a top-level field `"type"` with a value of `"commonjs"`.
- Files with a `.js` extension or without an extension, when the nearest parent `package.json` file doesn't contain a top-level field [`"type"` or there is no `package.json` in any parent folder.
- Files with an extension that is not `.mjs`, `.cjs`, `.json`, `.node`, or `.js`
	- when the nearest parent `package.json` file contains a top-level field `"type"` with a value of `"module"`, those files will be recognized as CommonJS modules only if they are being included via `require()`
- If the exact filename is not found, then Node.js will attempt to load the required filename with the added extensions: `.js`, `.json`, and finally `.node`. When loading a file that has a different extension (e.g. `.cjs`), its full name must be passed to `require()`, including its file extension (e.g. `require('./file.cjs')`).
# Module wrapper
- Before a module's code is executed, Node.js will wrap it with a function wrapper.
```Javascript title='Module wrapper in Node.js'
(function(exports, require, module, __filename, __dirname) {
// Module code actually lives in here
});
```
- Module wrapper keeps top-level variables (defined with `var`, `const`, or `let`) *scoped to the module* rather than the global object.
# Behavior
- `CommonJS` modules are fully synchronous.
---
# References
1. https://nodejs.org/docs/latest-v22.x/api/modules.html for CommonJS in Node.js version 22.
2. https://nodejs.org/docs/latest-v22.x/api/modules.html#the-module-wrapper for Module wrapper in Node.js.
3. https://nodejs.org/api/packages.html#type for `type` property in `package.json`.