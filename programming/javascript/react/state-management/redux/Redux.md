#reactive-programming #software-architecture #software-engineering #react #javascript #jsx #functional-programming #high-order-function #redux #typescript 
# Redux concepts
## Redux
- Redux is a pattern and library for managing and updating <mark class="hltr-yellow">global application state</mark>, where the UI triggers events called actions to describe what happened, and separate update logic called <mark class="hltr-yellow">reducers</mark> updates the state in response. 
- It serves as a <mark class="hltr-yellow">centralized store for state</mark> that needs to be used across your entire application, <mark class="hltr-yellow">with rules</mark> ensuring that the state can only be updated in a predictable fashion.
## State management
- Redux state management is formed of three main parts of React components:
	- State: the data behind the scenes.
	- View: the UI based on current states.
	- Actions: the events that trigger updates.
- ![](Pasted%20image%2020250614113309.png)
```Jsx title='Three main parts of React components'
function Counter() {
  // State: a counter value
  const [counter, setCounter] = useState(0)

  // Action: code that causes an update to the state when something happens
  const increment = () => {
    setCounter(prevCounter => prevCounter + 1)
  }

  // View: the UI definition
  return (
    <div>
      Value: {counter} <button onClick={increment}>Increment</button>
    </div>
  )
}
```

## Actions
- An action is a plain JavaScript object that has a `type` field, which describes something that has happened in the application.
```Javascript title='Action in Redux'
const addTodoAction = {
  type: 'todos/todoAdded',
  payload: 'Buy milk'
}
```
- An action creator is a function that returns an action object.
```Javascript title='Action creator'
const addTodo = text => {
  return {
    type: 'todos/todoAdded',
    payload: text
  }
}
```

## Reducers
- A reducer is a function whose type is `(state, action) => newState`, which accepts the current state and an action object, and determines the new state based on the action.
- A reducer must not modify the existing state but return a completely new state object instead for <mark class="hltr-yellow">immutability</mark> purpose.
```Javascript title='Reducer must not modify the state object'
const initialState = { value: 0 }

function counterReducer(state = initialState, action) {
  // Check to see if the reducer cares about this action
  if (action.type === 'counter/increment') {
    // If so, make a copy of `state`
    return {
      ...state,
      // and update the copy with the new value
      value: state.value + 1
    }
  }
  // otherwise return the existing state unchanged
  return state
}
```
## Store
- Store is the <mark class="hltr-yellow">singleton object</mark> which hold all of the states of the application.
```Javascript title='Redux store'
import { configureStore } from '@reduxjs/toolkit'

const store = configureStore({ reducer: counterReducer })

console.log(store.getState())
// {value: 0}
```

## Dispatch
- Dispatch(er) is a function which <mark class="hltr-yellow">accepts an action object and internally calls its reducer to update the state</mark> inside the Redux store.
```Javascript title='Dispatcher function'
store.dispatch({ type: 'counter/increment' })

console.log(store.getState())
// {value: 1}
```

## Selector
- Selector is a small function that extracts the necessary state information from the store object.
```Javascript title='Selector'
const selectCounterValue = state => state.value

const currentValue = selectCounterValue(store.getState())
console.log(currentValue)
// 2
```

# Redux data flow
- ![[assets/ReduxDataFlowDiagram-49fa8c3968371d9ef6f2a1486bd40a26.gif]]
- Initial setup:
	- A Redux store is created using a root reducer function.
	- The store calls the root reducer once, and saves the return value as its initial `state`.
	- When the UI is first rendered, UI components access the current state of the Redux store, and use that data to render. They also <mark class="hltr-yellow">subscribe</mark> to any future store updates so they can know if the state has changed.
- Updates:
	- An event occurs in the app, and <mark class="hltr-yellow">its handler function dispatches an action</mark> to the Redux store.
	- The store runs the reducer function again with the previous `state` and the current `action`, and saves the return value as the new `state`.
	- The store notifies all parts of the UI that are subscribed that the store has been updated.
	- Each UI component that subscribes data from the store checks to see if their own state has been changed.
	- Each component that sees its data has changed forces a <mark class="hltr-yellow">re-render with the new data</mark>, so it can update what's shown on the screen
# References
1. https://redux.js.org/tutorials/essentials/part-1-overview-concepts
2. [useReducer hook](useReducer%20hook.md) for reducer concepts.
3. [Singleton pattern](software-engineering/software-architecture/design-pattern/fundamentals/creational-pattern/Singleton%20pattern.md) for Singleton pattern.
4. [Observer pattern](software-engineering/software-architecture/design-pattern/fundamentals/behavioral-pattern/Observer%20pattern.md) for Observer pattern.