#hook #reactjs  #javascript  #jsx #functional-programming  #high-order-function  #reactive-programming  #ajax #software-architecture 

# Characteristics
- `useEffect` is only run ==after the rendering phase== $\equiv$ after all of the components are renderred $\implies$ if `useEffect` callback change a state, React will trigger a re-render. [Component lifecycle](Component%20lifecycle.md)
- ==Avoid infinite loop== by specifying dependencies $\equiv$ React triggers a re-render only when that dependency has been changed $\implies$ only use with asynchronous events.
- ==Fetch data== from web API.
- Synchronize with DOM API $\implies$ manipulate DOM in case of blocking mechanism.

>[!Note]
>Dependencies can be ==properties==, states, or ==functions== or ==context values== that `useEffect` will trigger a re-render if these values change.

## Return type
- `underfined` or a cleanup function.
- A cleanup function to remove the unused event listener or callback.
# Usage
- Synchronize with DOM API. 
```jsx
import { useState, useRef, useEffect } from 'react';

function VideoPlayer({ src, isPlaying }) {
  const ref = useRef(null);
  // runtime error because at this line of code, the video has not been rendered yet,
  // so the ref is null => ref.current will cause error.
  // need to wait until the video has already been renderred
  if (isPlaying) {
    ref.current.play();  // Calling these while rendering isn't allowed.
  } else {
    ref.current.pause(); // Also, this crashes.
  }

  return <video ref={ref} src={src} loop playsInline />;
}

export default function App() {
  const [isPlaying, setIsPlaying] = useState(false);
  return (
    <>
      <button onClick={() => setIsPlaying(!isPlaying)}>
        {isPlaying ? 'Pause' : 'Play'}
      </button>
      <VideoPlayer
        isPlaying={isPlaying}
        src="https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4"
      />
    </>
  );
}
```

```jsx
import { useEffect, useRef } from 'react';  

function VideoPlayer({ src, isPlaying }) {  

	const ref = useRef(null);  

   // works brilliantly
	useEffect(() => {  
		if (isPlaying) {  
			ref.current.play();  
		} else {  
		ref.current.pause();  
		}  
	});  
	return <video ref={ref} src={src} loop playsInline />;  
}
```

- Fetch data from web api ==only after== all components are mounted.
```jsx
import { useEffect } from 'react';
import { createConnection } from './chat.js';

export default function ChatRoom() {
  // wait for components to mount because fetch/axios apis are all asynchronous
  useEffect(() => {
    const connection = createConnection();
    connection.connect();
  }, []);
  return <h1>Welcome to the chat!</h1>;
}
```



