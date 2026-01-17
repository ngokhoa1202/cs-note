#angular #angular17 #angular18 #typescript #javascript #html #dom #data-binding #object-oriented-programming
==Property binding== enables ==one-way data flow== from the component to the template by binding component properties to DOM element properties or directives. This mechanism updates the view automatically when component data changes.

# Interpolation vs Property Binding

## String Interpolation
==String interpolation== uses ==double curly braces== `{{ }}` to embed expressions in templates:

```html
<h1>{{ pageTitle }}</h1>
<p>Welcome, {{ user.name }}!</p>
<img src="{{ user.avatarUrl }}" alt="User avatar">
```

String interpolation is ==converted to property binding== by Angular internally. The following are equivalent:

```html
<p>{{ message }}</p>
<p [textContent]="message"></p>
```

## Property Binding Syntax
Property binding uses ==square brackets== `[]` to bind data to element properties:

```html
<img [src]="user.avatarUrl" [alt]="user.name">
<button [disabled]="isProcessing">Submit</button>
<div [innerHTML]="htmlContent"></div>
```

### When to Use Property Binding
- **Non-string values**: Binding booleans, numbers, objects, or arrays
- **Element properties**: Setting DOM properties like `disabled`, `hidden`, `value`
- **Performance**: Slightly more efficient than interpolation
- **Security**: When binding potentially unsafe content with proper sanitization

# Basic Property Binding

## Binding to Element Properties
```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-property-demo',
  standalone: true,
  template: `
    <!-- Image source -->
    <img [src]="imageUrl" [alt]="imageDescription">

    <!-- Input value -->
    <input [value]="userName" [placeholder]="placeholderText">

    <!-- Button state -->
    <button [disabled]="isLoading">{{ buttonText }}</button>

    <!-- Hidden element -->
    <div [hidden]="!showDetails">Details content</div>

    <!-- Class binding -->
    <div [className]="cssClasses">Styled element</div>

    <!-- ID binding -->
    <div [id]="elementId">Element with dynamic ID</div>
  `
})
export class PropertyDemoComponent {
  imageUrl = 'https://example.com/avatar.jpg';
  imageDescription = 'User Avatar';
  userName = 'Khoa';
  placeholderText = 'Enter your name';
  isLoading = false;
  buttonText = 'Submit';
  showDetails = true;
  cssClasses = 'card primary';
  elementId = 'main-content';
}
```

## Binding to Component Properties
```typescript
@Component({
  selector: 'app-user-card',
  standalone: true,
  template: `
    <div class="card">
      <h3>{{ user.name }}</h3>
      <p>{{ user.email }}</p>
    </div>
  `
})
export class UserCardComponent {
  @Input() user!: User;
}

// Parent component
@Component({
  template: `
    <app-user-card [user]="currentUser"></app-user-card>
  `
})
export class ParentComponent {
  currentUser = {
    name: 'Khoa Ngo',
    email: 'khoa@example.com'
  };
}
```

# Attribute Binding

## Binding to Attributes
Some HTML attributes don't have corresponding DOM properties. Use ==attribute binding== with the `attr.` prefix:

```typescript
@Component({
  template: `
    <!-- ARIA attributes -->
    <div
      role="progressbar"
      [attr.aria-valuenow]="currentProgress"
      [attr.aria-valuemin]="0"
      [attr.aria-valuemax]="100">
      Progress: {{ currentProgress }}%
    </div>

    <!-- Data attributes -->
    <button [attr.data-user-id]="userId">
      User Profile
    </button>

    <!-- Custom attributes -->
    <div [attr.custom-attribute]="customValue">
      Custom element
    </div>

    <!-- Colspan/rowspan -->
    <td [attr.colspan]="columnSpan">Cell content</td>
  `
})
export class AttributeBindingComponent {
  currentProgress = 45;
  userId = 123;
  customValue = 'some-value';
  columnSpan = 2;
}
```

## Binding to SVG Attributes
SVG elements often require attribute binding:

```html
<svg>
  <circle
    [attr.cx]="centerX"
    [attr.cy]="centerY"
    [attr.r]="radius"
    [attr.fill]="fillColor">
  </circle>
</svg>
```

# Class Binding

## Single Class Binding
Bind a ==single CSS class== conditionally:

```html
<div [class.active]="isActive">Active state</div>
<div [class.disabled]="isDisabled">Disabled state</div>
<div [class.highlight]="isHighlighted">Highlighted</div>
```

## Multiple Class Binding
Bind multiple classes using different syntaxes:

```typescript
@Component({
  template: `
    <!-- String -->
    <div [class]="classString">String classes</div>

    <!-- Array -->
    <div [class]="classArray">Array classes</div>

    <!-- Object -->
    <div [class]="classObject">Object classes</div>
  `
})
export class ClassBindingComponent {
  classString = 'card primary large';

  classArray = ['card', 'primary', 'large'];

  classObject = {
    card: true,
    primary: this.isPrimary,
    large: this.isLarge,
    disabled: this.isDisabled
  };

  isPrimary = true;
  isLarge = false;
  isDisabled = false;
}
```

# Style Binding

## Single Style Binding
Bind individual CSS style properties:

```html
<!-- Without units -->
<div [style.color]="textColor">Colored text</div>
<div [style.background-color]="bgColor">Colored background</div>

<!-- With units -->
<div [style.width.px]="widthValue">Fixed width</div>
<div [style.font-size.rem]="fontSize">Sized font</div>
<div [style.margin.%]="marginPercent">Percentage margin</div>
```

## Multiple Style Binding
Bind multiple styles using an object:

```typescript
@Component({
  template: `
    <div [style]="styleObject">Styled element</div>
  `
})
export class StyleBindingComponent {
  styleObject = {
    'color': '#3498db',
    'font-size': '16px',
    'padding': '10px 20px',
    'border-radius': '4px',
    'background-color': '#ecf0f1'
  };
}
```

# Binding to Directive Properties

## Built-in Directive Binding
```html
<!-- ngClass -->
<div [ngClass]="{'active': isActive, 'disabled': isDisabled}">
  Conditional classes
</div>

<!-- ngStyle -->
<div [ngStyle]="{'color': textColor, 'font-size.px': fontSize}">
  Conditional styles
</div>

<!-- ngIf -->
<div *ngIf="showContent">Conditional content</div>

<!-- ngFor -->
<ul>
  <li *ngFor="let item of items">{{ item }}</li>
</ul>
```

# Security Considerations

## Sanitization
Angular automatically ==sanitizes== values to prevent XSS attacks:

```typescript
@Component({
  template: `
    <!-- Safe: Angular sanitizes HTML -->
    <div [innerHTML]="userContent"></div>

    <!-- Dangerous: bypassing security (use with caution) -->
    <div [innerHTML]="trustedContent"></div>
  `
})
export class SecurityComponent {
  constructor(private sanitizer: DomSanitizer) {}

  userContent = '<script>alert("XSS")</script>'; // Sanitized automatically

  get trustedContent() {
    return this.sanitizer.bypassSecurityTrustHtml('<b>Trusted HTML</b>');
  }
}
```

## Safe Binding Contexts
- ==URL sanitization==: `src`, `href` attributes
- ==Script sanitization==: Removes `<script>` tags
- ==Style sanitization==: Validates CSS expressions
- ==Resource URL sanitization==: iframe `src`, object `data`

# Real-World Example: Dynamic Card Component

```typescript
import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';

interface CardConfig {
  title: string;
  description: string;
  imageUrl?: string;
  variant: 'default' | 'primary' | 'success' | 'danger';
  size: 'small' | 'medium' | 'large';
  isLoading: boolean;
  progress?: number;
}

@Component({
  selector: 'app-dynamic-card',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div
      [class]="cardClasses"
      [style.opacity]="config.isLoading ? 0.5 : 1"
      [attr.data-variant]="config.variant">

      <!-- Image section -->
      <img
        *ngIf="config.imageUrl"
        [src]="config.imageUrl"
        [alt]="config.title"
        [class.loading]="config.isLoading">

      <!-- Content section -->
      <div class="content">
        <h3 [style.color]="titleColor">{{ config.title }}</h3>
        <p>{{ config.description }}</p>

        <!-- Progress bar -->
        <div
          *ngIf="config.progress !== undefined"
          class="progress-bar"
          role="progressbar"
          [attr.aria-valuenow]="config.progress"
          [attr.aria-valuemin]="0"
          [attr.aria-valuemax]="100">
          <div
            class="progress-fill"
            [style.width.%]="config.progress"
            [style.background-color]="progressColor">
          </div>
        </div>
      </div>

      <!-- Loading overlay -->
      <div
        class="loading-overlay"
        [hidden]="!config.isLoading"
        [attr.aria-busy]="config.isLoading">
        <span>Loading...</span>
      </div>
    </div>
  `,
  styles: [`
    .card { border-radius: 8px; overflow: hidden; }
    .card.small { width: 200px; }
    .card.medium { width: 300px; }
    .card.large { width: 400px; }
    .card.primary { border: 2px solid #3498db; }
    .card.success { border: 2px solid #2ecc71; }
    .card.danger { border: 2px solid #e74c3c; }
    .loading-overlay { position: absolute; inset: 0; background: rgba(0,0,0,0.3); }
    .progress-bar { height: 8px; background: #ecf0f1; border-radius: 4px; }
    .progress-fill { height: 100%; transition: width 0.3s; }
  `]
})
export class DynamicCardComponent {
  @Input() config!: CardConfig;

  get cardClasses(): string {
    return `card ${this.config.size} ${this.config.variant}`;
  }

  get titleColor(): string {
    const colors = {
      default: '#2c3e50',
      primary: '#3498db',
      success: '#27ae60',
      danger: '#c0392b'
    };
    return colors[this.config.variant];
  }

  get progressColor(): string {
    if (!this.config.progress) return '#3498db';
    if (this.config.progress < 33) return '#e74c3c';
    if (this.config.progress < 66) return '#f39c12';
    return '#2ecc71';
  }
}
```

# Best Practices

## Performance
- Use property binding for ==non-string values== to avoid type conversion overhead
- Avoid ==complex expressions== in bindings - use component methods or properties instead
- Use ==OnPush change detection== strategy when possible for better performance

## Readability
- Prefer ==property binding over interpolation== for element properties
- Use ==descriptive property names== in the component
- Group ==related bindings== together in templates

## Maintainability
- Keep binding expressions ==simple==
- Use ==getter methods== for computed values
- Implement ==proper typing== for bound properties
- Document ==complex binding logic== with comments

***
# References
1. https://angular.dev/guide/templates/property-binding for official property binding documentation
2. https://angular.dev/guide/templates/interpolation for string interpolation guide
3. https://angular.dev/guide/security for Angular security guidelines
4. [Event binding](Event%20binding.md)
5. [Two-way binding in Angular](../components/Two-way%20binding%20in%20Angular.md)
