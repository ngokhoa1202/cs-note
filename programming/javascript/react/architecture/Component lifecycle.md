#react #javascript #functional-programming #object-oriented-programming #software-architecture 

# Lifecycle
## Simplified lifecycle
- ![](Pasted%20image%2020250614080427.png)
## Full lifecycle
- ![](Pasted%20image%2020250614080509.png)
# Class-based lifecycle
## Mounting phase
- Mounting phase is the time that JSX components are loaded into the real DOM tree.
### Render phase
#### `Constructor(props)`
- Constructor is invoked and initialize the state and bind methods when the document is loaded in the first time.
#### `static getDerivedStateFromProps(props, state)`
- `static getDerivedStateFromProps()` is called before render and on every update.
- `static getDerivedStateFromProps()` is rarely needed and used for state synchronization with props.
#### `render()`
- `render()` is a pure function without any side effects returning JSX and rendering components.
### Commit phase
#### `componentDidMount()`
- `componentDidMount()` is called once after initial render.
- Side effects such as API calls, DOM manipulations and subscriptions can be safely called in this function.
## Updating phase
- The updating phase are automatically executed whenever new props or state changes are detected.
### Render phase
#### `static getDerivedStateFromProps(props, state)`
- `static getDerivedStateFromProps()` is called on every update and used on a limited basis.
#### `shouldComponentUpdate(nextProps, nextState)`
- `shouldComponentUpdate()`  is invoked before every render and determines whether a component should be re-rendered in response to state or props changes, thereby helping conditionally skip the re-rendering process.
#### `render()`
- `render()` function renders the components with new states or props.
### Pre-commit phase
- During the pre-commit phase, the DOM can be read.
#### `getSnapshotBeforeUpdate(prevProps, prevState)`
- `getSnapshotBeforeUpdate()` is invoked before the DOM is updated and is used to capture the previous state of the components before getting updated.
### Commit phase
#### `componentDidUpdate(prevProps, prevState, snapshot)`
- `componentDidUpdate` is invoked after the DOM has been updated.
- Side effects such as API calls, DOM manipulations and subscriptions can be safely called in this function.
## Unmounting phase
- Unmounting phase is the time JSX components are removed.
### Commit phase
#### `componentWillUnmount()`
- `componentWillUnmount` performs clean up tasks such as cancelling timers, aborting fetches and unsubscribing from events.
## Error boundary
- An error boundary is a React component that catches errors in its child component tree during render phase, lifecycle methods and constructor of child components.
### `static getDerivedStateFromError(error)`
- `static getDerivedStateFromError` is made use of to update states to show the fallback UI in case an error is thrown right before render.
- A fallback flag is returned on a regular basis.
```Javascript title='getDerivedStateFromError example'
static getDerivedStateFromError(error) {
  return { hasError: true };
}
```

### `componentDidCatch(error, info)`
- `componentDidCatch()` is invoked right after the component is removed during commit phase.
- Logging is usually performed in this method.
```Javascript title='componentDidCatch example'
componentDidCatch(error, info) {
  console.error("Caught error:", error);
  console.error("Component Stack:", info.componentStack);
}
```

# Example
## Class-based component
```JSX title='Class-based component lifecycle'
import React from 'react';

class ChatWindow extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      user: null,
      messages: [],
    };
    this.chatRef = React.createRef();
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.chatId !== prevState.chatId) {
      return { messages: [], chatId: nextProps.chatId };
    }
    return null;
  }

  componentDidMount() {
    this.fetchUser();
    this.connectWebSocket();
  }

  shouldComponentUpdate(nextProps, nextState) {
    // Prevent re-render if nothing important changed
    return nextProps.chatId !== this.props.chatId || nextState.messages !== this.state.messages;
  }

  getSnapshotBeforeUpdate(prevProps, prevState) {
    const chatBox = this.chatRef.current;
    if (chatBox) {
      return chatBox.scrollTop;
    }
    return null;
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (snapshot !== null) {
      console.log('Previous scroll position:', snapshot);
    }
    if (prevProps.chatId !== this.props.chatId) {
      this.loadChatMessages();
    }
  }

  componentWillUnmount() {
    this.socket?.close();
    clearInterval(this.timer);
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, info) {
    console.error("Error in ChatWindow:", error, info);
  }

  fetchUser() {
    fetch(`/api/user/${this.props.userId}`)
      .then(res => res.json())
      .then(user => this.setState({ user }));
  }

  connectWebSocket() {
    this.socket = new WebSocket('wss://example.com/chat');
    this.socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      this.setState(prev => ({ messages: [...prev.messages, message] }));
    };
  }

  loadChatMessages() {
    fetch(`/api/chat/${this.props.chatId}/messages`)
      .then(res => res.json())
      .then(data => this.setState({ messages: data }));
  }

  render() {
    if (this.state.hasError) {
      return <div>Something went wrong.</div>;
    }
    return (
      <div ref={this.chatRef}>
        {this.state.messages.map(msg => <p key={msg.id}>{msg.text}</p>)}
      </div>
    );
  }
}

```

## Functional component
```Jsx title='Functional component example'
import { useState, useEffect, useRef, useLayoutEffect } from 'react';

function ChatWindow({ userId, chatId }) {
  const [user, setUser] = useState(null);
  const [messages, setMessages] = useState([]);
  const [hasError, setHasError] = useState(false);
  const chatRef = useRef(null);
  const prevChatIdRef = useRef(chatId);
  const scrollPosRef = useRef(0);
  const socketRef = useRef(null);

  // Fetch user data on mount
  useEffect(() => {
    fetch(`/api/user/${userId}`)
      .then(res => res.json())
      .then(setUser)
      .catch(() => setHasError(true));
  }, [userId]);

  // Sync messages when chatId changes
  useEffect(() => {
    if (prevChatIdRef.current !== chatId) {
      fetch(`/api/chat/${chatId}/messages`)
        .then(res => res.json())
        .then(setMessages)
        .catch(() => setHasError(true));
      prevChatIdRef.current = chatId;
    }
  }, [chatId]);

  // WebSocket connection (mount + cleanup)
  useEffect(() => {
    const socket = new WebSocket('wss://example.com/chat');
    socketRef.current = socket;

    socket.onmessage = (event) => {
      const message = JSON.parse(event.data);
      setMessages(prev => [...prev, message]);
    };

    return () => {
      socket.close();
    };
  }, []);

  // Track scroll position before DOM updates
  useLayoutEffect(() => {
    if (chatRef.current) {
      scrollPosRef.current = chatRef.current.scrollTop;
    }
  });

  // Simulated error boundary — not native in function components
  if (hasError) {
    return <div>Something went wrong.</div>;
  }

  return (
    <div ref={chatRef}>
      {messages.map(msg => <p key={msg.id}>{msg.text}</p>)}
    </div>
  );
}

```
***
# References
1. https://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/ for lifecycle diagram.
2. https://legacy.reactjs.org/docs/ for lifecycle docs (oop-based).
3. https://react.dev/reference/react/Component for lifecycle docs (functional-based).
