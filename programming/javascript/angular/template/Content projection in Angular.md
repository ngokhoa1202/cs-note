#object-oriented-programming  #angular #javascript #html #typescript #software-engineering #software-architecture #html #event-driven-programming 

# Concept
- Content projection is equivalent to the oop <mark style="background: #e4e62d;">inheritance</mark>:
	- Child classes inherit all methods from its parent class.
	- Only concrete class can be instantiated.
- Parent components are also known as <mark style="background: #ABF7F7A6;">host elements</mark>.
# Purpose
-  Wrap reusable components.
# Usage
- Specify all resuable HTML elements in the parent template.
- Specify the child-specific placeholder by using `<ng-content>` tag.
- "Override" the placeholder in the child components.
- If there are many placeholders, employe `select` attribute.

> [!important]
> Only <mark style="background: #e4e62d;">child components</mark> can be specified in other templates to be renderd

