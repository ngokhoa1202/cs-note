  #git #github #software-engineering #software-architecture #site-realibility-engineering  #file-system #project-management 
  #version-control #shell #project-management 
- Remote repositories are repository hosted on the Internet.

# Cloning remote repositories
- Run `git clone` from [Initialize project](Initialize%20project.md).
```bash
git clone -o <remote-name> <repo> <dir>
```
- By default, Git sets remote server name to `origin`.
# Showing remote repositories
- Use `git remote`.
```bash
git remote # For showing repo name only

git remote -v # For showing URL
```
- ![](Pasted%20image%2020241023095429.png)
# Adding a remote repository
- Explicitly add a remote repository as a <mark style="background: #e4e62d;">local project name</mark> $\implies$ use this name for all upstream or downstream interactions.
- Use `git remote add`
>[!Note]
>The local repository running the command must be git-initialized.

```bash
git remote add <name> <url>

git remote add origin <url> # Origin is the common remote repo name
```

- ![](Pasted%20image%2020241023101717.png)
# Fetching and pulling from remote repositories
- Downloads all the data that the local repository has not been updated yet.
- After fetching, the local repository should have all <mark style="background: #e4e62d;">references to the branches</mark> of that remote repository. However, `git fetch` <mark style="background: #e4e62d;">does not merge</mark> local branch with remote branch while `git pull` does instead.
- Use `git fetch <remote-repo>`
```bash
git fetch <remote-repo>
```
- ![](Pasted%20image%2020241023102308.png)

# Pushing to remote repositories
- Push all commits of a specific branch to the upstream server in case you gain write access to that repository.
```bash
git push <local-name-of-remote-repo> <local-branch>

git push origin master 
```

# Inspecting a remote repository
- View detailed information about a repository.
- Use `git remote show`
```bash
git remote show <local-name-of-repo>

git remote show origin
```
- ![](Pasted%20image%2020241023103835.png)
# Renaming repositories
- Use `git remote rename`
```bash
git remote rename <old-name> <new-name>
```
- The command takes effect on only local repository.
# Remove repositories
- Remove the link between the local repository and the remote one.
- Use `git remote remove`
```bash
git remote remove <repo-name>
```
- ![](Pasted%20image%2020241023104513.png)


# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	1. Git Basics.
		1. Working with remotes
2. 