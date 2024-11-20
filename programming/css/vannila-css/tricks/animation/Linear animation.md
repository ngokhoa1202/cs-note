#css #vanilla-css #css-tricks #css-animation

# Define an animation
- Employ `@keyframes`:
```CSS
/* CSS Animation */

@keyframes moveInLeft {

	/* when animation starts */
	0% {
		opacity: 0;
		transform: translate(-10rem, 0);
	}
	
	/* when animation is happening */
	80% {
		transform: translate(10rem, 0);
	}
	
	/* when animation ends */
	100% {
		opacity: 1;
		transform: translate(0, 0);
	}
}
```
# Use CSS animation
- Use `animation` defined in `@keyframes`
```CSS
.heading-primary-main {
	animation-name: moveInLeft;
	animation-duration: 3s;
	animation-delay: 1s;
	/* animation repeeats three times */
	/* animation-iteration-count: 3; */
	animation-timing-function: ease-in-out;
}

  

.heading-primary-sub {
	animation: moveInRight 2s ease-in-out 0.5s;
}
```

## `animation`
- Syntax:
```CSS
animation: name duration timing-function delay iteration-count direction fill-mode play-state;
```
- `timing-function`: `cubic` function or `ease-in`, `ease-out`,...
- `fill-mode`:  specifies a style for the element when the animation is not playing.
	- `backwards`: get the style values set by the ==first keyframe before the animation starts==.
	- `forwards`: retain the style values from the last keyframe when the animation ends.
# References
1. https://www.w3schools.com/cssref/css3_pr_animation-fill-mode.php 