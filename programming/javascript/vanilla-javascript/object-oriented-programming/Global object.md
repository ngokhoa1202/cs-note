#object-oriented-programming #javascript #vanilla-javascript #nodejs #browser 

# Definition
- The global object in Javascript is an object which represents the global scope.
- The global object's interface depends on the execution context in which the script is running:
	- For normal Web browser environment, the global object is `{Javascript} window`.
	- For service worker, the global object is `{Javascript} workerGlobalScope`.
	- For Node.js, the global object is `{Javascript} global`.
- The global object is now standardized as `{Javascript} globalThis` object.
```Javascript title='window as global object in browser environment'
// Accessing global object
console.log(window === globalThis); // true in browsers

// Global variables become window properties
var globalVar = "Hello";
console.log(window.globalVar); // "Hello"

// Window properties
window.location.href = "https://example.com";
window.history.back();
window.open("popup.html", "_blank");
```

```Javascript title='global object in Node.js'
// Global scope (equivalent to window in browsers)
global.myVar = "accessible everywhere";
console.log(globalThis === global); // true

// Global variables
global.DATABASE_URL = "mongodb://localhost:27017";
```
# 
# References
1. https://developer.mozilla.org/en-US/docs/Glossary/Global_object
2. https://javascript.info/global-object
3. 