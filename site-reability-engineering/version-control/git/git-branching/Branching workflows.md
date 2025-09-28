#git #github #version-control #project-management #cli #file-system #software-engineering #ide 
#site-realibility-engineering #project-management #software-architecture 

# Long-running branches
- In reality, a project is separated into three main branches to embrace source code stability.
- ![](Pasted%20image%2020241101112332.png)
## Main/master branch
- Only controls stable source code after having been released into production.
## Development 
- Split from master branch.
- Controls both stable source code and unstable source code (bugs, new features) which have not been released yet.
## Topic branch
- Split from development branch.
- <mark style="background: #e4e62d;">Short-lived</mark> branches.
- Controls new feature's source code, unstable source code, fixing bugs...

# Example
- ![](Pasted%20image%2020241101112522.png)
- Merge branch `iss91v2`  with branch `dumbidea`  $\implies$ three-way merging![](Pasted%20image%2020241101113545.png)

---
# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	- Git Branching.
		- Branch workflows.
		- Remote branches
1. https://git-scm.com/docs/git-branch for `git branch`
2. [Recording changes to repository](Recording%20changes%20to%20repository.md) for `git commit`.
3. https://git-scm.com/docs/git-log for `git log`
4. [Git branching and merging](Git%20branching%20and%20merging.md)
	- [Merging a branch - three-way merging - merge commit](Git%20branching%20and%20merging.md#Merging%20a%20branch%20-%20three-way%20merging%20-%20merge%20commit)