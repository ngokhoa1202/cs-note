#angularjs #angular1 #javascript #controller #best-practice #legacy
==Controller as syntax== is an alternative way to write controllers in AngularJS that ==binds methods and properties to the controller instance== rather than directly to `$scope`. This approach is considered a ==best practice== and bridges the gap toward modern Angular's component-based architecture.

# Concept
- Binds properties to ==`this`== instead of ==`$scope`==
- Controller instance is published into the scope under a specified name
- Provides better clarity about where properties come from
- More aligned with ES6 classes and modern JavaScript
- Easier migration path to Modern Angular

# Basic Syntax

## Controller Definition
```javascript
angular.module('myApp', [])
  .controller('UserController', function() {
    var vm = this; // "vm" stands for ViewModel

    vm.name = 'Khoa';
    vm.age = 22;

    vm.greet = function() {
      alert('Hello, ' + vm.name);
    };
  });
```

## Using in HTML
```html
<div ng-app="myApp" ng-controller="UserController as userCtrl">
  <h1>{{ userCtrl.name }}</h1>
  <p>Age: {{ userCtrl.age }}</p>
  <button ng-click="userCtrl.greet()">Greet</button>
</div>
```

# Traditional $scope vs Controller As

## Traditional $scope Approach
```javascript
app.controller('TodoController', function($scope) {
  $scope.todos = [];

  $scope.addTodo = function(todo) {
    $scope.todos.push(todo);
  };
});
```

```html
<div ng-controller="TodoController">
  <ul>
    <li ng-repeat="todo in todos">{{ todo }}</li>
  </ul>
  <button ng-click="addTodo('New Task')">Add</button>
</div>
```

## Controller As Approach
```javascript
app.controller('TodoController', function() {
  var vm = this;
  vm.todos = [];

  vm.addTodo = function(todo) {
    vm.todos.push(todo);
  };
});
```

```html
<div ng-controller="TodoController as todoCtrl">
  <ul>
    <li ng-repeat="todo in todoCtrl.todos">{{ todo }}</li>
  </ul>
  <button ng-click="todoCtrl.addTodo('New Task')">Add</button>
</div>
```

# Advantages

## Clarity and Readability
```html
<!-- Clear where properties come from -->
<div ng-controller="UserController as user">
  <div ng-controller="ProductController as product">
    <p>User: {{ user.name }}</p>        <!-- From UserController -->
    <p>Product: {{ product.name }}</p>  <!-- From ProductController -->
  </div>
</div>
```

## No $scope Confusion
```javascript
// Traditional: $scope can be confusing in nested scopes
app.controller('ParentController', function($scope) {
  $scope.value = 'parent';

  $scope.updateValue = function() {
    $scope.value = 'updated'; // Which scope?
  };
});

// Controller As: Clear reference
app.controller('ParentController', function() {
  var vm = this;
  vm.value = 'parent';

  vm.updateValue = function() {
    vm.value = 'updated'; // Clearly refers to this controller
  };
});
```

## Easier Testing
```javascript
describe('UserController', function() {
  var controller;

  beforeEach(function() {
    controller = new UserController();
  });

  it('should initialize with name', function() {
    expect(controller.name).toBe('Khoa');
  });

  it('should greet user', function() {
    spyOn(window, 'alert');
    controller.greet();
    expect(window.alert).toHaveBeenCalledWith('Hello, Khoa');
  });
});
```

# When $scope is Still Needed

## Watching for Changes
```javascript
app.controller('UserController', function($scope) {
  var vm = this;
  vm.name = 'Khoa';

  // $scope needed for $watch
  $scope.$watch('vm.name', function(newVal, oldVal) {
    console.log('Name changed from ' + oldVal + ' to ' + newVal);
  });
});
```

## Event Broadcasting
```javascript
app.controller('UserController', function($scope) {
  var vm = this;

  // $scope needed for $emit and $broadcast
  $scope.$emit('userUpdated', vm.user);

  $scope.$on('dataChanged', function(event, data) {
    vm.data = data;
  });
});
```

## Using $scope Methods
```javascript
app.controller('UserController', function($scope) {
  var vm = this;
  vm.users = [];

  // $scope needed for $apply
  setTimeout(function() {
    $scope.$apply(function() {
      vm.users.push({name: 'New User'});
    });
  }, 1000);
});
```

# Real-World Example

## Complete Todo Application
```javascript
angular.module('todoApp', [])
  .controller('TodoController', ['$http', function($http) {
    var vm = this;

    // Properties
    vm.todos = [];
    vm.newTodo = '';
    vm.filter = 'all';

    // Initialize
    vm.init = function() {
      $http.get('/api/todos').then(function(response) {
        vm.todos = response.data;
      });
    };

    // Methods
    vm.addTodo = function() {
      if (vm.newTodo.trim()) {
        var todo = {
          text: vm.newTodo,
          completed: false,
          createdAt: new Date()
        };

        $http.post('/api/todos', todo).then(function(response) {
          vm.todos.push(response.data);
          vm.newTodo = '';
        });
      }
    };

    vm.removeTodo = function(todo) {
      $http.delete('/api/todos/' + todo.id).then(function() {
        var index = vm.todos.indexOf(todo);
        vm.todos.splice(index, 1);
      });
    };

    vm.toggleComplete = function(todo) {
      $http.put('/api/todos/' + todo.id, todo);
    };

    vm.clearCompleted = function() {
      var completedTodos = vm.todos.filter(function(t) {
        return t.completed;
      });

      completedTodos.forEach(function(todo) {
        vm.removeTodo(todo);
      });
    };

    vm.getRemainingCount = function() {
      return vm.todos.filter(function(t) {
        return !t.completed;
      }).length;
    };

    // Initialize on load
    vm.init();
  }]);
```

```html
<div ng-app="todoApp" ng-controller="TodoController as todo">
  <h1>Todo List</h1>

  <!-- Add new todo -->
  <form ng-submit="todo.addTodo()">
    <input type="text"
           ng-model="todo.newTodo"
           placeholder="What needs to be done?">
    <button type="submit">Add</button>
  </form>

  <!-- Filter options -->
  <div>
    <button ng-click="todo.filter = 'all'">All</button>
    <button ng-click="todo.filter = 'active'">Active</button>
    <button ng-click="todo.filter = 'completed'">Completed</button>
  </div>

  <!-- Todo list -->
  <ul>
    <li ng-repeat="item in todo.todos | filter: { completed: todo.filter === 'completed' }">
      <input type="checkbox"
             ng-model="item.completed"
             ng-change="todo.toggleComplete(item)">
      <span ng-class="{ 'completed': item.completed }">
        {{ item.text }}
      </span>
      <button ng-click="todo.removeTodo(item)">Remove</button>
    </li>
  </ul>

  <!-- Summary -->
  <div>
    <span>{{ todo.getRemainingCount() }} items left</span>
    <button ng-click="todo.clearCompleted()">Clear completed</button>
  </div>
</div>
```

# Using with ES6 Classes

## ES6 Class Controller
```javascript
class UserController {
  constructor($http) {
    this.$http = $http;
    this.users = [];
    this.loadUsers();
  }

  loadUsers() {
    this.$http.get('/api/users').then((response) => {
      this.users = response.data;
    });
  }

  addUser(user) {
    this.$http.post('/api/users', user).then((response) => {
      this.users.push(response.data);
    });
  }

  deleteUser(user) {
    this.$http.delete('/api/users/' + user.id).then(() => {
      const index = this.users.indexOf(user);
      this.users.splice(index, 1);
    });
  }
}

UserController.$inject = ['$http'];

angular.module('myApp')
  .controller('UserController', UserController);
```

# Best Practices

## Use Consistent ViewModel Naming
```javascript
// Good: Use 'vm' (ViewModel) consistently
app.controller('UserController', function() {
  var vm = this;
  vm.name = 'Khoa';
});

// Good: Or use descriptive name
app.controller('UserController', function() {
  var user = this;
  user.name = 'Khoa';
});

// Avoid: Using 'this' directly (can be confusing)
app.controller('UserController', function() {
  this.name = 'Khoa'; // Context can change
});
```

## Organize Properties and Methods
```javascript
app.controller('UserController', function($http) {
  var vm = this;

  // Public properties (used in view)
  vm.users = [];
  vm.selectedUser = null;

  // Public methods (used in view)
  vm.selectUser = selectUser;
  vm.deleteUser = deleteUser;

  // Initialization
  activate();

  ////////////////

  // Private/implementation functions
  function activate() {
    loadUsers();
  }

  function loadUsers() {
    $http.get('/api/users').then(function(response) {
      vm.users = response.data;
    });
  }

  function selectUser(user) {
    vm.selectedUser = user;
  }

  function deleteUser(user) {
    $http.delete('/api/users/' + user.id).then(function() {
      var index = vm.users.indexOf(user);
      vm.users.splice(index, 1);
    });
  }
});
```

## Use with Directives
```javascript
app.directive('userCard', function() {
  return {
    restrict: 'E',
    scope: {
      user: '='
    },
    controller: function() {
      var vm = this;

      vm.formatName = function() {
        return vm.user.firstName + ' ' + vm.user.lastName;
      };
    },
    controllerAs: 'userCard',
    bindToController: true,
    template: '<div>{{ userCard.formatName() }}</div>'
  };
});
```

***
# References
1. https://docs.angularjs.org/api/ng/directive/ngController for ngController documentation
2. https://johnpapa.net/angularjss-controller-as-and-the-vm-variable for best practices
3. [Controllers and $scope](Controllers%20and%20$scope.md)
4. [Modern Angular](../../modern-angular/Modern%20Angular.md) for migration path
