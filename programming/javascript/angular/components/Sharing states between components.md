#angular #angular17 #angular18 #annotation #javascript #typescript #design-pattern #object-oriented-programming 
#functional-programming 
#structural-pattern #software-engineering #software-architecture #html 

# Input
## Input decorator
### Purpose
- Bind the property of a component to a HTML attribute value.
- Pass the property from the parent to its children.
### Usage
- For child component:
	- Declare a property and <mark style="background: #e4e62d;">decorate</mark> it with `@Input` decorator.
- For parent component:
	- Pass the property to its children by <mark style="background: #e4e62d;">specifying HTML attribute</mark>.

# Output
## Output decorator
### Purpose
- Emit child's state to parent component.
### Usage
- For child component:
	- Declare an `EventEmitter` property nesting the emitted property type and <mark style="background: #e4e62d;">decorate</mark> it with `@Output()` decorator.
	- Declare and bind an event to <mark style="background: #e4e62d;">emit</mark> the property in child template file.
- For parent component:
	- Declare a function to receive the emitted property.
	- <mark style="background: #e4e62d;">Bind</mark> the <mark style="background: #e4e62d;">event</mark> to the declared function in the child component tag in parent template file:
		- The argument binded in HTML template is still an event.
## Output function

# References
1. [Event binding](Event%20binding.md) for binding events in Angular.
2. [Decorator pattern](software-engineering/software-architecture/design-pattern/fundamentals/structural-pattern/Decorator%20pattern.md) for decorator used in both `@Input` and `@Output` annotation.
3. 


