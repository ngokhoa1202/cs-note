#software-engineering #software-architecture #operating-system #nodejs #javascript #process #thread #data-structure #secondary-storage #libuv #concurrency-control 

# Event loop
- The event loop is what allows Node.js to *perform <mark class="hltr-yellow">non-blocking</mark> I/O operations* by offloading operations to the system kernel whenever possible.
```sh title='Event loop in Node.js'
   ┌───────────────────────────┐
┌─>│           timers          │
│  └─────────────┬─────────────┘
│  ┌─────────────┴─────────────┐
│  │     pending callbacks     │
│  └─────────────┬─────────────┘
│  ┌─────────────┴─────────────┐
│  │       idle, prepare       │
│  └─────────────┬─────────────┘      ┌───────────────┐
│  ┌─────────────┴─────────────┐      │   incoming:   │
│  │           poll            │<─────┤  connections, │
│  └─────────────┬─────────────┘      │   data, etc.  │
│  ┌─────────────┴─────────────┐      └───────────────┘
│  │           check           │
│  └─────────────┬─────────────┘
│  ┌─────────────┴─────────────┐
└──┤      close callbacks      │
   └───────────────────────────┘
```
- Each phase has a *FIFO queue of callbacks* to execute. 
- When the event loop enters a given phase, it will perform any operations specific to that phase, then execute callbacks in that phase's queue until the queue has been exhausted or the maximum number of callbacks has executed.
- When the queue has been exhausted or the callback limit is reached, the event loop will move to the next phase, and so on.
## Timers
- This phase executes callbacks scheduled by `setTimeout()` and `setInterval()`.
- A timer specifies the <mark class="hltr-yellow">threshold</mark> after which a provided callback <mark class="hltr-yellow">may be executed</mark> *rather than the exact time* it is expected to be executed.
- Timers callbacks will run *as early as they can be scheduled* after the specified amount of time has passed; however, Operating System scheduling or the running of other callbacks may delay them.
```JavaScript title='Timer phase example in Node.js'
const fs = require('node:fs');

function someAsyncOperation(callback) {
  // Assume this takes 95ms to complete
  fs.readFile('/path/to/file', callback);
}

const timeoutScheduled = Date.now();

setTimeout(() => {
  const delay = Date.now() - timeoutScheduled; // should be 105ms

  console.log(`${delay}ms have passed since I was scheduled`);
}, 100);

// do someAsyncOperation which takes 95 ms to complete
someAsyncOperation(() => {
  const startCallback = Date.now();

  // do something that will take 10ms...
  while (Date.now() - startCallback < 10) {
    // do nothing
  }
});
```

> [!info] Explanation
> When the event loop enters the poll phase, it has an empty queue because`fs.readFile()` has not completed, so it will *wait* for the number of ms remaining *until the soonest timer's threshold* is reached. While it is waiting 95 ms pass, `fs.readFile()` finishes reading the file and the execution of its following callback which takes 10 ms to complete is added to the poll queue and executed.
> 
> When the callback finishes, there are no more callbacks in the queue, so the event loop will see that the threshold of the soonest timer has been reached, then wrap back to the timers phase to execute the timer's callback.
> 
> In summary, the total delay between the timer and the moment of callback execution is 105ms.
- The poll phase controls *when* timers are executed.
## Pending callbacks phase
- This phase executes callbacks for some system operations such as types of TCP errors. 
	- For example if a TCP socket receives `ECONNREFUSED` when attempting to connect, some Unix systems want to wait to report the error. This will be queued to execute in the *pending callbacks* phase.
```JavaScript title='TCP ECONNREFUSED on a dead port'
const net = require('node:net');

const sock = net.connect(65535, '127.0.0.1'); // very likely no server listening
sock.on('connect', () => console.log('connected (unexpected)'));
sock.on('error', (err) => {
  console.log('error event:', err.code); // typically ECONNREFUSED
});
```
## Poll phase
- The poll phase determines *how long* it should block and *poll for I/O operations* and then, *processes events* in the poll queue.
- When the event loop enters the poll phase _and there are no timers scheduled_, one of two things will happen:
	- If the poll queue is not empty, the event loop will iterate through its queue of callbacks executing them synchronously until the queue becomes exhausted or the system threshold has been reached.
	- If the poll queue is empty, one of two more things will happen:
		- If scripts have been scheduled by `setImmediate()`, the event loop will end the poll phase and enter the check phase to execute these scripts.
		- Otherwise, the event loop will wait for callbacks to be enqueued, then execute them immediately.
- Once the poll queue is empty, the event loop will check for timers _whose time thresholds have been reached_. If one or more timers are ready, the event loop will wrap back to the timers phase to execute those timers' callbacks.
## Check phase
- This phase allows the event loop to execute callbacks immediately after the poll phase.  In case If the poll phase is idle and scripts have been queued with `setImmediate()`, the event loop may *continue to the check phase* rather than waiting.
- `setImmediate()` is actually a special timer that runs in a *separate phase* of the event loop. It uses a `libuv` API that schedules callbacks to execute after the poll phase has completed.
## Close callbacks phase
- If a socket or handle is closed abruptly (e.g. `socket.destroy()`), the `'close'` event will be emitted in this phase. Otherwise it will be emitted via `process.nextTick()` and this phase is skipped.
```Javascript title='Example of close callbacks phase'
const fs = require('node:fs');

const r = fs.createReadStream(__filename);
r.on('close', () => console.log('stream close (abrupt -> close phase)'));

setImmediate(() => console.log('setImmediate (check phase before close)'));
setTimeout(() => console.log('setTimeout (next tick)'), 0);

// Abruptly tear down the stream -> triggers close in the close-callbacks phase
r.destroy(new Error('boom'));
```

# API explanation
## `setImmediate()` and `setTimeout()`

- `setImmediate()` executes scripts once the current poll phase finishes.
- `setTimeout()` schedules scripts to be run after a minimum threshold in ms has elapsed.
- If both of them are executed CPU-bound tasks, the order of execution is non-deterministic.
```Javascript title='The order of execution of setImmediate and setTimeout is unknown in CPU-bound task'
setTimeout(() => {
  console.log('timeout');
}, 0);

setImmediate(() => {
  console.log('immediate');
});

/*
First call:
timeout
immediate
*/

/* 
Second call:
immediate
timeout
*/
```
- If the calls occur within I/O-bound tasks, the immediate callback is always executed first. 
```Javascript title='immediate callback is always run first in I/O cycles'
// timeout_vs_immediate.js
const fs = require('node:fs');

fs.readFile(__filename, () => {
  setTimeout(() => {
    console.log('timeout');
  }, 0);
  setImmediate(() => {
    console.log('immediate');
  });
});

// For every call
// immediate
// timeout
```
## `process.nextTick()`
- `process.nextTick()` always resolves its argument callback before the event loop continues. It is fired immediately in the same phase. 
```Javascript title='The API call is still synchronous without process.nextTick'
let bar = null;

// this has an asynchronous signature, but calls callback synchronously
function someAsyncApiCall(callback) {
  callback();
}

// the callback is called before `someAsyncApiCall` completes.
someAsyncApiCall(() => {
  // since someAsyncApiCall hasn't completed, bar hasn't been assigned any value
  console.log('bar', bar); // null
});

bar = 1;
```

> [!example] 
> The user defines `someAsyncApiCall()` to have an asynchronous signature, but it *actually operates synchronously*. When it is called, the callback provided to `someAsyncApiCall()` is called in the same phase of the event loop because `someAsyncApiCall()` doesn't actually do anything asynchronously. As a result, the callback tries to reference `bar` even though it may not have that variable in scope yet, because the script has not been able to run to completion.


```JavaScript title='process.nexTick() asynchronously executes the callback before the current phase of the event loop continues'
let bar = null;

function someAsyncApiCall(callback) {
  process.nextTick(callback);
}

someAsyncApiCall(() => {
  console.log('bar', bar); // 1
});

bar = 1;
```
## `process.nextTick()` and `setImmediate()`
- `process.nextTick()` fires immediately on the same phase while `setImmediate()` fires on the following iteration or 'tick' of the event loop.
```JavaScript title='Wrong use of event emitter without process.nextTick()'
const EventEmitter = require('node:events');

class MyEmitter extends EventEmitter {
  constructor() {
    super();
    // the scripts in line 12 have not been proccessed so this results in misbehavior
    this.emit('event');
  }
}

const myEmitter = new MyEmitter();
myEmitter.on('event', () => {
  console.log('an event occurred!');
});
```

```JavaScript title='Employ process.nextTick() to add asynchronous behavior to the emit event'
const EventEmitter = require('node:events');

class MyEmitter extends EventEmitter {
  constructor() {
    super();

    // use nextTick to emit the event once a handler is assigned
    process.nextTick(() => {
      this.emit('event');
    });
  }
}

const myEmitter = new MyEmitter();
myEmitter.on('event', () => {
  console.log('an event occurred!');
});

```
---
# References
1. https://nodejs.org/en/learn/asynchronous-work/event-loop-timers-and-nexttick
2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Execution_model#stack_and_execution_contexts
3. https://docs.libuv.org/en/v1.x/design.html for `libuv` library which implements Node.js event loop.
4. https://learn.microsoft.com/en-in/answers/questions/1791963/what-is-the-purpose-of-process-nexttick()-in-node for `process.nextTick()` use case.