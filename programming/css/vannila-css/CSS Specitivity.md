#vanilla-css #css #compilation 

- Apply the style of the selector with ==highest specitivity==. 
- Occurs during CSS parsing phase [Basic CSS Compilation](Basic%20CSS%20Compilation.md)
- ![](Pasted%20image%2020240606153938.png)
# Importance
- `!important` wins.
- Default browser/user declarations.
# Specitivity
- Ranked by:
	1. Inline style.
	2. IDs
	3. Classes, pseudo classes, attribute.
	4. Elements, pseudo elements.
- When a certain does not apply, look up its specitivity.
- ![900x](Pasted%20image%2020240606160119.png)
# Source order
- CSS is a ==interpreter== language $\implies$ later style applies.