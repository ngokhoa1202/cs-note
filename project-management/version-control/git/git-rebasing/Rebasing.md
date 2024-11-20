#git #github #version-control #project-management #cli #file-system #software-engineering 
#site-realibility-engineering #project-management #software-architecture 

# Basic rebasing
- Git rebasing means all the changes committed on one branch is taken and <mark style="background: #e4e62d;">rewritten on a different branch</mark>.
- Rebasing works by as follow:
	- Find the common ancestor of the two branches.
	- <mark style="background: #e4e62d;">Rewrite</mark> the differences introduced by the <mark style="background: #e4e62d;">commits</mark> of the current branch (`experiment`) into new commits of the branch rebased onto  `master`
	- <mark style="background: #e4e62d;">Reset the current branch</mark> to the <mark style="background: #ADCCFFA6;">recently latest rewritten commit</mark> of the branch rebased onto.
	- $\implies$ *Linearize* the branch tree.
>[!Important]
>What makes the difference between `git merge` and `git rebase` is that rebasing rewrites commits onto another branch while merging creates a new commit to merge commits on the main branch and make any merge modification on that commit.

- Use `git checkout` and `git rebase` command:
```bash
git checkout <topic-branch> # Move HEAD pointer to topic branch

git rebase <main-branch> # Rewrite all commits diverging from topic branch onto main branch, 
# set topic branch to its latest rewritten commit, but the main branch has not moved yet

git checkout <main-branch> # Switch to main branch to prepare for merging

git merge <topic-branch> 
# Perform a fast-forward merging because the commit on which the main branch
# because the commit which the main branch is currently on is the direct ancestor of the rewritten
# commits made by git rebase. In a word, move the main branch to the latest rewritten commit.

```
- Before rebasing ![](Pasted%20image%2020241102153226.png)
- After rebasing, fast-forward merging may be required to merge the current branch (`dev`) with the branch rebased onto (`main`)![](Pasted%20image%2020241102153255.png)
- Fast-forward merge `dev` with `master`
- ![](Pasted%20image%2020241102153912.png)
# Example
- Original two branches `experiment` and `master` ![](Pasted%20image%2020241102145405.png)
- Three-way merging: `C5` is a merge commit ![](Pasted%20image%2020241102145031.png)
- Rebasing: Rewrite commits of `experiment` into `master` and set `experiment` to the latest rewritten commits.
- ![](Pasted%20image%2020241102153605.png)
- ![](Pasted%20image%2020241102153951.png)

# Advanced rebasing
## Rebasing only necessary commits
- In case there are three branches involved (`main`, `server` and `client`). The `client` branch needs merging into `main` branch for production deployment while the divergence made by the `server` branch must be postponed being merged until all of its effects have been already tested.
- ![](Pasted%20image%2020241107110945.png)
- Run `git rebase --onto` to tackle this issue: `C8` and `C9` are replayed on `master` branch into `C8'`, `C9'` while `C3`,`C4`, `C10` on `server` branch do not involve during the rebasing
```bash
# Take and rewrite all changes made on client branch which are not on server branch o
# onto main branch
git rebase --onto main server client
```

- ![](Pasted%20image%2020241107111745.png)
- After rebasing, `git checkout` and `git merge` is required to fast-forward `master` branch ![Pasted image 20241107111604](Pasted%20image%2020241107111604.png)
```bash
git checkout main

git merge client
```

## Rebasing without checkout
- Rewrite all the commits made by a topic branch onto the main branch without check the former out.
- Run `git rebase` command.
```bash
git rebase <main-branch> <topic-branch>
```
- ![](Pasted%20image%2020241107112314.png)
## Deleting redundant branch history
- After a rebasing is performed, a branch commit history may need to be manually deleted.
- Run `git branch -d` [Git branching and merging](Git%20branching%20and%20merging.md)

# Perils of rebasing
## Tips
- Rebasing means deleting existing commits in one branch and rewriting them into another branch.
>[!Important]
>Never rebase commits existing outside your repository and that other developers have based work on..
>
>Never rebase a branch that has been pushed to Git.


- In case the repository based working on has been rebased and forcefully pushed to the remote server, another `git rebase` rather than `git merge` may be needed to reorganize the local branches.
```bash
git checkout <main-branch> # Switch to local main branch

 # rebase this branch to reorganize the local main branch
git rebase <remote-main-branch-which-has-been-rebased>
```
- The rationale behind this technique is that if a branch on which is based working has been remotely rebased, pulled down to one's local machine and <mark style="background: #e4e62d;">locally rebased again</mark>, Git can automagically detect which work is unique to his repository and apply them back on top of the new branch thanks to the patch id (or patch checksum).
- Run `git pull --rebase` to automatically rebase or `git fetch` followed by `git rebase` to manually rebase.
```bash title:"Rebase when your work has already rebased"

# Automatically rebase
git pull --rebase # Pull then rebase

git config --global pull.rebase true # Set git pull --rebase by default


# Manually rebase
git fetch <remote-branch>

git checkout <main-branch>

git rebase <remote-branch>

```
## Examples
- Initial repository ![](Pasted%20image%2020241107114023.png)
- After other developers' commits, pushes to server and these commits are pulled to local. ![](Pasted%20image%2020241107114304.png)
- If someone who pushed the merged work decide to go back and rebase their work, they run `git push --force` to overwrite server's history. Then these commits are manually fetched to local.
- ![](Pasted%20image%2020241107114808.png)
- If these changes are pulled, a merge commit will be created and it includes both history of the two branches.
- ![](Pasted%20image%2020241107115259.png)
- If we run a `git log` when your history looks like this, we’ll see two commits `C4` and `C6` that have the same author, date, and message.  Furthermore, if you push this history back up to the server, you’ll reintroduce all those rebased commits to the central server, which can further confuse people. That’s why they <mark style="background: #e4e62d;">rebased in the first place</mark>.
- If we run `git rebase teamone/master`, Git will:
	- Determine which work is unique to our branch (`C2`,  `C3`, `C4`, `C6`, `C7`)
	- Determine which work is not a merge commit (`C2`, `C3`, `C4`).
	- Determine which work has not been rewritten into the target branch (`C2`, `C3`):
		- `C4` has the same patch id as `C4'` , thereby implying that it has been rewritten.
	- Apply those commits on top of `teamone/master` branch ($\approx$ take and rewrite them).
- ![](Pasted%20image%2020241107143506.png)
- 
---
# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	1. Git Branching.
		1. More interesting rebases.
		2. The Perils of Rebasing.
		3. Rebase when you rebase.
1. https://git-scm.com/docs/git-branch for `git branch`
2. [Recording changes to repository](Recording%20changes%20to%20repository.md) for `git commit`.
3. https://git-scm.com/docs/git-log for `git log`
4. https://git-scm.com/docs/git-rebase for `git rebase`
5. [Fast-forward merging](Git%20branching%20and%20merging.md#Fast-forward%20merging)
6. [Three-way merging](Git%20branching%20and%20merging.md#Three-way%20merging)
7. [Git branching and merging](Git%20branching%20and%20merging.md)