#angular #angular17 #angular18 #typescript #javascript #component #data-binding #decorator #object-oriented-programming #software-engineering #software-architecture
==Component communication== in Angular enables data flow between parent and child components through ==property binding== and ==event emission==. This mechanism is fundamental for building modular and reusable component architectures.

# Input Decorator

## Purpose
The `@Input()` decorator enables a ==parent component to pass data== to a child component through property binding. This creates a one-way data flow from parent to child.

## Basic Usage

### Child Component Declaration
Declare a property decorated with `@Input()` to receive data from the parent:

```typescript
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-user-card',
  standalone: true,
  template: `
    <div class="card">
      <h3>{{ userName }}</h3>
      <p>{{ userEmail }}</p>
    </div>
  `
})
export class UserCardComponent {
  @Input() userName: string = '';
  @Input() userEmail: string = '';
}
```

### Parent Component Usage
The parent component binds data to the child's input properties using ==property binding syntax== `[]`:

```typescript
@Component({
  selector: 'app-parent',
  standalone: true,
  imports: [UserCardComponent],
  template: `
    <app-user-card
      [userName]="currentUser.name"
      [userEmail]="currentUser.email">
    </app-user-card>
  `
})
export class ParentComponent {
  currentUser = {
    name: 'Khoa Ngo',
    email: 'khoa@example.com'
  };
}
```

## Input Aliasing
Use an alias to expose a different property name externally:

```typescript
export class UserCardComponent {
  @Input('displayName') userName: string = '';
}
```

```html
<!-- Parent uses 'displayName' instead of 'userName' -->
<app-user-card [displayName]="user.name"></app-user-card>
```

## Required Inputs
Mark inputs as required using the `required` option (Angular 16+):

```typescript
export class UserCardComponent {
  @Input({ required: true }) userName!: string;
  @Input({ required: true }) userEmail!: string;
}
```

If a required input is not provided, Angular throws an error at compile time.

## Input Transforms
Transform input values automatically using the `transform` option (Angular 16+):

```typescript
import { booleanAttribute, numberAttribute } from '@angular/core';

export class ConfigComponent {
  @Input({ transform: booleanAttribute }) enabled: boolean = false;
  @Input({ transform: numberAttribute }) count: number = 0;
}
```

```html
<!-- String "true" is converted to boolean true -->
<app-config enabled="true" count="5"></app-config>
```

# Output Decorator

## Purpose
The `@Output()` decorator enables a ==child component to emit events== to its parent component. This creates a one-way data flow from child to parent, allowing the child to notify the parent of state changes or user actions.

## Basic Usage

### Child Component Declaration
Declare an `EventEmitter` property decorated with `@Output()`:

```typescript
import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-counter',
  standalone: true,
  template: `
    <button (click)="increment()">Increment</button>
    <span>{{ count }}</span>
  `
})
export class CounterComponent {
  count = 0;
  @Output() countChange = new EventEmitter<number>();

  increment(): void {
    this.count++;
    this.countChange.emit(this.count);
  }
}
```

### Parent Component Usage
The parent component listens to the child's event using ==event binding syntax== `()`:

```typescript
@Component({
  selector: 'app-parent',
  standalone: true,
  imports: [CounterComponent],
  template: `
    <app-counter (countChange)="onCountChange($event)"></app-counter>
    <p>Total count: {{ totalCount }}</p>
  `
})
export class ParentComponent {
  totalCount = 0;

  onCountChange(newCount: number): void {
    this.totalCount = newCount;
    console.log('Count updated to:', newCount);
  }
}
```

## Output Aliasing
Expose a different event name externally:

```typescript
export class CounterComponent {
  @Output('valueChanged') countChange = new EventEmitter<number>();
}
```

```html
<!-- Parent listens to 'valueChanged' instead of 'countChange' -->
<app-counter (valueChanged)="onCountChange($event)"></app-counter>
```

## Emitting Complex Data
EventEmitters can emit objects or multiple values:

```typescript
interface UserAction {
  userId: number;
  action: 'edit' | 'delete';
  timestamp: Date;
}

export class UserListComponent {
  @Output() userAction = new EventEmitter<UserAction>();

  onUserClick(userId: number, action: 'edit' | 'delete'): void {
    this.userAction.emit({
      userId,
      action,
      timestamp: new Date()
    });
  }
}
```

# Complete Example: Todo Item Component

## Child Component
```typescript
import { Component, Input, Output, EventEmitter } from '@angular/core';

interface Todo {
  id: number;
  title: string;
  completed: boolean;
}

@Component({
  selector: 'app-todo-item',
  standalone: true,
  template: `
    <div class="todo-item">
      <input
        type="checkbox"
        [checked]="todo.completed"
        (change)="onToggle()">
      <span [class.completed]="todo.completed">
        {{ todo.title }}
      </span>
      <button (click)="onDelete()">Delete</button>
    </div>
  `,
  styles: [`
    .completed {
      text-decoration: line-through;
      color: gray;
    }
  `]
})
export class TodoItemComponent {
  @Input({ required: true }) todo!: Todo;
  @Output() toggle = new EventEmitter<number>();
  @Output() delete = new EventEmitter<number>();

  onToggle(): void {
    this.toggle.emit(this.todo.id);
  }

  onDelete(): void {
    this.delete.emit(this.todo.id);
  }
}
```

## Parent Component
```typescript
@Component({
  selector: 'app-todo-list',
  standalone: true,
  imports: [TodoItemComponent],
  template: `
    <div class="todo-list">
      <app-todo-item
        *ngFor="let todo of todos"
        [todo]="todo"
        (toggle)="toggleTodo($event)"
        (delete)="deleteTodo($event)">
      </app-todo-item>
    </div>
  `
})
export class TodoListComponent {
  todos: Todo[] = [
    { id: 1, title: 'Learn Angular', completed: false },
    { id: 2, title: 'Build an app', completed: false }
  ];

  toggleTodo(id: number): void {
    const todo = this.todos.find(t => t.id === id);
    if (todo) {
      todo.completed = !todo.completed;
    }
  }

  deleteTodo(id: number): void {
    this.todos = this.todos.filter(t => t.id !== id);
  }
}
```

# Alternative Communication Methods

## ViewChild for Direct Access
Access child component instance directly:

```typescript
import { Component, ViewChild } from '@angular/core';

@Component({
  selector: 'app-parent',
  template: `
    <app-counter #counter></app-counter>
    <button (click)="resetCounter()">Reset</button>
  `
})
export class ParentComponent {
  @ViewChild('counter') counterComponent!: CounterComponent;

  resetCounter(): void {
    this.counterComponent.count = 0;
  }
}
```

## Services for Sibling Communication
Use a shared service for communication between sibling components:

```typescript
import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  private dataSubject = new BehaviorSubject<string>('');
  data$ = this.dataSubject.asObservable();

  updateData(value: string): void {
    this.dataSubject.next(value);
  }
}
```

# Best Practices

## Input Best Practices
- Use `required: true` for mandatory inputs
- Provide default values for optional inputs
- Use input transforms for type conversions
- Avoid mutating input properties directly (use immutable patterns)

## Output Best Practices
- Use descriptive event names (e.g., `userSelected`, `itemDeleted`)
- Emit meaningful data (avoid emitting raw DOM events)
- Document expected event payload types
- Consider using TypeScript interfaces for complex payloads

## General Practices
- Keep component communication unidirectional when possible
- Use services for complex cross-component communication
- Avoid deeply nested component hierarchies
- Consider using state management for global state

***
# References
1. https://angular.dev/guide/components/inputs for @Input decorator documentation
2. https://angular.dev/guide/components/outputs for @Output decorator documentation
3. [Event binding](../templates/Event%20binding.md)
4. [Two-way binding in Angular](Two-way%20binding%20in%20Angular.md)
5. [Property binding](../templates/Property%20binding.md)
