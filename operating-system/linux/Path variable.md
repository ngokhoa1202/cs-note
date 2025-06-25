#ubuntu #os  #configuration  #installation  #os  #cli  #debian 

# Path variable location
- Append the `$PATH` environment variable with the `bin` path of the program that we want to make us of its command on the terminal.
- Normally use the `~/.bashrc` file to configure the path.
```bash
sudo nvim ~/.bashrc
```
- After having changed the `bashrc` file and exitted, apply the changes by
```bash
source ~/.bashrc
```

- Refer to https://stackoverflow.com/questions/37676849/where-is-path-variable-set-in-ubuntu 
