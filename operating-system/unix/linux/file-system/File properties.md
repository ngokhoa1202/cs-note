#cli #ubuntu #linux #operating-system #file-system #software-architecture #data-structure 

# Directory/File properties
- ![](Pasted%20image%2020240817153022.png)
## Type
- Specified by the first column.
- Symbol:
	- `d` $\to$ directory.
	- `l` $\to$ link to another file.
	- `c` $\to$ special file or device file.
	- `s` $\to$ socket.
	- `p` $\to$ named pipe.
	- `b` $\to$ block device.
## Link
- The number of hard links to the file.
- If the file is actually a directory, the link is the number of of its immediate subdirectories plus its parent plus itself.
## Ownership
### Owner
- The owner of the file.
### Group
- The group owns the file.
## Size
- The size of the file/directory.
## Timestamp
### Month
- The month when the file is created.

### Date
-  The date when the file is created.
### Time
-  The time when the file is created.

# Inode
- Stands for Index Node.
- Represented by a number and stores metadata of a file / directory:
	- File type.
	- File size.
	- Ownership.
	- Permission.
	- Timestamps:
		- ctime: created time.
		- mtime: modified time.
		- atime: accessed time.
	- Link count: The number of hard links pointing the inode.
	- Pointers to the data blocks: Store address to the blocks on the disk where the actual data is stored.
***
# References
1. 