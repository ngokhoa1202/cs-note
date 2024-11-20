#reactjs  #javascript  #hook #functional-programming #high-order-function #dom #reactive-programming 
#structured-programming 
# Characteristics
- References to a value which is ==not used for renderring==.
- Mutating a `useRef` ==does not trigger a re-render== $\implies$ Help store information between rerenders.
- ==Must not== be written or read ==during renderring phase==. 
- The scope is ==local to the component instance== that holds it.

## Return type
- Returns an object with the `current` property to access object content.

# Usage
## Store the information between rerenders
- `initialValue` for the first  render $\implies$ React does not recalculate this value.
- Change `ref.current` in event handler functions.
- Can store callback function if necessary. (e.g to clear interval).
```jsx
export default function Counter() {
  let ref = useRef(0);

  function handleClick() {
    ref.current = ref.current + 1;
    alert('You clicked ' + ref.current + ' times!');
  }

  return (
    <button onClick={handleClick}>
      Click me!
    </button>
  );
}
```
## Manipulating DOM tree
- First, declare a ref object with an initial value of `null`
```jsx
import { useRef } from 'react';  

function MyComponent() {  
	const inputRef = useRef(null);  
// ...
```
- Then,  pass ref object as the `ref` prop to the JSX component:

```jsx
// ...  
return <input ref={inputRef} />;
```
- Define an event handler and write or read that reference via `current` attribute.
```jsx
function handleClick() {  
  inputRef.current.focus();  
}  
```

- `ref` property ==may not work with a custom component== 
	- pass as props and use it in an `<input>` component.
	- use `forwardRef` function to explicitly expose `ref` property to its parent component.
```jsx
const Form = () => {
  const inputRef = useRef(null);  // refers to <input> element
  return <MyInput ref={inputRef} />; 
}
```

```jsx
const MyInput = forwardRef(function MyInput(props, ref) { // props may be destructured as {p1, p2, ..., pN}
  const { label, ...otherProps } = props;
  return (
    <label>
      {label}
      <input {...otherProps} ref={ref} />
    </label>
  );
});
```



---

# References
1. https://goshacmd.com/controlled-vs-uncontrolled-inputs-react/#conclusion for controlled and uncontrolled components.
2. https://react.dev/reference/react/useRef#referencing-a-value-with-a-ref for `useRef` hook.
3. https://react.dev/reference/react/forwardRef for `forwardRef` function.
4. https://react.dev/learn/manipulating-the-dom-with-refs for `useRef` usage.