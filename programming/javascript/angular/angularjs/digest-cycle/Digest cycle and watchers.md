#angularjs #angular1 #javascript #digest-cycle #scope #watchers #performance #legacy
The ==`$digest` cycle== is AngularJS's ==change detection mechanism== that monitors scope variables and updates the view when changes occur. Understanding the digest cycle is crucial for optimizing AngularJS applications.

# Concept
- AngularJS uses ==dirty checking== to detect changes
- The ==`$digest` cycle== runs through all ==watchers==
- Continues until no more changes are detected
- Maximum ==10 digest iterations== to prevent infinite loops

# How Digest Cycle Works

## Basic Flow
1. Event occurs (click, HTTP response, timeout)
2. ==`$digest` cycle== starts
3. Runs through all ==watchers== on current scope and children
4. If value changed, mark as ==dirty== and run watch listener
5. After all watchers checked, run digest again if any were dirty
6. Repeat until no changes or max 10 iterations
7. Update DOM with new values

## Diagram
```
Event → $digest → Check Watchers → Changes? → Yes → Run Again
                                              ↓ No
                                            Update DOM
```

# Watchers

## Creating Watchers
```javascript
app.controller('WatchController', function($scope) {
  $scope.name = 'Khoa';

  // Watch a single property
  $scope.$watch('name', function(newVal, oldVal) {
    console.log('Name changed: ' + oldVal + ' → ' + newVal);
  });

  // Watch expression
  $scope.$watch('user.age * 2', function(newVal, oldVal) {
    console.log('Double age: ' + newVal);
  });

  // Deep watch (watches object properties)
  $scope.$watch('user', function(newVal, oldVal) {
    console.log('User object changed');
  }, true); // true enables deep watch
});
```

## Watch Collection
```javascript
// Watch array/object changes (shallow)
$scope.$watchCollection('users', function(newVal, oldVal) {
  console.log('Users array changed');
});
```

## Watch Group
```javascript
// Watch multiple expressions
$scope.$watchGroup(['user.name', 'user.email'], function(newVals, oldVals) {
  console.log('Name or email changed');
  console.log('New values:', newVals);
});
```

# $apply and $digest

## $apply
- Executes expression and triggers ==`$digest` on `$rootScope`==
- Use when integrating with non-Angular code

```javascript
app.controller('ApplyController', function($scope, $timeout) {
  $scope.message = 'Hello';

  // Native setTimeout (outside Angular)
  setTimeout(function() {
    $scope.$apply(function() {
      $scope.message = 'Updated!';
    });
  }, 1000);

  // Angular $timeout (automatically calls $apply)
  $timeout(function() {
    $scope.message = 'Auto updated!';
  }, 2000);
});
```

## $digest
- Triggers digest cycle on ==current scope and children only==
- Use sparingly - prefer `$apply`

```javascript
$scope.$digest(); // Run digest on current scope
```

## When to Use $apply
```javascript
// Third-party library callback
$(document).on('customEvent', function() {
  $scope.$apply(function() {
    $scope.data = 'Updated from jQuery';
  });
});

// WebSocket message
socket.on('message', function(data) {
  $scope.$apply(function() {
    $scope.messages.push(data);
  });
});

// Non-Angular async operation
window.addEventListener('message', function(event) {
  $scope.$apply(function() {
    $scope.externalData = event.data;
  });
});
```

# Performance Considerations

## Watcher Count
```javascript
// Check watcher count (debugging)
function countWatchers() {
  var root = angular.element(document.getElementsByTagName('body'));
  var watchers = [];

  var f = function(element) {
    angular.forEach(['$scope', '$isolateScope'], function(scopeProperty) {
      if (element.data() && element.data().hasOwnProperty(scopeProperty)) {
        angular.forEach(element.data()[scopeProperty].$$watchers, function(watcher) {
          watchers.push(watcher);
        });
      }
    });

    angular.forEach(element.children(), function(childElement) {
      f(angular.element(childElement));
    });
  };

  f(root);
  return watchers.length;
}

console.log('Total watchers:', countWatchers());
```

## Optimization Tips
- **Limit watchers**: Keep under 2000 watchers per page
- **Use one-time binding**: `{{ ::value }}` (AngularJS 1.3+)
- **Debounce ng-model**: Use `ng-model-options` with debounce
- **Track by in ng-repeat**: Always use `track by`
- **Disable watchers**: Remove unnecessary `$watch` calls

## One-Time Binding
```html
<!-- Regular binding (creates watcher) -->
<p>{{ user.name }}</p>

<!-- One-time binding (no watcher after first digest) -->
<p>{{ ::user.name }}</p>

<ul>
  <li ng-repeat="item in ::items">
    {{ ::item.name }}
  </li>
</ul>
```

## Debounce ng-model
```html
<input type="text"
       ng-model="searchText"
       ng-model-options="{ debounce: 500 }">
```

# Best Practices

## Do's
- **Use Angular services** (`$timeout`, `$interval`) instead of native ones
- **Minimize watchers** - remove when no longer needed
- **Use one-time binding** for static data
- **Batch updates** when possible

## Don'ts
- **Avoid complex watch expressions**
- **Don't watch large objects** without necessity
- **Don't call `$apply` inside Angular context** (causes "$digest already in progress" error)
- **Don't create watchers in loops**

## Example: Remove Watchers
```javascript
app.controller('CleanupController', function($scope) {
  // Register watcher
  var unwatch = $scope.$watch('value', function(newVal) {
    console.log('Value changed:', newVal);
  });

  // Remove watcher when done
  $scope.cleanup = function() {
    unwatch(); // Call to remove watcher
  };

  // Auto cleanup on destroy
  $scope.$on('$destroy', function() {
    unwatch();
  });
});
```

***
# References
1. https://docs.angularjs.org/api/ng/type/$rootScope.Scope for scope API
2. https://docs.angularjs.org/guide/scope for scope guide
3. [Two-way data binding](../data-binding/Two-way%20data%20binding.md)
4. [Controllers and $scope](../controllers/Controllers%20and%20$scope.md)
