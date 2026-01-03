#file-system  #ubuntu #linux #operating-system 
- Hard links and soft links are both used to utilize the memory space.
# Hard link
- Shares the same inode with the target file.
- If the target file is modified, the filesystem will <mark class="hltr-yellow">automatically create a new file inode</mark> for the hard link $\implies$ the hard link file is unchanged.
```Shell title='Create a hard link'
ln <source-path> <target-link>
```
- ![[assets/Pasted image 20260103114702.png]]
- The data referenced by hard links is only deleted when there is no hard link pointed to it.
- Only <mark class="hltr-yellow">files</mark>, not folders can be hard linked.
- Hard links can be only created to files on the <mark class="hltr-yellow">same filesystem</mark>.
- Ensure permissions
- ![[assets/Pasted image 20260103115212.png]]
# Soft link
- Points to the target file's path, not its inode.
- Has its own inode.
```Shell title='Create soft link syntax'
ln -s <source-path> <original-link>
```
- Soft links can be created to files spanning across file system.
- If the actual file is modified, the <mark class="hltr-yellow">soft link will broken</mark>too because it only tracks name and location, not file inode.
```Shell title='Check for soft link'
ls -l

readlink <file-path>
```
- ![[assets/Pasted image 20260103135228.png]]
***
# References
1. 