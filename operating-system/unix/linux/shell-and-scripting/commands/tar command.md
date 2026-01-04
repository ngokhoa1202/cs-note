#linux #unix #shell  #archive #compression #backup #bash

- `tar` (Tape ARchive) creates, extracts, and manipulates archive files.
- <mark class="hltr-yellow">Bundles multiple files and directories into single archive file</mark>.
- Can compress archives using gzip, bzip2, or xz compression.

# Basic Syntax

```Shell title='tar command syntax'
tar [options] [archive-file] [files/directories]
```

## Main Operations
- **`-c`** - Create archive
- **`-x`** - Extract archive
- **`-t`** - List archive contents
- **`-r`** - Append files to archive
- **`-u`** - Update archive with newer files

## Common Options
- **`-f`** - Specify archive filename (required)
- **`-v`** - Verbose (show files being processed)
- **`-z`** - Compress with gzip (.tar.gz)
- **`-j`** - Compress with bzip2 (.tar.bz2)
- **`-J`** - Compress with xz (.tar.xz)
- **`-C`** - Change to directory before operation

# Creating Archives

## Create Simple Archive
```Shell title='Create uncompressed archive'
# Create archive of directory
tar -cf archive.tar /path/to/directory

# Create archive of multiple files
tar -cf documents.tar file1.txt file2.pdf file3.doc

# Create archive with verbose output
tar -cvf backup.tar /home/user/documents

# Output:
# /home/user/documents/
# /home/user/documents/file1.txt
# /home/user/documents/file2.pdf
```

## Create Compressed Archives
```Shell title='Create compressed archives'
# Create gzip compressed archive (.tar.gz or .tgz)
tar -czf archive.tar.gz /path/to/directory

# Create bzip2 compressed archive (.tar.bz2)
tar -cjf archive.tar.bz2 /path/to/directory

# Create xz compressed archive (.tar.xz)
tar -cJf archive.tar.xz /path/to/directory

# Verbose compressed archive
tar -czvf backup.tar.gz /home/user/documents
```

## Practical Use Case: Website Backup
```Shell title='Backup website files'
# Create compressed backup with timestamp
tar -czf website-backup-$(date +%Y%m%d).tar.gz /var/www/html

# Backup with verbose output
tar -czvf website-backup.tar.gz \
  /var/www/html \
  /etc/nginx/sites-available \
  /etc/nginx/nginx.conf

# Output example:
# website-backup-20240115.tar.gz created
# Total size: 250MB compressed to 85MB
```

# Extracting Archives

## Extract Complete Archive
```Shell title='Extract entire archive'
# Extract uncompressed archive
tar -xf archive.tar

# Extract gzip compressed archive
tar -xzf archive.tar.gz

# Extract with verbose output
tar -xzvf archive.tar.gz

# Extract bzip2 archive
tar -xjf archive.tar.bz2

# Extract xz archive
tar -xJf archive.tar.xz
```

## Extract to Specific Directory
```Shell title='Extract to custom location'
# Extract to /tmp directory
tar -xzf archive.tar.gz -C /tmp

# Extract to current directory
tar -xzf archive.tar.gz -C .

# Create and extract to new directory
mkdir restored && tar -xzf backup.tar.gz -C restored

# Verbose extraction to specific location
tar -xzvf backup.tar.gz -C /opt/restore/
```

## Extract Specific Files
```Shell title='Extract selected files only'
# Extract single file
tar -xzf archive.tar.gz path/to/file.txt

# Extract multiple specific files
tar -xzf archive.tar.gz file1.txt file2.txt

# Extract files matching pattern
tar -xzf archive.tar.gz --wildcards '*.conf'

# Extract directory
tar -xzf archive.tar.gz path/to/directory/
```

## Practical Use Case: Restore Backup
```Shell title='Restore from backup'
# Extract backup to original location
tar -xzf website-backup.tar.gz -C /

# Preview before extracting
tar -tzf website-backup.tar.gz | head -20

# Extract specific configuration
tar -xzf backup.tar.gz etc/nginx/nginx.conf

# Restore with ownership preserved
sudo tar -xzvf backup.tar.gz -C / --preserve-permissions
```

# Listing Archive Contents

## List All Files
```Shell title='View archive contents'
# List files in archive
tar -tf archive.tar

# List compressed archive
tar -tzf archive.tar.gz

# List with detailed information
tar -tvf archive.tar

# List bzip2 archive
tar -tjf archive.tar.bz2
```

## Detailed Listing
```Shell title='Detailed file information'
# Long format listing (like ls -l)
tar -tvzf archive.tar.gz

# Output example:
# drwxr-xr-x user/group  0 2024-01-15 10:30 documents/
# -rw-r--r-- user/group  1024 2024-01-15 10:30 documents/file1.txt
# -rw-r--r-- user/group  2048 2024-01-15 10:30 documents/file2.pdf

# List with human-readable sizes
tar -tvzf archive.tar.gz | awk '{print $3, $6}'
```

## Search Archive Contents
```Shell title='Find files in archive'
# Search for specific file
tar -tzf archive.tar.gz | grep "config.json"

# Count files in archive
tar -tzf archive.tar.gz | wc -l

# List only .txt files
tar -tzf archive.tar.gz | grep "\.txt$"

# Show directory structure
tar -tzf archive.tar.gz | grep "/$"
```

# Compression Comparison

## Compression Levels
```Shell title='Adjust compression level'
# Gzip with compression level (1=fast, 9=best)
tar -czf archive.tar.gz --use-compress-program="gzip -9" directory/

# Fast compression (less CPU, larger file)
tar -czf archive.tar.gz --use-compress-program="gzip -1" directory/

# Bzip2 with best compression
tar -cjf archive.tar.bz2 --use-compress-program="bzip2 -9" directory/

# XZ with maximum compression
tar -cJf archive.tar.xz --use-compress-program="xz -9" directory/
```

## Compression Type Comparison
```Shell title='Compare different compression methods'
# Original directory size: 1GB

# No compression (fastest, largest)
tar -cf archive.tar directory/
# Result: 1GB, Time: 10s

# Gzip compression (balanced)
tar -czf archive.tar.gz directory/
# Result: 250MB, Time: 30s

# Bzip2 compression (better ratio, slower)
tar -cjf archive.tar.bz2 directory/
# Result: 200MB, Time: 60s

# XZ compression (best ratio, slowest)
tar -cJf archive.tar.xz directory/
# Result: 180MB, Time: 120s
```

| Compression | Extension | Speed | Ratio | Best For |
|-------------|-----------|-------|-------|----------|
| None | .tar | Fastest | 0% | Temporary, local backups |
| gzip (-z) | .tar.gz | Fast | 60-70% | General purpose, web |
| bzip2 (-j) | .tar.bz2 | Medium | 70-75% | Better compression needed |
| xz (-J) | .tar.xz | Slow | 75-80% | Maximum compression |

# Advanced Operations

## Exclude Files and Directories
```Shell title='Exclude patterns when creating archive'
# Exclude specific directory
tar -czf backup.tar.gz --exclude='node_modules' /project

# Exclude multiple patterns
tar -czf backup.tar.gz \
  --exclude='*.log' \
  --exclude='*.tmp' \
  --exclude='.git' \
  /project

# Exclude from file
echo "node_modules" > exclude.txt
echo ".git" >> exclude.txt
tar -czf backup.tar.gz --exclude-from=exclude.txt /project

# Exclude hidden files
tar -czf backup.tar.gz --exclude='.*' /home/user
```

## Include Only Specific Files
```Shell title='Archive specific file types'
# Include only specific extensions
tar -czf source-code.tar.gz \
  --include='*.py' \
  --include='*.js' \
  /project

# Use find with tar
find /project -name "*.py" -o -name "*.js" | \
  tar -czf source-code.tar.gz -T -

# Archive modified files only
find /project -mtime -7 | tar -czf recent-changes.tar.gz -T -
```

## Preserve Permissions and Ownership
```Shell title='Maintain file attributes'
# Preserve permissions
tar -czf backup.tar.gz --preserve-permissions /data

# Preserve ownership (requires root)
sudo tar -czf backup.tar.gz --same-owner /data

# Extract preserving permissions
tar -xzf backup.tar.gz --preserve-permissions

# Extract as original owner (requires root)
sudo tar -xzf backup.tar.gz --same-owner
```

## Split Large Archives
```Shell title='Create multi-volume archives'
# Split into 100MB chunks
tar -czf - /large-directory | split -b 100M - backup.tar.gz.

# Results:
# backup.tar.gz.aa
# backup.tar.gz.ab
# backup.tar.gz.ac

# Reconstruct and extract
cat backup.tar.gz.* | tar -xzf -

# Split with tar multi-volume (older method)
tar -czvf backup.tar.gz -M -L 100M /large-directory
```

# Incremental and Differential Backups

## Incremental Backup
```Shell title='Backup only changed files'
# First full backup
tar -czf full-backup.tar.gz --listed-incremental=backup.snar /data

# Incremental backup (only changes since last backup)
tar -czf incremental-1.tar.gz --listed-incremental=backup.snar /data

# Next incremental
tar -czf incremental-2.tar.gz --listed-incremental=backup.snar /data

# Restore process:
# 1. Extract full backup
tar -xzf full-backup.tar.gz --listed-incremental=/dev/null
# 2. Extract incrementals in order
tar -xzf incremental-1.tar.gz --listed-incremental=/dev/null
tar -xzf incremental-2.tar.gz --listed-incremental=/dev/null
```

## Differential Backup
```Shell title='Backup changes since full backup'
# Full backup with snapshot
tar -czf full-backup.tar.gz --listed-incremental=full.snar /data

# Copy snapshot for differential
cp full.snar diff.snar

# Differential backup (changes since full)
tar -czf diff-backup.tar.gz --listed-incremental=diff.snar /data

# Restore: Extract full + latest differential
tar -xzf full-backup.tar.gz --listed-incremental=/dev/null
tar -xzf diff-backup.tar.gz --listed-incremental=/dev/null
```

# Practical Use Cases

## Use Case 1: Project Backup
```Shell title='Backup development project'
# Backup excluding build artifacts
tar -czf project-backup.tar.gz \
  --exclude='node_modules' \
  --exclude='dist' \
  --exclude='build' \
  --exclude='.git' \
  --exclude='*.log' \
  /home/user/project

# Verify backup contents
tar -tzf project-backup.tar.gz | head -20

# Restore to different location
tar -xzf project-backup.tar.gz -C /tmp/restore
```

## Use Case 2: System Configuration Backup
```Shell title='Backup system configurations'
# Backup important config files
sudo tar -czf system-config-$(date +%Y%m%d).tar.gz \
  /etc/nginx \
  /etc/apache2 \
  /etc/mysql \
  /etc/php \
  /etc/ssh/sshd_config \
  /etc/fstab \
  /etc/hosts

# Scheduled backup (crontab)
# 0 2 * * * tar -czf /backup/config-$(date +\%Y\%m\%d).tar.gz /etc
```

## Use Case 3: Log Rotation and Archive
```Shell title='Archive old log files'
# Archive logs older than 30 days
find /var/log -name "*.log" -mtime +30 -print0 | \
  tar -czf old-logs-$(date +%Y%m%d).tar.gz --null -T -

# Remove original logs after archiving
find /var/log -name "*.log" -mtime +30 -delete

# Compress individual log files
find /var/log -name "*.log" -mtime +7 -exec gzip {} \;
```

## Use Case 4: Remote Backup over SSH
```Shell title='Backup to remote server'
# Create and send backup to remote server
tar -czf - /data | ssh user@remote "cat > /backup/data-$(date +%Y%m%d).tar.gz"

# Stream backup directly
tar -czf - /var/www | ssh user@backup-server "dd of=/backups/www-backup.tar.gz"

# Backup from remote server
ssh user@remote "tar -czf - /data" > remote-backup.tar.gz

# Two-way sync: backup and restore
tar -czf - /local/data | ssh remote "cd /restore && tar -xzf -"
```

## Use Case 5: Database Backup
```Shell title='Archive database dumps'
# MySQL backup
mysqldump -u root -p database_name | gzip > db-backup.sql.gz

# PostgreSQL backup
pg_dump database_name | gzip > db-backup.sql.gz

# Archive all database dumps
tar -czf all-databases-$(date +%Y%m%d).tar.gz /var/backups/*.sql

# Combine backup and archive
mysqldump -u root -p --all-databases | \
  tar -czf mysql-backup-$(date +%Y%m%d).tar.gz -T -
```

## Use Case 6: Docker Container Backup
```Shell title='Backup Docker volumes and configs'
# Backup Docker volumes
docker run --rm -v myvolume:/data -v $(pwd):/backup alpine \
  tar -czf /backup/volume-backup.tar.gz /data

# Backup Docker Compose project
tar -czf docker-project.tar.gz \
  --exclude='*/node_modules' \
  --exclude='*/vendor' \
  docker-compose.yml \
  ./services \
  ./data

# Restore Docker volume
docker run --rm -v myvolume:/data -v $(pwd):/backup alpine \
  tar -xzf /backup/volume-backup.tar.gz -C /
```

## Use Case 7: Automated Backup Script
```Shell title='Complete backup automation'
#!/bin/bash
# Automated backup script

BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d)
RETENTION_DAYS=30

# Create backup
tar -czf "$BACKUP_DIR/backup-$DATE.tar.gz" \
  --exclude='*/node_modules' \
  --exclude='*/tmp' \
  --exclude='*.log' \
  /var/www \
  /etc/nginx \
  /home/user/projects

# Verify backup created
if [ -f "$BACKUP_DIR/backup-$DATE.tar.gz" ]; then
  echo "Backup created successfully"

  # Test archive integrity
  tar -tzf "$BACKUP_DIR/backup-$DATE.tar.gz" > /dev/null
  if [ $? -eq 0 ]; then
    echo "Backup integrity verified"
  fi

  # Upload to remote server
  scp "$BACKUP_DIR/backup-$DATE.tar.gz" user@remote:/backups/

  # Remove old backups
  find "$BACKUP_DIR" -name "backup-*.tar.gz" -mtime +$RETENTION_DAYS -delete
else
  echo "Backup failed!" | mail -s "Backup Error" admin@example.com
fi
```

# Verification and Testing

## Verify Archive Integrity
```Shell title='Test archive without extracting'
# Test archive integrity
tar -tzf archive.tar.gz > /dev/null
if [ $? -eq 0 ]; then
  echo "Archive is valid"
else
  echo "Archive is corrupted"
fi

# Verify and show errors
tar -tzf archive.tar.gz 2>&1 | grep -i error

# Compare archive with original
tar -df archive.tar /original/path

# Verify after creation
tar -czf backup.tar.gz /data && tar -tzf backup.tar.gz > /dev/null
```

## Test Extraction
```Shell title='Test extraction in temporary location'
# Extract to temporary directory for testing
mkdir /tmp/test-restore
tar -xzf backup.tar.gz -C /tmp/test-restore

# Verify extracted files
diff -r /original /tmp/test-restore

# Cleanup
rm -rf /tmp/test-restore
```

# Performance Optimization

## Parallel Compression
```Shell title='Use multiple CPU cores'
# Use pigz (parallel gzip) for faster compression
tar -cf - /data | pigz > archive.tar.gz

# Extract with parallel decompression
pigz -dc archive.tar.gz | tar -xf -

# Use pbzip2 for parallel bzip2
tar -cf - /data | pbzip2 > archive.tar.bz2

# Use pxz for parallel xz
tar -cf - /data | pxz > archive.tar.xz
```

## Tuning for Performance
```Shell title='Optimize tar performance'
# Increase block size for faster I/O
tar -czf archive.tar.gz --blocking-factor=20 /data

# Use faster compression level
tar -czf archive.tar.gz --use-compress-program="gzip -1" /data

# No compression for fast archiving
tar -cf archive.tar /data

# Stream to storage without intermediate file
tar -czf - /data > /mnt/backup/archive.tar.gz
```

# Common Pitfalls and Solutions

## Pitfall 1: Absolute vs Relative Paths
```Shell title='Handle path issues'
# Creates with absolute paths (problematic)
tar -czf backup.tar.gz /home/user/data
# Extracts to /home/user/data (overwrites!)

# Better: Use relative paths
cd /home/user
tar -czf backup.tar.gz data
# Extracts to ./data

# Or strip leading path components
tar -czf backup.tar.gz --transform='s|^home/user/||' /home/user/data
```

## Pitfall 2: Disk Space
```Shell title='Check available space'
# Check archive size before extracting
tar -tzf archive.tar.gz | wc -l
du -sh archive.tar.gz

# Estimate extracted size
tar -tvzf archive.tar.gz | awk '{sum+=$3} END {print sum/1024/1024 " MB"}'

# Check available disk space
df -h /destination
```

## Pitfall 3: File Permissions
```Shell title='Preserve or modify permissions'
# Extract without preserving permissions
tar -xzf archive.tar.gz --no-same-permissions

# Extract as current user
tar -xzf archive.tar.gz --no-same-owner

# Extract with custom umask
(umask 022 && tar -xzf archive.tar.gz)
```

# Quick Reference

## Most Common Commands
```Shell title='Frequently used tar operations'
# Create compressed archive
tar -czf archive.tar.gz directory/

# Extract compressed archive
tar -xzf archive.tar.gz

# List archive contents
tar -tzf archive.tar.gz

# Create with exclusions
tar -czf backup.tar.gz --exclude='*.log' directory/

# Extract to specific location
tar -xzf archive.tar.gz -C /destination/

# Create verbose archive
tar -czvf archive.tar.gz directory/
```

## Option Quick Reference
| Option | Description | Example |
|--------|-------------|---------|
| `-c` | Create archive | `tar -cf archive.tar files/` |
| `-x` | Extract archive | `tar -xf archive.tar` |
| `-t` | List contents | `tar -tf archive.tar` |
| `-f` | Archive filename | `tar -cf file.tar` (required) |
| `-v` | Verbose output | `tar -cvf archive.tar files/` |
| `-z` | Gzip compress | `tar -czf archive.tar.gz files/` |
| `-j` | Bzip2 compress | `tar -cjf archive.tar.bz2 files/` |
| `-J` | XZ compress | `tar -cJf archive.tar.xz files/` |
| `-C` | Change directory | `tar -xf archive.tar -C /dest/` |
| `--exclude` | Exclude pattern | `tar -czf archive.tar.gz --exclude='*.log'` |

***
# References
1. GNU Tar Manual - https://www.gnu.org/software/tar/manual/
2. `man tar` - Linux manual page
3. The Linux Command Line - William Shotts - 2nd Edition - 2019 - No Starch Press
	1. Chapter 18: Archiving and Backup
4. Unix and Linux System Administration Handbook - Evi Nemeth - 5th Edition - 2017 - Addison-Wesley
	1. Chapter 10: Backup and Recovery
5. https://www.gnu.org/software/tar/manual/html_node/
