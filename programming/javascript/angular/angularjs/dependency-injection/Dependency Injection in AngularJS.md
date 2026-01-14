#angularjs #angular1 #javascript #dependency-injection #design-pattern #ioc #legacy
==Dependency Injection== (DI) is a core design pattern in AngularJS that handles ==creating and providing dependencies== to components. AngularJS has a built-in DI system that manages the lifecycle of services and injects them where needed.

# Concept
- ==Inversion of Control== (IoC) pattern
- Framework ==creates and manages== dependencies
- Components ==declare== what they need
- Promotes ==loose coupling== and ==testability==

# Injection Methods

## Implicit Annotation
```javascript
// NOT minification-safe
app.controller('UserController', function($scope, $http, UserService) {
  // Dependencies inferred from parameter names
});
```

## Inline Array Annotation (Recommended)
```javascript
// Minification-safe
app.controller('UserController', ['$scope', '$http', 'UserService',
  function($scope, $http, UserService) {
    // Dependencies explicitly declared
  }
]);
```

## $inject Property Annotation
```javascript
var UserController = function($scope, $http, UserService) {
  // Controller logic
};

UserController.$inject = ['$scope', '$http', 'UserService'];

app.controller('UserController', UserController);
```

# Built-in Services
- ==`$http`== - HTTP requests
- ==`$timeout`== - Delayed execution
- ==`$interval`== - Repeated execution
- ==`$q`== - Promises
- ==`$location`== - URL manipulation
- ==`$route`== / `$routeParams` - Routing
- ==`$scope`== / `$rootScope` - Scope management
- ==`$filter`== - Data formatting
- ==`$window`== - Window object
- ==`$document`== - Document object

# Injecting Services
```javascript
app.controller('ExampleController', ['$scope', '$http', '$timeout',
  function($scope, $http, $timeout) {
    $http.get('/api/data').then(function(response) {
      $scope.data = response.data;
    });

    $timeout(function() {
      console.log('Executed after 1 second');
    }, 1000);
  }
]);
```

# Dependency Injection in Different Components

## Controllers
```javascript
app.controller('MyController', ['$scope', 'MyService',
  function($scope, MyService) {
    $scope.data = MyService.getData();
  }
]);
```

## Services
```javascript
app.service('UserService', ['$http', '$q',
  function($http, $q) {
    this.getUsers = function() {
      return $http.get('/api/users');
    };
  }
]);
```

## Directives
```javascript
app.directive('myDirective', ['$timeout',
  function($timeout) {
    return {
      link: function(scope, element, attrs) {
        $timeout(function() {
          element.addClass('loaded');
        }, 100);
      }
    };
  }
]);
```

## Filters
```javascript
app.filter('formatDate', ['$filter',
  function($filter) {
    return function(input) {
      return $filter('date')(input, 'yyyy-MM-dd');
    };
  }
]);
```

# Benefits of DI
- **Testability**: Easy to mock dependencies in unit tests
- **Maintainability**: Clear dependency declarations
- **Flexibility**: Easy to swap implementations
- **Reusability**: Services can be injected anywhere

***
# References
1. https://docs.angularjs.org/guide/di for DI guide
2. [Services and Factories](../services/Services%20and%20Factories.md)
3. [Controllers and $scope](../controllers/Controllers%20and%20$scope.md)
