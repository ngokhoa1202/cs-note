#css #vanilla-css #css-tricks 

- Employ CSS property `position: absolute`. Add  property`content` and `transform`
```CSS
.pricing-plan--complete::after {
	content: "Best value";
	position: absolute;
	top: 6%;
	right: -18%;
	
	text-transform: uppercase;
	font-size: 1.4rem;
	font-weight: 700;
	color: #333;
	background-color: #ffd43b;
	padding: 0.8rem 8rem;
	transform: rotate(45deg);
}
```
