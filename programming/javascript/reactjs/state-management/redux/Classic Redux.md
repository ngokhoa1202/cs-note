#software-architecture #software-engineering #reactjs #javascript #jsx #functional-programming #high-order-function #event-driven-programming

# State structure
- The root Redux state value is almost always a plain JSON object, with other data nested inside of it.
# Action design
- Action is actually a JSON object with a `type` property and usually a `payload` property.
```Jsx title='action object in reality'
export default {
    parent: 'FwUser',
    reducers: {
        /**
         * @param {Object} state - The current state of the user reducer.
         * @param {Object} action - The action dispatched to the reducer.
         * @param {string} action.type - The type of action being dispatched.
         * @param {Object} action.payload - The payload of the action.
        */
        user: (state = { loading: false, items: { list: [] } }, action) => {
            switch (action.type) {
                case 'FwUser_Loading':
                    return { ...state, loading: true };
                case 'FwUser_GetPage':
                    return { items: action.payload, loading: false };
                case 'FwUser_GetItem':
                    return { item: action.payload, loading: false };
                case 'FwUser_UpdateItem':
                    return {
                        ...state,
                        loading: false,
                        items: {
                            ...state.items,
                            list: state.items.list.map((item) => item.id === action.payload.id ? action.payload : item)
                        }
                    };
                case 'FwUser_DeleteItem':
                    return {
                        ...state,
                        loading: false,
                        items: {
                            ...state.items,
                            list: state.items.list.filter((item) => item.id !== action.payload)
                        }
                    };
                case 'FwUser_Failed':
                    return { ...state, loading: false };
                default: return state;
            }
        }
    }
};
```

# Writing reducers
- The Redux app has only one root reducer function, which is passed as argument into `createStore` function. That one root reducer function is responsible for handling _all_ of the actions that are dispatched, and calculating what the _entire_ new state result should be every time.
- Reducers should be organized based on their <mark class="hltr-yellow">features</mark> into slice files and combined once.
```Javascript title='Manually combine reducers in reducer.js'
import todosReducer from './features/todos/todosSlice'
import filtersReducer from './features/filters/filtersSlice'

export default function rootReducer(state = {}, action) {
  // always return a new object for the root state
  return {
    // the value of `state.todos` is whatever the todos reducer returns
    todos: todosReducer(state.todos, action),
    // For both reducers, we only pass in their slice of the state
    filters: filtersReducer(state.filters, action)
  }
}
```

```Javascript title='Combine reducers using combineReducers() function'
import { combineReducers } from 'redux'

import todosReducer from './features/todos/todosSlice'
import filtersReducer from './features/filters/filtersSlice'

const rootReducer = combineReducers({
  // Define a top-level state field named `todos`, handled by `todosReducer`
  todos: todosReducer,
  filters: filtersReducer
})

export default rootReducer
```
# Initializing store
- Each Redux store has only <mark class="hltr-yellow">one single root reducer</mark> function.
```Javascript title='Set up the store with root reducer'
import { createStore } from 'redux'
import rootReducer from './reducer'

const store = createStore(rootReducer)

export default store
```
- Initial state can also be loaded using the second argument.
```Javascript title='Loading initial state from localStorage'
import { createStore } from 'redux'
import rootReducer from './reducer'

let preloadedState
const persistedTodosString = localStorage.getItem('todos')

if (persistedTodosString) {
  preloadedState = {
    todos: JSON.parse(persistedTodosString)
  }
}

const store = createStore(rootReducer, preloadedState)
```
# Dispatching actions
```Javascript title='Dispatch actions using Redux store object'
// Omit existing React imports

import store from './store'

// Log the initial state
console.log('Initial state: ', store.getState())
// {todos: [....], filters: {status, colors}}

// Every time the state changes, log it
// Note that subscribe() returns a function for unregistering the listener
const unsubscribe = store.subscribe(() =>
  console.log('State after dispatch: ', store.getState())
)

// Now, dispatch some actions

store.dispatch({ type: 'todos/todoAdded', payload: 'Learn about actions' })
store.dispatch({ type: 'todos/todoAdded', payload: 'Learn about reducers' })
store.dispatch({ type: 'todos/todoAdded', payload: 'Learn about stores' })

store.dispatch({ type: 'todos/todoToggled', payload: 0 })
store.dispatch({ type: 'todos/todoToggled', payload: 1 })

store.dispatch({ type: 'filters/statusFilterChanged', payload: 'Active' })

store.dispatch({
  type: 'filters/colorFilterChanged',
  payload: { color: 'red', changeType: 'added' }
})

// Stop listening to state updates
unsubscribe()

// Dispatch one more action to see what happens

store.dispatch({ type: 'todos/todoAdded', payload: 'Try creating a store' })

// Omit existing React rendering logic
```

- Every invocation of `store.dispatch()` makes the store internally call the root reducer function, which may delegate the responsibility to the proper slice reducer:
	- If there are any changes, the store automatically saves the new state value inside.
	- Then, it calls all the listener subscription callbacks.
	- If a listener has access to the `store`, it can now call `store.getState()` to read the latest state value.
```Javascript title='Subscribe and listen to state changes by using store.subscribe()'
// Omit existing React imports

import store from './store'

// Log the initial state
console.log('Initial state: ', store.getState())
// {todos: [....], filters: {status, colors}}

// Every time the state changes, log it
// Note that subscribe() returns a function for unregistering the listener
const unsubscribe = store.subscribe(() =>
  console.log('State after dispatch: ', store.getState())
)

// Now, dispatch some actions

store.dispatch({ type: 'todos/todoAdded', payload: 'Learn about actions' })
store.dispatch({ type: 'todos/todoAdded', payload: 'Learn about reducers' })
store.dispatch({ type: 'todos/todoAdded', payload: 'Learn about stores' })

store.dispatch({ type: 'todos/todoToggled', payload: 0 })
store.dispatch({ type: 'todos/todoToggled', payload: 1 })

store.dispatch({ type: 'filters/statusFilterChanged', payload: 'Active' })

store.dispatch({
  type: 'filters/colorFilterChanged',
  payload: { color: 'red', changeType: 'added' }
})

// Stop listening to state updates
unsubscribe()

// Dispatch one more action to see what happens

store.dispatch({ type: 'todos/todoAdded', payload: 'Try creating a store' })

// Omit existing React rendering logic
```

- Behind the scenes, the Redux store ends up being mapped into a single function with its reducers.
```Javascript title='Redux store behind the scenes'
function createStore(reducer, preloadedState) {
  let state = preloadedState
  const listeners = []

  function getState() {
    return state
  }

  function subscribe(listener) {
    listeners.push(listener)
    return function unsubscribe() {
      const index = listeners.indexOf(listener)
      listeners.splice(index, 1)
    }
  }

  function dispatch(action) {
    state = reducer(state, action)
    listeners.forEach(listener => listener())
  }

  dispatch({ type: '@@redux/INIT' })

  return { dispatch, subscribe, getState }
}
```
# References
1. https://redux.js.org/tutorials/fundamentals/part-3-state-actions-reducers
2. 