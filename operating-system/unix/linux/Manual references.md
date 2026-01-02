#linux #unix #ubuntu #debian #fedora #centos-stream #rhel #operating-system 
# `man` page
- Use `man <command>` to read the  manual instructions of a specific commands.
```Shell title='Man command'
man man
man php
```
# `apropos`
- Use `apropos <keyword>` to find out the command, configuration file  or logging file for any keyword.
```Shell title='apropos command'
apropos apache
```
- ![[Pasted image 20260102070659.png]]
# `mandb`
- Both `man` and `apropos` searches from the `mandb` for manual documentation.
- Update the `mandb` to update the latest documentation.
```Shell title='Update mandb'
sudo mandb
```
***
# References
1. 