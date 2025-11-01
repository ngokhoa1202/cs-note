#css #vanilla-css #css-tricks 

- Used with [Blend image and color](Blend%20background%20color%20and%20background%20image.md#Blend%20image%20and%20color)
# Method
- Sepcify in HTML file
```html
<div class="card__picture card__picture--p3">
	<!--Background image only-->
	&nbsp;
</div>

<div class="card__heading">

	<span class="card__heading-span card__heading-span--s3">The Snow Adventurer</span>

</div>

<div class="card__details">
	<ul>
		<li>12 days tour</li>
		<li>Up to 20 people</li>
		<li>4 tour guides</li>
		<li>Sleep in reliable tents</li>
		<li>Difficulty: hard</li>
	</ul>
</div>
```

- Specify heading position as `absolute`.
- Add `text-align: right` and shorten `width` property to force the text inside jumps into the new line $\implies$ emphasizes.
- Use `background-image` as heading block color.
- Add `box-decoration-break: clone;` to make it look nicer.
```css
&__heading {

	font-size: 3.2rem;
	
	text-transform: uppercase;
	
	font-weight: 300;
	
	/* specify text-align in the parent element */
	
	text-align: right;
	position: absolute;
	top: 13rem;
	
	/* decrease its width until heading is close to the right side of the box */
	
	width: 60%;
	right: 2rem;
}

  

&__heading-span {

	color: $color-white;
	
	/* Add padding to make it like a block */
	
	padding: 1.2rem 1.8rem;
	
	/* make the text spanning in the two lines looks like a united block */
	
	/* if not specified, it looks the two separate blocks */
	
	box-decoration-break: clone;
	
	-webkit-box-decoration-break: clone;

	&--s1 {
		background-image: linear-gradient(to right bottom, rgba($color-secondary-light, 0.8), rgba($color-secondary-dark, 0.8));
	}

  

	&--s2 {
		background-image: linear-gradient(to right bottom, rgba($color-primary-light, 0.8), rgba($color-primary-dark, 0.8));
	}

  

	&--s3 {
		background-image: linear-gradient(to right bottom, rgba($color-tertiary-light, 0.8), rgba($color-tertiary-dark, 0.8));
	}

}
```

- ![800](Pasted%20image%2020240624185718.png)