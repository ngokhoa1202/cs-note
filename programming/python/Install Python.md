#python #installation  #ubuntu  #shell 
# Install Python
- Download `tar.gz` file from https://www.python.org/
- Extract the `.tar.gz` file
```Shell
tar -xf Python-3.12.1.tgz
```
- Open the newly extracted file, run configuration scripts to prepare for installation and optimization execution speed.
```bash
./configure --enable-optimizations
```
- Install python
```bash
sudo make install
```
or make it as an alternative to existed python version
```bash
sudo make altinstall
```
***
# References
1. https://phoenixnap.com/kb/how-to-install-python-3-ubuntu for building python from source.
2. https://www.python.org/ for downloading python.