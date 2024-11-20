#css #vanilla-css  #css-animation 

# Method
- Use `tranform` property and `skew` function in CSS.
```SCSS
.heading-secondary {
	font-size: 3.6rem;
	text-transform: uppercase;
	font-weight: 600;
	display: inline-block;
	background-image: linear-gradient(to right, $color-primary-light, $color-primary-dark);
	-webkit-background-clip: text;
	color: transparent;
	letter-spacing: 0.4rem;
	transition: all 0.2s ease-in;
	
	&:hover {
		transform: skew(2deg, 5deg) scale(1.1);
		text-shadow: 0.8rem 1.2rem 2.4rem rgba($color-black, 0.2);
	}
}
```
- ![800](Pasted%20image%2020240623141207.png)