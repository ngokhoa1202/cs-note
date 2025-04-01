#reactjs  #javascript  #hook #functional-programming #high-order-function #dom #reactive-programming 

>[!Note]
>A **reducer** is a function that receives the current `state` and an `action` object, decides how to update the state if necessary, and returns the new state: `(state, action) => newState`.
# Common syntax
```Javascript title='useReducer syntax'
const [state, dispatch] = useReducer(reducer, initialArg, init?)
```
# Parameter
- `reducer` : a pure function that specifies <mark style="background: #DCF2B0;">how the state gets updated</mark>. It accepts the state and action as arguments, and return the next state.  State and action can be of any types.
- `initialArg`: the value passed to `init` function to initialize the state.
- `init`: The initializer function that should return the initial state. If it’s not specified, the initial state is set to `initialArg`. Otherwise, the initial state is set to the result of calling `init(initialArg)`.
# Return type
- Returns an array with two elements:
	- The current state or the initial state during the first render.
	- Dispatcher - a function which updates the state to a different value and triggers a page re-render.
# Characteristics
- Dispatcher allows a s<mark style="background: #c19939;">tate to be updated by passing a specific action</mark>.
```Javascript title='useReducer hook'
import React, { useReducer } from 'react';
import logo from './logo.svg';
import './App.css';

/**
 * 
 * @param {{name: string}} state 
 * @param {{type: string}} action 
 */
function reducer(state, action) {
  switch (action.type) {
    case 'perfect':
      return { name: 'Site reliability engineer' };
    case 'great':
      return { name: 'DevOps engineer' };
    case 'pleasing':
      return { name: 'Java Backend engineer' };
    case 'satisfying':
      return { name: 'Fullstack engineer' };
    default:
      return state;
  }

}

export default function App() {

  const [job, dispatch] = useReducer(reducer, { name: 'Java Backend engineer' });

  /**
   * 
   * @param {Event} e
   * @param {string} joy
   */
  const onClickButton = (e, joy) => {
    alert('You clicked my button');
    dispatch({ type: joy });
  }

  return (
    <>
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
      </header>


        <button style={{ padding: '10px', borderRadius: '5px', width: '200px', fontSize: '32px' }}
          onClick={(e) => onClickButton(e, 'perfect')}>
          Perfect
        </button>

        <button style={{ padding: '10px', borderRadius: '5px', width: '200px', fontSize: '32px' }}
          onClick={(e) => onClickButton(e, 'great')}>
          Great
        </button>

        <button style={{ padding: '10px', borderRadius: '5px', width: '200px', fontSize: '32px' }}
          onClick={(e) => onClickButton(e, 'pleasing')}>
          Pleasing
        </button>

        <button style={{ padding: '10px', borderRadius: '5px', width: '200px', fontSize: '32px' }}
          onClick={(e) => onClickButton(e, 'satisfying')}>
          Satisfying
        </button>
        <p>{job?.name ?? 'I do not know'}</p>

    </>
  );
}
```
- State updates within an event handler are <mark style="background: #c19939;">batched</mark>. React only updates the webpage **after all the event handlers have run** and have called their `set` functions.
- Reducer consolidates state logic management by separating and centralizing states into a function. 
---
# References
1. https://react.dev/reference/react/useReducer for `useReducer` docs.
2. https://react.dev/learn/extracting-state-logic-into-a-reducer for migration from `useState` to `useReducer`.
3. https://react.dev/learn/queueing-a-series-of-state-updates for Queuing React States.