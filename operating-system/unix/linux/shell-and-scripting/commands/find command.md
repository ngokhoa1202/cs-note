#linux #unix #shell  #file-search #bash #file-system #windows #wsl #fedora #ubuntu #centos-stream #rhel 

- `find` searches for files and directories in a directory hierarchy.
- <mark class="hltr-yellow">Recursively traverses directories and evaluates expressions to locate files</mark>.
- Can execute actions on found files (delete, move, execute commands).
# Basic Syntax

```Shell title='Find command syntax'
find [path...] [expression]
```
## Components
- **path**: Starting directory for search (default: current directory `.`)
- **expression**: Search criteria and actions
	- **Options**: Affect overall operation
	- **Tests**: Evaluate file properties (return true/false)
	- **Actions**: Perform operations on matched files
	- **Operators**: Combine expressions (AND, OR, NOT)
# Search by Name
## Exact Name Match
```Shell title='Find files by exact name'
# Find file named "config.json"
find /home/user -name "config.json"

# Find in current directory
find . -name "README.md"

# Case-insensitive search
find /var/log -iname "error.log"
```
## Pattern Matching (Wildcards)
```Shell title='Find files with patterns'
# Find all .txt files
find /documents -name "*.txt"

# Find all files starting with "test"
find . -name "test*"

# Find all .conf or .cfg files
find /etc -name "*.conf" -o -name "*.cfg"

# Case-insensitive pattern
find . -iname "*.PDF"
```
## Practical Use Case: Find Configuration Files
```Shell title='Locate all configuration files in /etc'
# Find all .conf files
find /etc -type f -name "*.conf"

# Find nginx-related configs
find /etc -type f -name "*nginx*.conf"

# Output:
# /etc/nginx/nginx.conf
# /etc/nginx/sites-available/default.conf
```
# Search by Type
```Shell title='Find by file type'
# Find regular files
find /home -type f

# Find directories
find /home -type d

# Find symbolic links
find /usr/bin -type l

# Find block devices
find /dev -type b

# Find character devices
find /dev -type c

# Find named pipes (FIFOs)
find /tmp -type p

# Find sockets
find /var/run -type s
```
## File Type Flags
| Flag | Type |
|------|------|
| `f` | Regular file |
| `d` | Directory |
| `l` | Symbolic link |
| `b` | Block device |
| `c` | Character device |
| `p` | Named pipe (FIFO) |
| `s` | Socket |
## Practical Use Case: Clean Up Broken Symlinks
```Shell title='Find and remove broken symbolic links'
# Find broken symlinks
find /usr/local/bin -type l ! -exec test -e {} \; -print

# Remove broken symlinks
find /usr/local/bin -type l ! -exec test -e {} \; -delete
```
# Search by Size
```Shell title='Find files by size'
# Files larger than 100MB
find /var -type f -size +100M

# Files smaller than 1KB
find /tmp -type f -size -1k

# Files exactly 512 bytes
find . -type f -size 512c

# Files between 10MB and 50MB
find /home -type f -size +10M -size -50M

# Empty files (0 bytes)
find /var/log -type f -size 0
```

## Size Units
| Unit | Meaning |
|------|---------|
| `c` | Bytes |
| `k` | Kilobytes (1024 bytes) |
| `M` | Megabytes (1024 KB) |
| `G` | Gigabytes (1024 MB) |
| `b` | 512-byte blocks |
## Practical Use Case: Find Large Files
```Shell title='Identify files consuming disk space'
# Find top 10 largest files in /var
find /var -type f -size +100M -exec ls -lh {} \; | sort -k5 -hr | head -10

# Find large log files
find /var/log -type f -size +50M -name "*.log"

# Output example:
# /var/log/syslog.1 (250M)
# /var/log/apache2/access.log (120M)
```
# Search by Time
## Modification Time (`mtime`)
= `mtime` is the time that the file content is changed.
```Shell title='Find by modification time'
# Modified in last 7 days
find /home/user -type f -mtime -7

# Modified exactly 7 days ago
find /home/user -type f -mtime 7

# Modified more than 30 days ago
find /var/log -type f -mtime +30

# Modified in last 24 hours
find . -type f -mtime 0
```
## Access Time (`atime`)
```Shell title='Find by access time'
# Accessed in last 7 days
find /var/www -type f -atime -7

# Not accessed in 90 days
find /home -type f -atime +90
```
## Change Time (`ctime`)
- `ctime` is the time that the file metadata is changed.
```Shell title='Find by metadata change time'
# Metadata changed in last 2 days
find /etc -type f -ctime -2

# Status changed more than 30 days ago
find . -type f -ctime +30
```
## Time in Minutes
```Shell title='Find by time in minutes'
# Modified in last 60 minutes
find /tmp -type f -mmin -60

# Modified more than 2 hours ago
find /var/log -type f -mmin +120

# Accessed in last 30 minutes
find /var/www -type f -amin -30
```
## Practical Use Case: Clean Old Files
```Shell title='Remove old temporary files'
# Find and list files older than 7 days
find /tmp -type f -mtime +7

# Delete files not accessed in 30 days
find /tmp -type f -atime +30 -delete

# Archive logs older than 90 days
find /var/log -type f -name "*.log" -mtime +90 -exec gzip {} \;
```
# Search by Permissions
```Shell title='Find by permissions'
# Find files with exact permissions 644
find /home -type f -perm 644

# Find files with at least these permissions (any of these bits set)
find /usr/bin -type f -perm -755

# Find world-writable files (security risk)
find /var/www -type f -perm -002

# Find files or directory that other cannot either read or write
find /var/log ! -perm /o=rw

# Find files that the group can at least read and other cannot read or write
find . -type f -perm -g=r ! -perm /o=rw

# Find files that group can read and others cannot read or write (parentheses are needed)
find . -type f \( -perm -g=r -o ! -perm /o=rw \)

# Find SUID files
find / -type f -perm -4000

# Find SGID files
find / -type f -perm -2000

# Find files with sticky bit
find /tmp -type d -perm -1000
```
## Practical Use Case: Security Audit
```Shell title='Find security vulnerabilities'
# Find world-writable files (security risk)
find /var/www -type f -perm -002 ! -path "*/tmp/*"

# Find SUID root executables
find / -type f -perm -4000 -user root -ls 2>/dev/null

# Find files with no owner
find / -nouser -o -nogroup 2>/dev/null

# Output:
# -rwsr-xr-x root root /usr/bin/passwd
# -rwsr-xr-x root root /usr/bin/sudo
```
# Search by Owner
```Shell title='Find by ownership'
# Find files owned by user
find /home -user alice

# Find files owned by group
find /var/www -group www-data

# Find files with specific UID
find / -uid 1000

# Find files with specific GID
find / -gid 1000

# Find files owned by user OR group
find /home -user alice -o -group developers

# Find files NOT owned by user
find /tmp ! -user alice
```
## Practical Use Case: Fix Ownership
```Shell title='Fix file ownership after migration'
# Find files owned by old user
find /var/www -user olduser

# Change ownership to new user
find /var/www -user olduser -exec chown newuser:www-data {} \;

# Verify changes
find /var/www -user newuser | wc -l
```
# Actions on Found Files
## Print Actions
```Shell title='Display found files'
# Print file path (default)
find /home -name "*.txt"

# Print with details (like ls -l)
find /var/log -name "*.log" -ls

# Print with custom format
find . -type f -printf "%p - %s bytes\n"

# Print only filename
find /usr/bin -type f -printf "%f\n"
```
## Execute Commands
```Shell title='Execute commands on found files'
# Execute single command per file
find /var/log -name "*.log" -exec gzip {} \;

# Execute command with multiple files at once (more efficient)
find /var/log -name "*.log" -exec gzip {} +

# Interactive confirmation before execution
find /tmp -name "*.tmp" -ok rm {} \;

# Execute multiple commands
find . -name "*.txt" -exec echo "Processing {}" \; -exec wc -l {} \;
```
## Delete Files
```Shell title='Delete found files'
# Delete matched files
find /tmp -name "*.tmp" -delete

# Delete empty files
find /var/log -type f -size 0 -delete

# Delete empty directories
find /home/user -type d -empty -delete

# Delete with confirmation
find /tmp -name "*.old" -ok rm {} \;
```
## Practical Use Case: Batch File Processing
```Shell title='Process multiple files efficiently'
# Convert all .txt to .md
find . -name "*.txt" -exec bash -c 'mv "$0" "${0%.txt}.md"' {} \;

# Add execute permission to all .sh files
find . -name "*.sh" -exec chmod +x {} \;

# Count lines in all Python files
find . -name "*.py" -exec wc -l {} + | tail -1

# Compress all log files older than 7 days
find /var/log -name "*.log" -mtime +7 -exec gzip {} \;
```
# Combining Expressions
## Logical Operators
```Shell title='Combine search criteria'
# AND operator (default, both conditions must be true)
find /home -type f -name "*.txt" -size +1M

# OR operator (-o)
find /home -name "*.txt" -o -name "*.md"

# NOT operator (!)
find /home -type f ! -name "*.log"

# Grouping with parentheses
find /home \( -name "*.txt" -o -name "*.md" \) -size +1M

# Complex expression
find /var/log \( -name "*.log" -o -name "*.txt" \) ! -name "system.*" -mtime -7
```
## Practical Use Case: Complex Search
```Shell title='Find files matching multiple criteria'
# Find large old log files for cleanup
find /var/log -type f \
  -name "*.log" \
  -size +50M \
  -mtime +30 \
  -ls

# Find source code files excluding node_modules
find . \( -name "*.js" -o -name "*.ts" \) \
  ! -path "*/node_modules/*" \
  ! -path "*/dist/*"

# Find recent modified config files with specific permissions
find /etc -type f \
  -name "*.conf" \
  -mtime -7 \
  -perm -644 \
  -exec ls -lh {} \;
```
# Advanced Use Cases
## Use Case 1: Backup Modified Files
```Shell title='Backup recently modified files'
# Find files modified in last 24 hours and copy to backup
find /var/www/html -type f -mtime 0 -exec cp --parents {} /backup/ \;

# Create tarball of modified files
find /var/www -type f -mtime -7 | tar -czf backup-$(date +%Y%m%d).tar.gz -T -
```
## Use Case 2: Clean Build Artifacts
```Shell title='Remove build and cache files'
# Remove all __pycache__ directories
find . -type d -name "__pycache__" -exec rm -rf {} +

# Clean node_modules
find . -type d -name "node_modules" -prune -exec rm -rf {} +

# Remove compiled files
find . -type f \( -name "*.pyc" -o -name "*.o" -o -name "*.class" \) -delete
```
## Use Case 3: Find Duplicate Filenames
```Shell title='Identify duplicate filenames'
# Find files with same name in different directories
find /home -type f -printf "%f\n" | sort | uniq -d

# Find duplicate files by content (using md5sum)
find /home -type f -exec md5sum {} + | sort | uniq -w32 -d
```
## Use Case 4: Mass Rename Files
```Shell title='Rename files in batch'
# Lowercase all filenames
find . -type f -name "*.TXT" -exec bash -c 'mv "$0" "${0%.TXT}.txt"' {} \;

# Add prefix to all files
find . -type f -name "*.log" -exec bash -c 'mv "$0" "backup-$(basename $0)"' {} \;

# Replace spaces with underscores
find . -type f -name "* *" -exec bash -c 'mv "$0" "${0// /_}"' {} \;
```

## Use Case 5: Find Files by Content
```Shell title='Search file contents with find and grep'
# Find Java files containing "TODO"
find . -name "*.java" -exec grep -l "TODO" {} \;

# Find and count occurrences
find . -name "*.py" -exec grep -c "import" {} \; | awk -F: '{sum+=$2} END {print sum}'

# Find files with specific text and show context
find /var/log -name "*.log" -exec grep -H "ERROR" {} \;
```

## Use Case 6: Directory Size Report
```Shell title='Calculate directory sizes'
# Find largest directories
find /home -type d -exec du -sh {} \; | sort -hr | head -10

# Find directories larger than 1GB
find /var -type d -exec du -sm {} \; | awk '$1 > 1024' | sort -nr
```

## Use Case 7: File Synchronization
```Shell title='Sync files between directories'
# Find new files and copy to destination
find /source -type f -mtime -1 -exec cp {} /destination/ \;

# Find and sync with rsync
find /source -type f -mtime -1 -print0 | rsync -av --files-from=- --from0 /source /destination
```
# Performance Optimization
## Limit Search Depth
```Shell title='Control search depth'
# Search only current directory (no recursion)
find . -maxdepth 1 -name "*.txt"

# Search up to 2 levels deep
find /var -maxdepth 2 -type d

# Search at least 3 levels deep
find /home -mindepth 3 -name "*.log"
```
## Prune Directories
```Shell title='Exclude directories from search'
# Skip .git directories
find . -name ".git" -prune -o -name "*.js" -print

# Skip multiple directories
find /var -path "*/node_modules" -prune -o -path "*/.git" -prune -o -type f -print

# Exclude hidden directories
find . -name ".*" -type d -prune -o -name "*.txt" -print
```
## Optimize Execution
```Shell title='Efficient command execution'
# Bad: One process per file
find . -name "*.txt" -exec cat {} \;

# Good: Batch multiple files
find . -name "*.txt" -exec cat {} +

# Better: Use xargs for large file lists
find . -name "*.txt" -print0 | xargs -0 cat
```
# Common Pitfalls and Solutions
## Problem: Permission Denied Errors
```Shell title='Handle permission errors'
# Suppress error messages
find / -name "config.txt" 2>/dev/null

# Redirect errors to file for review
find / -name "*.conf" 2>find-errors.log

# Search only accessible directories
find /home -readable -name "*.txt"
```
## Problem: Filenames with Spaces
```Shell title='Handle filenames with spaces'
# Use -print0 and xargs -0
find . -name "*.txt" -print0 | xargs -0 ls -l

# Use -exec with proper quoting
find . -name "*.txt" -exec grep "pattern" {} \;

# Use while loop
find . -name "*.txt" -print0 | while IFS= read -r -d '' file; do
    echo "Processing: $file"
done
```
## Problem: Case Sensitivity
```Shell title='Case-insensitive searches'
# Case-insensitive name search
find . -iname "*.PDF"

# Case-insensitive with regex
find . -iregex ".*\.\(jpg\|jpeg\|png\)$"
```
# Find with Regular Expressions
```Shell title='Use regex patterns'
# Basic regex (emacs style)
find . -regex ".*\.txt$"

# Extended regex (modern)
find . -regextype posix-extended -regex ".*/[0-9]{4}-[0-9]{2}-[0-9]{2}\.log$"

# Case-insensitive regex
find . -iregex ".*\.\(jpg\|png\|gif\)$"

# Find files with numbers in name
find . -regextype posix-extended -regex ".*[0-9]+.*"
```
# Integration with Other Commands
## Find + Grep
```Shell title='Combine find and grep'
# Find files containing pattern
find . -name "*.log" -exec grep -l "ERROR" {} \;

# Count occurrences across files
find . -name "*.py" -exec grep -c "import" {} \;

# Complex search with context
find /var/log -name "*.log" -exec grep -H -A 2 -B 2 "ERROR" {} \;
```
## Find + Xargs
```Shell title='Pipe to xargs for efficiency'
# Process multiple files efficiently
find . -name "*.txt" | xargs grep "pattern"

# Handle special characters
find . -name "*.txt" -print0 | xargs -0 grep "pattern"

# Parallel execution
find . -name "*.jpg" -print0 | xargs -0 -P 4 convert -resize 50%
```
## Find + Tar
```Shell title='Create archives'
# Archive found files
find /var/log -name "*.log" -mtime +30 | tar -czf old-logs.tar.gz -T -

# Backup with exclusions
find /home/user -type f ! -path "*/node_modules/*" | tar -czf backup.tar.gz -T -
```
# Common Options

| Option      | Description             | Example                                            |
| ----------- | ----------------------- | -------------------------------------------------- |
| `-name`     | Match filename pattern  | `find . -name "*.txt"`                             |
| `-iname`    | Case-insensitive name   | `find . -iname "*.PDF"`                            |
| `-type`     | Match file type         | `find . -type d`                                   |
| `-size`     | Match file size         | `find . -size +100M`                               |
| `-mtime`    | Modified time (days)    | `find . -mtime -7`                                 |
| `-mmin`     | Modified time (minutes) | `find . -mmin -60`                                 |
| `-user`     | Match owner             | `find . -user alice`                               |
| `-perm`     | Match permissions       | `find . -perm 644`                                 |
| `-exec`     | Execute command         | `find . -exec ls {} \;`                            |
| `-delete`   | Delete matched files    | `find . -name "*.tmp" -delete`                     |
| `-maxdepth` | Limit search depth      | `find . -maxdepth 2`                               |
| `-prune`    | Exclude directory       | `find . -name ".git" -prune`                       |
| `-a`        | And operator            | `find . -type f ! -perm -o=r -a ! -perm -o=w`      |
| `!`         | Not operator            | `find . -type f ! -perm -o=r -a ! -perm -o=w`      |
| `-o`        | Or operator             | `find . -type f \( -perm -g=r -o ! -perm /o=rw \)` |

***
# References
1. GNU Findutils Documentation - https://www.gnu.org/software/findutils/
2. `man find` - Linux manual page
3. The Linux Command Line - William Shotts - 2nd Edition - 2019 - No Starch Press
	1. Chapter 17: Searching for Files
4. Unix and Linux System Administration Handbook - Evi Nemeth - 5th Edition - 2017 - Addison-Wesley
	1. Chapter 8: Storage
5. https://www.gnu.org/software/findutils/manual/html_mono/find.html
