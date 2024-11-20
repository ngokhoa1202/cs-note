#css #vanilla-css  #css-tricks 

- Also called ==clearfix== hack.
# Purpose
- Prevent the height of the container of the float elements from becoming 0.
# Method
- Add `clearfix` class to ==container== element.
- Use `clear` and `display` property.
```CSS
.clearfix::after {
    /* append pseudo-element to clear float */
	content: "";
	display: table;
	clear: both;
}
```

# References
1. https://www.w3schools.com/howto/howto_css_clearfix.asp for clearfix hack.
