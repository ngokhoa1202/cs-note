#javascript #software-architecture #software-engineering #operating-system #nodejs #browser #thread #process #browser 
# Javascript engine and host environment
- The execution of Javascript requires the cooperation of *Javascript engine* and the *host environment*.
- The Javascript engine implements the ECMAScript language specification, providing the core functionality. While the host environment provides external resources, implements security- or performance-related mechanisms.
- For example, the *HTML DOM* is the host environment when JavaScript is executed in a *web browser*. *Node.js* is another host environment that allows JavaScript to be run on the *server side*.
# Agent execution model
- An agent is an autonomous executor of Javascript. Each agent maintains its facilities for code execution.
- Each agent is practically a thread:
	- In Web browser, the main thread is one agent and each web worker has its own agent. Agents are almost always <mark class="hltr-yellow">mapped to native threads</mark> in the browser’s process.
	- In Node.js the main event loop is one agent. Each worker thread creates one agent. Each agent ends being <mark class="hltr-yellow">mapped into an OS thread</mark>, scheduled by the kernel.
- Each agent can have multiple *realms* that can synchronously access each other, and thus needs to run in a single execution thread.
- In Web browser, each worker creates its own agent, while one or more windows may be within the same agent—usually a main document and its similar-origin `iframes`.
- ![A diagram consisting of two agents: one HTML page and one worker. Each has its own stack containing execution contexts, heap containing objects, and queue containing jobs.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Execution_model/runtime-environment-diagram.svg)
## Heap
- Heap becomes populated as objects are instantiated in the program.
- in the case of shared memory, each agent has its own heap with its own version of a `SharedArrayBuffer`object, but the underlying memory represented by the buffer is shared.
## Job queue
- Also known as the *event loop*.
- Job queue allows the execution of Javascript to be asynchronous while the language is single-threaded.
- The queue scheduling policy is FIFO.
- [[Browser Job queue]]
## Execution context stack
- Also known as the *call stack*.
- The stack of execution context allows *transferring control flow* by entering and exiting execution contexts like functions.
- Every job enters by pushing a new frame onto the stack, and exits by popping the stack.
# Realm
- A realm is an independent global environment for Javascript execution, consists of:
	- A list of intrinsic objects like `Array`, `Array.prototype`, etc.
	- Globally declared variables, the value of `globalThis`, and the global object.
	- A cache of template literal arrays.
- On the web, a realm is equivalent to a global object.
***
# References
1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Execution_model#stack_and_execution_contexts for Javascript execution model.
2. https://262.ecma-international.org/16.0/index.html for ECMAScript 262 Specification.
3. https://nodejs.org/docs/latest-v22.x/api/worker_threads.html for Worker threads in Node.js 22.
4. [[Browser Job queue]] 
5. [[programming/javascript/node.js/architecture/Event loop]] for Node.js event loop.
6. [[operating-system/unix/linux/process-management/Process]]
7. 