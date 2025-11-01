#css  #vanilla-css  #layout-components 

# Box shadow effect
- Use `box-shadow`
```CSS
.meal {
	box-shadow: 0 2.4rem 4.8rem rgba(0, 0, 0, 0.075);
	border-radius: 11px;
	overflow: hidden;
	transition: all 0.4s;
}
```

# Moving up effect
- Use `transform: translate` 
```CSS
.meal:hover {
	transform: translateY(-1.2rem);
	box-shadow: 0 3.2rem 6.4rem rgba(0, 0, 0, 0.06);
}
```

# Attach special text
- File `.index.html`

```HTML
<div class="pricing-plan pricing-plan--complete">

	<header class="plan-header">
		<p class="plan-name">Complete</p>
		<p class="plan-price"><span>$</span>649</p>
		<p class="plan-text">per month. That's just $11 per meal!</p>
	</header>

	<ul class="list">
		<li class="list-item">
			<ion-icon class="list-icon" name="checkmark-outline"></ion-icon>
			<span><strong>2 meals</strong> per day</span>
		</li>

		<li class="list-item">
			<ion-icon class="list-icon" name="checkmark-outline"></ion-icon>
			<span>Order <strong>24/7</strong></span>
		</li>

		<li class="list-item">
			<ion-icon class="list-icon" name="checkmark-outline"></ion-icon>
			<span>Delivery is free</span>
		</li>

		<li class="list-item">
			<ion-icon class="list-icon" name="checkmark-outline"></ion-icon>
			<span>Get access to latest recipes</span>
		</li>

	</ul>
		<div class="plan-sing-up">
		<a href="#" class="btn btn--full">Start eating well</a>
	</div>

</div>
```
- Use `::after` or `::before` selector to add text. `position: absolute` for positioning. `transform: rotate(45deg)` animation.
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
# References
1. 