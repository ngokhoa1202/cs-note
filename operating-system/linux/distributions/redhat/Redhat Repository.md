#cli #operating-system #centos-stream #file-system #regular-expression  #fedora
#dependency-manager #rhel 
# List enabled repositories
```Shell title='List all enabled repositories'
sudo dnf repo list
```
- ![[Pasted image 20250624065305.png]]
# Enable and disable a repository
## Enable a repository
```Shell title='Disable a repository'
sudo dnf config-manager --set-disabled <repo-name>
```
- ![[Pasted image 20250624065537.png]]
## Disable a repository
```Shell title='Enable a repository'
sudo dnf config-manager --set-enabled elrepo
```
***
# References
1. 