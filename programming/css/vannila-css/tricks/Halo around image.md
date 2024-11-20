#vanilla-css  #css #css-tricks 

- Employ `after` and `before` selctor to create two halo effects: one inner and one outer. Remember to make `position` `absolute`
```CSS
.step-img-box::before,
.step-img-box::after {
	content: "";
	display: block;
	border-radius: 50%;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
```
- Modify appropriate `z-index` for each halo:
```CSS
.step-img-box::before {
	width: 60%;
	/* height: 60%; */	
	/* 60% of parent's width */
	padding-bottom: 60%;
	background-color: #fdf2e9;
	z-index: -2;
}

  

.step-img-box::after {
	width: 45%;
	padding-bottom: 45%;
	background-color: #fae5d3;
	z-index: -1;
}
```
- ![](Pasted%20image%2020240604205735.png)
- 