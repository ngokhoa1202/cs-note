#css #vanilla-css #css-tricks 
# Hide but keep animation
- Modify property `opacity`, `visibility` and `pointer-events`
```CSS
.element {
	/* Visually hide main nav */
	
	opacity: 0;
	
	transition: all 1s ease-in; /* like sliding */
	
	  
	
	/* Make it unaccessible by user events */
	
	pointer-events: none;
	
	  
	
	/* Hide from screen readers */
	
	visibility: hidden;
	}
```

# Hide all
```CSS
.element {
	display: none;
}
```
