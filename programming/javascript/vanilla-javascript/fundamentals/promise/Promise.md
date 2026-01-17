#software-engineering #software-architecture #javascript #vanilla-javascript #typescript #computer-network #application-layer #design-pattern #operating-system #concurrency-control #event-driven-programming 

# Definition
- A **Promise** in JavaScript is an object representing the <mark class="hltr-yellow">eventual completion or failure of an asynchronous operation</mark>. by  associating event handlers with an asynchronous action's eventual success value or failure error.
- Promise is <mark class="hltr-yellow">eagerly executed</mark> by its executor function behind the scenes. Whenever a promise is instantiated, its executor function immediately executes at that moment. However, it is not until the promise is settled at an that its value or reason can be used.
```Javascript title='Promises are eagerly executed by Javascript'
console.log('Start');

const promise = new Promise((resolve, reject) => {
  console.log('Executor running');
  setTimeout(() => {
    resolve('Complete');
  }, 1000);
});

console.log('Promise created');
```
- If a promise should be lazily executed, it must be wrapped as a callback.
```Javascript title='Promise is wrapped to be lazily executed'
// Lazy - starts only when called
const lazyOperation = () => new Promise((resolve) => {
    // This runs when lazyOperation() is invoked
    performExpensiveOperation();
    resolve();
});
```
# Lifecycle
- ![](Pasted%20image%2020250221064245.png)
- A `Promise` is in one of these states:
	- _pending_: initial state, neither fulfilled nor rejected.
	- _fulfilled_: meaning that the operation was completed successfully.
	- _rejected_: meaning that the operation failed.
# Chained Promise
```Javascript title='Promise concepts'
const myPromise = new Promise((resolve, reject) => { // initial promise
  setTimeout(() => {
    resolve("foo");
  }, 300);
});

myPromise
  // new promise: the promise returned by then()
  .then(handleFulfilledA, handleRejectedA) // fulfillment handler and rejection handler are passed to then()
  // new promise: the promise returned by then()
  .then(handleFulfilledB, handleRejectedB) 
  .then(handleFulfilledC, handleRejectedC);

```
- The <mark class="hltr-yellow">settled state</mark> of the initial promise determines which handler to execute.
	- If the initial promise is fulfilled, the fulfillment handler is called with the <mark class="hltr-yellow">fulfillment value</mark>.
	- If the initial promise is rejected, the rejection handler is called with the <mark class="hltr-yellow">rejection reason</mark>.
- `then()` consumes its preceding promise and produces another promise.
```Javascript title='Promise usage example'
let promise = new Promise(function(resolve, reject) {
  setTimeout(() => resolve("done!"), 1000);
});

// resolve runs the first function in .then
promise.then(
  result => alert(result), // shows "done!" after 1 second
  error => alert(error) // doesn't run
);
```
- `catch()` consumes its preceding promise which has produced an error, handles that error and keep producing a new promise.
```Javascript title='catch() in Promise'
let promise = new Promise((resolve, reject) => {
  setTimeout(() => reject(new Error("Whoops!")), 1000);
});

// .catch(f) is the same as promise.then(null, f)
promise.catch(alert); // shows "Error: Whoops!" after 1 second
```
- `finally()` always runs when its previous promise settled whether that promise was resolved or rejected and is mainly used for cleanup function such as stop loading indicators and closing network connections.
```Javascript title='finally() example'
new Promise((resolve, reject) => {
  /* do something that takes time, and then call resolve or maybe reject */
})
  // runs when the promise is settled, doesn't matter successfully or not
  .finally(() => stop loading indicator)
  // so the loading indicator is always stopped before we go on
  .then(result => show result, err => show error)
```

>[!Important] finally method
> - `finally()` does not accept any argument
> - `finally` handler passes through the result or error to the next handler

```Javascript title='finally handler passes through settled value'
new Promise((resolve, reject) => {
  setTimeout(() => resolve("value"), 2000);
})
  .finally(() => alert("Promise ready")) // triggers first
  .then(result => alert(result)); // <-- .then shows "value"
```
# Error handler
- Whenever a promise rejects, the control flow immediately goes to the closest rejection handler.
```Javascript title='Error handler in Promise'
fetch('/article/promise-chaining/user.json')
  .then(response => response.json())
  .then(user => fetch(`https://api.github.com/users/${user.name}`))
  .then(response => response.json())
  .then(githubUser => new Promise((resolve, reject) => {
    let img = document.createElement('img');
    img.src = githubUser.avatar_url;
    img.className = "promise-avatar-example";
    document.body.append(img);

    setTimeout(() => {
      img.remove();
      resolve(githubUser);
    }, 3000);
  }))
  .catch(error => alert(error.message));
```

- A new error can be thrown by the rejection handler and the control flow keeps jumping into the closest rejection handler.
# Promise concurrency
- Promise concurrency allows multiple independent promises to be <mark class="hltr-yellow">concurrently executed</mark> without being wastefully blocked and always return a single Promise.
```Javascript title='Independent promises are wastefully blocked'
async function getPageData() {
  const user = await fetchUser();
  const product = await fetchProduct();
  const order = await fetchOrder();
  const analytics = await fetchAnalytics()
}
```
## `Promise.all`
 - `Promise.all()` fulfills when **all** of the promises fulfill with an array of *fulfillment values*; and rejects when **any** of the promises rejects with only the *first reject reason*.
```Javascript title='Promise.all() may cause unhandled rejections'
async function getPageData() {
  try {
    const [user, product] = await Promise.all([
      fetchUser(), fetchProduct()
    ])
  } catch (err) {
    // when there is an error thrown from one of the rejected promises
    // Only the first error is handled
    // If there is another promise which is later rejected, its reason is ignored
  }
}
```

```Javascript title='Each promise has his error handler in the Promise.all() to prevent unhandled rejections'
function onReject(err) {
  handle(err)
  return err
}

async function getPageData() {
  
  const [user, product] = await Promise.all([
    fetchUser().catch(onReject), // ⬅️
    fetchProduct().catch(onReject) // ⬅️
  ])

  if (user instanceof Error) {
    handle(user) // ✅
  }
  if (product instanceof Error) {
    handle(product) // ✅
  }
}
```
## `Promise.allSettled`
 - `Promise.allSettled()` fulfills when **all** promises settle, with an array of objects that describe the outcome of each promise. Each settled object is made up of `status` and `value` in case of fulfillment or `reason` in case of rejection properties.
```Javascript title='Promise.allSettled() usage'
async function getPageData() {
  const results = await Promise.allSettled([
    fetchUser(), fetchProduct()
  ])

  // Nicer on the eyes
  const [user, product] = handleResults(results)
}
```
- The error handler of `Promise.allSetted` is implemented based on the status of the settled Promise.
```Javascript title='Generic error handler for Promise.allSettled'
// Generic function to throw if any errors occured, or return the responses
// if no errors happened
function handleResults(results) {
  const errors = results
    .filter(result => result.status === 'rejected')
    .map(result => result.reason)

  if (errors.length) {
    // Aggregate all errors into one
    throw new AggregateError(errors)
  }

  return results.map(result => result.value)
}

async function getPageData() {
  const results = await Promise.allSettled([
    fetchUser(), fetchProduct()
  ])

  try {
    const [user, product] = handleResults(results)
  } catch (err) {
    for (const error of err.errors) {
      handle(error)
    }
  }
}
```
## `Promise.any`
- `Promise.any` fulfills when any of the promises **fulfills**; rejects when **all** of the promises reject. As a consequence, it waits for *the first fulfilled promise* if necessary.
- This returned promise fulfills when any of the input's promises fulfills, with this first fulfillment value. It rejects when all of the input's promises reject (including when an empty iterable is passed), with an `AggregateError` containing an array of rejection reasons.
```Javascript title='Promise.any' usage
const getCachedData = async (key) => {
    const cacheStrategies = [
        getFromMemoryCache(key),
        getFromRedisCache(key),
        getFromDatabase(key)
    ];
    
    try {
        const data = await Promise.any(cacheStrategies);
        return data;
    } catch (aggregateError) {
        throw new Error(`Data not found in any cache layer for key: ${key}`);
    }
};

const getFromMemoryCache = (key) => {
    return new Promise((resolve, reject) => {
        const cached = memoryCache.get(key);
        if (cached) {
            resolve(cached);
        } else {
            reject(new Error('Not found in memory cache'));
        }
    });
};
```
- `Promise.any()` differs significantly from `Promise.race()` by continuing execution until the first successful resolution rather than settling on the first completion regardless of success or failure.
## `Promise.race`
- `Promise.race()` settles when **any** of the promises **settles**. It settles immediately after any of the promises settles regardless of fulfillment or rejection. In other words, the fastest promise wins in `Promise.race`.
```Javascript title='Promise.race example'
Promise.race([
    longRunningTask(),
    userCancellation(),
    systemShutdown()
]).then(() => {
    cleanup(); // Cleanup on ANY completion
});
```
# Async - await
- `async` allows a function to be asynchronously executed and always return a promise.
```Javascript title='async await in Javascript'
async function f() {
  return 1;
}

f().then(alert); // 1
// is equivalent to
async function f() {
  return Promise.resolve(1);
}

f().then(alert); // 1
```
- `await` is only allowed in `async` function. The JavaScript runtime employs a <mark class="hltr-yellow">single-threaded event loop</mark> architecture rather than thread creation. When encountering asynchronous operations, the runtime <mark class="hltr-yellow">delegates these tasks to underlying system APIs</mark> while the <mark class="hltr-yellow">main JavaScript thread continues executing subsequent code</mark>, which is known as *cooperative concurrency*. The runtime manages completion notifications through *callback queues and the event loop*. 
	- The complete runtime environment requires sophisticated *multi-threaded coordination* at the system level to deliver the asynchronous capabilities that modern applications require. For instance, Linux employs `epoll`, MacOS and BSD employ `kqueue`, Windows employs I/O Completion Ports.
```Javascript title='async await in Javascript'
async function f() {

  let promise = new Promise((resolve, reject) => {
    setTimeout(() => resolve("done!"), 1000)
  });

  let result = await promise; // wait until the promise resolves (*)

  alert(result); // "done!"
}
f();
```

# References
1. https://github.com/domenic/promises-unwrapping/blob/master/docs/states-and-fates.md
2. https://javascript.info/promise-basics
3. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
4. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/race for `Promise.race()`.
5. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/any for `Promise.any()`.
6. https://en.wikipedia.org/wiki/Epoll
7. https://en.wikipedia.org/wiki/Kqueue

