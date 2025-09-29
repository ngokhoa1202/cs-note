#nodejs #javascript #vanilla-javascript #concurrency-control #thread #process #nodejs #process-synchronization #software-engineering #software-architecture 

- Given multiple asynchronous tasks to be execute, the schedule of execution of promises can be customized with [[Promise#Promise concurrency]] API provided by JavaScript.
```JavaScript title='Asynchronous tasks to be executed'
// Async task -> Promise-based
const asyncTask = (arg) =>
  new Promise((resolve) => {
    console.log(`do something with '${arg}', return 1 sec later`);
    setTimeout(() => resolve(arg * 2), 1000);
  });

const items = [1, 2, 3, 4, 5, 6];
```
# Sequential execution of promises
## Implementation
```JavaScript title='Sequential execution of promises'
/* 1) Sequential (series) — processes one-by-one */
const series = (xs) =>
  xs.reduce(
    (pAcc, x) =>
      pAcc.then(async (acc) => {
        const r = await asyncTask(x);
        return [...acc, r]; // immutable append
      }),
    Promise.resolve([])
  );

series(items).then((results) => console.log('Done (series)', results));
```
## Characteristics
- All promises are sequentially executed, which results in blocking operations and long I/O waiting.
- There is no need for final callback because only a promise is allowed to be execute.
# Fully parallel execution of promises
## Implementation
```JavaScript title='Promises are fully parallel executed'
/* 2) Fully parallel — all at once (no ordering guarantees except join order) */
const parallel = (xs) => Promise.all(xs.map(asyncTask));

parallel(items).then((results) => console.log('Done (parallel)', results));

// Promise [worker0, worker1, ..., workerN-1]
```
## Characteristics
- All promises are asynchronously executed without blocking. The degree of concurrency reaches maximum.
- The order of promise resolution or rejection is not guaranteed as it depends on the system level.
# Limited parallel execution of promises
## Implementation
```JavaScript title='Promises are patially parallel executed'
/* 3) Limited concurrency — run at most `limit` tasks at a time */
const withConcurrency = (xs, limit, fn) => {
  const results = new Array(xs.length); // stable result order
  let nextIndex = 0;

  const worker = async () => {
    while (nextIndex < xs.length) {
      const i = nextIndex++;
      results[i] = await fn(xs[i]);
    }
  };

  // spawn `limit` workers
  return Promise.all(Array.from({ length: Math.min(limit, xs.length) }, worker))
    .then(() => results);
};

withConcurrency(items, 2, asyncTask).then((results) =>
  console.log('Done (concurrency=2)', results)
);
/*
Promises [worker0, worker1]
*/
```
## Characteristics
- Only a limited number of promises are parallel executed at a time. The degree of concurrency is limited.
- The order of promise  resolution or rejection is not guaranteed as it depends on the system level.
---
# References
1. https://book.mixu.net/node/ch7.html for Concurrency control in Node.js without library.
2. https://github.com/sindresorhus/p-limit for `pLimit` library for concurrency control in Node.js
3. 