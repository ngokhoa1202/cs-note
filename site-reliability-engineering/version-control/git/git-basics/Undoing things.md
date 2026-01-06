#git #github #software-engineering #software-architecture #site-realibility-engineering  #file-system #project-management #version-control #shell #project-management 

- Always use [Checking repository status](site-reliability-engineering/version-control/git/git-basics/Recording%20changes%20to%20repository.md#Checking%20repository%20status) to check repository status before making commits.
# Amending commits
- <mark style="background: #e4e62d;">Redo a commit</mark> in case you have made a mistake with that commit.
- The mistaken commit <mark style="background: #e4e62d;">has not been pushed to the remote</mark> repository yet.
```bash
git commit -m "Mistaken commit"

git add <forgotten-file>

git commit --ammend
```
- The terminal will open a new prompt for you to fix the message for that commit before the commit takes its effect.
# Unstaging a staged file
- Unstage a file for the next commit $\equiv$ All of the file changes will be removed for the next commit.
- Use `git reset HEAD`
```bash
git reset HEAD <file>
```

# Git restore
## Unstaging a staged file
- Similarly to [Unstaging a staged file with Git reset](#Unstaging%20a%20staged%20file), use `git restore` to unstage a file change for the following commit.
```bash
git restore --staged <file>
```
- ![](Pasted%20image%2020241023093940.png)

## Revert a modified file
- <mark style="background: #e4e62d;">Discard all the changes</mark> made to the file $\equiv$ revert it to the last commit.
- Use `git restore`
```bash
git restore <file>
```
- ![](Pasted%20image%2020241023094247.png)
# Ignore committed files
- [Ignoring files](site-reliability-engineering/version-control/git/git-basics/Recording%20changes%20to%20repository.md#Ignoring%20files) for `.gitignore`
- Employs `git rm --cache`
```Bash title='Ignore committed file in Git'
git rm --cached <FILENAME>
```
***
# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	1. Git Basics.
		1. Undoing things.
2. [Viewing commit history](site-reliability-engineering/version-control/git/git-basics/Viewing%20commit%20history.md)
3. https://docs.github.com/en/get-started/git-basics/ignoring-files for ignoring files in Git.