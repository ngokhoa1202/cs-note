#react #oop #javascript  #typescript  #software-engineering #software-architecture #jsx 
- This approach is legacy and deprecated.
# Props
- A JSX component accepts properties via a single `props` object.
```Jsx title='props object in React class'
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
```
# State
- Equivalent to `useState` hook and used to remember the state of component when preparing to run side effects.
```Jsx title='state in React class'
class Clock extends React.Component {
  constructor(props) {    super(props);    this.state = {date: new Date()};  }
  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>     
      </div>
    );
  }
}
```
# Lifecycle methods
- There are three essential lifecycle methods `constructor`, `render`, `componentDidMount`, `componentDidUpdate` ,`componentUnmount`
```Jsx title='Lifecycle method in React class-based component'
class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  componentDidMount() {  } 
  componentDidUpdate(prevProps) {
  // Typical usage (don't forget to compare props):
	  if (this.props.userID !== prevProps.userID) {
	    this.fetchData(this.props.userID);
	  }
	}
  componentWillUnmount() {  }
  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}
```
## `constructor`
- Initializes the states of the component before being rendered.
## `render`
- Purely mounts and renders the component into the web user interface (simply build from Jsx to HTML).
## `componentDidMount`
- After the component is successfully rendered,  `componentDidMount` runs side effects to update the state on DOM and refs.
## `componentDidUpdate`
- Invoked immediately after the component has been successfully updated.
- Used to compare the new props with the old props and perform operations.
## `componentWillUnmount`
- Invoked right before the component is unmounted and destroyed.
- Used to perform clean up function.
***
# References
1. https://legacy.reactjs.org/docs/components-and-props.html for ReactJs legacy class-based components.
2. [useState hook](programming/javascript/react/hooks/useState%20hook.md) for React `useState` hooks.
3. [Component lifecycle](Component%20lifecycle.md) for React-class based component life cycle.