#vanilla-css  #css #css-tricks 

# `text-align` property
- Use `text-align: center;` in the container to center its ==child inline elements==.
# `position` property and `transform` property
- Adapt `position: absolute` to current element and `position: relative` to parent element.
- Use `transform: translate(-50%, -50%)` in current element.
```CSS
.header {
	position: relative;
}

.text-box { /* child */
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: center;
}
```

# `margin` property
- Use `margin: 0 auto` to center the child block elements.
```CSS
.div {
  margin: 0 autp;
}
```
