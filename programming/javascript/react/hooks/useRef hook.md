#react  #javascript  #hook #functional-programming #high-order-function #dom #event-driven-programming 
#structured-programming #typescript 

# Common syntax
```JSX title='useRef syntax'
useRef(initialValue)
```
# Characteristics
- `useRef` hook is employed to store a reference to a DOM element.
	- When the `ref` attribute is used on an HTML element, the `ref` created in the constructor with `React.createRef()` receives the underlying DOM element as its `current` property.
	- When the `ref` attribute is used on a custom class component, the `ref` object receives the mounted instance of the component as its `current`.
	- `ref` may not work with functional components if they do not have their own instances.
- `ref.current` is mutable, but must be neither read nor written during rendering, except for initialization.
- When `ref.current` is mutated, the component is not re-rendered. React does not even notice the change because `ref.current` is actually a plain Javascript object. As a result, `ref` is never appropriate for rendering information.
- The `current` property is assigned by React with the DOM element when the component mounts, and assigned back to `null` when the element unmounts. `ref` updates happen before `componentDidMount` or `componentDidUpdate` lifecycle methods.
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
### Functional components
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
### Class components
```Jsx title='ref in class components'
class CustomTextInput extends React.Component {
  constructor(props) {
    super(props);
    // create a ref to store the textInput DOM element
    this.textInput = React.createRef();    this.focusTextInput = this.focusTextInput.bind(this);
  }

  focusTextInput() {
    // Explicitly focus the text input using the raw DOM API
    // Note: we're accessing "current" to get the DOM node
    this.textInput.current.focus();  }

  render() {
    // tell React that we want to associate the <input> ref
    // with the `textInput` that we created in the constructor
    return (
      <div>
        <input
          type="text"
          ref={this.textInput} />        
        <input
          type="button"
          value="Focus the text input"
          onClick={this.focusTextInput}
        />
      </div>
    );
  }
}
```

#### Callback refs
- A setter function is passed into the ref attribute of the component.
- The `ref` callback is executed whenever the component mounts, and call with `null` when it unmounts
```Jsx title='Callback reference example'
class CustomTextInput extends React.Component {
  constructor(props) {
    super(props);

    this.textInput = null;
    this.setTextInputRef = element => {      this.textInput = element;    };
    this.focusTextInput = () => {      // Focus the text input using the raw DOM API      if (this.textInput) this.textInput.focus();    };  }

  componentDidMount() {
    // autofocus the input on mount
    this.focusTextInput();  }

  render() {
    // Use the `ref` callback to store a reference to the text input DOM
    // element in an instance field (for example, this.textInput).
    return (
      <div>
        <input
          type="text"
          ref={this.setTextInputRef}        />
        <input
          type="button"
          value="Focus the text input"
          onClick={this.focusTextInput}        />
      </div>
    );
  }
}
```
- `ref` can be passed as a property from the parent into the child component.
```Jsx title='Pass ref from parent to child in React class'
function CustomTextInput(props) {
  return (
    <div>
      <input ref={props.inputRef} />    </div>
  );
}

class Parent extends React.Component {
  render() {
    return (
      <CustomTextInput
        inputRef={el => this.inputElement = el}      />
    );
  }
}
```


# References
1. https://goshacmd.com/controlled-vs-uncontrolled-inputs-react/#conclusion for controlled and uncontrolled components.
2. https://react.dev/reference/react/useRef#referencing-a-value-with-a-ref for `useRef` hook.
3. https://react.dev/reference/react/forwardRef for `forwardRef` function.
4. https://react.dev/learn/manipulating-the-dom-with-refs for `useRef` usage.
5. https://legacy.reactjs.org/docs/refs-and-the-dom.html for `ref` in Class component.
6. 