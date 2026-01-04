#operating-system #ubuntu #installation  #shell #debian
# Install `.deb` file
- Use the command:
```bash
sudo dpkg -i <file>.deb
```
where `-i` stands for install.
- Or use `apt install`
```Shell
sudo apt install ./<file>.deb
```
# Fix missing package
- If there are some dependecies missing during installation,  use `--fix-missing` command to add new metada.
```Shell
 sudo apt update --fix-missing
```
-  Install missing packages using `-f` flag which stands for fix.
```Shell
sudo apt install -f
```
***
# References
1. 