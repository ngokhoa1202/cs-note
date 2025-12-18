#css-animation  #vanilla-css  #css-tricks 

- ![800](Pasted%20image%2020240624184125.png)
# Method
1. Define a parent element card containing the ==two sides==: front side and back side:
	- Set two sides `position: absolute` and the same position `top` and `left`. This implies the three elements ==stay at the same position==.
2. Add `perspective` property to parent element to ==specify distance to 3D space==:
	- Smaller pixels means ==closer== distance to z-axis $\implies$ more impressive rotation effect but annoying.
	- Bigger pixels means ==further== distance to z-aixs $\implies$ less impressive effect, more comfortable.
3. Keep the front side element original $\equiv$ 0 deg. But add `transform: rotateY(180deg)` property to make the back side always stay behind the front side element by default.
4. When hovering the parent element:
	- rotate the front side element ==by -180deg== to make it become the back side.
	- rotate the back side element by ===0 deg===.
	- Add `trasition` property to watch the rotation clearly.
```css
.card {

	/* make as if the card is moving towards users */
	
	/* specify perspective property in parent element */
	
	/* use a huge number of pxs */

	perspective: 100rem;
	
	-moz-perspective: 150rem; // for mozilla browser
	
	position: relative;
	
	/* in abosulute position must specify its height */
	
	height: 52rem;

  

	&__side {
	
		height: 52rem;
		
		transition: all 1s ease-in;
		
		/* make two sides overlap each other */
		
		position: absolute;
		
		top: 0;
		
		left: 0;
		
		/* must explicitly specify width */
		
		width: 100%;
		
		/* hide the back part of the animation effect */
		
		backface-visibility: hidden;
		
		border-radius: 1rem;
		
		/* hide overflow parts */
		
		overflow: hidden;
		
		box-shadow: 0 2.4rem 3.2rem rgba($color-black, 0.3);
	
		&--front {
			background-color: $color-white;
		}
	
		&--back {
			/* back side always stays behind front side by default */
			transform: rotateY(180deg);
	  
			&--1 {
				background-image: linear-gradient(to right bottom, $color-secondary-light, $color-secondary-dark);
			}
			
			&--2 {
				background-image: linear-gradient(to right bottom, $color-primary-light, $color-primary-dark);
			}
			
			&--3 {
				background-image: linear-gradient(to right bottom, $color-tertiary-light, $color-tertiary-dark);
			}
		}
	}
	
	  
	
	/* select the front side when the card is being hoverred => rotate it */
	
	&:hover &__side--front {
		transform: rotateY(-180deg);
	}
	
	/* hover back to the front side */
	
	&:hover &__side--back {
		transform: rotateY(0);
	}
	
	  
	
	&__picture {
	
		background-size: cover;
		
		/* must specify height */
		height: 25rem;
		
		/* Blend the two background images */
		/* Not compatible with all browser: e.g Internet explorer */
		background-blend-mode: screen;

		&--p1 {
		
			background-image:
			
			linear-gradient(to right bottom, $color-secondary-light, $color-secondary-dark),
			url("../img/nat-5.jpg"); /* After preprocessing, url is translated to css file style.css */
			
			background-position: center;
			
			/* clip-path may be not compatible with Edge browser */
			
			clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
			-webkit-clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
		}
		
		  
		
		&--p2 {
		
			background-image:
				linear-gradient(to right bottom, $color-primary-light, $color-primary-dark), url("../img/nat-6.jpg");
		
			background-position: center;
			
			clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
			
			-webkit-clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
		}
		
		&--p3 {
		
			background-image:
			
			linear-gradient(to right bottom, $color-tertiary-light, $color-tertiary-dark),
			
			url("../img/nat-7.jpg");
			
			background-position: center;
			
			clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
			
			-webkit-clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
		}
	}
	
	  
	
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
			background-image:
				linear-gradient(to right bottom, rgba($color-secondary-light, 0.8), rgba($color-secondary-dark, 0.8))
		}
		
		  
	
		&--s2 {
			background-image:
			linear-gradient(to right bottom, rgba($color-primary-light, 0.8), rgba($color-primary-dark, 0.8));
			
		}
				
		&--s3 {
		
			background-image:
			linear-gradient(to right bottom, rgba($color-tertiary-light, 0.8), rgba($color-tertiary-dark, 0.8));
		
		}
	}	
}
```
***
# References
1. 