#git #github #version-control #project-management #cli #file-system #ssh #https #software-engineering #site-realibility-engineering
#project-management 

# Initialize a repository
- Move to the project directory.
- Create a sub directory `.git` - no tracking.
```bash
git init
```
- Start tracking the repository.
```bash
git add . # add the file
git commit -m "Initilize the project"
```

# Clone a repository 
- Clone the source of a repository from a remote source host.
```bash
git clone <repo-url>
```
- Clone the remote repository and rename it.
```bash
git clone <repo-url> <repo-name>
```

>[!Important]
>https:// prefix urls use HTTPS protocol.
>git:// or username@server:path/to/repo.git use SSH protocol.

# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	1. Git Basics.