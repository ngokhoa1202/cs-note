#angularjs #angular1 #javascript #service #factory #dependency-injection #singleton #legacy
==Services== and ==Factories== in AngularJS are ==singleton objects== used to organize and share code across your application. They are perfect for ==business logic==, ==data access==, and ==shared functionality== that doesn't belong in controllers or directives.

# Service vs Factory

## Key Differences
- ==Service==: Uses `new` keyword, ==binds to `this`==
- ==Factory==: Returns an object, ==more flexible==
- Both are ==singletons== (instantiated once)
- Both support ==dependency injection==

## Service Example
```javascript
angular.module('myApp', [])
  .service('UserService', function($http) {
    // 'this' is the service instance
    this.getUsers = function() {
      return $http.get('/api/users');
    };

    this.getUser = function(id) {
      return $http.get('/api/users/' + id);
    };
  });
```

## Factory Example
```javascript
angular.module('myApp', [])
  .factory('UserFactory', function($http) {
    // Return an object
    return {
      getUsers: function() {
        return $http.get('/api/users');
      },

      getUser: function(id) {
        return $http.get('/api/users/' + id);
      }
    };
  });
```

## Using Services and Factories
```javascript
// Both are injected the same way
app.controller('UserController', function(UserService, UserFactory) {
  // Using service
  UserService.getUsers().then(function(response) {
    console.log(response.data);
  });

  // Using factory
  UserFactory.getUsers().then(function(response) {
    console.log(response.data);
  });
});
```

# Creating Services

## Basic Service
```javascript
app.service('MathService', function() {
  this.add = function(a, b) {
    return a + b;
  };

  this.multiply = function(a, b) {
    return a * b;
  };

  this.calculate = function(operation, a, b) {
    switch(operation) {
      case 'add': return this.add(a, b);
      case 'multiply': return this.multiply(a, b);
      default: return 0;
    }
  };
});
```

## Service with Private Methods
```javascript
app.service('AuthService', function($http) {
  var currentUser = null;  // Private variable

  // Private method
  var saveToken = function(token) {
    localStorage.setItem('auth_token', token);
  };

  // Public methods
  this.login = function(credentials) {
    return $http.post('/api/login', credentials)
      .then(function(response) {
        currentUser = response.data.user;
        saveToken(response.data.token);
        return currentUser;
      });
  };

  this.logout = function() {
    currentUser = null;
    localStorage.removeItem('auth_token');
  };

  this.getCurrentUser = function() {
    return currentUser;
  };

  this.isAuthenticated = function() {
    return currentUser !== null;
  };
});
```

# Creating Factories

## Basic Factory
```javascript
app.factory('MathFactory', function() {
  var factory = {};

  factory.add = function(a, b) {
    return a + b;
  };

  factory.multiply = function(a, b) {
    return a * b;
  };

  return factory;
});
```

## Factory with Revealing Module Pattern
```javascript
app.factory('TodoFactory', function($http) {
  var todos = [];

  // Private function
  function processData(data) {
    return data.map(function(item) {
      item.formatted = item.title.toUpperCase();
      return item;
    });
  }

  // Public API
  return {
    getAll: function() {
      return $http.get('/api/todos')
        .then(function(response) {
          todos = processData(response.data);
          return todos;
        });
    },

    getById: function(id) {
      return $http.get('/api/todos/' + id)
        .then(function(response) {
          return response.data;
        });
    },

    create: function(todo) {
      return $http.post('/api/todos', todo)
        .then(function(response) {
          todos.push(response.data);
          return response.data;
        });
    },

    update: function(todo) {
      return $http.put('/api/todos/' + todo.id, todo)
        .then(function(response) {
          var index = todos.findIndex(function(t) {
            return t.id === todo.id;
          });
          if (index !== -1) {
            todos[index] = response.data;
          }
          return response.data;
        });
    },

    delete: function(id) {
      return $http.delete('/api/todos/' + id)
        .then(function() {
          todos = todos.filter(function(t) {
            return t.id !== id;
          });
        });
    },

    getCached: function() {
      return todos;
    }
  };
});
```

## Factory as Constructor
```javascript
app.factory('User', function() {
  function User(data) {
    this.id = data.id;
    this.name = data.name;
    this.email = data.email;
    this.role = data.role || 'user';
  }

  User.prototype.isAdmin = function() {
    return this.role === 'admin';
  };

  User.prototype.getDisplayName = function() {
    return this.name + ' (' + this.email + ')';
  };

  User.prototype.hasPermission = function(permission) {
    // Permission check logic
    return this.role === 'admin' || this.permissions.indexOf(permission) !== -1;
  };

  // Return constructor
  return User;
});

// Usage
app.controller('UserController', function(User) {
  var userData = { id: 1, name: 'Khoa', email: 'khoa@example.com', role: 'admin' };
  var user = new User(userData);

  console.log(user.isAdmin());        // true
  console.log(user.getDisplayName()); // "Khoa (khoa@example.com)"
});
```

# Real-World Service Examples

## Authentication Service
```javascript
app.service('AuthenticationService', function($http, $q, $window) {
  var self = this;
  self.currentUser = null;

  self.login = function(username, password) {
    return $http.post('/api/auth/login', {
      username: username,
      password: password
    }).then(function(response) {
      self.currentUser = response.data.user;
      $window.localStorage.setItem('token', response.data.token);
      $window.localStorage.setItem('user', JSON.stringify(response.data.user));
      return self.currentUser;
    });
  };

  self.logout = function() {
    self.currentUser = null;
    $window.localStorage.removeItem('token');
    $window.localStorage.removeItem('user');
  };

  self.isAuthenticated = function() {
    return !!self.getToken();
  };

  self.getToken = function() {
    return $window.localStorage.getItem('token');
  };

  self.getCurrentUser = function() {
    if (!self.currentUser) {
      var userJson = $window.localStorage.getItem('user');
      if (userJson) {
        self.currentUser = JSON.parse(userJson);
      }
    }
    return self.currentUser;
  };

  self.hasRole = function(role) {
    var user = self.getCurrentUser();
    return user && user.roles && user.roles.indexOf(role) !== -1;
  };
});
```

## HTTP Interceptor Service
```javascript
app.factory('AuthInterceptor', function($q, $window, $location) {
  return {
    request: function(config) {
      config.headers = config.headers || {};
      var token = $window.localStorage.getItem('token');
      if (token) {
        config.headers.Authorization = 'Bearer ' + token;
      }
      return config;
    },

    responseError: function(response) {
      if (response.status === 401) {
        $window.localStorage.removeItem('token');
        $location.path('/login');
      }
      return $q.reject(response);
    }
  };
});

// Register interceptor
app.config(function($httpProvider) {
  $httpProvider.interceptors.push('AuthInterceptor');
});
```

## Data Cache Service
```javascript
app.factory('CacheService', function($cacheFactory) {
  var cache = $cacheFactory('myCache');
  var DEFAULT_TTL = 300000; // 5 minutes

  return {
    put: function(key, value, ttl) {
      var expiresAt = Date.now() + (ttl || DEFAULT_TTL);
      cache.put(key, {
        data: value,
        expiresAt: expiresAt
      });
    },

    get: function(key) {
      var cached = cache.get(key);
      if (!cached) {
        return null;
      }

      if (Date.now() > cached.expiresAt) {
        cache.remove(key);
        return null;
      }

      return cached.data;
    },

    remove: function(key) {
      cache.remove(key);
    },

    clear: function() {
      cache.removeAll();
    }
  };
});
```

## Notification Service
```javascript
app.service('NotificationService', function($timeout) {
  var notifications = [];

  this.success = function(message, duration) {
    this.notify('success', message, duration);
  };

  this.error = function(message, duration) {
    this.notify('error', message, duration);
  };

  this.warning = function(message, duration) {
    this.notify('warning', message, duration);
  };

  this.info = function(message, duration) {
    this.notify('info', message, duration);
  };

  this.notify = function(type, message, duration) {
    var notification = {
      type: type,
      message: message,
      timestamp: Date.now()
    };

    notifications.push(notification);

    var ttl = duration || 3000;
    $timeout(function() {
      var index = notifications.indexOf(notification);
      if (index !== -1) {
        notifications.splice(index, 1);
      }
    }, ttl);
  };

  this.getNotifications = function() {
    return notifications;
  };

  this.clear = function() {
    notifications.length = 0;
  };
});
```

## Local Storage Service
```javascript
app.factory('LocalStorageService', function($window) {
  return {
    set: function(key, value) {
      try {
        $window.localStorage.setItem(key, JSON.stringify(value));
        return true;
      } catch(e) {
        console.error('Error saving to localStorage:', e);
        return false;
      }
    },

    get: function(key) {
      try {
        var item = $window.localStorage.getItem(key);
        return item ? JSON.parse(item) : null;
      } catch(e) {
        console.error('Error reading from localStorage:', e);
        return null;
      }
    },

    remove: function(key) {
      try {
        $window.localStorage.removeItem(key);
        return true;
      } catch(e) {
        console.error('Error removing from localStorage:', e);
        return false;
      }
    },

    clear: function() {
      try {
        $window.localStorage.clear();
        return true;
      } catch(e) {
        console.error('Error clearing localStorage:', e);
        return false;
      }
    },

    keys: function() {
      return Object.keys($window.localStorage);
    }
  };
});
```

# Best Practices

## Service Design Principles
- **Single Responsibility**: Each service should have one clear purpose
- **Reusability**: Write services that can be used across multiple controllers
- **Testability**: Keep services pure and easy to unit test
- **Consistency**: Use either service or factory consistently (factory is more common)

## When to Use Service vs Factory
```javascript
// Use Service when thinking in terms of classes
app.service('Calculator', function() {
  this.add = function(a, b) { return a + b; };
});

// Use Factory for more flexibility
app.factory('Calculator', function() {
  return {
    add: function(a, b) { return a + b; }
  };
});

// Recommendation: Use Factory (more common in community)
```

## Organizing Large Services
```javascript
app.factory('UserService', function($http, $q) {
  // API methods
  var api = {
    getAll: function() {
      return $http.get('/api/users');
    },
    getById: function(id) {
      return $http.get('/api/users/' + id);
    },
    create: function(user) {
      return $http.post('/api/users', user);
    },
    update: function(id, user) {
      return $http.put('/api/users/' + id, user);
    },
    delete: function(id) {
      return $http.delete('/api/users/' + id);
    }
  };

  // Business logic methods
  var business = {
    isEmailAvailable: function(email) {
      return $http.get('/api/users/check-email', { params: { email: email } })
        .then(function(response) {
          return response.data.available;
        });
    },

    validatePassword: function(password) {
      var minLength = 8;
      var hasUpperCase = /[A-Z]/.test(password);
      var hasLowerCase = /[a-z]/.test(password);
      var hasNumber = /\d/.test(password);

      return password.length >= minLength && hasUpperCase && hasLowerCase && hasNumber;
    }
  };

  // Public API
  return {
    // Expose API methods
    getAll: api.getAll,
    getById: api.getById,
    create: api.create,
    update: api.update,
    delete: api.delete,

    // Expose business methods
    isEmailAvailable: business.isEmailAvailable,
    validatePassword: business.validatePassword
  };
});
```

***
# References
1. https://docs.angularjs.org/guide/services for services guide
2. https://docs.angularjs.org/guide/providers for understanding providers
3. [Providers](Providers.md) for advanced service configuration
4. [Dependency Injection](programming/javascript/angular/angularjs/dependency-injection/Dependency%20Injection.md)
5. [Values and Constants](Values%20and%20Constants.md)
