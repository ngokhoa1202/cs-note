#software-engineering #software-architecture #javascript #vanilla-javascript #typescript #computer-network #application-layer #design-pattern #operating-system #concurrency-control #event-driven-programming 

# Promisification
## Definition
- Promisification is the transformation of a function that accepts a callback into a function that returns a promise. This approach is perfectly suitable for `async-await` mechanism in Javascript.
```Javascript title='Promisify a simple function'
/* loadScript that accepts a callback */
function loadScript(src, callback) {
  let script = document.createElement('script');
  script.src = src;

  script.onload = () => callback(null, script);
  script.onerror = () => callback(new Error(`Script load error for ${src}`));

  document.head.append(script);
}

// usage:
// loadScript('path/script.js', (err, script) => {...})

/* loadScript that accepts only src without callback and returns a promise */
let loadScriptPromise = function(src) {
  return new Promise((resolve, reject) => {
    loadScript(src, (err, script) => {
      if (err) reject(err);
      else resolve(script);
    });
  });
};

// usage:
// loadScriptPromise('path/script.js').then(...)
```
## Generalization
- The function that accepts a callback is invoked inside a promise. 
- The callback is re-defined to adapt to the promise pattern so that it makes the wrapper promise resolve with the return value if that function is successfully executed and reject with the reason in case of error.
- The callback is finally passed into that function's application together with the already passed arguments.
```Javascript title='Function promisification'
function promisify(f) {
  return function (...args) { // return a wrapper-function (*)
    return new Promise((resolve, reject) => {
      function callback(err, result) { // our custom callback for f (**)
        (err) ? reject(err) : resolve(result);
      }

      args.push(callback); // append our custom callback to the end of f arguments

      f.call(this, ...args); // call the original function
    });
  };
}

// usage:
let loadScriptPromise = promisify(loadScript);
loadScriptPromise(...).then(...);
```
- If the callback expects more than two arguments, which are `(error, result1, result2,...)`, the `promisify` function must return a promise that resolves an array of result rather a single one.
```Javascript title='Promisify a function whose its callback argument expects more than more than two arguments'
// promisify(f, true) to get array of results
function promisify(f, manyArgs = false) {
  return function (...args) {
    return new Promise((resolve, reject) => {
      function callback(err, ...results) { // our custom callback for f
        (err) ? reject(err) : resolve(manyArgs ? results : results[0]);
      }

      args.push(callback);

      f.call(this, ...args);
    });
  };
}

// usage:
f = promisify(f, true);
f(...).then(arrayOfResults => ..., err => ...);
```
# Usage
## Read file with `fs`
```Javascript title='Clearer logic after employing promifisified fs.readFile()'
const fs = require('fs');
const { promisify } = require('util');

const readFile = promisify(fs.readFile);

async function loadConfig() {
  try {
    const data = await readFile('./config.json', 'utf8');
    return JSON.parse(data);
  } catch (error) {
    console.error('Error loading config:', error.message);
    // Handle specific error types
    if (error.code === 'ENOENT') {
      console.error('Config file not found');
    }
    throw error; // Re-throw or handle as needed
  }
}
```
## Redis caching API
```Javascript title='Redis caching API without callbacks after being promisfied'
const redis = require('redis');
const { promisify } = require('util');

const client = redis.createClient();

// Promisify Redis operations
const getAsync = promisify(client.get).bind(client);
const setAsync = promisify(client.set).bind(client);
const delAsync = promisify(client.del).bind(client);

class CacheService {
  async getCachedData(key) {
    const cachedResult = await getAsync(key);
    return cachedResult ? JSON.parse(cachedResult) : null;
  }
  
  async setCachedData(key, data, expireSeconds = 3600) {
    await setAsync(key, JSON.stringify(data), 'EX', expireSeconds);
  }
  
  async invalidateCache(key) {
    await delAsync(key);
  }
}
```
---
# References
1. https://javascript.info/promisify
2. https://javascript.info/async-await
3. [[programming/javascript/vanilla-javascript/fundamentals/promise/Promise]]
4. 