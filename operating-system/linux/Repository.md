#operating-system #ubuntu #installation  #cli 
# Apt repository
## Search a package
```Shell
sudo apt search <name>
```
## Install a package
```Shell
sudo apt install <name>
```

or download the `.deb` file and follow [Install .deb file](operating-system/linux/distributions/debian/Install%20.deb%20file.md)
## Update the meta data
- Compare and check the local repository databse with new update from the central repository.
```Shell title='Update metada'
sudo apt update
```
## Delete a package
```Shell
sudo apt remove <name>
```
--- 
# References
1. https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg for repository management on Linux distro.