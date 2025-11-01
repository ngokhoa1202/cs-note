#reactjs  #javascript  #hook #dom  #jsx #functional-programming 

# Characteristics
- Similar to [Lifting state up](Lifting%20state%20up.md), `useContext` is used to ==share state among components== but ==without passing props into the virtual DOM tree==.
- Avoid props drilling $\equiv$ directly passing props into the virtual DOM tree. 
## Return type
- Returns a context value $\equiv$ environment value taken from the closest Context Provider for the calling components.
- If there is no Context Provider found, return the default value passed in the `createContext` function.
# Usage
## Basic
- Define the context by calling the `createContext` function and pass an default value to that function.
```jsx
import { createContext, useContext } from 'react';

const ThemeContext = createContext(null);

export default function MyApp() {
  return (
    <ThemeContext.Provider value="dark">
      <Form />
    </ThemeContext.Provider>
  )
}
```
- The context is defined and exported ==on a separate file== on a regular basis.
```jsx
import { createContext } from "react";
export const ApiUrlCtx = createContext("http://localhost:7171");
```
- Optionally define a `useState` hook and pass that state value to the `value` prop of Context Provider in ==the ancestor componen==t.  $\implies$ overriding this value is acceptable.
```jsx
export default function MyApp() {
  const [theme, setTheme] = useState('light');
  return (
    <>
      <ThemeContext.Provider value={theme}>
        <Form />
      </ThemeContext.Provider>
      <Button onClick={() => {
        setTheme(theme === 'dark' ? 'light' : 'dark');
      }}>
        Toggle theme
      </Button>
    </>
  )
}
```
- Read the Context value in the descendant components by `useContext` hook.  If there is no Context Provider, the initial value passed into the `createContext` function is employed.
```jsx
function Panel({ title, children }) {
  const theme = useContext(ThemeContext);
  const className = 'panel-' + theme;
  return (
    <section className={className}>
      <h1>{title}</h1>
      {children}
    </section>
  )
}
```

## Advanced - multiple contexts
- Refers to https://www.udemy.com/course/react-the-complete-guide-incl-redux/learn/lecture/8298056#questions

# References
1. https://www.udemy.com/course/react-the-complete-guide-incl-redux/learn/lecture/8298056#questions for separate context providers.
2. https://react.dev/reference/react/useContext#optimizing-re-renders-when-passing-objects-and-functions for `useContext` official documentation.
3. 



