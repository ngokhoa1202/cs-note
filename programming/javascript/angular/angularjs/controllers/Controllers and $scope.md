#angularjs #angular1 #javascript #mvc #controller #scope #legacy
- ==Controllers== in AngularJS are JavaScript constructor functions that ==augment the Angular scope== (`$scope`). They are responsible for setting up the initial state and adding behavior to the scope object.
# Concept
- Controllers act as the ==bridge between the view and the model==
- They use `$scope` as the glue between the controller and the view
- Controllers should only contain business logic, not DOM manipulation
- Each controller creates a new child scope
# Basic Controller Definition
## Controller Function
```javascript
angular.module('myApp', [])
  .controller('MyController', function($scope) {
    // Initialize the model
    $scope.greeting = 'Hello World';

    // Add behavior
    $scope.sayHello = function() {
      alert($scope.greeting);
    };
  });
```
## Using Controller in HTML
```html
<div ng-app="myApp" ng-controller="MyController">
  <h1>{{ greeting }}</h1>
  <button ng-click="sayHello()">Say Hello</button>
</div>
```
# The `$scope` Object
## Purpose
- `$scope` is the application model
- It is the execution context for expressions
- Scopes are arranged in ==hierarchical structure== that mimics the DOM structure
- Scopes can watch expressions and propagate events
## Properties and Methods
```javascript
app.controller('UserController', function($scope) {
  // Properties attached to $scope
  $scope.user = {
    name: 'Khoa',
    age: 22,
    email: 'khoa@example.com'
  };

  // Methods attached to $scope
  $scope.updateUser = function() {
    $scope.user.name = 'Updated Name';
  };

  // Watch for changes
  $scope.$watch('user.name', function(newVal, oldVal) {
    console.log('Name changed from ' + oldVal + ' to ' + newVal);
  });
});
```
# Scope Hierarchy
## Parent-Child Relationship
```html
<div ng-controller="ParentController">
  <p>{{ parentMessage }}</p>

  <div ng-controller="ChildController">
    <p>{{ childMessage }}</p>
    <p>{{ parentMessage }}</p> <!-- Child can access parent scope -->
  </div>
</div>
```

```javascript
app.controller('ParentController', function($scope) {
  $scope.parentMessage = 'From Parent';
});

app.controller('ChildController', function($scope) {
  $scope.childMessage = 'From Child';
  // Can access $scope.parentMessage through prototype chain
});
```
## Scope Inheritance
- Child scopes ==prototypically inherit== from parent scopes
- Properties defined in parent are accessible in child
- Modifying primitive values in child creates new property (does not modify parent)
- Modifying object properties in child affects parent object

# Controller Initialization

## Using ng-init
```html
<div ng-controller="MyController" ng-init="count = 5">
  <p>Count: {{ count }}</p>
</div>
```

## Better Practice: Initialize in Controller
```javascript
app.controller('MyController', function($scope) {
  // Initialize in controller instead of ng-init
  $scope.count = 5;

  $scope.increment = function() {
    $scope.count++;
  };
});
```

# Dependency Injection in Controllers

## Injecting Services
```javascript
app.controller('UserController', function($scope, $http, $timeout) {
  // $http service for HTTP requests
  $http.get('/api/users')
    .then(function(response) {
      $scope.users = response.data;
    });

  // $timeout service for delayed execution
  $timeout(function() {
    $scope.message = 'Loaded after 2 seconds';
  }, 2000);
});
```

## Minification-Safe Injection
```javascript
// Array annotation (minification-safe)
app.controller('UserController', ['$scope', '$http', function($scope, $http) {
  $http.get('/api/users')
    .then(function(response) {
      $scope.users = response.data;
    });
}]);

// $inject property annotation
var UserController = function($scope, $http) {
  // Controller logic
};
UserController.$inject = ['$scope', '$http'];
app.controller('UserController', UserController);
```
# Examples
## Good Controller Structure
```javascript
app.controller('TodoController', ['$scope', 'TodoService', function($scope, TodoService) {
  // Initialize
  $scope.todos = [];
  $scope.newTodo = '';

  // Load data using service
  TodoService.getAll().then(function(todos) {
    $scope.todos = todos;
  });

  // Business logic methods
  $scope.addTodo = function() {
    if ($scope.newTodo.trim()) {
      TodoService.add($scope.newTodo).then(function(todo) {
        $scope.todos.push(todo);
        $scope.newTodo = '';
      });
    }
  };

  $scope.removeTodo = function(todo) {
    TodoService.remove(todo.id).then(function() {
      var index = $scope.todos.indexOf(todo);
      $scope.todos.splice(index, 1);
    });
  };

  $scope.toggleComplete = function(todo) {
    TodoService.update(todo);
  };
}]);
```
***
# References
1. https://docs.angularjs.org/guide/controller for AngularJS controller guide
2. https://docs.angularjs.org/guide/scope for understanding `$scope`
3. [Dependency Injection](programming/javascript/angular/angularjs/dependency-injection/Dependency%20Injection.md)
4. [Digest cycle and watchers](../digest-cycle/Digest%20cycle%20and%20watchers.md)
5. [[programming/javascript/angular/angularjs/controllers/Controller as syntax]]
6. 
