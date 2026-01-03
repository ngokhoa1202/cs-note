#cli #ubuntu #operating-system #file-system
# File name
- [Wildcard character](operating-system/unix/linux/file-system/Wildcard%20character.md) 
# Listing files
- List all files inside a directory.
```bash
ls
```
## Long listing
- `-l` flag: List file size, permission, modified time...
## List all files
- `-a` or `--all` flag: List all files including ignored ones.
## Sort files by time
- `-t` flag: Sort listed files by time: newest first.
## Reverse sorting
- `-r` or `--reverse` flag: Reverse order when sorting.
## List inode
- `-i` or `--inode` flag: print the index number of the file.
# Change directory
```Shell title='Change directory'
cd <path-to-directory>
```
# Print working directory
```Shell title='Print current working directory'
pwd
```
# See file/directory details
```Shell title='See file details'
stat <file-or-directory>
```
# Creating a file/directory
## Create a file
- `touch` command.
```Shell title='Create multiple files'
touch <file-1> <file-2> <file-3> ... 
```
## Create a directory
- `mkdir` command.
```Shell title='Create a directory'
mkdir <directory>
```
- Use `-p` or `--parent` to create parent directories if necessary.
```Shell title='Create directory including parent directories if necessary'
mkdir <parent-1>/<parent-2>/.../<dir>
```
# Copy file/directory
- `cp` command.
```Shell title='Copy from source file to destination file'
cp <src-file> <dest-file>
```
- Use `-r` or `--recursive` to copy a directory.
```Shell title='Copy a directory'
cp -r <src-directory> <dest-directory>
```
- Use `-d` or `--no-dereference --preserve=links` to preserve the soft links as links, not copying the entire file they point to.
```Shell title='Copy and preseve soft links'
cp -d <src> <dst>
```
- Use `-p` or `--preserve=mode,ownership,timestamps` to keep the original file details.
```Shell title='Copy and preserve file details'
cp -p <src> <dst>
```
- Use `-a` or `--archive` which includes the three flag `-r`, `-d` and `-p` to archive the file for backup.
```Shell title='Copy and archive the file'
cp -a <src> <dst>
```
## Copy directory
- `-r` or `-R` or `--recursive`: copy all of content inside the directory into the new one.
# Move file/directory
- `mv` command
```Shell title='Move files'
mv <src-file> <dest-dir>
```
- Use `-f` or `--force` to disable any pop-up prompts.
```Shell title='Disable promps when moving file'
mv -f <src> <dst>
```
- Use `-v` or `--verbose` for verbose logging.
```Shell title='Verbose logging when moving file'
mv -v <src> <dst>
```
# Search a file/directory
## find command
- Iterates the filesystem to search for the file so it is slower compared to `locate` command.
```bash
find <directory> <file>
```

### Find by name
- `-name` flag: Find specified name as substring.
```bash
find <dir> -name "file"
```

## locate command
- Employs a pre-built database so it is faster than `find` command, but that database could be obselete $\implies$ update the database.
### Find by whole name
- `-w` or `--wholename` flag: Find the exact whole name.
### Find by base name
- `-b` or `--basename` flag: Find the base name as substring.
### Update the filesystem database
```bash
updatedb
```

# Remove a file/directory
- `rm` command
```Shell title='Remove file'
rm <file-1> <file-2>
```
- Use `-r` or `--recursive` for remove directories.
```Shell title='Remove directories'
rm -r <dir-1> <dir-2>
```
- Use `-f` or `--force` to ignore non-existent files or directories and disable any prompts.
```Shell title='Forcefully remove files'
rm -f <file-1> <file-2> 
```
## Remove a directory
```bash
rm -r <directory>
```
- `-r` flag: recursive remove all of its children.
# Search for string
- `grep`  command
```Shell
grep <string> <filename>
```
***
# References
1. 
