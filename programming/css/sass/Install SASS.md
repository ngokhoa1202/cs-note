#scss #css #css-preprocessor  #shell #npm #dependency-manager 

# Compilation
- SASS is always translated into vanilla CSS file so that the website can understand and style HTML element.
# Install npm project
- `npm init`
- `npm install node-sass`
# Config npm run scripts
- In `package.json`, set up:
	- under `"scripts"`, set up `"compile:sass: node-sass <sass-src> <dest-css>"`.
## Watching SASS file
- Automatically compiled to CSS file if SASS file is changed.
- Add watch flag `-w`: `ompile:sass: node-sass <sass-src> <dest-css> -w`
# Compile sass file
- Run `npm run compile:sass