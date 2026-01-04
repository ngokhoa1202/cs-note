#shell #typescript #javascript 
# Initialize TypeScript parser

```Shell title='Typescript basic commands'
# Run a compile based on a backwards look through the fs for a tsconfig.json  
tsc  
# Emit JS for just the index.ts with the compiler defaults  
tsc index.ts  
# Emit JS for any .ts files in the folder src, with the default settings  
tsc src/*.ts  
# Emit files referenced in with the compiler settings from tsconfig.production.json  
tsc --project tsconfig.production.json  
# Emit d.ts files for a js file with showing compiler options which are booleans  
tsc index.js --declaration --emitDeclarationOnly  
# Emit a single .js file from two files via compiler options which take string arguments  
tsc app.ts util.ts --target esnext --outfile index.js
```
***
# References
1. https://www.typescriptlang.org/docs/handbook/compiler-options.html for Typescript basic command lines.
2. [Typescript configuration](Typescript%20configuration.md) for Typescript configuration.