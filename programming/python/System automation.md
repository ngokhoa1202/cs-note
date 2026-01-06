#python #automation #subprocess #system #scripting #devops
# subprocess Module
- The `subprocess` module allows you to <mark class="hltr-yellow">spawn new processes, connect to their input/output/error pipes, and obtain return codes</mark>.
- Replaces older modules like `os.system()` and `os.popen()`.
## Running Commands
```python title='Execute system commands'
import subprocess

# Simple command execution
result = subprocess.run(["ls", "-la"])

# Capture output
result = subprocess.run(["ls", "-la"], capture_output=True, text=True)
print(result.stdout)
print(result.stderr)
print(result.returncode)

# Alternative: capture_output=True is same as:
result = subprocess.run(
    ["ls", "-la"],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True
)

# Check return code (raises exception if non-zero)
result = subprocess.run(["ls", "nonexistent"], check=True)  # Raises CalledProcessError

# Shell=True (use with caution - security risk)
result = subprocess.run("ls -la | grep py", shell=True, capture_output=True, text=True)

# Timeout
try:
    result = subprocess.run(["sleep", "10"], timeout=5)
except subprocess.TimeoutExpired:
    print("Command timed out")
```
## Working with stdin/stdout/stderr
```python title='Pipe data to commands'
import subprocess

# Provide input to command
result = subprocess.run(
    ["grep", "python"],
    input="python is great\njava is ok\npython rules\n",
    capture_output=True,
    text=True
)
print(result.stdout)  # Lines containing 'python'

# Chain commands
# echo "hello" | tr 'a-z' 'A-Z'
echo = subprocess.run(["echo", "hello"], capture_output=True, text=True)
tr = subprocess.run(
    ["tr", "a-z", "A-Z"],
    input=echo.stdout,
    capture_output=True,
    text=True
)
print(tr.stdout)  # HELLO

# Better way to chain commands
result = subprocess.run(
    'echo "hello world" | tr "a-z" "A-Z"',
    shell=True,
    capture_output=True,
    text=True
)
print(result.stdout)  # HELLO WORLD
```
## Advanced Process Control
```python title='Process management with Popen'
import subprocess

# Popen for more control
process = subprocess.Popen(
    ["python", "script.py"],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True
)

# Wait for completion and get output
stdout, stderr = process.communicate()
return_code = process.returncode

# Stream output in real-time
process = subprocess.Popen(
    ["ping", "-c", "5", "google.com"],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
    bufsize=1
)

for line in process.stdout:
    print(line, end='')

process.wait()

# Send input incrementally
process = subprocess.Popen(
    ["python", "-u", "interactive.py"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True
)

process.stdin.write("input data\n")
process.stdin.flush()
output = process.stdout.readline()
```
## Error Handling
```python title='Handle command execution errors'
import subprocess

try:
    result = subprocess.run(
        ["nonexistent_command"],
        check=True,
        capture_output=True,
        text=True
    )
except subprocess.CalledProcessError as e:
    print(f"Command failed with return code {e.returncode}")
    print(f"stdout: {e.stdout}")
    print(f"stderr: {e.stderr}")
except FileNotFoundError:
    print("Command not found")
except subprocess.TimeoutExpired:
    print("Command timed out")

# Check without exception
result = subprocess.run(["ls", "nonexistent"], capture_output=True)
if result.returncode != 0:
    print("Command failed")
    print(result.stderr.decode())
```
# Environment Variables
```python title='Access and modify environment variables'
import os

# Read environment variable
home = os.environ.get("HOME")
path = os.environ.get("PATH")
user = os.getenv("USER", "unknown")  # With default value

# Check if exists
if "HOME" in os.environ:
    print("HOME is set")

# Set environment variable
os.environ["MY_VAR"] = "value"

# Modify PATH
current_path = os.environ.get("PATH", "")
os.environ["PATH"] = f"/custom/bin:{current_path}"

# Remove environment variable
if "MY_VAR" in os.environ:
    del os.environ["MY_VAR"]

# Pass custom environment to subprocess
env = os.environ.copy()
env["CUSTOM_VAR"] = "custom_value"

result = subprocess.run(
    ["printenv", "CUSTOM_VAR"],
    env=env,
    capture_output=True,
    text=True
)
print(result.stdout)  # custom_value

# Load .env file
def load_env_file(filepath):
    """Load environment variables from .env file."""
    with open(filepath) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#'):
                key, value = line.split('=', 1)
                os.environ[key.strip()] = value.strip()

# Usage
# load_env_file(".env")
```
# System Information
```python title='Get system and platform information'
import platform
import os
import sys
import psutil  # pip install psutil

# Platform information
print(platform.system())          # 'Linux', 'Darwin', 'Windows'
print(platform.release())         # '5.15.0-58-generic'
print(platform.version())         # Full version string
print(platform.machine())         # 'x86_64', 'arm64'
print(platform.processor())       # 'x86_64'
print(platform.python_version())  # '3.10.6'

# OS information
print(os.name)           # 'posix', 'nt'
print(sys.platform)      # 'linux', 'darwin', 'win32'

# System resources (requires psutil)
cpu_percent = psutil.cpu_percent(interval=1)
memory = psutil.virtual_memory()
disk = psutil.disk_usage('/')

print(f"CPU: {cpu_percent}%")
print(f"Memory: {memory.percent}%")
print(f"Disk: {disk.percent}%")

# Network information
net_io = psutil.net_io_counters()
print(f"Bytes sent: {net_io.bytes_sent}")
print(f"Bytes received: {net_io.bytes_recv}")
```
# Process Management
```python title='Manage system processes'
import psutil
import os
import signal

# List all processes
for proc in psutil.process_iter(['pid', 'name', 'username']):
    print(proc.info)

# Find processes by name
def find_process_by_name(name):
    """Find all processes matching name."""
    processes = []
    for proc in psutil.process_iter(['pid', 'name', 'cmdline']):
        if name.lower() in proc.info['name'].lower():
            processes.append(proc.info)
    return processes

python_procs = find_process_by_name("python")

# Get process information
pid = os.getpid()  # Current process PID
proc = psutil.Process(pid)

print(f"PID: {proc.pid}")
print(f"Name: {proc.name()}")
print(f"Status: {proc.status()}")
print(f"CPU: {proc.cpu_percent()}")
print(f"Memory: {proc.memory_percent()}")
print(f"Threads: {proc.num_threads()}")

# Kill process
def kill_process(pid):
    """Kill process by PID."""
    try:
        process = psutil.Process(pid)
        process.terminate()  # SIGTERM
        process.wait(timeout=5)
    except psutil.NoSuchProcess:
        print(f"Process {pid} not found")
    except psutil.TimeoutExpired:
        process.kill()  # SIGKILL if not terminated
        print(f"Force killed process {pid}")

# Send signal
os.kill(pid, signal.SIGTERM)
os.kill(pid, signal.SIGKILL)
```
# Scheduled Tasks
## Cron Job Management
```python title='Create and manage cron jobs'
from crontab import CronTab  # pip install python-crontab

# Create cron tab
cron = CronTab(user=True)  # Current user
# or
cron = CronTab(user='username')

# Create new job
job = cron.new(command='python /path/to/script.py')
job.minute.every(5)  # Every 5 minutes
job.enable()

# Cron schedule examples
job.minute.every(5)         # */5 * * * *
job.hour.every(2)           # 0 */2 * * *
job.minute.on(30)           # 30 * * * *
job.hour.on(9)              # 0 9 * * *
job.dow.on('MON')           # 0 0 * * 1
job.month.on('JAN')         # 0 0 1 1 *

# Multiple conditions
job.minute.on(0, 30)        # 0,30 * * * *
job.hour.on(9, 17)          # 0 9,17 * * *

# Set schedule directly
job.setall('0 2 * * *')     # 2 AM daily

# Write crontab
cron.write()

# List all jobs
for job in cron:
    print(job)

# Find and remove job
for job in cron.find_comment('backup_job'):
    cron.remove(job)
cron.write()

# Clear all jobs
cron.remove_all()
cron.write()
```
## Schedule with APScheduler
```python title='Advanced scheduling with APScheduler'
# pip install apscheduler

from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.cron import CronTrigger
from datetime import datetime
import time

def job_function():
    print(f"Job executed at {datetime.now()}")

# Create scheduler
scheduler = BackgroundScheduler()

# Interval-based scheduling
scheduler.add_job(job_function, 'interval', minutes=5)

# Cron-style scheduling
scheduler.add_job(
    job_function,
    CronTrigger(hour=2, minute=0),  # 2 AM daily
    id='nightly_job'
)

# One-time job
run_date = datetime(2024, 12, 25, 10, 30)
scheduler.add_job(job_function, 'date', run_date=run_date)

# Start scheduler
scheduler.start()

try:
    # Keep running
    while True:
        time.sleep(1)
except (KeyboardInterrupt, SystemExit):
    scheduler.shutdown()
```
# Service Management (Linux)
```python title='Interact with systemd services'
import subprocess

def systemctl(action, service):
    """Control systemd service."""
    result = subprocess.run(
        ["sudo", "systemctl", action, service],
        capture_output=True,
        text=True
    )
    return result.returncode == 0, result.stdout, result.stderr

# Start service
success, stdout, stderr = systemctl("start", "nginx")

# Stop service
systemctl("stop", "nginx")

# Restart service
systemctl("restart", "nginx")

# Enable service (start on boot)
systemctl("enable", "nginx")

# Disable service
systemctl("disable", "nginx")

# Check status
def get_service_status(service):
    """Get service status."""
    result = subprocess.run(
        ["systemctl", "is-active", service],
        capture_output=True,
        text=True
    )
    return result.stdout.strip()  # 'active', 'inactive', 'failed'

status = get_service_status("nginx")
print(f"nginx is {status}")
```
# User and Permission Management
```python title='Manage users and permissions'
import os
import pwd
import grp
import stat

# Get current user
username = os.getlogin()
uid = os.getuid()
gid = os.getgid()

# Get user information
user_info = pwd.getpwnam("username")
print(f"UID: {user_info.pw_uid}")
print(f"GID: {user_info.pw_gid}")
print(f"Home: {user_info.pw_dir}")
print(f"Shell: {user_info.pw_shell}")

# Get user by UID
user_info = pwd.getpwuid(1000)
print(user_info.pw_name)

# Get group information
group_info = grp.getgrnam("groupname")
print(f"GID: {group_info.gr_gid}")
print(f"Members: {group_info.gr_mem}")

# Change file ownership (requires sudo)
os.chown("file.txt", uid=1000, gid=1000)

# Change file permissions
os.chmod("script.sh", 0o755)  # rwxr-xr-x
os.chmod("file.txt", stat.S_IRUSR | stat.S_IWUSR | stat.S_IRGRP | stat.S_IROTH)  # 644

# Check if running as root
if os.geteuid() == 0:
    print("Running as root")
```
# Disk Usage and Management
```python title='Monitor and manage disk space'
import os
import shutil
import psutil

# Get disk usage
usage = shutil.disk_usage("/")
print(f"Total: {usage.total / (1024**3):.2f} GB")
print(f"Used: {usage.used / (1024**3):.2f} GB")
print(f"Free: {usage.free / (1024**3):.2f} GB")

# Get all disk partitions
partitions = psutil.disk_partitions()
for partition in partitions:
    print(f"Device: {partition.device}")
    print(f"Mountpoint: {partition.mountpoint}")
    usage = psutil.disk_usage(partition.mountpoint)
    print(f"Usage: {usage.percent}%")
    print()

# Find large files
def find_large_files(directory, size_mb=100):
    """Find files larger than size_mb."""
    large_files = []
    min_size = size_mb * 1024 * 1024

    for root, dirs, files in os.walk(directory):
        for file in files:
            filepath = os.path.join(root, file)
            try:
                size = os.path.getsize(filepath)
                if size > min_size:
                    large_files.append((filepath, size))
            except OSError:
                pass

    return sorted(large_files, key=lambda x: x[1], reverse=True)

# Usage
large = find_large_files("/home", size_mb=100)
for path, size in large[:10]:
    print(f"{size / (1024**2):.2f} MB: {path}")
```
# Practical System Automation Examples
## Example 1: System Health Monitor
```python title='Monitor system health and send alerts'
#!/usr/bin/env python3
"""System health monitoring script."""

import psutil
import smtplib
from email.message import EmailMessage
import time

def check_cpu(threshold=80):
    """Check if CPU usage exceeds threshold."""
    cpu_percent = psutil.cpu_percent(interval=1)
    return cpu_percent > threshold, cpu_percent

def check_memory(threshold=80):
    """Check if memory usage exceeds threshold."""
    memory = psutil.virtual_memory()
    return memory.percent > threshold, memory.percent

def check_disk(threshold=90):
    """Check if disk usage exceeds threshold."""
    disk = psutil.disk_usage('/')
    return disk.percent > threshold, disk.percent

def send_alert(subject, message):
    """Send email alert."""
    msg = EmailMessage()
    msg.set_content(message)
    msg['Subject'] = subject
    msg['From'] = 'monitor@example.com'
    msg['To'] = 'admin@example.com'

    # Send via SMTP
    # with smtplib.SMTP('localhost') as s:
    #     s.send_message(msg)

    print(f"ALERT: {subject}\n{message}")

def monitor_system():
    """Monitor system and send alerts."""
    alerts = []

    # Check CPU
    is_high, cpu_percent = check_cpu(threshold=80)
    if is_high:
        alerts.append(f"CPU usage high: {cpu_percent:.1f}%")

    # Check memory
    is_high, mem_percent = check_memory(threshold=80)
    if is_high:
        alerts.append(f"Memory usage high: {mem_percent:.1f}%")

    # Check disk
    is_high, disk_percent = check_disk(threshold=90)
    if is_high:
        alerts.append(f"Disk usage high: {disk_percent:.1f}%")

    # Send alerts
    if alerts:
        message = "\n".join(alerts)
        send_alert("System Health Alert", message)

if __name__ == "__main__":
    while True:
        monitor_system()
        time.sleep(60)  # Check every minute
```
## Example 2: Process Watchdog
```python title='Restart crashed processes automatically'
#!/usr/bin/env python3
"""Watch and restart critical processes."""

import subprocess
import time
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(message)s'
)

def is_process_running(process_name):
    """Check if process is running."""
    result = subprocess.run(
        ["pgrep", "-f", process_name],
        capture_output=True
    )
    return result.returncode == 0

def start_process(command):
    """Start process."""
    logging.info(f"Starting process: {command}")
    subprocess.Popen(
        command,
        shell=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
    )

def watch_process(process_name, start_command, check_interval=10):
    """Watch process and restart if crashed."""
    logging.info(f"Watching process: {process_name}")

    while True:
        if not is_process_running(process_name):
            logging.warning(f"Process {process_name} not running")
            start_process(start_command)
            time.sleep(5)  # Wait for startup

        time.sleep(check_interval)

if __name__ == "__main__":
    # Example: Watch nginx
    watch_process(
        process_name="nginx",
        start_command="sudo systemctl start nginx",
        check_interval=30
    )
```
## Example 3: Automated Backup Script
```python title='Complete system backup automation'
#!/usr/bin/env python3
"""Automated backup with rotation and notification."""

import subprocess
import os
from pathlib import Path
from datetime import datetime
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('/var/log/backup.log'),
        logging.StreamHandler()
    ]
)

BACKUP_SOURCES = [
    "/home",
    "/etc",
    "/var/www"
]
BACKUP_DEST = "/backups"
MAX_BACKUPS = 7  # Keep last 7 backups

def create_backup():
    """Create system backup."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"backup_{timestamp}.tar.gz"
    backup_path = os.path.join(BACKUP_DEST, backup_name)

    # Create backup directory
    Path(BACKUP_DEST).mkdir(parents=True, exist_ok=True)

    # Build tar command
    sources = " ".join(BACKUP_SOURCES)
    cmd = f"tar -czf {backup_path} {sources} 2>/dev/null"

    logging.info(f"Creating backup: {backup_name}")

    try:
        subprocess.run(cmd, shell=True, check=True)
        size = os.path.getsize(backup_path) / (1024 ** 3)
        logging.info(f"Backup completed: {backup_name} ({size:.2f} GB)")
        return backup_path
    except subprocess.CalledProcessError as e:
        logging.error(f"Backup failed: {e}")
        return None

def rotate_backups():
    """Remove old backups."""
    backups = sorted(Path(BACKUP_DEST).glob("backup_*.tar.gz"))

    if len(backups) > MAX_BACKUPS:
        old_backups = backups[:-MAX_BACKUPS]
        for backup in old_backups:
            logging.info(f"Removing old backup: {backup.name}")
            backup.unlink()

def verify_backup(backup_path):
    """Verify backup integrity."""
    cmd = f"tar -tzf {backup_path} >/dev/null"
    result = subprocess.run(cmd, shell=True)
    return result.returncode == 0

if __name__ == "__main__":
    backup_path = create_backup()

    if backup_path:
        if verify_backup(backup_path):
            logging.info("Backup verified successfully")
            rotate_backups()
        else:
            logging.error("Backup verification failed")
    else:
        logging.error("Backup creation failed")
```
## Example 4: Log Cleaner
```python title='Clean old log files automatically'
#!/usr/bin/env python3
"""Clean old log files based on age and size."""

import os
from pathlib import Path
from datetime import datetime, timedelta
import gzip
import shutil

def clean_logs(log_dir, max_age_days=30, max_size_mb=100):
    """
    Clean old log files.

    Args:
        log_dir: Directory containing logs
        max_age_days: Delete logs older than this
        max_size_mb: Compress logs larger than this
    """
    log_path = Path(log_dir)
    now = datetime.now()
    cutoff_date = now - timedelta(days=max_age_days)
    max_size = max_size_mb * 1024 * 1024

    for log_file in log_path.glob("*.log*"):
        mtime = datetime.fromtimestamp(log_file.stat().st_mtime)
        size = log_file.stat().st_size

        # Delete old logs
        if mtime < cutoff_date:
            print(f"Deleting old log: {log_file.name}")
            log_file.unlink()
            continue

        # Compress large logs
        if size > max_size and not log_file.name.endswith('.gz'):
            print(f"Compressing large log: {log_file.name}")
            with open(log_file, 'rb') as f_in:
                with gzip.open(f"{log_file}.gz", 'wb') as f_out:
                    shutil.copyfileobj(f_in, f_out)
            log_file.unlink()

# Usage
# clean_logs("/var/log/myapp", max_age_days=30, max_size_mb=100)
```
***
# References
1. subprocess - Subprocess management - https://docs.python.org/3/library/subprocess.html
2. os - Miscellaneous operating system interfaces - https://docs.python.org/3/library/os.html
3. psutil - Cross-platform lib for process and system monitoring - https://psutil.readthedocs.io/
4. python-crontab - Cron jobs made easy - https://gitlab.com/doctormo/python-crontab/
5. APScheduler - Advanced Python Scheduler - https://apscheduler.readthedocs.io/
6. platform - Access to underlying platform's identifying data - https://docs.python.org/3/library/platform.html
