#angular #angular17 #angular18 #reactive-programming #javascript #typescript #software-engineering #software-architecture #object-oriented-programming #functional-programming #html #css #scss #web-framework
==Modern Angular== (Angular 2+) is a complete rewrite of AngularJS, built as a ==component-based framework== using TypeScript. The current versions (Angular 17/18) focus on performance, developer experience, and modern web standards.

# Key Features
- **Component-based architecture**: Everything is built around reusable components
- **TypeScript-first**: Strong typing and modern JavaScript features
- **Reactive programming**: Built-in integration with RxJS for asynchronous operations
- **Signal-based reactivity**: Fine-grained change detection (Angular 17+)
- **Standalone components**: Simplified module system
- **Ahead-of-Time compilation**: Better performance and smaller bundle sizes

# CLI and Project Setup
- [Angular commands](cli/Angular%20commands.md)

# Core Concepts
- [Angular fundamentals](fundamentals/Angular.md)

# Components
Components are the ==fundamental building blocks== of Angular applications. Each component consists of:
- TypeScript class for logic
- HTML template for structure
- CSS/SCSS for styling
- Component decorator for metadata

**Component Topics:**
- [Sharing states between components](components/Sharing%20states%20between%20components.md)
- [Two-way binding in Angular](components/Two-way%20binding%20in%20Angular.md)

# Templates
Angular templates use a ==declarative syntax== to bind data and events between components and the DOM.

**Template Topics:**
- [Property binding](templates/Property%20binding.md)
- [Event binding](templates/Event%20binding.md)
- [Class and Style binding](templates/Class%20and%20Style%20binding.md)
- [Content projection in Angular](templates/Content%20projection%20in%20Angular.md)
- [Pipes in Angular template](templates/Pipes%20in%20Angular%20template.md)

# Reactive Programming
Angular embraces ==reactive programming patterns== for handling asynchronous operations and state management.

**Reactive Programming Topics:**
- [Asynchronous programming in Angular](reactive-programming/Asynchronous%20programming%20in%20Angular.md)
- [RxJS](../../rxjs/RxJS.md)

# Modern Angular vs AngularJS
Modern Angular is fundamentally different from AngularJS (1.x):
- Component-based vs controller-based architecture
- TypeScript vs JavaScript
- Improved performance with Ahead-of-Time compilation
- Better mobile support
- Enhanced tooling and CLI
- Signal-based change detection vs dirty checking

For legacy AngularJS notes, see [AngularJS](../angularjs/AngularJS.md)

***
# References
1. https://angular.dev official Angular documentation
2. https://angular.dev/guide/components for component documentation
3. https://angular.dev/guide/templates for template syntax
4. https://angular.dev/guide/signals for signal-based reactivity
