#hook #reactjs  #javascript  #jsx #functional-programming  #high-order-function  #reactive-programming  #ajax #software-architecture 

# Common syntax
```JSX title='useMemo hook'
const cachedValue = useMemo(calculateValue, dependencies)
```
# Characteristics
- `useMemo` caches the result of a calculation between re-renders.
# Parameter
- `calculatedValue` is a function calculating the value that should be cached. It should be pure, should take no arguments, and should return a value of any type. On the first render, the function is executed. On next renders, the cached value is instantly returned if the `dependencies` have not changed since the last render.
- `dependencies` is  a list of all reactive values referenced inside of the `calculateValue` code. Reactive values include props, state, and all the variables and functions declared directly inside your component body.
# Usage
- `useMemo` is used to skip calculating computed states with heavy computations.
```JSX title='useMemo hook to skip unnecessary computations'
import { useMemo } from 'react';

function TodoList({ todos, tab, theme }) {
  const visibleTodos = useMemo(() => filterTodos(todos, tab), [todos, tab]);
  // ...
}
```
- `useMemo` is also made use of skipping re-renders of child components.
- 
---
# References
1. https://react.dev/reference/react/useMemo