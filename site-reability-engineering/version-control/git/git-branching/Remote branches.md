#git #github #version-control #project-management #cli #file-system #software-engineering 
#site-realibility-engineering #project-management #software-architecture 
# Remote branch initialization
- Remote branches is actually <mark style="background: #e4e62d;">pointers</mark> to commits stored on remote server.
- Explicitly list remote branches use `git ls-remote` or `git remote show` commands.
```bash
git ls-remote <local-name-of-remote-branch>
# equivalent to
git remote show <local-name-of-remote-branch>
```
- ![](Pasted%20image%2020241102111844.png)
- Remote-tracking branch names take the form `<remote>/<branch>` . Example: `origin/main`, `origin/dev`, `origin/master`,...
>[!Important]
>By default, Git automatically sets the remote branch name to `origin/master` when cloning a repository.
>Rename remote name when cloning a repository using  `-o` flag
>`git clone -o <remote-name>` 
- ![](Pasted%20image%2020241102112711.png)

# Remote branch fetching
- Local branches and remote branches may significantly diverges. ![](Pasted%20image%2020241102112848.png)
- Remote branch synchronization means <mark style="background: #e4e62d;">fetching</mark> new data from remote server, <mark style="background: #e4e62d;">updating</mark> the local database, <mark style="background: #e4e62d;">moving the locally remote branch</mark> to its up-to-date position.
```bash
git fetch <remote-branch> # Fetch, update & move locally remote branch

git fetch origin master # Update the master branch in remote origin
```

- ![](Pasted%20image%2020241102113528.png)
## Multiple remote servers
- Use `git remote add` to add a remote server to the local database. [Fetching and pulling from remote repositories](Remote%20repository.md#Fetching%20and%20pulling%20from%20remote%20repositories)
- ![](Pasted%20image%2020241102113832.png)
- Run `git fetch <remote>` to fetch, update the new remote  branch on remote server.
- ![](Pasted%20image%2020241102114030.png)
- `git fetch` only downloads new <mark style="background: #e4e62d;">immutable remote branches</mark> ($\equiv$ not editable) but <mark style="background: #e4e62d;">NOT</mark> create an editable local equivalent branch.
- $\implies$ There are two ways to resolve this:
	- Switch to local branch and merge it with the fetched remote branch using `git merge`
	- Create a local copy branch based on that remote branch using `git checkout` or `git branch -u` 
```bash title:"git checkout for fetching remote"
# Creating a branch based on remote branch
git checkout -b <new-local-branch> <fetched-remote-branch>

# If the new local branch has already created
git branch -u <remote-branch>

# Fetch all up-to-date commits
git fetch --all


# Example
git checkout -b serverfix origin/serverfix 
Branch serverfix set up to track remote branch serverfix from origin. Switched to a new branch 'serverfix
```

# Remote branch push
- Run `git push` to upload the local branch update to the remote branch. [Pushing to remote repositories](Remote%20repository.md#Pushing%20to%20remote%20repositories)
```bash title:"git push to push a branch"
git push <remote> <branch> # General simplest form
```
- The full branch form in both local and remote server is `refs/head/<local-name-of-branch>:refs/head/<remote-name-of-branch>`.
# Remote branch track
- When a repository is cloned, an <mark style="background: #e4e62d;">upstream branch</mark> is automatically locally created to track changes of that cloned remote branch. Run `git checkout --track` to manually track a remote branch. 
```bash
git checkout --track <remote-branch>
```
- In case the branch name does not exist or exactly matches a remote branch name, it is <mark style="background: #e4e62d;">automatically tracked</mark> by Git.
- ![](Pasted%20image%2020241102135338.png)
- If a branch is being tracked, `@{upstream}` or `@{u}` can be used to replace the remote branch name when merging.
```bash title:@{upstream}
git merge @{u}
```

# Remote branch pull
- `git pull` both fetches the remote branches' updates and merges them with the local branches. In a word, `git pull` is equivalent to `git fetch` and `git merge`.
```bash
git pull <remote-branch>
```

# Remote branch deletion
- Run `git push -d` to delete a remote branch.
```bash title:"git push --delete"
git push <remote> --delete <branch> # Verbose form

git push <remote> -d <branch> # Simple form
```

---
# References
- Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	- Git Branching.
		- Branch workflows.
		- Remote branches
-  https://git-scm.com/docs/git-branch for `git branch`
-  [Recording changes to repository](Recording%20changes%20to%20repository.md) for `git commit`.
-  https://git-scm.com/docs/git-log for `git log`
-  [Git branching and merging](Git%20branching%20and%20merging.md)
	- [Merging a branch - three-way merging - merge commit](Git%20branching%20and%20merging.md#Merging%20a%20branch%20-%20three-way%20merging%20-%20merge%20commit)
- [Remote repository](Remote%20repository.md)


