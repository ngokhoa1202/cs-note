#git #github #version-control #project-management #cli #file-system #software-engineering #ide 
#site-realibility-engineering #project-management #software-architecture 

# Basic branching
## Creating a new branch
- [Creating a new branch](Git%20branching%20architecture.md#Creating%20a%20new%20branch)
## Switching a specific branch
- [Switching branches](Git%20branching%20architecture.md#Switching%20branches)
- When switching from a branch to another branch, Git resets the current directory to the state of the <mark style="background: #e4e62d;">last commit</mark> on that branch.
## Deleting a branch
- Deleting a branch is <mark style="background: #e4e62d;">deleting a pointer variable</mark> which points to a specific commit.
- Deleting a branch which contains unmerged files induces error.
- Use `git branch -d`
```bash
# Delete locally
git branch -d <branch-name> # Simple form

git branch --delete <branch-name> # Verbose form
```
- Remotely delete branch [Branch management](Branch%20management.md)
# Basic merging
- Merging a branch is actually <mark style="background: #e4e62d;">changing the commit to which that branch refers</mark>.
## Fast-forward merging
- Git <mark style="background: #e4e62d;">simply moves the pointer forward</mark> in case a commit is merged with another commit that can be reached by following the first commit's history $\equiv$ the commit merged into is the <mark style="background: #e4e62d;">direct ancestor</mark> of the commit merged in.

> [!Important]
> The commit <mark style="background: #ADCCFFA6;">merged into</mark> is the commit which will be <mark style="background: #e4e62d;">kept</mark> after having been merged.
> Inversely, the commit <mark style="background: #ADCCFFA6;">merged in</mark> is the commit will be <mark style="background: #e4e62d;">deleted</mark> after  having been merged

- Move to predecessor commits by `git checkout`.
- Use `git merge` to merge the predecessor commit to a specific successor commit.
```bash
git checkout <parent-commit>

git merge <child-commit>
```
- ![](Pasted%20image%2020241026162900.png)
## Three-way merging
- Three-way merging occurs when the commit merged into is not the direct ancestor of the commit merged in.
- Use `git merge` similarly to [Merge a branch - fast forward merging](#Merge%20a%20branch%20-%20fast%20forward%20merging)
	- Git does a simple <mark style="background: #e4e62d;">three-way merge</mark>, using the two snapshots pointed to by the two branches `master` and `dev` and the<mark style="background: #e4e62d;"> common ancestor</mark> of the two.
- Git creates a new snapshot that results from this three-way merge and automatically creates a new <mark style="background: #e4e62d;">merge commit</mark> that points to it.
- If there is any conflict, Git pauses merging and forces developers to resolve the conflicts.
## Merge conflicts
- Merge conflicts occur when there are <mark style="background: #e4e62d;">unsynchronized files</mark> between the two merged commits.
- ![](Pasted%20image%2020241028145131.png)
- Git automatically adds <mark style="background: #e4e62d;">conflict-resolution markers</mark> to the current file on the branch merged into ![](Pasted%20image%2020241028145548.png)
### Manual conflict resolution
- Manually resolve conflicts on the merged file on the branch merged into.
- After having finished conflict resolution, run `git add` to stage that file, thereby marking the file as resolved in Git.
- Run `git merge` to merge branch and `git status` to check the merging.
- Run `git commit` to finalize the merging.
- ![](Pasted%20image%2020241028151641.png)
- ![](Pasted%20image%2020241028151719.png)
### Merge tool
- Run `git mergetool`.
- Supported by IDE.
# Example
## Example 1
- The initial `master` branch ![](Pasted%20image%2020241026151838.png)
- Create a new branch called `iss53` ![](Pasted%20image%2020241026151856.png)
- Make commits to newly created branch: ![](Pasted%20image%2020241026151951.png)
- Switch back to `master` branch, create a new branch called `hotfix`. Make commits to it: ![](Pasted%20image%2020241026152211.png)
- Switch to `master` branch, merge `hotfix` branch with `master` branch. This is a <mark style="background: #e4e62d;">fast-forward</mark> merge. Because the commit `C4` pointed by `hotfix` branch is simple a successor of `C2` pointed by `master` branch. 
- ![](Pasted%20image%2020241026160554.png)
- Now both the `master` branch and the `hotfix` branch point to commit `C4`. We are able to delete `hotfix` branch and return to `master` branch.
- Switch to `iss53` branch and make 2 commits to that branch, thereby make the Git branching <mark style="background: #e4e62d;">divergent</mark> ![](Pasted%20image%2020241026161740.png)

- Now if you want merge `master` branch with  `iss53` branch, then Git will perform 3-way merging. The three snapshots are `C2` , `C4` and `C5`  ![](Pasted%20image%2020241026162725.png)
- Merge commits can incur merge conflicts  ![](Pasted%20image%2020241026163647.png)

# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	- Git Branching.
		- Basic branching and merging.
2. [Recording changes to repository](Recording%20changes%20to%20repository.md) for `git commit`.
3. https://git-scm.com/docs/git-log for git.
4. [Hash-based Message Authentication Code](Hash-based%20Message%20Authentication%20Code.md) for Hash-based Message Authentication Code.
5. [Viewing commit history](Viewing%20commit%20history.md) for `git log` for git branching.
6. [Branch management](Branch%20management.md)