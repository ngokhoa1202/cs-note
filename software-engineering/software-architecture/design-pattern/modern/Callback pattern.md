#design-pattern #nodejs #java #functional-programming #high-order-function #reactive-programming #software-engineering #software-architecture

- A callback, also known as a "call-after" function, is _any executable code that is passed as an argument to other code_; that other code is expected to call back (execute) the argument at a given time.
- A callback is a high-order function.
# Purpose
- Maintain the correct order of execution of asynchronous operations.
# Application
- Handling non-blocking operations, such as reading files, making HTTP requests, or querying a database.
- Event handling in user interfaces, for example, responding to user actions like clicks or key presses.
- Decoupling modules or components that need to interact without having a direct dependency on each other.
# Components
## Caller
- The function that takes the callback as an argument and invokes it at the appropriate time.
## Callback
- The function that is passed as an argument to the caller and is executed when the caller decides.
## Context
- The scope in which the callback function is executed, which can affect its behavior and access to variables.
## Error handler
- Another callback function used to handle if there is any error.

# Example
- ![](Pasted%20image%2020250227075559.png)
- `interface Callback` is the common interface for callback function.
```Java title='interface Callback'

package com.iluwatar.callback;

/**
 * Callback interface.
 */
public interface Callback {

  void call();
}

```

- `class Task` is both the abstract caller and callee delegating `execute` action to its children and will execute the callback when the task is finished.
```Java title='Super class to maintain the execution order of callbacks'
public abstract class Task {

    final void executeWith(Callback callback) {
        execute();
        Optional.ofNullable(callback).ifPresent(Callback::call);
    }

    public abstract void execute();
}
```
- `class SimpleTask` is the concrete caller and callee implementing `execute` action on its own.
```Java title='Concrete caller and callee'
@Slf4j
public final class SimpleTask extends Task {

    @Override
    public void execute() {
        LOGGER.info("Perform some important activity and after call the callback method.");
    }
}
```

- `class Main` is the Client in which a task is executed with its callback.
```Java title='Context class'
@Slf4j
public final class App {

  private App() {
  }

  /**
   * Program entry point.
   */
  public static void main(final String[] args) {
    var task = new SimpleTask();
    task.executeWith(() -> LOGGER.info("I'm done now."));
  }
}
```
# Real example
- `Promise` API in JavaScript.
- Most of asynchronous API in Node.js
- `Stream` API from Java 8.
# Benefits
- Facilitates asynchronous operations and reactive programming.
- Decouples the execution login from the task of signaling and notification.
# Trade-offs
- The overuse of callback results in callback hell or pyramid of doom.
```JavaScript title='Callback hell in JavaScript'
fs.readdir(source, function (err, files) {
  if (err) {
    console.log('Error finding files: ' + err)
  } else {
    files.forEach(function (filename, fileIndex) {
      console.log(filename)
      gm(source + filename).size(function (err, values) {
        if (err) {
          console.log('Error identifying file size: ' + err)
        } else {
          console.log(filename + ' : ' + values)
          aspect = (values.width / values.height)
          widths.forEach(function (width, widthIndex) {
            height = Math.round(width / aspect)
            console.log('resizing ' + filename + 'to ' + height + 'x' + height)
            this.resize(width, height).write(dest + 'w' + width + '_' + filename, function(err) {
              if (err) console.log('Error writing file: ' + err)
            })
          }.bind(this))
        }
      })
    })
  }
})
```
# References

1. [Promise](programming/javascript/vanilla-javascript/fundamentals/promise/Promise.md) for Promise API.
2. https://java-design-patterns.com/patterns/callback/#programmatic-example-of-callback-pattern-in-java for callback pattern.
