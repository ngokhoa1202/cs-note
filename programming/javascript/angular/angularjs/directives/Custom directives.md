#angularjs #angular1 #javascript #directive #component #html #dom #legacy
==Custom directives== allow you to ==create reusable components== and extend HTML with new behaviors. They are one of the most powerful features of AngularJS, enabling you to build domain-specific markup.

# Creating a Directive

## Basic Directive Structure
```javascript
angular.module('myApp', [])
  .directive('myDirective', function() {
    return {
      restrict: 'E',
      template: '<div>Hello from directive!</div>'
    };
  });
```

```html
<my-directive></my-directive>
```

## Directive Definition Object
```javascript
app.directive('userCard', function() {
  return {
    restrict: 'E',              // Element, Attribute, Class, or Comment
    scope: {},                  // Isolate scope
    template: '<div></div>',    // Inline template
    templateUrl: 'user-card.html', // External template
    replace: true,              // Replace element with template
    transclude: false,          // Content projection
    controller: function() {},  // Controller function
    controllerAs: 'vm',        // Controller alias
    bindToController: true,     // Bind scope to controller
    link: function(scope, element, attrs) {}, // DOM manipulation
    compile: function(element, attrs) {},     // Compile function
    require: '^parentDirective' // Require other directives
  };
});
```

# Directive Restriction Types

## restrict Property
- ==`E`== - Element: `<my-directive></my-directive>`
- ==`A`== - Attribute: `<div my-directive></div>`
- ==`C`== - Class: `<div class="my-directive"></div>`
- ==`M`== - Comment: `<!-- directive: my-directive -->`

```javascript
// Element directive
app.directive('userCard', function() {
  return {
    restrict: 'E',
    template: '<div class="card">User Card</div>'
  };
});
```

```html
<user-card></user-card>
```

```javascript
// Attribute directive
app.directive('highlight', function() {
  return {
    restrict: 'A',
    link: function(scope, element, attrs) {
      element.css('background-color', 'yellow');
    }
  };
});
```

```html
<div highlight>This is highlighted</div>
```

```javascript
// Multiple restrictions
app.directive('tooltip', function() {
  return {
    restrict: 'EA', // Can be used as Element or Attribute
    template: '<span class="tooltip">{{ text }}</span>'
  };
});
```

```html
<tooltip></tooltip>
<div tooltip></div>
```

# Directive Scope

## Shared Scope (default)
- Directive shares parent scope
- Changes affect parent

```javascript
app.directive('sharedScope', function() {
  return {
    restrict: 'E',
    template: '<div>{{ message }}</div>'
  };
});
```

## Isolate Scope
- Directive has its own isolated scope
- Does not inherit from parent
- Best practice for reusable components

```javascript
app.directive('userCard', function() {
  return {
    restrict: 'E',
    scope: {}, // Isolate scope
    template: '<div class="card">Isolated</div>'
  };
});
```

## Scope Binding

### @ - One-way String Binding
```javascript
app.directive('greeting', function() {
  return {
    restrict: 'E',
    scope: {
      name: '@' // Binds to attribute value as string
    },
    template: '<div>Hello, {{ name }}!</div>'
  };
});
```

```html
<greeting name="Khoa"></greeting>
<greeting name="{{ userName }}"></greeting>
```

### = - Two-way Data Binding
```javascript
app.directive('userEditor', function() {
  return {
    restrict: 'E',
    scope: {
      user: '=' // Two-way binding
    },
    template: '<input ng-model="user.name">'
  };
});
```

```html
<user-editor user="currentUser"></user-editor>
```

### & - Expression Binding
```javascript
app.directive('deleteButton', function() {
  return {
    restrict: 'E',
    scope: {
      onDelete: '&' // Binds to parent function
    },
    template: '<button ng-click="onDelete()">Delete</button>'
  };
});
```

```html
<delete-button on-delete="removeUser(user)"></delete-button>
```

### Complete Example with All Bindings
```javascript
app.directive('taskItem', function() {
  return {
    restrict: 'E',
    scope: {
      title: '@',           // String binding
      task: '=',            // Two-way binding
      onComplete: '&',      // Function binding
      status: '@taskStatus' // Different attribute name
    },
    template: `
      <div class="task">
        <h3>{{ title }}</h3>
        <p>{{ task.description }}</p>
        <p>Status: {{ status }}</p>
        <input ng-model="task.completed" type="checkbox">
        <button ng-click="onComplete({ task: task })">Complete</button>
      </div>
    `
  };
});
```

```html
<task-item
  title="My Task"
  task="myTask"
  task-status="pending"
  on-complete="handleComplete(task)">
</task-item>
```

# Template Options

## Inline Template
```javascript
app.directive('simpleCard', function() {
  return {
    restrict: 'E',
    template: '<div class="card"><h2>{{ title }}</h2></div>'
  };
});
```

## Multi-line Template
```javascript
app.directive('userCard', function() {
  return {
    restrict: 'E',
    template: `
      <div class="card">
        <h2>{{ user.name }}</h2>
        <p>{{ user.email }}</p>
        <button ng-click="edit()">Edit</button>
      </div>
    `
  };
});
```

## External Template
```javascript
app.directive('userCard', function() {
  return {
    restrict: 'E',
    templateUrl: 'templates/user-card.html',
    scope: {
      user: '='
    }
  };
});
```

## Template Function
```javascript
app.directive('dynamicCard', function() {
  return {
    restrict: 'E',
    template: function(element, attrs) {
      if (attrs.type === 'large') {
        return '<div class="card large">Large Card</div>';
      }
      return '<div class="card">Normal Card</div>';
    }
  };
});
```

# Link Function

## Basic Link Function
```javascript
app.directive('colorPicker', function() {
  return {
    restrict: 'E',
    scope: {
      color: '='
    },
    template: '<input type="color" ng-model="color">',
    link: function(scope, element, attrs) {
      // DOM manipulation here
      element.css('border', '2px solid ' + scope.color);

      // Watch for changes
      scope.$watch('color', function(newVal) {
        element.css('border-color', newVal);
      });
    }
  };
});
```

## Link Function Parameters
- ==`scope`== - Directive's scope
- ==`element`== - jqLite-wrapped DOM element
- ==`attrs`== - Normalized attribute names and values
- ==`controller`== - Controller instance (when require is used)

```javascript
app.directive('tooltip', function() {
  return {
    restrict: 'A',
    scope: {
      tooltipText: '@'
    },
    link: function(scope, element, attrs) {
      // Create tooltip element
      var tooltip = angular.element('<span class="tooltip"></span>');
      tooltip.text(scope.tooltipText);

      // Add event listeners
      element.on('mouseenter', function() {
        element.append(tooltip);
      });

      element.on('mouseleave', function() {
        tooltip.remove();
      });

      // Cleanup on destroy
      scope.$on('$destroy', function() {
        element.off('mouseenter mouseleave');
      });
    }
  };
});
```

```html
<button tooltip tooltip-text="Click to save">Save</button>
```

# Transclusion (Content Projection)

## Basic Transclusion
```javascript
app.directive('panel', function() {
  return {
    restrict: 'E',
    transclude: true,
    template: `
      <div class="panel">
        <div class="panel-header">Panel Header</div>
        <div class="panel-body" ng-transclude></div>
      </div>
    `
  };
});
```

```html
<panel>
  <p>This content is transcluded</p>
  <button>Click me</button>
</panel>
```

## Multi-slot Transclusion
```javascript
app.directive('card', function() {
  return {
    restrict: 'E',
    transclude: {
      'header': '?cardHeader',
      'body': 'cardBody',
      'footer': '?cardFooter'
    },
    template: `
      <div class="card">
        <div class="card-header" ng-transclude="header"></div>
        <div class="card-body" ng-transclude="body"></div>
        <div class="card-footer" ng-transclude="footer"></div>
      </div>
    `
  };
});
```

```html
<card>
  <card-header>
    <h2>Card Title</h2>
  </card-header>
  <card-body>
    <p>Card content goes here</p>
  </card-body>
  <card-footer>
    <button>Action</button>
  </card-footer>
</card>
```

# Controllers in Directives

## Basic Controller
```javascript
app.directive('counter', function() {
  return {
    restrict: 'E',
    scope: {},
    template: `
      <div>
        <p>Count: {{ count }}</p>
        <button ng-click="increment()">+</button>
        <button ng-click="decrement()">-</button>
      </div>
    `,
    controller: function($scope) {
      $scope.count = 0;

      $scope.increment = function() {
        $scope.count++;
      };

      $scope.decrement = function() {
        $scope.count--;
      };
    }
  };
});
```

## Controller As with bindToController
```javascript
app.directive('userProfile', function() {
  return {
    restrict: 'E',
    scope: {
      user: '=',
      onSave: '&'
    },
    bindToController: true,
    controllerAs: 'vm',
    template: `
      <div>
        <h2>{{ vm.user.name }}</h2>
        <button ng-click="vm.save()">Save</button>
      </div>
    `,
    controller: function() {
      var vm = this;

      vm.save = function() {
        vm.onSave({ user: vm.user });
      };
    }
  };
});
```

# Require Other Directives

## Require Parent Directive
```javascript
// Parent directive
app.directive('tabs', function() {
  return {
    restrict: 'E',
    transclude: true,
    template: '<div class="tabs" ng-transclude></div>',
    controller: function() {
      var tabs = [];

      this.addTab = function(tab) {
        tabs.push(tab);
      };

      this.selectTab = function(selectedTab) {
        tabs.forEach(function(tab) {
          tab.selected = (tab === selectedTab);
        });
      };
    }
  };
});

// Child directive
app.directive('tab', function() {
  return {
    restrict: 'E',
    require: '^tabs', // Require parent tabs controller
    scope: {
      title: '@'
    },
    transclude: true,
    template: `
      <div ng-show="selected" ng-transclude></div>
    `,
    link: function(scope, element, attrs, tabsCtrl) {
      // Access parent controller
      tabsCtrl.addTab(scope);

      scope.select = function() {
        tabsCtrl.selectTab(scope);
      };
    }
  };
});
```

```html
<tabs>
  <tab title="Tab 1">
    <p>Content 1</p>
  </tab>
  <tab title="Tab 2">
    <p>Content 2</p>
  </tab>
</tabs>
```

# Real-World Examples

## Dropdown Component
```javascript
app.directive('dropdown', function($document) {
  return {
    restrict: 'E',
    scope: {
      options: '=',
      selected: '=',
      onSelect: '&'
    },
    template: `
      <div class="dropdown">
        <button ng-click="toggle()">
          {{ selected || 'Select...' }}
        </button>
        <ul ng-show="isOpen">
          <li ng-repeat="option in options"
              ng-click="selectOption(option)">
            {{ option }}
          </li>
        </ul>
      </div>
    `,
    link: function(scope, element, attrs) {
      scope.isOpen = false;

      scope.toggle = function() {
        scope.isOpen = !scope.isOpen;
      };

      scope.selectOption = function(option) {
        scope.selected = option;
        scope.isOpen = false;
        scope.onSelect({ option: option });
      };

      // Close dropdown when clicking outside
      var closeDropdown = function(event) {
        if (!element[0].contains(event.target)) {
          scope.$apply(function() {
            scope.isOpen = false;
          });
        }
      };

      $document.on('click', closeDropdown);

      scope.$on('$destroy', function() {
        $document.off('click', closeDropdown);
      });
    }
  };
});
```

## Pagination Component
```javascript
app.directive('pagination', function() {
  return {
    restrict: 'E',
    scope: {
      totalItems: '=',
      itemsPerPage: '=',
      currentPage: '=',
      onPageChange: '&'
    },
    template: `
      <div class="pagination">
        <button ng-click="goToPage(1)"
                ng-disabled="currentPage === 1">
          First
        </button>

        <button ng-click="goToPage(currentPage - 1)"
                ng-disabled="currentPage === 1">
          Previous
        </button>

        <span ng-repeat="page in getPages()">
          <button ng-click="goToPage(page)"
                  ng-class="{ 'active': page === currentPage }">
            {{ page }}
          </button>
        </span>

        <button ng-click="goToPage(currentPage + 1)"
                ng-disabled="currentPage === totalPages">
          Next
        </button>

        <button ng-click="goToPage(totalPages)"
                ng-disabled="currentPage === totalPages">
          Last
        </button>
      </div>
    `,
    controller: function($scope) {
      $scope.totalPages = Math.ceil($scope.totalItems / $scope.itemsPerPage);

      $scope.goToPage = function(page) {
        if (page >= 1 && page <= $scope.totalPages) {
          $scope.currentPage = page;
          $scope.onPageChange({ page: page });
        }
      };

      $scope.getPages = function() {
        var pages = [];
        var start = Math.max(1, $scope.currentPage - 2);
        var end = Math.min($scope.totalPages, $scope.currentPage + 2);

        for (var i = start; i <= end; i++) {
          pages.push(i);
        }

        return pages;
      };

      $scope.$watch('totalItems', function() {
        $scope.totalPages = Math.ceil($scope.totalItems / $scope.itemsPerPage);
      });
    }
  };
});
```

## Loading Spinner Directive
```javascript
app.directive('loadingSpinner', function() {
  return {
    restrict: 'E',
    scope: {
      loading: '=',
      message: '@'
    },
    template: `
      <div ng-show="loading" class="spinner-overlay">
        <div class="spinner"></div>
        <p ng-if="message">{{ message }}</p>
      </div>
    `,
    link: function(scope, element, attrs) {
      // Add CSS for spinner
      var style = angular.element('<style></style>');
      style.text(`
        .spinner-overlay {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background: rgba(0, 0, 0, 0.5);
          display: flex;
          align-items: center;
          justify-content: center;
          flex-direction: column;
        }
        .spinner {
          border: 4px solid #f3f3f3;
          border-top: 4px solid #3498db;
          border-radius: 50%;
          width: 40px;
          height: 40px;
          animation: spin 1s linear infinite;
        }
        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }
      `);
      angular.element(document.head).append(style);
    }
  };
});
```

```html
<loading-spinner loading="isLoading" message="Loading users..."></loading-spinner>
```

# Best Practices

## Do's
- **Use isolate scope** for reusable components
- **Prefer restrict 'E'** for component directives
- **Use restrict 'A'** for behavior directives
- **Use controllerAs** with bindToController
- **Clean up event listeners** in `$destroy`
- **Use templateUrl** for complex templates
- **Name directives clearly** and consistently

## Don'ts
- **Don't manipulate DOM outside link function**
- **Don't use $ prefix** for directive names (reserved for Angular)
- **Avoid ng prefix** (reserved for Angular)
- **Don't overcomplicate** - keep directives focused
- **Don't forget to clean up** resources and listeners

***
# References
1. https://docs.angularjs.org/guide/directive for directive developer guide
2. https://docs.angularjs.org/api/ng/service/$compile for $compile service
3. [Built-in directives](Built-in%20directives.md)
4. [Modern Angular](../../modern-angular/Modern%20Angular.md) for component migration
