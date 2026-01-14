#angularjs #angular1 #javascript #directive #html #dom #legacy
==Directives== are markers on a DOM element that tell AngularJS to ==attach specific behavior== to that element or even transform the element and its children. AngularJS comes with a rich set of ==built-in directives== that extend HTML functionality.

# Core Directives

## ng-app
- ==Bootstraps== the AngularJS application
- Designates the root element of the application
- Only one ng-app per HTML document (normally)

```html
<html ng-app="myApp">
  <head>
    <script src="angular.js"></script>
    <script>
      angular.module('myApp', []);
    </script>
  </head>
  <body>
    <!-- AngularJS active here -->
  </body>
</html>
```

## ng-controller
- Attaches a controller to the view
- Creates a new child scope

```html
<div ng-controller="UserController">
  <p>{{ userName }}</p>
</div>
```

```javascript
app.controller('UserController', function($scope) {
  $scope.userName = 'Khoa';
});
```

# Data Binding Directives

## ng-model
- ==Two-way data binding== between view and model
- Primarily used with form elements
- Provides validation, CSS classes, and value formatting

```html
<input type="text" ng-model="user.name">
<p>Hello, {{ user.name }}!</p>
```

### ng-model with Different Input Types
```html
<!-- Text input -->
<input type="text" ng-model="user.name">

<!-- Checkbox -->
<input type="checkbox" ng-model="user.agreed">

<!-- Radio buttons -->
<input type="radio" ng-model="user.gender" value="male"> Male
<input type="radio" ng-model="user.gender" value="female"> Female

<!-- Select dropdown -->
<select ng-model="user.country">
  <option value="vn">Vietnam</option>
  <option value="us">United States</option>
  <option value="jp">Japan</option>
</select>

<!-- Textarea -->
<textarea ng-model="user.bio"></textarea>
```

## ng-bind
- One-way data binding from model to view
- Alternative to ==`{{ }}`== interpolation
- Prevents flashing of uncompiled template

```html
<!-- Using interpolation (may flash before compilation) -->
<p>Hello, {{ userName }}!</p>

<!-- Using ng-bind (no flashing) -->
<p>Hello, <span ng-bind="userName"></span>!</p>
```

## ng-bind-html
- Binds HTML content to an element
- Requires `ngSanitize` module for security
- ==Sanitizes HTML== to prevent XSS attacks

```javascript
angular.module('myApp', ['ngSanitize'])
  .controller('ContentController', function($scope) {
    $scope.htmlContent = '<strong>Bold text</strong> and <em>italic</em>';
  });
```

```html
<div ng-bind-html="htmlContent"></div>
<!-- Renders: Bold text and italic -->
```

# Conditional Directives

## ng-if
- ==Adds or removes== elements from DOM based on condition
- Creates a new scope
- Complete DOM removal (not just hiding)

```html
<div ng-if="isLoggedIn">
  <p>Welcome, {{ userName }}!</p>
</div>

<div ng-if="!isLoggedIn">
  <p>Please log in</p>
</div>
```

## ng-show / ng-hide
- ==Shows or hides== elements using CSS `display` property
- Does not remove from DOM
- No scope creation

```html
<!-- ng-show: shows when true -->
<div ng-show="isVisible">
  <p>This content is visible</p>
</div>

<!-- ng-hide: hides when true -->
<div ng-hide="isHidden">
  <p>This content is not hidden</p>
</div>
```

### ng-if vs ng-show
```html
<!-- ng-if: Better for expensive content that's rarely shown -->
<div ng-if="showExpensiveWidget">
  <expensive-widget></expensive-widget>
</div>

<!-- ng-show: Better for frequently toggled content -->
<div ng-show="showMenu">
  <ul>
    <li>Menu Item 1</li>
    <li>Menu Item 2</li>
  </ul>
</div>
```

## ng-switch
- ==Conditionally renders== one element from multiple choices
- Similar to switch statement in JavaScript

```html
<div ng-switch="userRole">
  <div ng-switch-when="admin">
    <h2>Admin Dashboard</h2>
    <p>You have full access</p>
  </div>

  <div ng-switch-when="user">
    <h2>User Dashboard</h2>
    <p>You have limited access</p>
  </div>

  <div ng-switch-default>
    <h2>Guest View</h2>
    <p>Please log in</p>
  </div>
</div>
```

# Loop Directives

## ng-repeat
- ==Iterates over a collection== and instantiates a template for each item
- Creates a new scope for each iteration
- Provides special properties: `$index`, `$first`, `$last`, `$middle`, `$even`, `$odd`

```html
<ul>
  <li ng-repeat="user in users">
    {{ $index + 1 }}. {{ user.name }} ({{ user.email }})
  </li>
</ul>
```

### ng-repeat Special Properties
```html
<table>
  <tr ng-repeat="item in items">
    <td>{{ $index }}</td>                    <!-- 0-based index -->
    <td>{{ item.name }}</td>
    <td ng-if="$first">First Item</td>       <!-- true for first item -->
    <td ng-if="$last">Last Item</td>         <!-- true for last item -->
    <td ng-class="{ 'even': $even }">        <!-- true for even indices -->
      {{ item.value }}
    </td>
  </tr>
</table>
```

### ng-repeat with Objects
```html
<!-- Iterate over object properties -->
<div ng-repeat="(key, value) in user">
  <strong>{{ key }}:</strong> {{ value }}
</div>
```

### ng-repeat with Filters
```html
<!-- Filter and order results -->
<ul>
  <li ng-repeat="user in users | filter: searchText | orderBy: 'name'">
    {{ user.name }}
  </li>
</ul>
```

### ng-repeat with track by
```html
<!-- Use track by for better performance -->
<div ng-repeat="item in items track by item.id">
  {{ item.name }}
</div>

<!-- Track by $index for primitive arrays -->
<div ng-repeat="tag in tags track by $index">
  {{ tag }}
</div>
```

# Event Directives

## ng-click
- Executes expression when element is clicked

```html
<button ng-click="count = count + 1">
  Clicked {{ count }} times
</button>

<button ng-click="deleteUser(user)">Delete</button>
```

## ng-submit
- Executes expression when form is submitted
- Prevents default form submission

```html
<form ng-submit="submitForm()">
  <input type="text" ng-model="formData.name">
  <button type="submit">Submit</button>
</form>
```

## Other Event Directives
```html
<!-- Double click -->
<div ng-dblclick="onDoubleClick()">Double click me</div>

<!-- Mouse events -->
<div ng-mouseenter="isHovering = true"
     ng-mouseleave="isHovering = false">
  Hover over me
</div>

<!-- Keyboard events -->
<input type="text"
       ng-keyup="onKeyUp($event)"
       ng-keydown="onKeyDown($event)"
       ng-keypress="onKeyPress($event)">

<!-- Focus events -->
<input type="text"
       ng-focus="isFocused = true"
       ng-blur="isFocused = false">

<!-- Change event -->
<select ng-change="onCountryChange()" ng-model="selectedCountry">
  <option value="vn">Vietnam</option>
  <option value="us">USA</option>
</select>
```

# Class and Style Directives

## ng-class
- ==Dynamically sets CSS classes== on an element

```html
<!-- String syntax -->
<div ng-class="myClass">Content</div>

<!-- Object syntax -->
<div ng-class="{ 'active': isActive, 'disabled': isDisabled }">
  Button
</div>

<!-- Array syntax -->
<div ng-class="['class1', 'class2', myDynamicClass]">
  Content
</div>

<!-- Expression syntax -->
<div ng-class="isActive ? 'active' : 'inactive'">
  Status
</div>
```

## ng-style
- ==Dynamically sets CSS styles== on an element

```html
<div ng-style="{ 'color': textColor, 'font-size': fontSize + 'px' }">
  Styled text
</div>

<div ng-style="myStyles">
  Custom styles
</div>
```

```javascript
$scope.myStyles = {
  'background-color': '#3498db',
  'padding': '10px',
  'border-radius': '5px'
};
```

## ng-class-even / ng-class-odd
- Applies classes to even/odd items in ng-repeat

```html
<ul>
  <li ng-repeat="item in items"
      ng-class-even="'even-row'"
      ng-class-odd="'odd-row'">
    {{ item.name }}
  </li>
</ul>
```

# Attribute Directives

## ng-src
- Use instead of `src` for images to prevent 404 errors

```html
<!-- Bad: May cause 404 error during template compilation -->
<img src="{{ imageUrl }}">

<!-- Good: Waits for AngularJS to compile -->
<img ng-src="{{ imageUrl }}">
```

## ng-href
- Use instead of `href` for links

```html
<!-- Bad: May navigate to wrong URL -->
<a href="{{ profileUrl }}">Profile</a>

<!-- Good: Waits for compilation -->
<a ng-href="{{ profileUrl }}">Profile</a>
```

## ng-disabled
- Conditionally disables form elements

```html
<button ng-disabled="isProcessing">Submit</button>

<input type="text" ng-disabled="!isEditable" ng-model="user.name">
```

## ng-readonly
- Makes form elements read-only conditionally

```html
<input type="text" ng-readonly="!canEdit" ng-model="user.email">
```

## ng-checked
- Sets checked state of checkbox/radio

```html
<input type="checkbox" ng-checked="isChecked">
```

## ng-selected
- Sets selected state of option

```html
<select>
  <option ng-repeat="country in countries"
          ng-selected="country.code === selectedCountry"
          value="{{ country.code }}">
    {{ country.name }}
  </option>
</select>
```

# Form Validation Directives

## ng-required
```html
<input type="text" ng-model="user.name" ng-required="true">
<input type="email" ng-model="user.email" ng-required="isEmailRequired">
```

## ng-minlength / ng-maxlength
```html
<input type="text"
       ng-model="user.username"
       ng-minlength="3"
       ng-maxlength="20">
```

## ng-pattern
```html
<input type="text"
       ng-model="user.phone"
       ng-pattern="/^[0-9]{10}$/">
```

# Other Useful Directives

## ng-init
- Initializes scope variables
- Better practice: initialize in controller

```html
<div ng-init="count = 0; message = 'Hello'">
  {{ message }} - Count: {{ count }}
</div>
```

## ng-cloak
- Prevents flashing of uncompiled template
- Hides element until AngularJS is ready

```html
<style>
  [ng-cloak] {
    display: none !important;
  }
</style>

<div ng-cloak>
  {{ message }} <!-- Won't flash during load -->
</div>
```

## ng-include
- Includes external HTML template

```html
<!-- String -->
<div ng-include="'templates/header.html'"></div>

<!-- Expression -->
<div ng-include="templateUrl"></div>
```

## ng-transclude
- Used with custom directives for content projection

```html
<!-- Directive template -->
<div class="card">
  <div ng-transclude></div>
</div>
```

# Real-World Example

## User Management Interface
```html
<div ng-controller="UserController as ctrl">
  <!-- Loading indicator -->
  <div ng-show="ctrl.isLoading" ng-cloak>
    <p>Loading users...</p>
  </div>

  <!-- Error message -->
  <div ng-if="ctrl.error" class="error">
    {{ ctrl.error }}
  </div>

  <!-- Add user form -->
  <form ng-submit="ctrl.addUser()" ng-hide="ctrl.isLoading">
    <input type="text"
           ng-model="ctrl.newUser.name"
           ng-required="true"
           placeholder="Name">

    <input type="email"
           ng-model="ctrl.newUser.email"
           ng-required="true"
           placeholder="Email">

    <button type="submit" ng-disabled="!ctrl.newUser.name || !ctrl.newUser.email">
      Add User
    </button>
  </form>

  <!-- User list -->
  <table ng-if="ctrl.users.length > 0">
    <thead>
      <tr>
        <th ng-click="ctrl.sortBy('name')">Name</th>
        <th ng-click="ctrl.sortBy('email')">Email</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <tr ng-repeat="user in ctrl.users | orderBy: ctrl.orderField track by user.id"
          ng-class="{ 'active-user': user.isActive, 'inactive-user': !user.isActive }">

        <td>{{ user.name }}</td>
        <td>{{ user.email }}</td>

        <td>
          <span ng-show="user.isActive" class="badge badge-success">Active</span>
          <span ng-hide="user.isActive" class="badge badge-danger">Inactive</span>
        </td>

        <td>
          <button ng-click="ctrl.editUser(user)">Edit</button>
          <button ng-click="ctrl.deleteUser(user)"
                  ng-disabled="ctrl.isDeleting">
            Delete
          </button>
        </td>
      </tr>
    </tbody>
  </table>

  <!-- Empty state -->
  <div ng-if="ctrl.users.length === 0 && !ctrl.isLoading">
    <p>No users found. Add one above!</p>
  </div>
</div>
```

***
# References
1. https://docs.angularjs.org/api/ng/directive for complete directive reference
2. https://docs.angularjs.org/guide/directive for directive guide
3. [Custom directives](Custom%20directives.md) for creating your own directives
4. [Form validation](../forms/Form%20validation.md)
5. [Filters](../filters/Filters.md)
