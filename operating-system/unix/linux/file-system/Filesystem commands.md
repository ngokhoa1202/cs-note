#cli #ubuntu #operating-system #file-system

# Filesystem manual documentation
```bash
man <command>
```
or 
```bash
<command> --help
```
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
```bash
cd <path-to-directory>
```

# Print working directory
```bash
pwd
```

# See file/directory details
```bash
stat <file-or-directory>
```

# Creating a file/directory
## Create a file
- `touch` command.
```bash
touch <file-1> <file-2> <file-3> ... 
```

## Create a directory
- `mkdir` command.
```
mkdir <directory>
```


# Copy file/directory
- `cp` command.
```bash
cp <src-file> <dest-file>
```

## Copy directory
- `-r` or `-R` or `--recursive`: copy all of content inside the directory into the new one.

# Move file/directory
- `mv` command
```bash
mv <src-file> <dest-dir>
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
```bash
rm <file-1> <file-2>
```
## Remove a directory
```bash
rm -r <directory>
```

- `-r` flag: recursive remove all of its children.

# Create a link
- [Hard link and Soft link](operating-system/unix/linux/file-system/Hard%20link%20and%20Soft%20link.md)
- `ln` command
## Soft link
```bash
ln -s <file-to-be-linked>
```
- `-s` or `--symbolic` creates a soft link or symbolic link.
## Hard link
```bash
ln <file-to-be-linked>
```

# Search for string
- `grep`  command
```bash
grep <string> <filename>
```

