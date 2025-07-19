#operating-system #cli #ubuntu #linux #software-architecture #file-system 

# Filesystem architecture
- The parent directory is `/`
- ![600x800](Pasted%20image%2020240817144540.png)
## Boot loader
- The directory `/boot`
- Contains the file used by the boot loader `grub.cfg`
- ![](Pasted%20image%2020240817140717.png)
## System devices
- The directory `/dev`
- ![](Pasted%20image%2020240817140746.png)
- Contains information about terminal devices, usb, or any device attached to the system.
## Root directory
- The directory `/root`
- Every single file and directory starts from the root directory.
- Priviledged.
- Different from `/` directory.
## Configuration files
- The directory `/etc`
- Contains configuration files required by all programs: ==startup and shutdown shell scripts== used to start/stop individual programs.
- ![](Pasted%20image%2020240817141206.png)
## User binaries
- The `/bin` directory.
- Contains binary executables and shared linux commands. (e.g: ps, ping, ls, cp,...)
- ![](Pasted%20image%2020240817141705.png)
## System binaries
- The `sbin` directory.
- Contain binary executables and commands ==for system aministrator== and for system maintenance purpose (e.g: iptables, reboot, fdisk, ifconfig, swapon).
- ![](Pasted%20image%2020240817142100.png)
## Process
- The `/proc` directory.
- Virtual filesystem containing information about the running processes.
- ![](Pasted%20image%2020240817142509.png)
- 
## Variable files
- The `var` directory.
- Contains content of the files that are ==expected to grow==:
	- system log files (/var/log); 
	- packages and database files (/var/lib); emails (/var/mail); 
	- print queues (/var/spool); lock files (/var/lock); 
	- temp files needed across reboots (/var/tmp);
- ![](Pasted%20image%2020240817142708.png)
## Temporary files
- The `tmp` directory.
- Contains temporary files created by system or users and deleted when system is rebooted.
- ![](Pasted%20image%2020240817142829.png)
## User programs
- The `usr` directory.
- Contains binaries, libraries, documentation, and source-code for second level programs.
## User binaries
### User binary programs
- The directory `usr/bin`
### Super user binary programs
- The directory `usr/sbin`
### Installed from source
- The directory `usr/local`
- Contains user programs installed from sources.
## Home directory
- The directory `/home`
- The directory for all users' personal file.
- ![](Pasted%20image%2020240817144040.png)
## Optional add-on applications
- The directory `/opt`
- Contains add-on programs from vendors.
## Mount directory
- The directory `/mnt`
- Temporary mount directory where sysadmins can mount filesystems.
## Removable media devices
- The directory `/media`
- Temporary mount directory for removable devices. 
	- `/media/cdrom` for CD-ROM; 
	- `/media/floppy` for floppy drives; 
	- `/media/cdrecorder` for CD writer
## Service data
- The directory `srv`.
- Contains the service-related data.
