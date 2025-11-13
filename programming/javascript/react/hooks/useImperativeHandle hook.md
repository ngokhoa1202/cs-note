#react  #javascript  #hook #jsx #functional-programming #high-order-function 

# Characteristics
- Customizes the exposure of `ref.current` object API when <mark style="background: #c19939;">forwarding the children</mark>`ref` to its <mark style="background: #c19939;">parent</mark>.
## Return type
- `undefined`
# Usage
## Exposes only specified ref handler to its parent:
- Accompanied with `forwardRef` function to pass `ref` as props [Manipulating DOM tree](useRef%20hook.md#Manipulating%20DOM%20tree) .
- Child component has its own ref.
```jsx
import { forwardRef, useRef, useImperativeHandle } from 'react';  

const MyInput = forwardRef(function MyInput(props, ref) {  

	const internalRef = useRef(null);  
	
	useImperativeHandle(ref, () => {  
	
		return {  
			focus() {  
			
				inputRef.current.focus();  
			},  
		
			scrollIntoView() {  
				inputRef.current.scrollIntoView();  
			},  
		};  
	}, []);  

	return <input {...props} ref={internalRef} />;  
});
```
- Parent component ==defines a separate ref from child component's one== and only invokes exposured ref's API.
```jsx
import { useRef } from 'react';
import MyInput from './MyInput.js';

export default function Form() {
  const ref = useRef(null);

  function handleClick() {
    ref.current.focus();
    // This won't work because the DOM node isn't exposed:
    // ref.current.style.opacity = 0.5;
  }

  return (
    <form>
      <MyInput placeholder="Enter your name" ref={ref} />
      <button type="button" onClick={handleClick}>
        Edit
      </button>
    </form>
  );
}
```

# References
1. https://react.dev/reference/react/forwardRef for `useForwardRef` hook in ReactJs official documentation.
2. 