#css #vanilla-css  #css-tricks  #css-animation 
# Method
- Define in HTML file
```HTML
<div class="composition">
  <!--High-quality images first-->
  <img src="img/nat-1-large.jpg" alt="Photo 1"    class="composition__photo composition__photo--p1">
  <img src="img/nat-2-large.jpg" alt="Photo 2" class="composition__photo composition__photo--p2">
  <img src="img/nat-3-large.jpg" alt="Photo 3" class="composition__photo composition__photo--p3">
</div>
```
- Add property `position: absolute` to each photo inside to specify their arbitary positions.
```SCSS
.composition {
	position: relative;
	&__photo {

		width: 60%;
		box-shadow: 0 1.2rem 4.8rem rgba($color-black, 0.4);
		/* use absolute position to easily specify their arbitary position */
		position: absolute;
		border-radius: 1rem;
		z-index: 1;
		transition: all 0.2s ease-in;
    /* style each photo a distinct position */

	&--p1 {
		top: -1rem;
		left: 0;
	}
	
	/* style each photo a distinct position */
	
	&--p2 {
		top: 4rem;
		right: -8rem;
	}
	
	/* style each photo a distinct position */
	
	&--p3 {
		top: 12rem;
		left: 8rem;
	}
}
```

- Add `hover` effect:
	- Scale photo.
	- Add `outline` property to "focus" a photo when hoverring it. 
	- Add `z-index` to make it on top of the stack context.
```SCSS
.composition {
	position: relative;
	&__photo {

		width: 60%;
		box-shadow: 0 1.2rem 4.8rem rgba($color-black, 0.4);
		/* use absolute position to easily specify their arbitary position */
		position: absolute;
		border-radius: 1rem;
		z-index: 1;
		transition: all 0.2s ease-in;
    /* style each photo a distinct position */

	&--p1 {
		top: -1rem;
		left: 0;
	}
	
	/* style each photo a distinct position */
	
	&--p2 {
		top: 4rem;
		right: -8rem;
	}
	
	/* style each photo a distinct position */
	
	&--p3 {
		top: 12rem;
		left: 8rem;
	}

	&:hover {
		transform: scale(1.2) translate(0, -1.6rem);
		box-shadow: 0 2.4rem 4.8rem rgba($color-black, 0.5);
		z-index: 1000;
		outline: 1.2rem solid $color-primary;
		outline-offset: 2.4rem;
	}
}
```

- "Defocus" other photos not being hoverred.
```SCSS
.composition {
	position: relative;
	&__photo {

		width: 60%;
		box-shadow: 0 1.2rem 4.8rem rgba($color-black, 0.4);
		/* use absolute position to easily specify their arbitary position */
		position: absolute;
		border-radius: 1rem;
		z-index: 1;
		transition: all 0.2s ease-in;
    /* style each photo a distinct position */

	&--p1 {
		top: -1rem;
		left: 0;
	}
	
	/* style each photo a distinct position */
	
	&--p2 {
		top: 4rem;
		right: -8rem;
	}
	
	/* style each photo a distinct position */
	
	&--p3 {
		top: 12rem;
		left: 8rem;
	}

	&:hover {
		transform: scale(1.2) translate(0, -1.6rem);
		box-shadow: 0 2.4rem 4.8rem rgba($color-black, 0.5);
		z-index: 1000;
		outline: 1.2rem solid $color-primary;
		outline-offset: 2.4rem;
	}
	
	&:hover &__photo:not(:hover) {
		transform: scale(0.95);
	}
}
```

- ![800](Pasted%20image%2020240624173749.png)