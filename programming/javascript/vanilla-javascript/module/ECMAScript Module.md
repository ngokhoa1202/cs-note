#software-engineering #software-architecture #javascript #nodejs #vanilla-javascript 

- For a long time, JavaScript had no a language-level module syntax because the scripts used to be small and simple.
- The language-level module system was first specified in the ECMAScript 2015, gradually evolved and adopted since then, and is now supported by all major browsers and in Node.js.
# ECMAScript module
- Modules are singletons. Even if a module is imported multiple times, only a single instance of that module exists.
- A module can import variables or functions from other modules. It refers to those modules via _module specifiers_, strings that are either:
	- Relative paths (`'../model/user'`): these paths are interpreted relatively to the location of the *importing module*. The file extension `.js` can usually be omitted.
	- Absolute paths (`'/lib/js/helpers'`): point directly to the file of the module to be imported.
	- Names (`'util'`): What modules names refer to has to be configured.
## Multiple named exports
- A module can export multiple things by prefixing its declarations with the keyword `export`. 
- These exports are distinguished by their names and are called _named exports_.
```JavaScript title='Multiple named exports in a module'
//------ lib.js ------
export const sqrt = Math.sqrt;
export function square(x) {
    return x * x;
}
export function diag(x, y) {
    return sqrt(square(x) + square(y));
}

//------ main.js ------
import { square, diag } from 'lib';
console.log(square(11)); // 121
console.log(diag(4, 3)); // 5
```
## Single default export
- A variable, function, etc can be selected to be the main exported value of a module.
```JavaScript title='Single default export in JavaScript'
//------ myFunc.js ------
export default function () {} // no semicolon!

//------ main1.js ------
import myFunc from 'myFunc';
myFunc();
```
- There are two styles of default exports:
	- Labeling declarations.
	- Default-exporting values directly.
### Labeling declarations
- The named function or named  class is prefixed with `export default` to make it the default export.
```JavaScript title='Labeling declarations in default export'
// In file bar.mjs
export default function MyFunc() {
  console.log('foo');
} // no semicolon!

// In file main.mjs
import MyFunc from "./bar.mjs";
MyFunc();
```
### Default exporting values directly
- Each of default direct exportation has the following structure.
```JavaScript title='Default export structure'
export default «expression»;
```

```JavaScript title='Direct default export examples'
export default 'abc';
export default foo();
export default /^xyz$/;
export default 5 * 7;
export default { no: false, yes: true };
```
- The export statement is equivalent to
```JavaScript title='Equivalence of direct default export statement'
const __default__ = «expression»;
export { __default__ as default }; // (A)
```
# File format
- Files with an `.mjs` extension.
- Files with a `.js` extension when the nearest parent `package.json` file contains a top-level `"type"` field with a value of `"module"`.
# Behavior
- ECMAScript modules are asynchronous.
- Imports and exports *must be at the top level* because the structure of ECMAScript 6 is static.
```JavaScript title='Syntax error arises when the import or export is nested inside a block'
if (Math.random()) {
    import 'foo'; // SyntaxError
}

// You can’t even nest `import` and `export`
// inside a simple block:
{
    import 'foo'; // SyntaxError
}
```
- Module imports are always *hoisted*.
```JavaScript title='Imports are internally moved to the beginning of the current file'
foo();

import { foo } from 'my_module';
```
- Imports are mutable on the exporter but *read-only live references* in the importer.
```JavaScript title='Imports are read-only live references in the importer'
//------ lib.js ------ --> exporter
export let counter = 3;
export function incCounter() {
    counter++;
}

//------ main.js ------ --> importer
import { counter, incCounter } from './lib';

// The imported value `counter` is live
console.log(counter); // 3
incCounter();
console.log(counter); // 4
```

---
# References
1. https://javascript.info/modules-intro for Javascript Module.
2. https://262.ecma-international.org/6.0/index.html for ECMAScript 2015.
3. https://v8.dev/features/modules#mjs
4. https://exploringjs.com/es6/ch_modules.html
5. [[programming/javascript/vanilla-javascript/module/CommonJS|CommonJS]]
6. https://nodejs.org/api/esm.html for Node.js ESModule.