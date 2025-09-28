#git #github #software-engineering #software-architecture #site-realibility-engineering  #file-system #project-management #version-control 
#cli #project-management 

# File lifecycle
-  Each file in the working directory can be in one of two states: <mark style="background: #e4e62d;">tracked</mark> or <mark style="background: #e4e62d;">untracked</mark>.
	- Tracked files are files that were in the <mark style="background: #e4e62d;">last snapshot</mark> and known by GitHub.
	- Untracked files are files which were not in the last snapshot $\equiv$ are not in staging areas.
- ![](Pasted%20image%2020241021115632.png)
# Checking repository status
- Use `git status`.
```bash
git status
```

## Short status
- Shorten the `git status` logs.
```bash
git status -s
```

or 
```bash
git status --short
```
### Description
- `??`: files have not been tracked.
- `A`: file have been added to staging areas.
- `M` = modified
- `T` = file type changed (regular file, symbolic link or submodule)
- `D` = deleted.
- `R` = renamed
- `C` = copied (if config option status.renames is set to "copies")
- `U` = updated but unmerged.

# Tracking new files - Stage files
- Use `git add` .
```bash
git add <filename>
```
- Use `git add .` to track new files and <mark style="background: #e4e62d;">stage</mark> existed files.
```bash
git add .
```

- After running `git add`, we can run `git status` to check status of files again $\implies$ If we commit the files at this time, GitHub will track the last state of file when  running `git add`.
- ![](Pasted%20image%2020241021121606.png)
- All stage files will be a part of the <mark style="background: #e4e62d;">next commit</mark>. If you modify a file after running `git add`, you have to run `git add` again to stage it for the next commit.
# Ignoring files
- Ignored files are not tracked and committed to GitHub.
- Specified in `.gitignore`.
## Examples
```bash
# ignore all .a files 
*.a 

# but do track lib.a, even though you're ignoring .a files above 
!lib.a 

# only ignore the TODO file in the current directory, not subdir/TODO 
/TODO

# ignore all files in any directory named build 
build/ 

# ignore doc/notes.txt, but not doc/server/arch.txt 
doc/*.txt 

# ignore all .pdf files in the doc/ directory and any of its subdirectories 
doc/**/*.pdf
```

# Comparing staged and unstaged changes
- Use `git diff` to see what changes you have made to the staged files.
```bash
git diff <file>
```

- ![](Pasted%20image%2020241021141707.png)
# Committing your changes
- <mark style="background: #e4e62d;">Commit</mark> every file in the staging area $\equiv$<mark style="background: #e4e62d;"> Record a change</mark> in the repository.
- Use `git commit`
```bash
git commit
```

## Adding message
- Use `-m` flag or ` -message` flag.
```bash
git commit -m "Your message"

git commit --message="Your message"
```

## Skipping staging area
- Automatically stage files that have been modified and deleted, but new untracked files are not affected.
- Use `-a` or `--all` flag.
```bash
git commit -a

git commit --all
```

# Removing files
- Remove a file from the staging area as well as remove the file from the working directory.
```bash
git rm <file>
```

# Moving files
- Can be used to rename file.
```bash
git mv <src_file> <dest_file> 
```

- This is equivalent to
```bash
mv <src> <dest>
git rm <src>
git add <dest>
```



---
# References
1. Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	1. Git Basics.
2. https://git-scm.com/docs/git-status
3. https://git-scm.com/docs/git-commit