#angular #javascript #shell #html #object-oriented-programming #typescript #string #dom 

# Double curly braces
- Use double curly braces `{{ object.property }}` :
	- Between HTML tags:
		- `<h1>{{ app.title }}</h1>`
	- String interpolation:
		- `<img src="{{ user.avatar }}" />`
# Property binding
- Wrap the property using the square bracket `[property]=value` .
```bash
<img [src]="user.avatar" />
```
- Angular accesses the underlying HTML DOM Element and assigns the value to that element.
- For some attribute tags (like `arial-...`), use `[attr.]` prefix to bind that attribute:
```html
 <div 
   role="progressbar"
   [attr.aria-valuenow]="currentVal"
   [attr.aria-valuemax]="maxVal">
   ...
</div>
```

