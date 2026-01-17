#angularjs #angular1 #javascript #web-framework #legacy #mvc #software-engineering #software-architecture
==AngularJS== (Angular 1.x) is the original Angular framework released in 2010. It is a ==JavaScript-based MVC framework== for building dynamic web applications.

> [!important]
> AngularJS reached ==end-of-life== on January 1, 2022. This section is maintained for ==legacy application support== and ==historical reference==.

# Key Characteristics
- **Two-way data binding**: Automatic synchronization between model and view
- **Dependency injection**: Built-in DI container for managing dependencies
- **Directives**: Extend HTML with custom attributes and elements
- **Controllers**: Manage application logic and data
- **Services**: Reusable business logic components
- **Scope-based**: Uses `$scope` for data binding

# AngularJS vs Modern Angular
AngularJS is ==completely different== from Modern Angular (2+):

| Feature | AngularJS (1.x) | Modern Angular (2+) |
|---------|----------------|---------------------|
| **Language** | JavaScript | TypeScript |
| **Architecture** | MVC/MVW | Component-based |
| **Change Detection** | Dirty checking with `$scope` | Zone.js + Signals |
| **Modules** | Angular modules | ES6 modules + NgModules |
| **Mobile Support** | Limited | Full support |
| **Performance** | Slower | Optimized with AOT |
| **Status** | End-of-life (2022) | Active development |

# Migration
For migrating from AngularJS to Modern Angular:
- Consider hybrid approach using `ngUpgrade`
- Rewrite components incrementally
- Update to component-based architecture
- Migrate to TypeScript
- See [Modern Angular](../modern-angular/Modern%20Angular.md) for current framework

# Core Concepts

## Controllers
Controllers are the ==bridge between the view and model==, managing application logic and augmenting the `$scope`.

**Controller Topics:**
- [Controllers and $scope](controllers/Controllers%20and%20$scope.md)
- [Controller as syntax](controllers/Controller%20as%20syntax.md)

## Directives
Directives ==extend HTML== with custom behaviors and components. They are one of the most powerful features of AngularJS.

**Directive Topics:**
- [Built-in directives](directives/Built-in%20directives.md)
- [Custom directives](directives/Custom%20directives.md)

## Services
Services are ==singleton objects== used to organize and share code across the application.

**Service Topics:**
- [Services and Factories](services/Services%20and%20Factories.md)

## Data Binding
AngularJS's signature feature: ==automatic synchronization== between model and view.

**Data Binding Topics:**
- [Two-way data binding](data-binding/Two-way%20data%20binding.md)
- [Digest cycle and watchers](digest-cycle/Digest%20cycle%20and%20watchers.md)

## Routing
Enable ==single-page application== navigation with client-side routing.

**Routing Topics:**
- [ngRoute](routing/ngRoute.md)

## Forms
Built-in form validation and state management.

**Form Topics:**
- [Form validation](forms/Form%20validation.md)

## Filters
Format and transform data for display in templates.

**Filter Topics:**
- [Filters](filters/Filters.md)

## Dependency Injection
AngularJS's built-in ==IoC container== for managing dependencies.

**DI Topics:**
- [Dependency Injection](programming/javascript/angular/angularjs/dependency-injection/Dependency%20Injection.md)

***
# References
1. https://angularjs.org official AngularJS documentation (archived)
2. https://docs.angularjs.org/guide for AngularJS guide
3. https://angular.dev/guide/upgrade for migration guide
