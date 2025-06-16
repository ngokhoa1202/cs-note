#reactjs #javascript  #hook   #dom #jsx 

# Controlled form inputs
- Controlled components manage their state using React state.
```jsx
<input value={someValue} onChange={handleChange} />
...
```
- Make use of ==event handler callback== to change state.
# Uncontrolled form inputs
- Uncontrolled components manage their state internally using DOM refs.
- `useRef` hook in functional components or `React.createRef()` in class components) are employed to access form element values directly.
- [useRef hook](useRef%20hook.md)

# References
1. https://goshacmd.com/controlled-vs-uncontrolled-inputs-react/#conclusion for controlled and uncontrolled components.
2. [useRef hook](useRef%20hook.md)
3. https://www.freecodecamp.org/news/what-are-controlled-and-uncontrolled-components-in-react/