#javascript #web #browser 
# JavaScript URL
- JavaScript URLs, which is prefixed with the `javascript:` scheme, are used as <mark class="hltr-yellow">fake navigation targets</mark> that execute JavaScript when the browser attempts to navigate.
- If the URL evaluates to a string, it is treated as HTML and rendered by the browser.
```URL title='javascript URL syntax'
javascript:<script>
```
- `javascript:` plays a navigation target. This includes, but not limited to:
	- The `href`]attribute of an `{HTML} <a>` or `{HTML} <area>` element.
    - The `action` attribute of a `{HTML} <form>` element.
    - The `src`]attribute of an `{HTML} <iframe>` element.
    - The `{JavaScript} window.location`JavaScript property.
    - The browser address bar itself.
# Behavior
- When a browser attempts to navigate to such a location, it parses and <mark class="hltr-yellow">executes the script</mark> . 
- The script may have a _completion value_, which is the same value if the script were executed with `eval()`:
	- If the last statement is an expression, the completion value is the value of that expression. 
	- If this completion value is a string, that string is treated as an HTML document and the browser navigates to a new document with that content, using the same URL as the current page. No history entry is created.
	- In case the completion value is not a string, the browser only executes the code and does not navigate. Therefore, if the script ends with a function call like `javascript:foo()`, it should be prefixed with `void` to prevent accidental navigation if the function happens to return a string.
# Example
## `javascript:`URLs as `href` targets
```HTML title='javascript: URLs as href targets'
<!-- Very bad practice, for example only -->
<a href="javascript:alert('Hello, world!')">Click me</a>
```
- The `javascript` URL alerts when the anchor element is clicked. Because `{JavaScript} alert()` returns `{JavaScript} undefined`, the browser does not navigate to the new page.
## `javascript:` URLs as forms action
```HTML title='javascript: URLs as form actions'
<!-- Very bad practice, for example only -->
<form action="javascript:alert(myInput.value)">
  <input id="myInput" />
  <input type="submit" value="Submit" />
</form>
```
## `javascript:` URLs as iframe source
```HTML title='javascript: URL as iframe source'
<!-- Very bad practice, for example only -->
<iframe src="javascript:pageContent"></iframe>
<script>
  // Use a var so it becomes a global variable and can be read elsewhere
  var pageContent = "Hello, world!";
</script>
```
## `javascript:` URLs with `{JavaScript} window.location`
- The `window.location` property is set to a `javascript:` URL that navigates to a new page with the content "Hello, world!".
```JavaScript title='set window.location to javascript: URLs'
// Very bad practice, for example only
window.location = "javascript:'Hello world!'";
```
***
# References
1. https://developer.mozilla.org/en-US/docs/Web/URI/Reference/Schemes/javascript for `javascript:` URL tutorial.
2. 