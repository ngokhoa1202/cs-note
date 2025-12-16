#react  #javascript  #functional-programming  #hook  #dom #event-driven-programming 

# Characteristics
- `useState` adds a state variable to a component, which retains data between renders and triggers React to re-render when the data is changed.
- Whenever a state is interactively updated by event callback, the setter callback creates a new object and assigns the reference to that new object as well as ==trigger a re-render.==
- State is preserved as long as its position and value on DOM tree is <mark class="hltr-yellow">unchanged</mark>.
- State updates are <mark class="hltr-yellow">batched</mark>, which means it is not until all code in the event handlers finish their execution that React processes state updates.
	- Each user interaction is considered a separate event.
	- React only batches state updates when it's safe, typically within a single event handler.
- In `StrictMode`,  state is rendered twice.
```Jsx title='State updates are batched'
import { useState } from 'react';

export default function Counter() {
  const [number, setNumber] = useState(0);

  return (
    <>
      <h1>{number}</h1>
      <button onClick={() => {
        setNumber(n => n + 1);
        setNumber(n => n + 1);
        setNumber(n => n + 1);
      }}>+3</button>
    </>
  )
}

```
## Return type
- Returns an array with two elements:
	- `initialState`
	- callback to update state.
# Initial state
- Never recreates object in initial state $\implies$ use an initializer callback instead.
```javascript
// ✅ Replace state with a new object  
function TodoList() {  
  const [todos, setTodos] = useState(createInitialTodos);
}
```
# Callback to update state
- The best practice is to ==pass a callback== to the set callback.
```javascript
function handleClick() {  
	setAge(a => a + 1); // setAge(42 => 43)  
	
	setAge(a => a + 1); // setAge(43 => 44)  
	
	setAge(a => a + 1); // setAge(44 => 45)  
}
```
- Never mutates the state $\implies$ create a new object instead.
```javascript
// ✅ Replace state with a new object  

setForm({  
	...form,  
	firstName: 'Taylor'  
});
```

- Usually change state in event handler function.
# Change key to update state
- Change the `key` prop in component to update its state as well.
# Sharing state between components
- [Lifting state up](programming/javascript/react/hooks/Lifting%20state%20up.md)
***
# References
1. https://react.dev/learn/preserving-and-resetting-state for state management.
2. https://react.dev/reference/react/useState#adding-state-to-a-component for callback.
3. https://react.dev/learn/keeping-components-pure for immutability.
4. 