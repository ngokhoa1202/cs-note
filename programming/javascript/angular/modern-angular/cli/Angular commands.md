#javascript #angular #angular17 #angular18 #typescript #cli #shell #object-oriented-programming
The ==Angular CLI== (Command Line Interface) is the official tool for initializing, developing, scaffolding, and maintaining Angular applications. It provides commands to automate common development tasks and enforce best practices.
# Project Initialization

## Creating a New Project
The `ng new` command creates a new Angular workspace with a default application.

```shell
ng new <project-name>
```

### Options
- `--routing`: Generates a routing module for the application
- `--style=scss`: Sets the stylesheet format (css, scss, sass, less)
- `--skip-git`: Skips git repository initialization
- `--strict`: Enables strict type checking and other strict mode features

### Example
```shell
ng new my-angular-app --routing --style=scss
```

This command performs the following actions:
- Creates a new directory with the project name
- Initializes a Git repository
- Installs npm dependencies
- Configures TypeScript and Angular settings
- Generates the initial application structure

# Generating Components

## Component Generation
The `ng generate component` command creates a new component with associated files.

### Full Command
```shell
ng generate component <component-name>
```

### Short Command
```shell
ng g c <component-name>
```

### Generated Files
Angular automatically generates four files for each component:
- `<component-name>.component.ts`: Contains the component logic and metadata
- `<component-name>.component.html`: Defines the component template
- `<component-name>.component.css`: Contains component-specific styles
- `<component-name>.component.spec.ts`: Contains unit tests for the component

### Options
- `--skip-tests`: Skips creation of the spec file
- `--inline-template`: Uses inline template instead of external HTML file
- `--inline-style`: Uses inline styles instead of external CSS file
- `--standalone`: Generates a standalone component (Angular 14+)
- `--export`: Exports the component from the parent module

### Example
```shell
ng g c user-profile --standalone --skip-tests
```

# Generating Other Artifacts

## Service Generation
Services provide reusable business logic and data management.

```shell
ng generate service <service-name>
ng g s <service-name>
```

### Example
```shell
ng g s services/user
```

This generates:
- `user.service.ts`: Service implementation
- `user.service.spec.ts`: Service unit tests

## Directive Generation
Creates a custom directive for DOM manipulation or behavior modification.

```shell
ng generate directive <directive-name>
ng g d <directive-name>
```

## Pipe Generation
Creates a custom pipe for data transformation in templates.

```shell
ng generate pipe <pipe-name>
ng g p <pipe-name>
```

## Guard Generation
Creates a route guard for controlling navigation.

```shell
ng generate guard <guard-name>
ng g g <guard-name>
```

## Module Generation
Creates a new NgModule for organizing application features.

```shell
ng generate module <module-name>
ng g m <module-name>
```

### Options
- `--routing`: Generates a routing module alongside the feature module
- `--route=<route-path>`: Creates a routed module

### Example
```shell
ng g m features/admin --routing
```

## Interface Generation
Creates a TypeScript interface for type definitions.

```shell
ng generate interface <interface-name>
ng g i <interface-name>
```

# Development Server

## Serving the Application
The `ng serve` command builds and serves the application with live reload.

```shell
ng serve
```

### Options
- `--port=<port-number>`: Specifies the port number (default: 4200)
- `--open` or `-o`: Automatically opens the browser
- `--configuration=production`: Serves with production configuration
- `--host=<hostname>`: Specifies the host (default: localhost)

### Example
```shell
ng serve --open --port=4300
```

# Building the Application

## Production Build
The `ng build` command compiles the application into an output directory.

```shell
ng build
```

### Options
- `--configuration=production`: Builds with production optimizations
- `--output-path=<path>`: Specifies the output directory
- `--base-href=<href>`: Sets the base href in index.html
- `--source-map`: Generates source maps

### Example
```shell
ng build --configuration=production
```

Production builds include:
- Ahead-of-Time (AOT) compilation
- Tree shaking to remove unused code
- Code minification and uglification
- Bundle optimization

# Testing

## Running Unit Tests
Executes unit tests using Karma test runner.

```shell
ng test
```

### Options
- `--watch=false`: Runs tests once without watching
- `--code-coverage`: Generates code coverage report
- `--browsers=<browser>`: Specifies which browser to use

## Running End-to-End Tests
Executes end-to-end tests (requires separate E2E framework installation).

```shell
ng e2e
```

# Code Quality

## Linting
Analyzes code for potential errors and style issues.

```shell
ng lint
```

## Updating Dependencies
Updates Angular dependencies to the latest versions.

```shell
ng update
```

### Example
```shell
ng update @angular/core @angular/cli
```

# Additional Useful Commands

## Adding External Libraries
Adds npm packages configured for Angular.

```shell
ng add <package-name>
```

### Example
```shell
ng add @angular/material
```

This command:
- Installs the package via npm
- Runs the package's installation schematic
- Updates configuration files automatically

## Extracting Translations
Extracts translatable text from templates.

```shell
ng extract-i18n
```

## Running Custom Scripts
Executes an architect target with optional custom configuration.

```shell
ng run <project>:<architect-target>
```

***
# References
1. https://angular.dev/cli for official Angular CLI documentation
2. https://angular.dev/cli/generate for generate command reference
3. https://angular.dev/cli/build for build command options
