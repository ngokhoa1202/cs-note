#cli #operating-system #centos #file-system #regular-expression  #fedora 

# List enabled repositories
```bash title='List all enabled repositories'
sudo dnf repolist
```
- ![[Pasted image 20250624065305.png]]
# Disable a repository
```bash title='Disable a repository'
sudo dnf config-manager --set-disabled <repo-name>
```
- ![[Pasted image 20250624065537.png]]
# Enable a repository
```bash title='Enable a repository'
sudo dnf config-manager --set-enabled elrepo
```
# References
1. 