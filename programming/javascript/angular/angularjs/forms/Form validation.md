#angularjs #angular1 #javascript #forms #validation #html #legacy
AngularJS provides ==built-in form validation== that tracks form and input state, providing CSS classes and validation properties for creating user-friendly forms.

# Form States

## Form Properties
- ==`$valid`== - Form is valid
- ==`$invalid`== - Form has errors
- ==`$pristine`== - User hasn't interacted with form
- ==`$dirty`== - User has interacted with form
- ==`$touched`== - Field has been blurred
- ==`$untouched`== - Field hasn't been blurred
- ==`$submitted`== - Form has been submitted

# Basic Validation
```html
<form name="userForm" ng-submit="submitForm()" novalidate>
  <div>
    <label>Name:</label>
    <input type="text"
           name="username"
           ng-model="user.name"
           required
           ng-minlength="3"
           ng-maxlength="20">

    <!-- Show errors -->
    <div ng-show="userForm.username.$invalid && userForm.username.$touched">
      <span ng-show="userForm.username.$error.required">Name is required</span>
      <span ng-show="userForm.username.$error.minlength">Name too short</span>
      <span ng-show="userForm.username.$error.maxlength">Name too long</span>
    </div>
  </div>

  <div>
    <label>Email:</label>
    <input type="email"
           name="email"
           ng-model="user.email"
           required>

    <div ng-show="userForm.email.$invalid && userForm.email.$touched">
      <span ng-show="userForm.email.$error.required">Email required</span>
      <span ng-show="userForm.email.$error.email">Invalid email</span>
    </div>
  </div>

  <button type="submit" ng-disabled="userForm.$invalid">Submit</button>
</form>
```

# Validation Directives
- ==`required`== - Field must have value
- ==`ng-minlength`== - Minimum length
- ==`ng-maxlength`== - Maximum length
- ==`ng-pattern`== - Regex pattern match
- ==`type="email"`== - Email validation
- ==`type="url"`== - URL validation
- ==`type="number"`== - Number validation

# CSS Classes
AngularJS automatically adds CSS classes:
- ==`.ng-valid`== / `.ng-invalid`
- ==`.ng-pristine`== / `.ng-dirty`
- ==`.ng-touched`== / `.ng-untouched`

```css
.ng-invalid.ng-touched {
  border-color: red;
}

.ng-valid.ng-touched {
  border-color: green;
}
```

# Custom Validation
```javascript
app.directive('validateUsername', function($q, $http) {
  return {
    require: 'ngModel',
    link: function(scope, element, attrs, ngModel) {
      ngModel.$asyncValidators.usernameAvailable = function(modelValue) {
        return $http.get('/api/check-username?username=' + modelValue)
          .then(function(response) {
            if (response.data.available) {
              return true;
            }
            return $q.reject();
          });
      };
    }
  };
});
```

***
# References
1. https://docs.angularjs.org/guide/forms for forms guide
2. [Built-in directives](../directives/Built-in%20directives.md)
