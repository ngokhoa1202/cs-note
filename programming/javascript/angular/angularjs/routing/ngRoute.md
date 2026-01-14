#angularjs #angular1 #javascript #routing #spa #navigation #legacy
==ngRoute== is AngularJS's official routing module that enables ==single-page application== (SPA) navigation by mapping URLs to controllers and templates.

# Setup

## Include ngRoute
```html
<script src="angular.js"></script>
<script src="angular-route.js"></script>
```

## Inject Dependency
```javascript
angular.module('myApp', ['ngRoute'])
  .config(function($routeProvider) {
    // Route configuration
  });
```

# Configuring Routes
```javascript
app.config(function($routeProvider) {
  $routeProvider
    .when('/home', {
      templateUrl: 'views/home.html',
      controller: 'HomeController'
    })
    .when('/users', {
      templateUrl: 'views/users.html',
      controller: 'UsersController',
      controllerAs: 'vm'
    })
    .when('/users/:id', {
      templateUrl: 'views/user-detail.html',
      controller: 'UserDetailController',
      resolve: {
        user: function($route, UserService) {
          return UserService.getById($route.current.params.id);
        }
      }
    })
    .otherwise({
      redirectTo: '/home'
    });
});
```

# ng-view Directive
```html
<!DOCTYPE html>
<html ng-app="myApp">
<body>
  <nav>
    <a href="#/home">Home</a>
    <a href="#/users">Users</a>
    <a href="#/about">About</a>
  </nav>

  <div ng-view></div>
</body>
</html>
```

# Route Parameters
```javascript
app.controller('UserDetailController', function($routeParams, UserService) {
  var userId = $routeParams.id;

  UserService.getById(userId).then(function(user) {
    this.user = user;
  });
});
```

# Programmatic Navigation
```javascript
app.controller('MyController', function($location) {
  this.goToUsers = function() {
    $location.path('/users');
  };

  this.goToUser = function(id) {
    $location.path('/users/' + id);
  };
});
```

***
# References
1. https://docs.angularjs.org/api/ngRoute for ngRoute documentation
2. [UI Router](UI%20Router.md) for advanced routing
