#css #vanilla-css #css-animation #sass 

# Method
- Add `background-img` property as `linear-gradient`.
- Add `-webkit-background-clip` property as `text`:
	- Represents the extent to which background image or color will apply.
- Set `color` property as `transparent`.
- Add animation when hoverring.
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