#angular #event-driven-programming   #oop #javascript #software-architecture #software-engineering #dependency-injection #design-pattern 
- Also called event callback.
# Event binding
- Specify the event attribute in the `component.html` file with the method invocation. For example:
```jsx
<button (click)="onSelectUser()"> <!-- Bind event here -->
  Click me
</button>
```
- Define a method in the `Component` class
```typescript
import { Component } from "@angular/core";

interface User {
	name: string;
	subject: string;
	age: number;
}

  

@Component({
	selector: 'app-header',
	standalone: true,
	templateUrl: './header.component.html',
	styleUrl: './header.component.css'

})
export class HeaderComponent {

	private readonly _user: User = {
		name: "Khoa",
		subject: "Java, React, Angular, HTML, CSS, Javascript, Typescript",
		age: 22
	}

	get user(): User {
		return this._user;
	}

	public onSelectUser() {
		console.log("Clicked");
	}

}
```