#angular #angular17 #angular18 #typescript #javascript #html #object-oriented-programming #software-engineering #data-binding #forms
==Two-way data binding== is a mechanism that ==synchronizes data between the component class and the template== in both directions. When the user modifies data in the view, the component model updates automatically, and vice versa.

# Concept

## Definition
Two-way binding combines two unidirectional bindings:
- ==Property binding==: Flows data from the component to the template
- ==Event binding==: Flows data from the template to the component

## Syntax
The two-way binding syntax uses ==banana-in-a-box notation== `[()]`:
```html
[(propertyName)]="componentProperty"
```

This notation is shorthand for:
```html
[propertyName]="componentProperty" (propertyNameChange)="componentProperty=$event"
```

# Two-Way Binding with Custom Components

## Implementation Steps
To implement two-way binding in a custom component, follow these requirements:
- Declare an `@Input()` property for the incoming value
- Declare an `@Output()` property named `<propertyName>Change` that emits the new value
- Emit the new value whenever the internal state changes

## Example: Size Controller Component
```typescript
import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-sizer',
  standalone: true,
  template: `
    <div>
      <button (click)="dec()" [disabled]="size <= minSize">-</button>
      <span>{{ size }}</span>
      <button (click)="inc()" [disabled]="size >= maxSize">+</button>
    </div>
  `
})
export class SizerComponent {
  @Input() size!: number | string;
  @Output() sizeChange = new EventEmitter<number>();

  minSize = 8;
  maxSize = 40;

  dec(): void {
    this.resize(-1);
  }

  inc(): void {
    this.resize(+1);
  }

  resize(delta: number): void {
    const newSize = Math.min(this.maxSize, Math.max(this.minSize, +this.size + delta));
    this.size = newSize;
    this.sizeChange.emit(newSize);
  }
}
```

## Usage in Parent Component
```typescript
@Component({
  selector: 'app-parent',
  template: `
    <app-sizer [(size)]="fontSizePx"></app-sizer>
    <p [style.font-size.px]="fontSizePx">Resizable Text</p>
  `
})
export class ParentComponent {
  fontSizePx = 16;
}
```

## Naming Convention
The output property ==must== follow the naming pattern:
- Input property: `propertyName`
- Output property: `propertyNameChange`
- This convention allows Angular to recognize and bind the two-way binding syntax.
# Two-Way Binding with `ngModel`

## Using `ngModel` with Template-Driven Forms
The `ngModel` directive provides two-way binding for form elements.
### Import `FormsModule`
First, import the `FormsModule` in your component:

```typescript
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-form',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './form.component.html'
})
export class FormComponent {
  userName = '';
  userEmail = '';
}
```
### Apply `ngModel` in Template
```html
<div>
  <label for="name">Name:</label>
  <input
    id="name"
    type="text"
    [(ngModel)]="userName">
  <p>Hello, {{ userName }}!</p>
</div>

<div>
  <label for="email">Email:</label>
  <input
    id="email"
    type="email"
    [(ngModel)]="userEmail">
</div>
```
## `ngModel` with `Signals`
- When binding to a ==Signal==, Angular automatically unwraps the signal value.
### Example with Signals
```typescript
import { Component, signal, WritableSignal } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-signal-form',
  standalone: true,
  imports: [FormsModule],
  template: `
    <input [(ngModel)]="userName">
    <p>Welcome, {{ userName() }}!</p>
  `
})
export class SignalFormComponent {
  userName: WritableSignal<string> = signal('');
}
```

- Angular handles signal updates automatically when using `ngModel`, calling the signal's `set()` method internally.

## ngModel Variations

### One-Way Binding
Use property binding for read-only data flow:
```html
<input [ngModel]="userName">
```

### Event Binding Only
Listen to value changes without property binding:
```html
<input (ngModelChange)="onNameChange($event)">
```

### Combined with Event Handler
React to changes while maintaining two-way binding:
```html
<input
  [(ngModel)]="userName"
  (ngModelChange)="onNameUpdate()">
```

# Use Cases

## Form Controls
Two-way binding is ideal for form inputs where user interaction should immediately update the component state:
- Text inputs
- Checkboxes
- Radio buttons
- Select dropdowns
- Textarea elements

## Custom Form Components
Create reusable form controls that integrate with Angular's forms:
- Rating components
- Color pickers
- Date pickers
- Custom sliders

## Real-Time Updates
Implement features that require instant synchronization:
- Live search filters
- Character counters
- Dynamic form validation
- Interactive configuration panels

***
# References
1. https://angular.dev/guide/templates/two-way-binding for official two-way binding guide
2. https://angular.dev/guide/forms for Angular forms documentation
3. [Property binding](../templates/Property%20binding.md)
4. [Event binding](../templates/Event%20binding.md)
5. [Sharing states between components](Sharing%20states%20between%20components.md)
