#software-architecture #software-engineering #reactjs #javascript #jsx #functional-programming #high-order-function #event-driven-programming 

# Selector function
- A selector function is a function that accepts the Redux store state (or part of the state) as an argument, and returns data that is based on that state.
```Javascript title='Selector function example'
// Arrow function, direct lookup
const selectEntities = state => state.entities

// Function declaration, mapping over an array to derive values
function selectItemIds(state) {
  return state.items.map(item => item.id)
}

// Function declaration, encapsulating a deep lookup
function selectSomeSpecificField(state) {
  return state.some.deeply.nested.field
}

// Arrow function, deriving values from an array
const selectItemsWhoseNamesStartWith = (items, namePrefix) =>
  items.filter(item => item.name.startsWith(namePrefix))
```

---
# References
1. https://redux.js.org/usage/deriving-data-selectors