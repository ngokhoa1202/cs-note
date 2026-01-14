#angularjs #angular1 #javascript #data-binding #scope #mvc #legacy
==Two-way data binding== in AngularJS is a core feature that ==automatically synchronizes== data between the model (JavaScript) and the view (HTML). When the model changes, the view updates, and when the view changes, the model updates.

# Concept
- ==Automatic synchronization== between model and view
- Uses ==`$scope`== as the bridge
- Powered by ==`$digest` cycle==
- Primary mechanism: ==`ng-model`== directive

# Basic Two-Way Binding

## Using ng-model
```html
<div ng-controller="MyController">
  <input type="text" ng-model="name">
  <p>Hello, {{ name }}!</p>
</div>
```

```javascript
app.controller('MyController', function($scope) {
  $scope.name = 'Khoa';
});
```

# How It Works

## The Digest Cycle
1. User types in input field
2. `ng-model` updates `$scope.name`
3. ==`$digest` cycle== triggers
4. Angular checks all ==watchers==
5. View updates with new value

## Watchers
```javascript
app.controller('WatchController', function($scope) {
  $scope.name = 'Khoa';

  // Manually create a watcher
  $scope.$watch('name', function(newVal, oldVal) {
    console.log('Name changed from ' + oldVal + ' to ' + newVal);
  });
});
```

# Interpolation vs ng-bind

## Interpolation `{{ }}`
```html
<p>{{ message }}</p>
```

## ng-bind Directive
```html
<p ng-bind="message"></p>
```

## Comparison
- ==Interpolation==: Two-way binding, may flash during load
- ==ng-bind==: One-way binding, no flashing

# Examples

## Form Binding
```html
<div ng-controller="FormController">
  <form>
    <label>Name:</label>
    <input type="text" ng-model="user.name">

    <label>Email:</label>
    <input type="email" ng-model="user.email">

    <label>Country:</label>
    <select ng-model="user.country">
      <option value="vn">Vietnam</option>
      <option value="us">USA</option>
    </select>

    <label>
      <input type="checkbox" ng-model="user.agree">
      I agree to terms
    </label>
  </form>

  <h3>Preview:</h3>
  <p>Name: {{ user.name }}</p>
  <p>Email: {{ user.email }}</p>
  <p>Country: {{ user.country }}</p>
  <p>Agreed: {{ user.agree }}</p>
</div>
```

***
# References
1. https://docs.angularjs.org/guide/databinding for data binding guide
2. [Digest cycle and watchers](../digest-cycle/Digest%20cycle%20and%20watchers.md)
3. [Built-in directives](../directives/Built-in%20directives.md)
