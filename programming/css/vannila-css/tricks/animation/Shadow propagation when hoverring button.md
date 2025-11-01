#css #css-tricks  #css-animation 

# Method
- Style `<button>` or `<a>` with moving up effect when being hoverred.
```SCSS
.btn {
	&:link,
	&:visited {
		position: relative;
		text-decoration: none;
		display: inline-block;
		text-transform: uppercase;
		border-radius: 1rem;
		transition: all 0.5s ease-in;
	}

	&:hover {
		transform: translate(0, -0.8rem);
		box-shadow: 0 1rem 2rem rgba($color-black, 0.1);
	}
	
	  
	
	&:active {
		transform: translate(0, -0.4rem);
	}
}
```

- Add a ==pseudo button== lying beheind main button using `::after` selector. Add `transition` for propagation effect.
```SASS
.btn {
	&:link,
	&:visited {
		position: relative;
		text-decoration: none;
		display: inline-block;
		text-transform: uppercase;
		border-radius: 1rem;
		transition: all 0.5s ease-in;
	}

	&:hover {
		transform: translate(0, -0.8rem);
		box-shadow: 0 1rem 2rem rgba($color-black, 0.1);
	}
	
	  
	
	&:active {
		transform: translate(0, -0.4rem);
	}

    &::after {
		content: "";
		display: inline-block;
		height: 100%;
		width: 100%;
		border-radius: 1rem;
		position: absolute;
		top: 0;
		left: 0;
		z-index: -1;
		/* always displayed behind btn */
		transition: all 0.5s ease-in;
	}
}
```
- Add effect to that pseudo element when button is being hoverred using `.btn:hover::after` selector. Remember to make it invisible to create effect.
```CSS
.btn {
	&:link,
	&:visited {
		position: relative;
		text-decoration: none;
		display: inline-block;
		text-transform: uppercase;
		border-radius: 1rem;
		transition: all 0.5s ease-in;
	}

	&:hover {
		transform: translate(0, -0.8rem);
		box-shadow: 0 1rem 2rem rgba($color-black, 0.1);
		&::after {
		/* Create box shadow propagation effect */
		/* only has after pseudo-element when being hoverred */
		/* when hoverring button, .btn::after transits to be more transparent and scaled to a certain size => creates propagation effect */
		transform: scaleX(1.5) scaleY(1.2);
		opacity: 0;
		}
	}
	
	&:active {
		transform: translate(0, -0.4rem);
	}

    &::after {
		content: "";
		display: inline-block;
		height: 100%;
		width: 100%;
		border-radius: 1rem;
		position: absolute;
		top: 0;
		left: 0;
		z-index: -1;
		/* always displayed behind btn */
		transition: all 0.5s ease-in;
	}
}
```

