#angularjs #angular1 #javascript #filter #pipes #template #legacy
==Filters== in AngularJS are used to ==format data== displayed to the user. They can be used in templates, controllers, and services. Filters are similar to ==pipes== in modern Angular.

# Built-in Filters

## currency
```html
<p>{{ 1234.56 | currency }}</p>
<!-- Output: $1,234.56 -->

<p>{{ 1234.56 | currency:'€' }}</p>
<!-- Output: €1,234.56 -->
```

## date
```html
<p>{{ myDate | date:'yyyy-MM-dd' }}</p>
<p>{{ myDate | date:'fullDate' }}</p>
<p>{{ myDate | date:'short' }}</p>
```

## filter
```html
<ul>
  <li ng-repeat="user in users | filter:searchText">
    {{ user.name }}
  </li>
</ul>
```

## json
```html
<pre>{{ myObject | json }}</pre>
```

## limitTo
```html
<!-- Limit array -->
<li ng-repeat="item in items | limitTo:5">{{ item }}</li>

<!-- Limit string -->
<p>{{ longText | limitTo:100 }}...</p>
```

## lowercase / uppercase
```html
<p>{{ 'Hello World' | lowercase }}</p>
<!-- Output: hello world -->

<p>{{ 'Hello World' | uppercase }}</p>
<!-- Output: HELLO WORLD -->
```

## number
```html
<p>{{ 1234.5678 | number:2 }}</p>
<!-- Output: 1,234.57 -->
```

## orderBy
```html
<li ng-repeat="user in users | orderBy:'name'">
  {{ user.name }}
</li>

<!-- Reverse order -->
<li ng-repeat="user in users | orderBy:'name':true">
  {{ user.name }}
</li>
```

# Custom Filters

## Creating a Filter
```javascript
app.filter('capitalize', function() {
  return function(input) {
    if (!input) return '';
    return input.charAt(0).toUpperCase() + input.slice(1);
  };
});
```

```html
<p>{{ 'hello world' | capitalize }}</p>
<!-- Output: Hello world -->
```

## Filter with Parameters
```javascript
app.filter('truncate', function() {
  return function(input, length, suffix) {
    if (!input) return '';
    length = length || 10;
    suffix = suffix || '...';

    if (input.length <= length) {
      return input;
    }

    return input.substring(0, length) + suffix;
  };
});
```

```html
<p>{{ longText | truncate:50:'...' }}</p>
```

# Chaining Filters
```html
<p>{{ user.name | lowercase | capitalize }}</p>

<li ng-repeat="user in users | filter:searchText | orderBy:'name' | limitTo:10">
  {{ user.name }}
</li>
```

# Using Filters in Controllers
```javascript
app.controller('MyController', function($scope, $filter) {
  var date = $filter('date')(new Date(), 'yyyy-MM-dd');
  var currency = $filter('currency')(1234.56);

  $scope.formattedDate = date;
  $scope.formattedPrice = currency;
});
```

***
# References
1. https://docs.angularjs.org/api/ng/filter for filter API
2. [Pipes in Angular template](../../modern-angular/templates/Pipes%20in%20Angular%20template.md) for modern equivalent
