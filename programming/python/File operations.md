#python #file-io #automation #scripting #filesystem
# File Reading
- Python provides multiple ways to <mark class="hltr-yellow">read file contents</mark>.
- Always use context managers (`with` statement) to ensure proper file closing.
## Reading Entire File
```python title='Read complete file content'
# Read as single string
with open("file.txt", "r") as f:
    content = f.read()
    print(content)

# Read with encoding
with open("file.txt", "r", encoding="utf-8") as f:
    content = f.read()

# Read specific number of bytes
with open("file.txt", "r") as f:
    chunk = f.read(100)  # Read first 100 characters
```
## Reading Line by Line
```python title='Line-by-line reading'
# Read all lines as list
with open("file.txt", "r") as f:
    lines = f.readlines()  # ['line1\n', 'line2\n', ...]

# Read one line at a time (memory efficient for large files)
with open("large_file.txt", "r") as f:
    for line in f:
        process(line.strip())

# Read specific line
with open("file.txt", "r") as f:
    first_line = f.readline()
    second_line = f.readline()

# Skip empty lines
with open("file.txt", "r") as f:
    for line in f:
        line = line.strip()
        if line:  # Skip empty lines
            print(line)
```
# File Writing
## Writing Text
```python title='Write to files'
# Write string (overwrites existing content)
with open("output.txt", "w") as f:
    f.write("Hello, World!\n")
    f.write("Second line\n")

# Write multiple lines
lines = ["Line 1\n", "Line 2\n", "Line 3\n"]
with open("output.txt", "w") as f:
    f.writelines(lines)

# Append to existing file
with open("output.txt", "a") as f:
    f.write("Appended line\n")

# Write with formatting
data = {"name": "Alice", "age": 30}
with open("output.txt", "w") as f:
    f.write(f"Name: {data['name']}\n")
    f.write(f"Age: {data['age']}\n")

# Safer file writing (atomic write)
import tempfile
import os

def safe_write(filename, content):
    """Write to temp file first, then rename."""
    fd, temp_path = tempfile.mkstemp(dir=os.path.dirname(filename))
    try:
        with os.fdopen(fd, 'w') as f:
            f.write(content)
        os.replace(temp_path, filename)  # Atomic on Unix
    except:
        os.unlink(temp_path)
        raise
```
# Binary Files
```python title='Binary file operations'
# Read binary file
with open("image.png", "rb") as f:
    data = f.read()

# Write binary file
with open("output.bin", "wb") as f:
    f.write(b'\x00\x01\x02\x03')

# Copy binary file
with open("source.bin", "rb") as src:
    with open("dest.bin", "wb") as dst:
        dst.write(src.read())

# Read/write in chunks (memory efficient)
def copy_file_chunks(src_path, dst_path, chunk_size=8192):
    with open(src_path, "rb") as src:
        with open(dst_path, "wb") as dst:
            while True:
                chunk = src.read(chunk_size)
                if not chunk:
                    break
                dst.write(chunk)
```
# File Information
```python title='Get file metadata using os module'
import os
import stat
from datetime import datetime

path = "file.txt"

# Check existence
if os.path.exists(path):
    print("File exists")

if os.path.isfile(path):
    print("Is a file")

if os.path.isdir(path):
    print("Is a directory")

# File size
size = os.path.getsize(path)
print(f"Size: {size} bytes")
print(f"Size: {size / 1024:.2f} KB")

# File timestamps
mtime = os.path.getmtime(path)  # Last modification time
atime = os.path.getatime(path)  # Last access time
ctime = os.path.getctime(path)  # Creation time (Windows) or metadata change (Unix)

# Convert timestamp to datetime
mod_time = datetime.fromtimestamp(mtime)
print(f"Last modified: {mod_time}")

# File permissions
mode = os.stat(path).st_mode
is_readable = bool(mode & stat.S_IRUSR)
is_writable = bool(mode & stat.S_IWUSR)
is_executable = bool(mode & stat.S_IXUSR)

# Detailed file stats
file_stats = os.stat(path)
print(f"Size: {file_stats.st_size}")
print(f"UID: {file_stats.st_uid}")
print(f"GID: {file_stats.st_gid}")
print(f"Mode: {oct(file_stats.st_mode)}")
```
# Path Operations with pathlib
- `pathlib` provides <mark class="hltr-yellow">object-oriented interface for filesystem paths</mark>.
- Recommended for modern Python code.
```python title='Pathlib path operations'
from pathlib import Path

# Create Path objects
p = Path("folder/file.txt")
home = Path.home()  # ~/
cwd = Path.cwd()    # Current directory

# Path components
print(p.name)       # 'file.txt'
print(p.stem)       # 'file' (without extension)
print(p.suffix)     # '.txt'
print(p.parent)     # 'folder'
print(p.parents[0]) # 'folder'
print(p.parents[1]) # '.'
print(p.anchor)     # '' (or '/' on Unix, 'C:\' on Windows)

# Join paths
config_path = Path.home() / ".config" / "app" / "settings.conf"
data_file = Path("/var/log") / "app.log"

# Change extension
new_path = p.with_suffix(".md")  # 'folder/file.md'
new_path = p.with_name("other.txt")  # 'folder/other.txt'

# Absolute path
absolute = p.resolve()  # Full absolute path
absolute = p.absolute()  # Simple absolute path

# Relative path
rel = Path("/home/user/docs/file.txt").relative_to("/home/user")
# Returns: 'docs/file.txt'
```
# Directory Operations
```python title='Directory manipulation'
import os
from pathlib import Path
import shutil

# Create directory
os.mkdir("new_folder")
os.makedirs("parent/child/grandchild")  # Create all intermediate dirs

# With pathlib
Path("new_folder").mkdir(exist_ok=True)
Path("parent/child").mkdir(parents=True, exist_ok=True)

# List directory contents
files = os.listdir(".")
for file in files:
    print(file)

# List with full paths
for file in os.listdir("."):
    full_path = os.path.join(".", file)
    print(full_path)

# Pathlib iteration
for item in Path(".").iterdir():
    if item.is_file():
        print(f"File: {item}")
    elif item.is_dir():
        print(f"Dir: {item}")

# Walk directory tree
for root, dirs, files in os.walk("."):
    for file in files:
        full_path = os.path.join(root, file)
        print(full_path)

# Remove directory
os.rmdir("empty_folder")  # Only empty directories
shutil.rmtree("folder")    # Remove directory and all contents

# Pathlib removal
Path("empty_folder").rmdir()
```
# File and Directory Operations
```python title='Copy, move, and delete operations'
import shutil
import os
from pathlib import Path

# Copy file
shutil.copy("source.txt", "dest.txt")  # Copy file
shutil.copy2("source.txt", "dest.txt")  # Copy with metadata

# Copy directory
shutil.copytree("source_dir", "dest_dir")

# Move/rename
shutil.move("old_name.txt", "new_name.txt")
os.rename("old.txt", "new.txt")  # Same as move for files

# Pathlib rename
Path("old.txt").rename("new.txt")

# Delete file
os.remove("file.txt")
os.unlink("file.txt")  # Same as remove
Path("file.txt").unlink()  # Pathlib

# Delete with error handling
try:
    os.remove("file.txt")
except FileNotFoundError:
    print("File not found")
except PermissionError:
    print("Permission denied")

# Safe delete (check exists first)
if os.path.exists("file.txt"):
    os.remove("file.txt")

# Pathlib safe delete
Path("file.txt").unlink(missing_ok=True)  # Python 3.8+
```
# File Searching and Filtering
```python title='Find files matching patterns'
import os
import glob
from pathlib import Path

# glob - Unix style pattern matching
txt_files = glob.glob("*.txt")
all_py = glob.glob("**/*.py", recursive=True)

# glob with full paths
for file in glob.glob("/var/log/*.log"):
    print(file)

# Pathlib glob
for txt_file in Path(".").glob("*.txt"):
    print(txt_file)

# Recursive glob with pathlib
for py_file in Path(".").rglob("*.py"):
    print(py_file)

# Find files by extension
def find_files_by_extension(directory, extension):
    """Find all files with given extension."""
    files = []
    for root, dirs, filenames in os.walk(directory):
        for filename in filenames:
            if filename.endswith(extension):
                files.append(os.path.join(root, filename))
    return files

python_files = find_files_by_extension(".", ".py")

# Find files modified within last N days
from datetime import datetime, timedelta
import time

def find_recent_files(directory, days=7):
    """Find files modified in last N days."""
    cutoff = time.time() - (days * 86400)
    recent = []

    for root, dirs, files in os.walk(directory):
        for file in files:
            path = os.path.join(root, file)
            if os.path.getmtime(path) > cutoff:
                recent.append(path)

    return recent
```
# Temporary Files
```python title='Work with temporary files and directories'
import tempfile
import os

# Create temporary file
with tempfile.NamedTemporaryFile(mode='w', delete=False) as tmp:
    tmp.write("Temporary data\n")
    temp_name = tmp.name
    print(f"Temp file: {temp_name}")

# File is closed, use it
process_file(temp_name)

# Manual cleanup
os.unlink(temp_name)

# Auto-delete temporary file
with tempfile.NamedTemporaryFile(mode='w', delete=True) as tmp:
    tmp.write("Data\n")
    tmp.flush()
    # File exists while context is open
    process_file(tmp.name)
# File automatically deleted when context exits

# Temporary directory
with tempfile.TemporaryDirectory() as tmpdir:
    print(f"Temp dir: {tmpdir}")
    # Create files in tmpdir
    temp_file = os.path.join(tmpdir, "data.txt")
    with open(temp_file, 'w') as f:
        f.write("Data\n")
# Directory and all contents automatically deleted

# Get temp directory path
temp_dir = tempfile.gettempdir()  # /tmp on Unix
```
# File Watching
```python title='Monitor file changes using watchdog'
# Install: pip install watchdog

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import time

class FileChangeHandler(FileSystemEventHandler):
    """Handle file system events."""

    def on_modified(self, event):
        if not event.is_directory:
            print(f"Modified: {event.src_path}")

    def on_created(self, event):
        if not event.is_directory:
            print(f"Created: {event.src_path}")

    def on_deleted(self, event):
        if not event.is_directory:
            print(f"Deleted: {event.src_path}")

def watch_directory(path):
    """Watch directory for changes."""
    event_handler = FileChangeHandler()
    observer = Observer()
    observer.schedule(event_handler, path, recursive=True)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()

    observer.join()

# Usage
# watch_directory("/path/to/watch")
```
# Archive Operations
```python title='Create and extract archives'
import tarfile
import zipfile
import gzip
import shutil

# TAR.GZ archives
# Create
with tarfile.open("archive.tar.gz", "w:gz") as tar:
    tar.add("folder", arcname="backup")
    tar.add("file.txt")

# Extract
with tarfile.open("archive.tar.gz", "r:gz") as tar:
    tar.extractall("extract_here")

# ZIP archives
# Create
with zipfile.ZipFile("archive.zip", "w", zipfile.ZIP_DEFLATED) as zipf:
    zipf.write("file.txt")
    zipf.write("folder", arcname="backup")

# Add all files in directory
with zipfile.ZipFile("archive.zip", "w") as zipf:
    for root, dirs, files in os.walk("source_folder"):
        for file in files:
            file_path = os.path.join(root, file)
            arcname = os.path.relpath(file_path, "source_folder")
            zipf.write(file_path, arcname)

# Extract ZIP
with zipfile.ZipFile("archive.zip", "r") as zipf:
    zipf.extractall("extract_here")

# Extract specific file
with zipfile.ZipFile("archive.zip", "r") as zipf:
    zipf.extract("file.txt", "extract_here")

# GZIP single file
# Compress
with open("file.txt", "rb") as f_in:
    with gzip.open("file.txt.gz", "wb") as f_out:
        shutil.copyfileobj(f_in, f_out)

# Decompress
with gzip.open("file.txt.gz", "rb") as f_in:
    with open("file.txt", "wb") as f_out:
        shutil.copyfileobj(f_in, f_out)
```
# CSV File Operations
```python title='Read and write CSV files'
import csv

# Read CSV
with open("data.csv", "r") as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)  # List of strings

# Read CSV with header
with open("data.csv", "r") as f:
    reader = csv.DictReader(f)
    for row in reader:
        print(row["name"], row["age"])  # Access by column name

# Write CSV
data = [
    ["Name", "Age", "City"],
    ["Alice", "30", "NYC"],
    ["Bob", "25", "LA"]
]

with open("output.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(data)

# Write CSV with dict
data = [
    {"name": "Alice", "age": 30, "city": "NYC"},
    {"name": "Bob", "age": 25, "city": "LA"}
]

with open("output.csv", "w", newline="") as f:
    fieldnames = ["name", "age", "city"]
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(data)

# Custom delimiter
with open("data.tsv", "r") as f:
    reader = csv.reader(f, delimiter="\t")
    for row in reader:
        print(row)
```
# JSON File Operations
```python title='Work with JSON files'
import json

# Read JSON
with open("data.json", "r") as f:
    data = json.load(f)

# Write JSON
data = {
    "name": "Alice",
    "age": 30,
    "hobbies": ["reading", "coding"]
}

with open("output.json", "w") as f:
    json.dump(data, f, indent=2)

# Pretty print JSON
print(json.dumps(data, indent=2))

# Parse JSON string
json_string = '{"name": "Alice", "age": 30}'
data = json.loads(json_string)

# Convert to JSON string
json_string = json.dumps(data)

# Handle custom objects
from datetime import datetime

class DateEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        return super().default(obj)

data = {"timestamp": datetime.now()}
json_string = json.dumps(data, cls=DateEncoder)
```
# Practical File Automation Examples
## Example 1: Batch File Renamer
```python title='Rename multiple files based on pattern'
#!/usr/bin/env python3
"""Batch rename files matching pattern."""

import os
import re
from pathlib import Path

def batch_rename(directory, pattern, replacement):
    """
    Rename files matching regex pattern.

    Args:
        directory: Directory containing files
        pattern: Regex pattern to match
        replacement: Replacement string
    """
    dir_path = Path(directory)
    renamed_count = 0

    for file_path in dir_path.iterdir():
        if file_path.is_file():
            old_name = file_path.name
            new_name = re.sub(pattern, replacement, old_name)

            if new_name != old_name:
                new_path = file_path.parent / new_name
                print(f"{old_name} -> {new_name}")
                file_path.rename(new_path)
                renamed_count += 1

    print(f"\nRenamed {renamed_count} files")

# Usage examples:
# Replace spaces with underscores
# batch_rename(".", r"\s+", "_")

# Add prefix to all .txt files
# batch_rename(".", r"^(.+\.txt)$", r"prefix_\1")

# Change extension
# batch_rename(".", r"\.jpeg$", ".jpg")
```
## Example 2: Duplicate File Finder
```python title='Find duplicate files by content hash'
#!/usr/bin/env python3
"""Find duplicate files using MD5 hash."""

import hashlib
import os
from collections import defaultdict

def get_file_hash(filepath, chunk_size=8192):
    """Calculate MD5 hash of file."""
    hasher = hashlib.md5()

    with open(filepath, 'rb') as f:
        while True:
            chunk = f.read(chunk_size)
            if not chunk:
                break
            hasher.update(chunk)

    return hasher.hexdigest()

def find_duplicates(directory):
    """Find duplicate files in directory."""
    hashes = defaultdict(list)

    # Calculate hash for each file
    for root, dirs, files in os.walk(directory):
        for filename in files:
            filepath = os.path.join(root, filename)
            try:
                file_hash = get_file_hash(filepath)
                hashes[file_hash].append(filepath)
            except (IOError, OSError) as e:
                print(f"Error reading {filepath}: {e}")

    # Find duplicates
    duplicates = {h: files for h, files in hashes.items() if len(files) > 1}

    # Print results
    if duplicates:
        print(f"Found {len(duplicates)} sets of duplicates:\n")
        for file_hash, files in duplicates.items():
            print(f"Hash: {file_hash}")
            for f in files:
                size = os.path.getsize(f) / 1024
                print(f"  - {f} ({size:.2f} KB)")
            print()
    else:
        print("No duplicates found")

    return duplicates

# Usage
# find_duplicates("/path/to/search")
```
## Example 3: Log File Rotator
```python title='Rotate and compress old log files'
#!/usr/bin/env python3
"""Rotate and compress log files."""

import gzip
import shutil
from pathlib import Path
from datetime import datetime, timedelta

def rotate_logs(log_file, max_age_days=7, keep_compressed=3):
    """
    Rotate log files: compress old, delete ancient.

    Args:
        log_file: Path to log file
        max_age_days: Days before compressing
        keep_compressed: Number of compressed files to keep
    """
    log_path = Path(log_file)

    if not log_path.exists():
        return

    # Compress if old enough
    mtime = datetime.fromtimestamp(log_path.stat().st_mtime)
    age_days = (datetime.now() - mtime).days

    if age_days >= max_age_days:
        # Compress log
        timestamp = mtime.strftime("%Y%m%d")
        compressed_name = f"{log_path.stem}_{timestamp}.gz"
        compressed_path = log_path.parent / compressed_name

        print(f"Compressing {log_path.name} -> {compressed_name}")

        with open(log_path, 'rb') as f_in:
            with gzip.open(compressed_path, 'wb') as f_out:
                shutil.copyfileobj(f_in, f_out)

        # Clear original log
        log_path.write_text("")

    # Remove old compressed logs
    compressed_logs = sorted(log_path.parent.glob(f"{log_path.stem}_*.gz"))

    if len(compressed_logs) > keep_compressed:
        for old_log in compressed_logs[:-keep_compressed]:
            print(f"Removing old compressed log: {old_log.name}")
            old_log.unlink()

# Usage
# rotate_logs("/var/log/app.log", max_age_days=7, keep_compressed=3)
```
## Example 4: Directory Sync
```python title='Sync files between directories'
#!/usr/bin/env python3
"""Synchronize files between source and destination."""

import os
import shutil
from pathlib import Path

def sync_directories(source, dest, delete=False):
    """
    Sync files from source to destination.

    Args:
        source: Source directory
        dest: Destination directory
        delete: Delete files in dest not in source
    """
    source_path = Path(source)
    dest_path = Path(dest)

    # Create destination if doesn't exist
    dest_path.mkdir(parents=True, exist_ok=True)

    # Track files in source
    source_files = set()

    # Copy/update files
    for src_file in source_path.rglob("*"):
        if src_file.is_file():
            # Calculate relative path
            rel_path = src_file.relative_to(source_path)
            dest_file = dest_path / rel_path
            source_files.add(rel_path)

            # Create parent directories
            dest_file.parent.mkdir(parents=True, exist_ok=True)

            # Copy if newer or doesn't exist
            if not dest_file.exists() or \
               src_file.stat().st_mtime > dest_file.stat().st_mtime:
                print(f"Copying: {rel_path}")
                shutil.copy2(src_file, dest_file)

    # Delete files not in source
    if delete:
        for dest_file in dest_path.rglob("*"):
            if dest_file.is_file():
                rel_path = dest_file.relative_to(dest_path)
                if rel_path not in source_files:
                    print(f"Deleting: {rel_path}")
                    dest_file.unlink()

# Usage
# sync_directories("/source", "/destination", delete=True)
```
***
# References
1. Python Documentation - File I/O - https://docs.python.org/3/tutorial/inputoutput.html
2. `pathlib` - Object-oriented filesystem paths - https://docs.python.org/3/library/pathlib.html
3. `os.path` - Common pathname manipulations - https://docs.python.org/3/library/os.path.html
4. `shutil` - High-level file operations - https://docs.python.org/3/library/shutil.html
5. `tempfile` - Generate temporary files and directories - https://docs.python.org/3/library/tempfile.html
6. watchdog - Python API library and shell utilities to monitor file system events - https://python-watchdog.readthedocs.io/
