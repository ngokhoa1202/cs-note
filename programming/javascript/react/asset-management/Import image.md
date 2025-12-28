#react #javascript #jsx  #image 

# Import normally
- Use `import` command.
```Javascript
import React from 'react';
import logo from './logo.png'; // Tell webpack this JS file uses this image

console.log(logo); // /logo.84287d09.png

function Header() {
  // Import result is the URL of your image
  return <img src={logo} alt="Logo" />;
}

export default Header;
```
			
# Import as `ReactComponent`
- Usually used for `svg` file.
```javascript
import React from 'react';
import {ReactComponent as Logo} from './logo.svg'; // Tell webpack this JS file uses this image

console.log(logo); // /logo.84287d09.png

function Header() {
  // Import result is the URL of your image
  return (
    <Logo alt="..." style={{...}} width={} height={} />
  );
}

export default Header;
```
***
# References
1. https://create-react-app.dev/docs/adding-images-fonts-and-files/ for source code.