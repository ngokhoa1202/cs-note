#javascript #software-architecture #software-engineering #operating-system #nodejs #browser #thread #process #browser #data-structure #event-driven-programming 

# Macro-task queue
- A task, or macro-task is *callback* which is *scheduled* to be run by the standard mechanisms such as *initially starting to run a program*, an *event* being dispatched asynchronously, or an *interval* or *timeout* being fired. These tasks are scheduled on the task queue.
- For example, tasks is added to the task queue when:
	- A new JavaScript program or subprogram is executed (such as from a console, or by running the code in a `<script>`element directly).
	- The user clicks an element. A task is then created and executes all event callbacks.
	- A timeout or interval created with `setTimeout()` or `setInterval()`is reached, causing the corresponding callback to be added to the task queue.
- <svg xmlns="http://www.w3.org/2000/svg" width="500" height="279" viewBox="0 0 500 279"><defs><style>@import url(https://fonts.googleapis.com/css?family=Open+Sans:bold,italic,bolditalic%7CPT+Mono);@font-face{font-family:&apos;PT Mono&apos;;font-weight:700;font-style:normal;src:local(&apos;PT MonoBold&apos;),url(/font/PTMonoBold.woff2) format(&apos;woff2&apos;),url(/font/PTMonoBold.woff) format(&apos;woff&apos;),url(/font/PTMonoBold.ttf) format(&apos;truetype&apos;)}</style></defs><g id="promise" fill="none" fill-rule="evenodd" stroke="none" stroke-width="1"><g id="eventLoop.svg"><path id="Rectangle-1-Copy-5" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M218 173h108v28H218z"/><text id="..." fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="258.9" y="189">...</tspan></text><path id="Rectangle-1-Copy-6" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M218 90h108v28H218z"/><path id="Rectangle-1-Copy-8" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M218 117h108v28H218z"/><text id="mousemove" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="233.7" y="136">mousemove</tspan></text><path id="Rectangle-1-Copy-9" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M218 145h108v28H218z"/><text id="script" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="246.8" y="109">script</tspan></text><text id="event-loop" fill="#C06334" font-family="OpenSans-Regular, Open Sans" font-size="24" font-weight="normal"><tspan x="76.422" y="134">event</tspan> <tspan x="82.615" y="167">loop</tspan></text><text id="macrotask-queue" fill="#AF6E24" font-family="OpenSans-Regular, Open Sans" font-size="24" font-weight="normal"><tspan x="348.371" y="136">macrotask</tspan> <tspan x="371.451" y="169">queue</tspan></text><path id="Path" fill="#C06334" fill-rule="nonzero" d="M192 40c22.467 0 43.818 7.359 61.285 20.712l.622.479.143.122 8.961 8.422-4.584-14.61 3.817-1.197 6.869 21.895 1.064 3.392-3.452-.852-22.278-5.5.959-3.883 14.864 3.669-8.886-8.352-.55-.424c-16.564-12.656-36.757-19.698-58.036-19.87L192 44c-30.748 0-59.095 14.403-77.315 38.412l-.549.73-3.208-2.387C129.87 55.303 159.664 40 192 40z"/><path id="Path-Copy-2" fill="#C06334" fill-rule="nonzero" d="M269.882 208.148l2.823 2.834-.366.365a533.245 533.245 0 00-3.982 4.033l-.333.34c-9.922 10.12-14.79 14.544-22.017 19.272-15.185 9.934-34.01 15.688-51.594 15.688-25.222 0-47.144-6.827-64.077-19.673l-.589-.45-.089-.07-.08-.078-8.854-8.581 4.36 14.68-3.835 1.138-6.532-21.998-1.012-3.409 3.439.906 22.19 5.841-1.018 3.868-14.808-3.898 8.766 8.497.488.374c16.02 12.15 36.782 18.698 60.792 18.85l.859.003c16.796 0 34.862-5.522 49.404-15.035 6.911-4.521 11.624-8.806 21.35-18.725l.334-.34a633.126 633.126 0 013.46-3.511l.736-.736.185-.185z"/><text id="setTimeout" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="230" y="164">setTimeout</tspan></text></g></g></svg>
- The macro-task execution policy is FIFO. The *oldest* runnable task in the task queue will be executed during a single iteration of the event loop. The oldest runnable task in the task queue will be executed during a single iteration of the event loop.  After that, micro-tasks will be executed until the micro-task queue is empty, and then the browser may choose to update rendering. Then the browser moves on to the next iteration of event loop.
- Rendering *never happens while the engine executes a task* in spite of how long the task takes to finish. Changes to the DOM are painted *only after* the task is complete.
- If a task takes too long, the browser is <mark class="hltr-yellow">being blocked from executing other tasks</mark> such handling user events. So after some time, it raises an alert like “Page Unresponsive”, suggesting killing the task with the whole page. That occurs when there are a lot of complex calculations or a programming error leading to an infinite loop.
# Micro-task queue
- Micro-tasks are callbacks executed as `Promise` handlers such as `.then`, `catch` and `finally`.
- When a promise is ready, its handlers are enqueued into micro-task queue (also known as `PromiseJobs` queue). It is, nevertheless, not until the JavaScript engine is free from current macro-task that these handlers are taken from the queue and executed.
```JavaScript title='Micro-tasks example'
let promise = Promise.resolve();

promise.then(() => alert("promise done!"));

alert("code finished"); // this alert shows first
```
## Unhandled rejections
- An unhandled rejection is a promise error is not handled at the end of the micro-task queue. See [[Promise#Error handler]]
- If the `.catch` is not chained immediately in the first creation of the Promise, the error thrown during the execution of that promise may not properly handled.
```JavaScript title='Promise rejection should be handled in the .catch handler of the Promise creation'
let promise = Promise.reject(new Error("Promise Failed!"));
setTimeout(() => promise.catch(err => alert('caught')), 1000); // Since the Promise is eagerly executed, the error may have been thrown and the promise.catch inside setTimeout callback may not work

// Error: Promise Failed!
window.addEventListener('unhandledrejection', event => alert(event.reason));
```
# Job queue behavior
- Each time a task exits, the event loop checks to see if the task is returning control to other JavaScript code. If not, it runs all of the micro-tasks in the micro-task queue. The micro-task queue is, then, processed *multiple times per iteration of the event loop*, including after handling events and other callbacks.
- If a micro-task adds more micro-tasks to the queue by calling `queueMicrotask()` those newly-added micro-tasks _execute before the next task is run_. That's because the event loop will keep calling micro-tasks until there are none left in the queue, even if more keep getting added.
## Example
```JavaScript title='Job queue behavior example'
Promise.resolve().then(() => console.log(1))

setTimeout(() => console.log(2), 1000)

queueMicrotask(() => {
  console.log(3)
  queueMicrotask(() => {
    console.log(4)
    queueMicrotask(() => console.log(8))
  })
})

console.log(5)

// Result: 5 1 3 4 8 2
```
# Application
## Progress indicator
- Without `setTimeout` the browser takes substantially long time to execute the code and the user experience poor responsiveness.
```HTML title='index.html'
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="script.js" defer></script>
  <title>Document</title>
</head>

<body>
  <h1>This is a testing page for Javascript</h1>
  <div id="progress"></div>
</body>

</html>
```

```JavaScript title='script.js: For loop blocks JavaScript engine from rendering'

const progress = document.getElementById("progress")
function count() {
  console.log("Hello")
  for (let i = 0; i < 1e6; i++) {
    i++;
    progress.innerText = i;
  }
}

count();
```

- With `setTimeout()`, the callback is consecutively added to the macro-task queue for every multiple of 1000 until it reaches 10000000. As a result, the user is constantly informed about the progress.
```JavaScript title='setTimeout adds callbacks to the macro-task for execution after every do-while loop'

const progress = document.getElementById("progress")

let i = 0;

function count() {

  // do a piece of the heavy job (*)
  do {
    i++;
    progress.innerHTML = i;
  } while (i % 1e3 != 0);

  if (i < 1e7) {
    setTimeout(count);
  }

}
count()
```
---
# References
1. https://javascript.info/microtask-queue
2. https://www.youtube.com/watch?v=cCOL7MC4Pl0
3. [[Promise]]
4. https://developer.mozilla.org/en-US/docs/Web/API/HTML_DOM_API/Microtask_guide
5. https://javascript.info/event-loop
6. https://www.youtube.com/watch?v=eiC58R16hb8 for Job queue visualization.