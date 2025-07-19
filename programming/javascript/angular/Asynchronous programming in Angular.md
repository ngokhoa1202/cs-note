#object-oriented-programming #functional-programming #angular #javascript #typescript #reactive-programming #software-architecture #software-engineering #solid #ajax  #angular17 #angular18 #api #dependency-injection 

# Asynchronous programming
## Zone.js
- The change of an element on DOM tree is automatically managed by Angular itself (actually `Zone.js`).
- Much simpler compared to [useState hook](useState%20hook.md) of ReactJs.
- However, Angular has to ==traverse all of the component tree== to detect which component needs updating after the state has been changed.
## signal
- More fine-grained because we ==explicitly declare which element on DOM is observed for change==.
- Wraps the changeable object in a `Signal` using `signal` function.
```typescript
import { Component, computed, Signal, signal, WritableSignal } from "@angular/core";

interface User {
	name: string;
	subject: string;
	age: number;

}

const DUMMY_SUBJECTS: Array<string> = [
	'Java',
	'Python',
	'Rust',
	'Go',
	'Javascript',
	'C',
	'Cpp',
	'PHP'
];

@Component({
	selector: 'app-header',
	standalone: true,
	templateUrl: './header.component.html',
	styleUrl: './header.component.css'
})
export class HeaderComponent {

	private _user: WritableSignal<User> = signal({
		name: 'Khoa',
		subject: DUMMY_SUBJECTS[0],
		age: 22,
	}); // Wrap the changeable object with signal function to register it on the DOM tree

	private _fullName: Signal<string> = computed(() =>
		'Ngo Vu Anh '.concat(this._user().name)
	); // wrap a computed value by calling computed function and pass a callback to it

	get user(): User {
		return this._user(); // retrieve signal content by simply call it
	} // define getter to retrieve object

	get fullName(): string {
		return this._fullName(); // retrieve signal content by simply call it
	} // define getter to retrieve object

	public onSelectUser() {
		const index: number = Math.floor(Math.random() * DUMMY_SUBJECTS.length);
		this._user.update((usr) => {
			return {
				...usr,
				subject: DUMMY_SUBJECTS[index],
			};
		}); // update the content inside the signal
	}
}
```

# RxJs
- [RxJs](RxJs.md)


