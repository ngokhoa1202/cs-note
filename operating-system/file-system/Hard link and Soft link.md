#file-system  #ubuntu #linux #operating-system #cli 
# Hard link
- Shares the same inode with the target file.
- If the target file is modified, the filesystem will automatically create a new file inode for the hard link $\implies$ the hard link file is unchanged.

# Soft link
- Points to the target file's path not its inode $\equiv$ shallow copy.
- Has its own inode.
- Spans across file system and links directory.
- If the actual file is modified, the soft link will be changed too because it is just a reference.