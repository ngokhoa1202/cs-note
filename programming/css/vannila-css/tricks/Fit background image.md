#css #css-tricks #vanilla-css 

# Scale background image
- File `index.html`
```HTML
<html lang="en">
<head>

</head>

<body>
	<div class="background"></div
</body>
</html>
```
- File `style.css`
```CSS
.background {
  background: url();
  background-size: cover;
}
```
- `contain` container can contain duplicate images to fit itself.
- `cover`:  image ==automatically resizes to be fully visible==.
# References 
1. https://www.w3schools.com/cssref/css3_pr_background-size.php
2. https://www.w3schools.com/cssref/playdemo.php?filename=playcss_background-size&preval=contain for demostration.