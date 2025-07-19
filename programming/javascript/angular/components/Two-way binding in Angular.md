#angular #html #angular17 #angular18 #typescript #javascript #object-oriented-programming #software-engineering #software-architecture #design-pattern #structural-pattern #dependency-injection 

# Concepts
- Two-way binding means two-way communication between what user do and what user see (input - output).
- Two-way binding also means <mark style="background: #e4e62d;">property binding</mark> and <mark style="background: #e4e62d;">event binding</mark>.
# Input - output decorators
- Declare the properties that needs two-way binding in the component:
	- One property for input annotated with `@Input` decorator.
	- One property for output annotated with `@Output` decorator.
	- Strictly follow naming convention
```typescript
export class SizerComponent {
  @Input() size!: number | string; // <input-name>
  @Output() sizeChange = new EventEmitter<number>(); // <input-nameChange> -> the naming convention
  dec() {
    this.resize(-1);
  }
  inc() {
    this.resize(+1);
  }
  resize(delta: number) {
    this.size = Math.min(40, Math.max(8, +this.size + delta));
    this.sizeChange.emit(this.size);
  }
}
```

- Declares the attribute in the HTML element. Wrap it with a parenthesis and a square bracket.
```html
<app-sizer [(size)]="fontSizePx"></app-sizer>
```

# Directive ngModel
## Without signal
- Import the `FormsModule` into the component.

```typescript
import {FormsModule} from '@angular/forms';
...
@Component({
  standalone: true,
...
    FormsModule, // <--- import into the component
...
  ],
})
export class AppComponent implements OnInit {
...
}
```
- Declare the property which needs two-way binding.
- Wrap the `ngModel` attribute in HTML form and assigns to that property.
```typescript
<label for="example-ngModel">[(ngModel)]:</label>
<input [(ngModel)]="currentItem.name" id="example-ngModel">
```

## signal
- If the property is a `Signal` , the two-way binding is identical to [Without signal](#Without%20signal) . Angular automatically reads the content of `signal`.

---
# References
1. https://angular.dev/guide/templates/two-way-binding

