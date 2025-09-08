#prototye #object-oriented-programming #javascript #vanilla-javascript #data-type #typescript 

# Object prototype
- Every object in Javascript has a built-in property `prototype`, which is also known as native prototype.
- ![[Pasted image 20250802094816.png]]
- Whenever a new object is instantiated,  its `[[Prototype]]` property is automatically set to `Object.prototype`. All the methods such `toString()` and `constructor` are inherited from the `Object.prototype`.
- ![[Pasted image 20250802095146.png]]
	- The prototype of an object is accesses via `__proto__` property.                    
```Javascript title='Check the prototypal inheritance of Object.prototype'
let obj = {};

alert(obj.__proto__ === Object.prototype); // true

alert(obj.toString === obj.__proto__.toString); //true
alert(obj.toString === Object.prototype.toString); //true
```

# Other built-in prototypes
- Other built-in objects such as `Array`, `Date` and `Function`,... inherit methods from their prototypes.
- For instance, when a literal array of numbers is initialized, the default constructor `new Array()` is internally invoked.
- <svg xmlns="http://www.w3.org/2000/svg" width="692" height="411" viewBox="0 0 692 411"><defs><style>@import url(https://fonts.googleapis.com/css?family=Open+Sans:bold,italic,bolditalic%7CPT+Mono);@font-face{font-family:&apos;PT Mono&apos;;font-weight:700;font-style:normal;src:local(&apos;PT MonoBold&apos;),url(/font/PTMonoBold.woff2) format(&apos;woff2&apos;),url(/font/PTMonoBold.woff) format(&apos;woff&apos;),url(/font/PTMonoBold.ttf) format(&apos;truetype&apos;)}</style></defs><g id="inheritance" fill="none" fill-rule="evenodd" stroke="none" stroke-width="1"><g id="native-prototypes-classes.svg"><path id="Rectangle-1" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M240 93h198v58H240z"/><text id="toString:-function" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="250" y="116">toString: function</tspan> <tspan x="250" y="131">other object methods</tspan></text><text id="Object.prototype" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="239" y="85">Object.prototype</tspan></text><path id="Line-2" fill="#C06334" fill-rule="nonzero" d="M299.5 27.5l7 14h-6v28h-2v-28h-6l7-14z"/><path id="Line-3" fill="#C06334" fill-rule="nonzero" d="M299.5 160.5l7 14h-6v28h-2v-28h-6l7-14z"/><text id="null" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="285" y="16">null</tspan></text><path id="Rectangle-1" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M14 224h198v58H14z"/><text id="slice:-function" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="24" y="247">slice: function</tspan> <tspan x="24" y="262">other array methods</tspan></text><text id="[[Prototype]]" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="66" y="174">[[Prototype]]</tspan></text><text id="[[Prototype]]-Copy-6" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="518" y="175">[[Prototype]]</tspan></text><text id="[[Prototype]]-Copy" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="310" y="187">[[Prototype]]</tspan></text><text id="[[Prototype]]-Copy-2" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="310" y="54">[[Prototype]]</tspan></text><text id="[[Prototype]]" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="310" y="317">[[Prototype]]</tspan></text><text id="[[Prototype]]-Copy-4" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="582" y="317">[[Prototype]]</tspan></text><text id="[[Prototype]]-Copy-5" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="117" y="317">[[Prototype]]</tspan></text><text id="Array.prototype" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="13" y="216">Array.prototype</tspan></text><path id="Rectangle-1" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M243 224h198v58H243z"/><text id="call:-function-other" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="253" y="247">call: function</tspan> <tspan x="253" y="262">other function methods</tspan></text><text id="Function.prototype" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="242" y="216">Function.prototype</tspan></text><path id="Rectangle-1" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M474 224h198v58H474z"/><text id="toFixed:-function" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="484" y="247">toFixed: function</tspan> <tspan x="484" y="262">other number methods</tspan></text><text id="Number.prototype" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="473" y="216">Number.prototype</tspan></text><path id="Line" fill="#C06334" fill-rule="nonzero" d="M204.855 157.011l15.645.489-9.778 12.223-2.515-5.448-65.288 30.133-.908.419-.838-1.816.908-.419 65.288-30.133-2.514-5.448zM478.147 157.088l-2.542 5.435 64.319 30.071.905.424-.847 1.811-.906-.423-64.318-30.071-2.54 5.436L462.5 157.5l15.647-.412z"/><path id="Rectangle-5" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M48 339h117v23H48z"/><text id="[1,-2,-3]" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="71" y="354">[1, 2, 3]</tspan></text><path id="Rectangle-6" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M243 339h198v65H243z"/><text id="function-f(args)-{" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="264" y="358">function f(args) {</tspan> <tspan x="264" y="373"> ...</tspan> <tspan x="264" y="388">}</tspan></text><path id="Rectangle-7" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M541 339h69v23h-69z"/><text id="5" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="573" y="355">5</tspan></text><path id="Line-4" fill="#C06334" fill-rule="nonzero" d="M299.5 290.5l7 14h-6v28h-2v-28h-6l7-14z"/><path id="Line-5" fill="#C06334" fill-rule="nonzero" d="M576.5 290.5l7 14h-6v28h-2v-28h-6l7-14z"/><path id="Line-6" fill="#C06334" fill-rule="nonzero" d="M106.5 290.5l7 14h-6v28h-2v-28h-6l7-14z"/></g></g></svg>
```Javascript title='Inheritance of array built-in prototype'
let arr = [1, 2, 3];

// it inherits from Array.prototype?
alert( arr.__proto__ === Array.prototype ); // true

// then from Object.prototype?
alert( arr.__proto__.__proto__ === Object.prototype ); // true

// and null on the top.
alert( arr.__proto__.__proto__.__proto__ ); // null
```
- If two methods in a prototype chain overlap, the variant's definition which is closer in the chain is employed.
- <svg xmlns="http://www.w3.org/2000/svg" width="209" height="316" viewBox="0 0 209 316"><defs><style>@import url(https://fonts.googleapis.com/css?family=Open+Sans:bold,italic,bolditalic%7CPT+Mono);@font-face{font-family:&apos;PT Mono&apos;;font-weight:700;font-style:normal;src:local(&apos;PT MonoBold&apos;),url(/font/PTMonoBold.woff2) format(&apos;woff2&apos;),url(/font/PTMonoBold.woff) format(&apos;woff&apos;),url(/font/PTMonoBold.ttf) format(&apos;truetype&apos;)}</style></defs><g id="inheritance" fill="none" fill-rule="evenodd" stroke="none" stroke-width="1"><g id="native-prototypes-array-tostring.svg"><path id="Rectangle-1" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M17 156h168v58H17z"/><text id="toString:-function" font-family="PTMono-Bold, PT Mono" font-size="14" font-weight="bold"><tspan x="27" y="179" fill="#C06334">toString: function</tspan> <tspan x="27" y="194" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-weight="normal">...</tspan></text><text id="Array.prototype" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="16" y="148">Array.prototype</tspan></text><path id="Rectangle-1" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M17 23h168v58H17z"/><text id="toString:-function" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="27" y="46">toString: function</tspan> <tspan x="27" y="61">...</tspan></text><text id="Object.prototype" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="16" y="15">Object.prototype</tspan></text><path id="Rectangle-1" fill="#FBF2EC" stroke="#DBAF88" stroke-width="2" d="M17 273h168v28H17z"/><path id="Line" fill="#C06334" fill-rule="nonzero" d="M76.5 222.5l7 14h-6v28h-2v-28h-6l7-14z"/><text id="[[Prototype]]" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="86" y="244">[[Prototype]]</tspan></text><path id="Line-2" fill="#C06334" fill-rule="nonzero" d="M76.5 90.5l7 14h-6v28h-2v-28h-6l7-14z"/><text id="[[Prototype]]" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="86" y="112">[[Prototype]]</tspan></text><text id="[1,-2,-3]" fill="#AF6E24" font-family="PTMono-Regular, PT Mono" font-size="14" font-weight="normal"><tspan x="41" y="291">[1, 2, 3]</tspan></text></g></g></svg>
# Primitive prototypes
- Primitives are not objects but behave as as if they do. When properties are accessed on primitives, JavaScript _auto-boxes_ the value into a <mark class="hltr-yellow">wrapper object</mark> and accesses the property on that object instead.
```Javascript title='Primitive data type are implicitly wrapped into a temporary object'
let s = 'Hello World';
s.includes('Hello'); // equivalent to String.prototype.includes('Hello');
```
# Changing native prototypes
- Native prototype can be re-written to add new functionalities., especially in polyfilling.
```Javascript title='Add functionality to Promise prototype'
const { limitFunction } = require('p-limit');
module.exports = promiseUtils;

function promiseUtils(app) {

    const MAX_PROMISE_CONCURRENCY_DEGREE = 50;
    /**
     * 
     * @param {Array<Object>} [items]
     * @param {(Object) => Promise<Object>} itemToPromiseMapFunction
     * @param {Number} [degree] 
     * @returns {Promise<Array<Object>>}
     */
    Promise.allWithLimit = function (items = [], itemToPromiseMapFunction, degree = MAX_PROMISE_CONCURRENCY_DEGREE) {
        const limitedFunction = limitFunction(itemToPromiseMapFunction, { concurrency: degree });
        return Promise.all(Array.from(items, limitedFunction));
    };

    /**
     * 
     * @param {Array<Object>} [items]
     * @param {(Object) => Promise<Object>} itemToPromiseMapFunction
     * @param {Number} [degree] 
     * @returns {Promise<Array<{status: string, value: Object}>>}
     */
    Promise.allSettledWithLimit = function (items = [], itemToPromiseMapFunction, degree = MAX_PROMISE_CONCURRENCY_DEGREE) {
        const limitedFunction = limitFunction(itemToPromiseMapFunction, { concurrency: degree });
        return Promise.allSettled(Array.from(items, limitedFunction));
    };

    Promise.CONCURRENCY_DEGREE = MAX_PROMISE_CONCURRENCY_DEGREE;
}
```
---
# References
1. https://javascript.info/native-prototypes for Native prototype in Javascript.
2. [[Prototypal inheritance]] for Prototypal inheritance In Javascript.
3. [[Polyfills and transpilers]]
4. [[Object]]
5. 