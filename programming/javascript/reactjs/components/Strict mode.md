#reactjs  #debug  #javascript #jsx 

# Purpose
- Creates a development environment to ==detect bugs early==.
```javascript
import { StrictMode } from 'react';import { createRoot } from 'react-dom/client';
const root = createRoot(document.getElementById('root'));root.render(  
	<StrictMode>    
		<App />  
	</StrictMode>
);
```
# Characteristics
- Rerender components ==one extra time to detect impure objects== (objects that has  been mutated).
- Rerun effects one extra time to to detect missing effect cleanup:
	- Run one extra setup and cleanup lifecycle.
- 