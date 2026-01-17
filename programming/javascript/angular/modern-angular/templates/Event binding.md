#angular #angular17 #angular18 #typescript #javascript #event-driven-programming #dom #html #object-oriented-programming #software-engineering
==Event binding== enables components to ==respond to user actions== such as clicks, key presses, mouse movements, and form submissions. It establishes a one-way data flow from the template to the component, executing component methods when DOM events occur.

# Syntax

## Basic Event Binding
Event binding uses ==parentheses== `()` to bind DOM events to component methods:

```html
<button (click)="handleClick()">Click Me</button>
```

The syntax pattern is:
```html
(eventName)="componentMethod()"
```

## Event Object Access
Access the ==`$event`== object to retrieve event details:

```html
<input (input)="onInput($event)">
<button (click)="onClick($event)">Click</button>
```

In the component:
```typescript
onInput(event: Event): void {
  const target = event.target as HTMLInputElement;
  console.log('Input value:', target.value);
}

onClick(event: MouseEvent): void {
  console.log('Click coordinates:', event.clientX, event.clientY);
}
```

# Common DOM Events

## Mouse Events

### Click Events
```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-button-demo',
  standalone: true,
  template: `
    <button (click)="onClick()">Single Click</button>
    <button (dblclick)="onDoubleClick()">Double Click</button>
    <div (contextmenu)="onRightClick($event)">Right Click Me</div>
  `
})
export class ButtonDemoComponent {
  onClick(): void {
    console.log('Button clicked');
  }

  onDoubleClick(): void {
    console.log('Button double-clicked');
  }

  onRightClick(event: MouseEvent): void {
    event.preventDefault();
    console.log('Right-clicked');
  }
}
```

### Mouse Movement Events
```typescript
@Component({
  template: `
    <div
      (mouseenter)="onMouseEnter()"
      (mouseleave)="onMouseLeave()"
      (mousemove)="onMouseMove($event)">
      Hover over me
    </div>
  `
})
export class MouseTrackingComponent {
  onMouseEnter(): void {
    console.log('Mouse entered');
  }

  onMouseLeave(): void {
    console.log('Mouse left');
  }

  onMouseMove(event: MouseEvent): void {
    console.log(`Position: ${event.clientX}, ${event.clientY}`);
  }
}
```

## Keyboard Events

### Key Press Detection
```typescript
@Component({
  template: `
    <input
      (keydown)="onKeyDown($event)"
      (keyup)="onKeyUp($event)"
      (keypress)="onKeyPress($event)"
      placeholder="Type something">
  `
})
export class KeyboardComponent {
  onKeyDown(event: KeyboardEvent): void {
    console.log('Key down:', event.key);

    // Handle specific keys
    if (event.key === 'Enter') {
      console.log('Enter pressed');
    }

    if (event.ctrlKey && event.key === 's') {
      event.preventDefault();
      this.save();
    }
  }

  onKeyUp(event: KeyboardEvent): void {
    console.log('Key up:', event.key);
  }

  onKeyPress(event: KeyboardEvent): void {
    console.log('Key press:', event.key);
  }

  save(): void {
    console.log('Save triggered');
  }
}
```

### Keyboard Event Filtering
Angular provides ==pseudo-events== for specific keys:

```html
<input (keydown.enter)="onEnter()">
<input (keydown.escape)="onEscape()">
<input (keydown.shift.tab)="onShiftTab()">
<input (keydown.control.s)="onSave()">
```

## Form Events

### Input and Change Events
```typescript
@Component({
  template: `
    <input
      (input)="onInput($event)"
      (change)="onChange($event)"
      (focus)="onFocus()"
      (blur)="onBlur()">

    <select (change)="onSelectChange($event)">
      <option value="1">Option 1</option>
      <option value="2">Option 2</option>
    </select>
  `
})
export class FormEventsComponent {
  onInput(event: Event): void {
    const value = (event.target as HTMLInputElement).value;
    console.log('Input changed:', value);
  }

  onChange(event: Event): void {
    const value = (event.target as HTMLInputElement).value;
    console.log('Value committed:', value);
  }

  onFocus(): void {
    console.log('Input focused');
  }

  onBlur(): void {
    console.log('Input blurred');
  }

  onSelectChange(event: Event): void {
    const value = (event.target as HTMLSelectElement).value;
    console.log('Selected:', value);
  }
}
```

### Form Submission
```typescript
@Component({
  template: `
    <form (submit)="onSubmit($event)">
      <input name="username" [(ngModel)]="username">
      <button type="submit">Submit</button>
    </form>
  `
})
export class FormSubmitComponent {
  username = '';

  onSubmit(event: Event): void {
    event.preventDefault(); // Prevent default form submission
    console.log('Form submitted:', this.username);
  }
}
```

# Event Binding with Template Variables

## Using Template Reference Variables
```html
<input #inputElement>
<button (click)="logValue(inputElement.value)">
  Log Input Value
</button>
```

```typescript
logValue(value: string): void {
  console.log('Value:', value);
}
```

# Passing Multiple Arguments

## Static and Dynamic Arguments
```html
<button (click)="onAction('delete', item.id)">Delete</button>
<button (click)="onAction('edit', item.id, $event)">Edit</button>
```

```typescript
onAction(action: string, id: number, event?: MouseEvent): void {
  console.log(`Action: ${action}, ID: ${id}`);
  if (event) {
    console.log('Event:', event);
  }
}
```

# Custom Events from Child Components

## Parent Listening to Child Events
```typescript
// Child component
@Component({
  selector: 'app-counter',
  template: `
    <button (click)="increment()">+</button>
    <span>{{ count }}</span>
  `
})
export class CounterComponent {
  count = 0;
  @Output() countChanged = new EventEmitter<number>();

  increment(): void {
    this.count++;
    this.countChanged.emit(this.count);
  }
}

// Parent component
@Component({
  template: `
    <app-counter (countChanged)="onCountChanged($event)"></app-counter>
    <p>Total: {{ total }}</p>
  `
})
export class ParentComponent {
  total = 0;

  onCountChanged(newCount: number): void {
    this.total = newCount;
  }
}
```

# Event Bubbling and Propagation

## Stopping Event Propagation
```typescript
@Component({
  template: `
    <div (click)="onDivClick()">
      <button (click)="onButtonClick($event)">
        Click Me
      </button>
    </div>
  `
})
export class BubblingComponent {
  onDivClick(): void {
    console.log('Div clicked');
  }

  onButtonClick(event: MouseEvent): void {
    event.stopPropagation(); // Prevents event from bubbling to div
    console.log('Button clicked');
  }
}
```

## Preventing Default Behavior
```html
<a href="https://example.com" (click)="onLinkClick($event)">
  Click (prevented)
</a>
```

```typescript
onLinkClick(event: MouseEvent): void {
  event.preventDefault(); // Prevents navigation
  console.log('Link clicked but navigation prevented');
}
```

# Real-World Example: Interactive Todo List

```typescript
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

interface Todo {
  id: number;
  text: string;
  completed: boolean;
}

@Component({
  selector: 'app-todo-list',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="todo-app">
      <h2>Todo List</h2>

      <!-- Add todo form -->
      <form (submit)="addTodo($event)">
        <input
          #todoInput
          type="text"
          (keydown.enter)="addTodo($event)"
          (keydown.escape)="clearInput(todoInput)"
          placeholder="Add new todo...">
        <button type="submit">Add</button>
      </form>

      <!-- Todo list -->
      <ul>
        <li
          *ngFor="let todo of todos; trackBy: trackByTodo"
          (mouseenter)="hoveredId = todo.id"
          (mouseleave)="hoveredId = null"
          [class.hovered]="hoveredId === todo.id">

          <input
            type="checkbox"
            [checked]="todo.completed"
            (change)="toggleTodo(todo.id)">

          <span
            [class.completed]="todo.completed"
            (dblclick)="editTodo(todo.id)">
            {{ todo.text }}
          </span>

          <button
            *ngIf="hoveredId === todo.id"
            (click)="deleteTodo(todo.id)">
            Delete
          </button>
        </li>
      </ul>

      <!-- Summary -->
      <div class="summary">
        <span>{{ remainingCount }} items left</span>
        <button (click)="clearCompleted()">Clear completed</button>
      </div>
    </div>
  `,
  styles: [`
    .completed { text-decoration: line-through; color: gray; }
    .hovered { background-color: #f0f0f0; }
  `]
})
export class TodoListComponent {
  todos: Todo[] = [];
  nextId = 1;
  hoveredId: number | null = null;

  get remainingCount(): number {
    return this.todos.filter(t => !t.completed).length;
  }

  addTodo(event: Event): void {
    event.preventDefault();

    const input = (event.target as HTMLFormElement).querySelector('input');
    const text = input?.value.trim();

    if (text) {
      this.todos.push({
        id: this.nextId++,
        text,
        completed: false
      });
      input!.value = '';
    }
  }

  toggleTodo(id: number): void {
    const todo = this.todos.find(t => t.id === id);
    if (todo) {
      todo.completed = !todo.completed;
    }
  }

  deleteTodo(id: number): void {
    this.todos = this.todos.filter(t => t.id !== id);
  }

  editTodo(id: number): void {
    console.log('Edit todo:', id);
    // Implementation for editing
  }

  clearCompleted(): void {
    this.todos = this.todos.filter(t => !t.completed);
  }

  clearInput(input: HTMLInputElement): void {
    input.value = '';
  }

  trackByTodo(index: number, todo: Todo): number {
    return todo.id;
  }
}
```

# Best Practices

## Method Invocation
- ==Keep event handler methods simple== - delegate complex logic to services
- ==Use TypeScript types== for event parameters
- ==Avoid inline expressions== - use component methods instead

## Performance
- ==Minimize work in event handlers== - avoid heavy computations
- ==Use trackBy== with `*ngFor` to optimize list rendering
- ==Debounce frequent events== (e.g., scroll, resize) using RxJS operators

## Security
- ==Always validate user input== in event handlers
- ==Sanitize data== before using it in templates or API calls
- ==Prevent XSS attacks== by avoiding direct DOM manipulation

***
# References
1. https://angular.dev/guide/templates/event-binding for official event binding documentation
2. https://angular.dev/guide/event-binding for event binding guide
3. [Sharing states between components](../components/Sharing%20states%20between%20components.md)
4. [Property binding](Property%20binding.md)
5. [Two-way binding in Angular](../components/Two-way%20binding%20in%20Angular.md)
