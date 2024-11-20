#reactjs  #javascript  #functional-programming  #hook  #dom #reactive-programming

# Characteristics
- Remembers ==state== of component in DOM tree.
- Interactively updated by event callback $\implies$ create a new object and assigns the reference to that new object $\equiv$ ==immutable state== as well as ==trigger a re-render.==
- State is preserved ==as long as its position and value on DOM tree is unchanged==.
- In `StrictMode`,  state is rendered twice.
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
[Lifting state up](Lifting%20state%20up.md)
# References
1. https://react.dev/learn/preserving-and-resetting-state for state management.
2. https://react.dev/reference/react/useState#adding-state-to-a-component for callback.
3. https://react.dev/learn/keeping-components-pure for immutability.
4. 