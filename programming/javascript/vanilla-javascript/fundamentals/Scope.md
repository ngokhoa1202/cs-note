#vanilla-javascript #javascript #compilation #abstract-syntax-tree #interpreter #ecmascript #scope 
#typescript 
# Global scope
- Global scope is default for all code running in <mark style="background: #e4e62d;">script mode</mark>.
# Module scope
- Module scope refers to the importation and exportation of a variable or a function in Javascript.
# Function scope
- Also generally known as block scope.
- Block scope is defined by a block declaration.
- Block scope only applies for variable with `{javascript} let` or `{javascript} const` declaration, but not with `var` declaration because of <mark style="background: #e4e62d;">variable hoisting</mark> mechanism.
```javascript title=''
type Environment = {
	OS: string;
	distro: string;
	version: string;
	[key: string]: string;
}

// successfully compiled
if (true) {
	var fedora: Environment = {
		OS: "Fedora Linux",
		distro: "Fedora",
		version: "41"
	}
}

console.log(fedora);
```
- Function declaration is also hoisted if necessary.
```javascript
train();
function train() {
  // do something
}
```
# References
1. https://developer.mozilla.org/en-US/docs/Glossary/Scope for official documentation about scope.
2. ECMAScript ® 2020 Language Specification - 11th June, 2020.
3. https://developer.mozilla.org/en-US/docs/Glossary/Hoisting for var hoisting.