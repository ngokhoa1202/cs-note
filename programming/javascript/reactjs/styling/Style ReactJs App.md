#reactjs  #css #vanilla-css  #javascript  #jsx 

# Vannila CSS
- Import file `style.css` into react components.
```javascript
import "./style.css";
```
- The styling scope is static and global (works across the whole page).
- 
# Inline Style
- Style via `style` props React.
```javascript
const smallIconStyle = {
	fontSize: "1.5rem",
	width: "1.5rem",
	height: "1.5rem",
	padding: "0",
}
...
<IonIcon icon={readerOutline} alt="Policy icon" lazy={true} style={smallIconStyle}

className="me-2"

/>
```
- The priority is over [Vannila CSS](Style%20ReactJs%20App.md#Vannila%20CSS) 
- The ==scope is dynamic and local==.
- Some css properties are not supported as JSX.
# CSS Module
- Style css file as usual
- Leave CSS file name as `style.module.css` and import as a Javascript object.
```javascript
import React, { Component } from 'react';  
import styles from './Button.module.css'; // Import css modules stylesheet as styles  
import './another-stylesheet.css'; // Import regular stylesheet  
  
class Button extends Component {  
	render() {  
	// reference as a js object  
	return <button className={styles.error}>Error Button</button>;  
	}  
}
```
- The scope is ==either static or dynamic but local to component== .
