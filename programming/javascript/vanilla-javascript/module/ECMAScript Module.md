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
---
# References
1. https://javascript.info/modules-intro for Javascript Module.
2. https://262.ecma-international.org/6.0/index.html for ECMAScript 2015.
3. https://v8.dev/features/modules#mjs
4. https://exploringjs.com/es6/ch_modules.html