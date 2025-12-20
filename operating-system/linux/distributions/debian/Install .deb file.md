#operating-system #ubuntu #installation  #cli #debian

# Install .deb file
- Use the command:
```bash
sudo dpkg -i <file>.deb
```
where `-i` stands for install.
- Or use `apt install`
```Sh
sudo apt install ./<file>.deb
```
# Fix missing package
- If there are some dependecies missing during installation,  use `--fix-missing` command to add new metada.
```bash
 sudo apt update --fix-missing
```
-  Install missing packages using `-f` flag which stands for fix.
```bash
sudo apt install -f
```