#git #github #version-control #project-management #shell #file-system #software-engineering 
#site-realibility-engineering #project-management #software-architecture 

# Git branching
- When a `git commit` is created, Git calculates the <mark style="background: #e4e62d;">checksum</mark> of each subdirectory if any and stores them as a <mark style="background: #e4e62d;">tree object</mark> in the Git repository. 
- Then Git creates a <mark style="background: #e4e62d;">commit object</mark> that has the <mark style="background: #ADCCFFA6;">metadata</mark> and a <mark style="background: #ADCCFFA6;">pointer to the root</mark> project tree.
- This commit object also contains the author’s name and email address, the attached message, and <mark style="background: #e4e62d;">its parental commits</mark>:
	- No parents in case of the initial commit.
	- One parent for a normal commit.
	- Multiple parents for a commit that results from a merge of two or more branches.
- A branch is simply a <mark style="background: #e4e62d;">movable pointer to</mark> one of these <mark style="background: #e4e62d;">commits</mark>.
- Git keeps a special pointer called <mark style="background: #e4e62d;">HEAD pointer</mark> to detect what branch the version control system is tracking:
	- The commits are stored as a linked tree and new commits are <mark style="background: #e4e62d;">added to the head</mark> of that linked list.
	- $\implies$ <mark style="background: #ADCCFFA6;">Successor</mark> commit nodes references <mark style="background: #ADCCFFA6;">predecessor</mark> commit ones.
## Example
- Assume we've staged three files as followed:
```bash
$ git add README test.rb LICENSE
$ git commit -m 'Initial commit
```
- There are 5 objects created for this commit:
	- 3 blob objects (for 3 files).
	- 1 tree object.
	- 1 commit object pointing to the root tree.
- ![](Pasted%20image%2020241026133342.png)

- The following commits store a pointer to its predecessor commit.
- ![](Pasted%20image%2020241026135017.png)


- After typing `git branch testing` command, the git tree looks like: ![](Pasted%20image%2020241026141606.png)
- Type `git checkout testing` to switch to `testing` branch:  ![](Pasted%20image%2020241026141628.png)
- When making a new commit, `testing` branch moves up while `master` branch stays still: ![](Pasted%20image%2020241026142851.png)
- Move back to `master` branch again: ![](Pasted%20image%2020241026143140.png)
- Committing to `master` branch make the two branches diverge: ![](Pasted%20image%2020241026143906.png)
# Creating a new branch
- Use `git branch` command to create a new branch but do not switch to that new branch.
```bash
git branch <branch-name>

git branch testing
```
- HEAD pointers still points to main branch![](Pasted%20image%2020241026141340.png)
- 
# Switching branches
- Use `git checkout` to switch to a specific branch.
- HEAD pointers is now pointing to `test` branch ![](Pasted%20image%2020241026141447.png)
- Or use `git switch` command
```bash
git checkout <branch-name> # git checkout

git switch <branch-name> # git switch is still acceptable
```
## Creating a new branch and switch to it
- Use `git checkout -b`
```bash
git checkout -b <branch-name> 

# Equivalent to git branch and git switch/git checkout
```
- Or use `git switch -c` 
```bash
git switch --create <branch-name> # Verbose

git switch -c <branch-name> # Simple
```


# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	- Git Branching.
		- Branches in a Nutshell.
2. [Recording changes to repository](site-reliability-engineering/version-control/git/git-basics/Recording%20changes%20to%20repository.md) for `git commit`.
3. https://git-scm.com/docs/git-log for git.
4. [Hash-based Message Authentication Code](Hash-based%20Message%20Authentication%20Code.md) for Hash-based Message Authentication Code.
5. [Viewing commit history](site-reliability-engineering/version-control/git/git-basics/Viewing%20commit%20history.md) for `git log` for git branching.