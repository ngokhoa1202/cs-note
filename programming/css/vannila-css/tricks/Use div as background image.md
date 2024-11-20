#vanilla-css #css #css-tricks 

- Specify HTML attribute `role` as `img`
```HTML
<div
	class="cta-img-box"
	role="img"
	aria-label="Woman enjoying food"
></div>
```
- Specify CSS property `background-img`
```CSS
.cta-img-box {

	background-image: linear-gradient(
		to right bottom,
		rgba(235, 151, 78, 0.35),
		rgba(230, 125, 34, 0.35)
	),

	url("../img/eating.jpg");
	background-size: cover;
	background-position: center;
}
```