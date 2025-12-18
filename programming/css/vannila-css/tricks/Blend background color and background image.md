#css #css-tricks #vanilla-css 
# Reduce color brightness
- Use `linear-gradient` on top of background image on the stacking context.
- Must specify `rgba` to ==reduce opacity== of color to make background image behind become visible.
- Emphasizes the backgroud ==image==.
```CSS
.section-features {
	background-image:
		linear-gradient(to right bottom, rgba($color-primary-light, 0.7), rgba($color-primary-dark, 0.7)),
		url("../img/nat-4.jpg");
	
	background-size: cover;
	
	/* which parts of background will be kept when being resized */
	
	background-position: center;
}
```

- ![800](Pasted%20image%2020240623211107.png)
# Blend image and color
- Must specify `background-blend-mode: <mode>`. For example, `screen`.
- Do not need to reduce color brightness.
- Not compatible with all Web browsers.
```CSS
&__picture {

	background-size: cover;
	/* must specify height */
	/* Blend the two background images */
	
	/* Not compatible with all browser: e.g Internet explorer */
	
	background-blend-mode: screen;

  

	&--p1 {

	background-image:
		linear-gradient(to right bottom, $color-secondary-light, $color-secondary-dark),
		url("../img/nat-5.jpg"); /* After preprocessing, url is translated to css file style.css */
	background-position: center;
	
}
```

- Emphasizes on the color pallete.
- ![800](Pasted%20image%2020240623211528.png)
***