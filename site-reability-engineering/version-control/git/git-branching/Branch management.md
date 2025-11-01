#git #github #version-control #project-management #cli #file-system #software-engineering #ide 
#site-realibility-engineering #project-management #software-architecture 
# Viewing branches
## Viewing current branch
- Run `git branch`
```Shell title='View current branch'
git branch
```
- ![](Pasted%20image%2020241028152824.png)
## Viewing the last commit of branches
- Run `git branch -v`
```bash
git branch -v # Simple form

git branch --verbose # Verbose form
```
- ![](Pasted%20image%2020241028153026.png)
## Viewing merged branches
- Run `git branch --merged` to view the branches which have been merged into the current branch including itself, similarly to `--no merged` filter.
```Shell title='View merged branches' 
git branch --merged # View branches that have been merged into current branch

git branch --no-merged # View branches that have not been merged into current branch

git branch --merged <branch-name> # View branches that have been merged with (not merge into or merge in)
```

# Deleting branches
- [Delete a branch](Git%20branching%20and%20merging.md#Delete%20a%20branch)
## Forcefully deleting branches
- Forcefully delete a branch using `git branch -D`.
```Shell title='Forcefully delete a branch'
git branch -D <branch-contains-unmerged-work>
```
## Remotely deleting branches
- Run `git push -d` to delete a branch on remote server.
```Shell title='Remotely delete a branch'
git push origin -d <branch> # Simple branch

git push origin --delete <branch>
```
# Changing branch name
- Rename branch name using `git branch --move` command:
```Shell title='Change a branch name'
git branch --move <old-branchname> <new-branchname> # on local only

git push --set-upstream origin master # Push that changed branch to remote server

git branch -m <old-name> <new-name>
```

- Or checkout to a specific branch and use `git branch -m` command.
```Shell title='Another way to change branch name'
git checkout <old-branch-name>
git branch -m <new-branch-name>
```
# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	- Git Branching.
		- Branch management.
2. https://git-scm.com/docs/git-branch for `git branch`
2. [Recording changes to repository](Recording%20changes%20to%20repository.md) for `git commit`.
3. https://git-scm.com/docs/git-log for `git log`