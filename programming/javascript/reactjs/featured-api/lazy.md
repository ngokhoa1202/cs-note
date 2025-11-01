#reactjs  #javascript  #dom  #jsx #api 

# Common syntax
```Jsx title='lazy API syntax'
const SomeComponent = lazy(load)
```
# Characteristics
- `lazy` <mark class="hltr-yellow">defers</mark> loading the component's code until it is rendered for the first time.
- `lazy` components must be declared at the top level of the current module and must not be declared inside other components.
# Parameter
- `load`: is a function that returns a Promise. It is not loaded until it is rendered for the first time. After the component is first loaded, its resolved value’s `.default` is rendered as a React component.
-  Both the returned Promise and the Promise’s resolved value will be cached, so the component is not loaded more than once. If the Promise rejects, React will `throw` the rejection reason.
# Return type
- `lazy` returns a lazily loaded React component.
# Usage
- `lazy` is employed to defer the loading of component.
## Lazily loading components
```Jsx title='eager loading'
import MarkdownPreview from './MarkdownPreview.js';
```

```Jsx title='lazy loading'
import { lazy } from 'react';

const MarkdownPreview = lazy(() => import('./MarkdownPreview.js')); // defer loading component's code
```
# References
1. https://react.dev/reference/react/lazy
2. 