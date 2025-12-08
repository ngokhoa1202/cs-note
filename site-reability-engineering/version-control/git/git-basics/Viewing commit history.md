#git #github #software-engineering #software-architecture #site-realibility-engineering  #file-system #project-management #version-control #cli #project-management 

- Use `git log` command.
- By default, `git log` lists all the commits made in the repository in reverse chronological order.
- ![](Pasted%20image%2020241021145508.png)
# Viewing commit patches
- Shows the <mark style="background: #e4e62d;">patches</mark> introduced in each commit.
- Use `-p` or `--patch` flag.
- Limit the number of commit entries to be compared.
```bash
git log -p -2 # See patches of the last two commits

git log --patch -2
```

- ![](Pasted%20image%2020241021150233.png)
# View commit statistics
- Show each commit version statistics: how many lines were added or deleted.
- Use `--stat` flag.
```bash
git log --stat
```

# Viewing current branch
- Use `--decorate` flag.
```bash
git log --decorate
```
- ![](Pasted%20image%2020241026141135.png)
# Customizing logging format
- Use `--prety=<format>` format:
	- `oneline`
	- `full`
	- `fuller`
	- `short`
	- ...
	- or user-defined format using specifier.
- Specifier:
	- ![](Pasted%20image%2020241021151356.png)

```bash
git log --pretty=oneline <file>

git log --pretty=format:"%h - %an, %ar : %s" <file>
```

# Viewing logging graph
- Use `--graph`
```bash
git log --graph <file>
```
- View all branch graph
```bash
git log --graph --decorate --all
```
- ![](Pasted%20image%2020241026144237.png)
# Filter logging output
## Time predicate
- Use `--since=<time>.<unit>` flag `--until=<time>.<unit>` 
```bash
git log --since=2.weeks # Since the last 2 weeks

git log --unitil=3.day # Until the last 3 days
```

## Viewing the last commits
- Use `-<n>` flag to show only the last `n` commits.
```bash
git log --patch -3 # show patches for the last 3 commits
```

# Viewing commits that changes occurrence of a string
- Accepts a string and show only commits that changed the number of occurrences of that string.
```bash
git log -S <function-name / file-name/ ...>
```


# Examples
```bash
git log --pretty="%h - %s" --author='Junio C Hamano' --since="2008-10-01" \ 
  --before="2008-11-01" --no-merges -- t/

# Result
5610e3b - Fix testcase failure when extended attributes are in use 
acd3b9e - Enhance hold_lock_file_for_{update,append}() API 
f563754 - demonstrate breakage of detached checkout with symbolic link HEAD 
d1a43f2 - reset --hard/read-tree --reset -u: remove unmerged new paths 
51a94af - Fix "checkout --track -b newbranch" on detached HEAD 
b0ad11e - pull: allow "git pull origin $something:$current_branch" into an unborn branch
```
***
# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	1. Git Basics.
		1. Viewing commit history
2. https://git-scm.com/docs/git-log for git.
3. [Git branching architecture](Git%20branching%20architecture.md) for git branching.
