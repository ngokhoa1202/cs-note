#git #github #software-engineering #software-architecture #site-realibility-engineering  #file-system #project-management #version-control #cli #project-management 

- Tag specific points in a repository's history.
# Show repository tagging difference
- Only works with [Annotated tags](#Annotated%20tags)
- Use `git show`
```bash
git show <tag-name>
```
- ![](Pasted%20image%2020241023111328.png)
- ![](Pasted%20image%2020241023111407.png)
# Listing tags
- List all tags following a pattern in alphabetical order.
- Use `git tag`

```bash
git tag # Shortest form

git tag -l # Optional

git tag --list # Verbose form

git tag -l <pattern> # List tags following a regular expression

git tag -l "1.1.*" # List all tags using wildcard patterns
```

```bash
$ git tag -l "v1.8.5*" 

v1.8.5 
v1.8.5-rc0 
v1.8.5-rc1 
v1.8.5-rc2 
v1.8.5-rc3
v1.8.5.1 
v1.8.5.2 
v1.8.5.3 
v1.8.5.4 
v1.8.5.5
```

- ![](Pasted%20image%2020241023105835.png)
- ![](Pasted%20image%2020241023105858.png)

# Creating tags
- There are two tags in Git:
## Annotated tags
- Annotated tags are <mark style="background: #e4e62d;">full objects</mark> in the Git database:
	- Checksummed.
	- Contains tagger name, email and date.
	- Contains tagging message.
	- Possibly signed and verified with GPG.
- Recommended.
- Use `git tag -a`
```bash
git tag -a <tag> -m <message> # Simple form

git tag --annotate <tag> --message="Message" # Verbose form

git tag -a v1.4 -m "Fix n+1 query problem for department"
```

## Lightweight tags
- Temporary tags:
	- Only stores commit checksum.
- Use `git tag` without `-a` or `-m`
```bash
git tag <tag-name>
```

# Adding tags to a specific commit
- Use `git log` in [Viewing commit history](Viewing%20commit%20history.md) to known the commit hash.
- Use `git tag -a` to add a tag to that commit.
```bash
git tag -a <tag-name> -m "Message" <commit-hash>
```

- ![](Pasted%20image%2020241023115335.png)
# Pushing/Sharing tags
- By default, `git push` doesn't upload the tags to remote servers.
- Explicitly push tags to remote repository using `git push`
## Pushing a specific tag
- Specific tag name in `git push` command
```bash
git push <local-name-of-repo> <tagname>
```

```bash
git push origin v1.5 
Counting objects: 14, done. 
Delta compression using up to 8 threads. 
Compressing objects: 100% (12/12), done.
Writing objects: 100% (14/14), 2.05 KiB | 0 bytes/s, done. 
Total 14 (delta 3), reused 0 (delta 0)
```

## Pushing all tags
- Use `--tags` option in `git push` command.
```bash
git push <local-name-of-repo> --tags
```

```bash
git push origin --tags 
Counting objects: 1, done. 
Writing objects: 100% (1/1), 160 bytes | 0 bytes/s, done. 
Total 1 (delta 0), reused 0 (delta 0) 
To git@github.com:schacon/simplegit.git 
  * [new tag] v1.4 -> v1.4 
  * [new tag] v1.4-lw -> v1.4-lw
```

## Push only annotated tags
- Only annotated tags will be pushed to the remote repository.
- Use `--follow-tags` option in `git push` command.
# Deleting tags
## Delete a specific tag on local
- Does not work with tags on remote repository.
- Use `-d` in `git tag` command.
```bash
git tag -d <tag-name> # Simple form

git tag --delete <tag-name> # Verbose form
```
- ![](Pasted%20image%2020241023120448.png)
## Delete a specific tag on remote server
- There are two ways to achieve this target.
## Read tag as null value
-<mark style="background: #e4e62d;"> Read the tag as null value</mark> when it is pushed to the remote server by using colon `:` in `git push :/refs`
```bash
git push <local-name-of-repo> :refs/tags/<tag-name>
```

```bash
$ git push origin :refs/tags/v1.4-lw 
To /git@github.com:schacon/simplegit.git 
  - [deleted]      v1.4-lw
```

## Delete option
- Use `-d` option when pushing the tag to remote server.
```bash
git push <local-name-of-repo> -d <tagname> # Simple form

git push <local-name-of-repo> --delete <tagname> # Verbose form
```

# Checking out tags

# References
1. . Pro Git - Scott Chacon, Ben Straut - version 2.1.434
	1. Git Basics.
		1. Tagging.
