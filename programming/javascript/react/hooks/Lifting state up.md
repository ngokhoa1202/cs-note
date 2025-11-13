#react #javascript  #functional-programming #software-architecture  #high-order-function  #dom

# Purpose
- Techniques that help ==share data among components==.
- Used for [useState hook](useState%20hook.md)
# Principle
- Lift the state up to the ==closest common ancestor==.
- ==Pass the state data as props== to child components.
- ==Change state via callbacks== in that ancestor component.
- ==Pass the callback as props== to child component (maybe use `Function.bind()`)
- Invoke the callback call via the props call.
- ![700x200](Pasted%20image%2020240603205133.png)
# References
1. https://react.dev/learn/sharing-state-between-components 
