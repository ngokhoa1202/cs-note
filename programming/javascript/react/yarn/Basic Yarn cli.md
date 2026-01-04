#shell #yarn #react #dependency-manager #javascript #typescript 

# Create React project
- `yarn create react-app <app-name>`
# Set version
- `yarn set version <version>`
```Bash title='yarn set version examples'
yarn set version classic # most stable yarn

yarn set version berry #  latest version of yarn


```

# Node linker - Install mode
- Use `yarn config set nodeLinker <type>`
```Bash title='yarn nodelinker examples'
yarn config set nodeLinker node_modules # default by npm, but not default by yarn --> slowest but most compatible

yarn config set nodeLinker pnpm #  ---> faster, less compatible

yarn config set nodeLinker pnp # default by yarn - plug and play --> fastest, but least compatible.
```

- Or using `yarnrc.yml` in the root source.
```yaml title='yarnc.yaml example'
nodeLinker: node-modules
yarnPath: .yarn/releases/yarn-1.22.22.cjs
```
# References
1. https://yarnpkg.com/ fior `yarn` cli.
2. https://yarnpkg.com/features/linkers for `yarn nodeLinker` comparison. 