#rxjs #reactive-programming #ajax #design-pattern #software-engineering #software-architecture #javascript #typescript #generator #behavioral-pattern #functional-programming #high-order-function 
# Concepts
- Observables are lazy <mark style="background: #e4e62d;">Push generators</mark> of multiple values:
	- Promises are Push <mark style="background: #ABF7F7A6;">generators</mark> of a single value.
	- <mark style="background: #e4e62d;">lazily executed</mark> $\equiv$ does <mark style="background: #ABF7F7A6;">not run callback until an Observer subscribe</mark>s to it.
- Observables are the generalization of function with zero arguments.
# Behavior
## Initialize Observable
- Define a common callback that will be executed by all of its subscribers (similarly to how a Subject notifies all of its Observers [Observer pattern](software-engineering/software-architecture/design-pattern/fundamentals/behavioral-pattern/Observer%20pattern.md)).
```javascript
import { Observable } from 'rxjs';

const foo = new Observable((subscriber) => {
  console.log('Hello');
  subscriber.next(42);  // generate a value for the observer's callback below
  subscriber.next(100); // happen synchronously
  subscriber.next(200); // happen synchronously
  setTimeout(() => {
    subscriber.next(300); // happens asynchronously
  }, 1000);
  subscriber.next(500);
});

console.log('before');
foo.subscribe((x) => {
  console.log(x);
});
console.log('after');
```

- The callback has to generate values to the subscriber by using `next` method.
## Execute Observable
- The execution <mark style="background: #e4e62d;">generates multiple values</mark> over time, either synchronously or asynchronously.
- There are 3 types of notifications generated:
	- Next notification $\implies$ continue generating or transit to Complete.
	- Error notification $\implies$ abnormally stop generating.
	- Complete notification $\implies$ normally stop generating.
## Subscribe Observable
- Each `Observable` object can make an Observer subscribe to it by calling `subscribe` method and passing the Observer callback. Each Observer has its own logic and similarly to `update` method in Observer pattern.
- Whenever the `subscribe` method is called, it means that the `Observable` will be <mark style="background: #e4e62d;">immediately executed</mark>.
## Unsubcribe Observable
- Manually stops the execution of Observable.
- Used to prevent infinite generation of Observable.
- Define and return `unsubscribe` method which returns a callback. That <mark style="background: #e4e62d;">callback will be invoked</mark> in the future whenever we want to dispose the subscription.
```javascript title='Unsubcribe an observable'
import { Observable } from "rxjs";

const observable = new Observable((subscriber) => {

	// Keep track of the interval resource
	const intervalId = setInterval(() => {
		subscriber.next("hi");
	}, 2000);

	// Provide a way of canceling and disposing the interval resource
	return function unsubscribe() {
		clearInterval(intervalId);
	};
});

const subscription = observable.subscribe({

	next(msg) {
		console.log(msg);
	}

});

setTimeout(() => {
	subscription.unsubscribe();
}, 10000);
```
---
# References
1. [Push protocol vs Pull protocol](Push%20protocol%20vs%20Pull%20protocol.md) .
2. [Generator](Generator.md) for generator concepts.
3. [Observer pattern](software-engineering/software-architecture/design-pattern/fundamentals/behavioral-pattern/Observer%20pattern.md) for observer pattern.
4. https://rxjs.dev/guide/observable
5. [RxJs](RxJs.md)
6. 