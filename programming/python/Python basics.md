#python #programming #scripting #automation #fundamentals
# Variables and Data Types
- Python is <mark class="hltr-yellow">dynamically typed</mark> - variables don't need explicit type declarations.
- Type is determined at runtime based on assigned value.
## Variable Declaration
```python title='Variable assignment and type inference'
# Basic types
name = "Alice"              # str
age = 30                    # int
height = 5.8                # float
is_admin = True             # bool
data = None                 # NoneType

# Multiple assignment
x, y, z = 1, 2, 3
a = b = c = 0

# Type hints (Python 3.5+)
username: str = "admin"
port: int = 8080
active: bool = True
```
## Built-in Data Types
```python title='Common data types'
# Numeric types
integer = 42
floating = 3.14
complex_num = 3 + 4j

# Sequence types
text = "Hello"                          # str
numbers = [1, 2, 3, 4]                 # list (mutable)
coordinates = (10, 20)                  # tuple (immutable)
range_obj = range(0, 10)               # range

# Mapping type
person = {"name": "Bob", "age": 25}    # dict

# Set types
unique = {1, 2, 3}                     # set (mutable)
immutable_set = frozenset([1, 2, 3])   # frozenset

# Boolean
is_valid = True
is_empty = False

# Check type
print(type(name))          # <class 'str'>
print(isinstance(age, int))  # True
```
# Strings
- Strings are <mark class="hltr-yellow">immutable sequences of Unicode characters</mark>.
- Support single quotes, double quotes, and triple quotes for multiline.
## String Operations
```python title='String manipulation'
# Creation
text = "Hello, World!"
multiline = """This is
a multiline
string"""

# Concatenation
greeting = "Hello" + " " + "World"
repeated = "Hi! " * 3  # "Hi! Hi! Hi! "

# Indexing and slicing
first = text[0]           # 'H'
last = text[-1]           # '!'
substring = text[0:5]     # 'Hello'
reverse = text[::-1]      # '!dlroW ,olleH'

# String methods
upper = text.upper()                    # 'HELLO, WORLD!'
lower = text.lower()                    # 'hello, world!'
stripped = "  text  ".strip()           # 'text'
replaced = text.replace("World", "Python")
split_words = text.split(", ")          # ['Hello', 'World!']
joined = "-".join(["a", "b", "c"])      # 'a-b-c'

# String formatting
name = "Alice"
age = 30

# f-strings (Python 3.6+) - recommended
message = f"Name: {name}, Age: {age}"

# format() method
message = "Name: {}, Age: {}".format(name, age)
message = "Name: {n}, Age: {a}".format(n=name, a=age)

# Old style (avoid in new code)
message = "Name: %s, Age: %d" % (name, age)
```
## String Checking
```python title='String validation methods'
text = "Hello123"

# Check content
text.isalpha()      # False (has numbers)
text.isdigit()      # False
text.isalnum()      # True
text.islower()      # False
text.isupper()      # False
text.isspace()      # False

# Check prefix/suffix
text.startswith("Hello")  # True
text.endswith("123")      # True

# Find substring
text.find("lo")           # 3 (index)
text.index("lo")          # 3 (raises ValueError if not found)
"lo" in text              # True
```
# Lists
- Lists are <mark class="hltr-yellow">ordered, mutable sequences</mark>.
- Can contain mixed data types.
```python title='List operations'
# Creation
empty = []
numbers = [1, 2, 3, 4, 5]
mixed = [1, "text", 3.14, True]
nested = [[1, 2], [3, 4]]

# List comprehension
squares = [x**2 for x in range(10)]
evens = [x for x in range(20) if x % 2 == 0]

# Access and modification
first = numbers[0]        # 1
last = numbers[-1]        # 5
numbers[0] = 10           # Modify element
sublist = numbers[1:4]    # [2, 3, 4]

# Adding elements
numbers.append(6)         # Add to end
numbers.insert(0, 0)      # Insert at index
numbers.extend([7, 8])    # Add multiple items

# Removing elements
numbers.remove(3)         # Remove first occurrence of 3
popped = numbers.pop()    # Remove and return last item
popped = numbers.pop(0)   # Remove at index
del numbers[1]            # Delete by index
numbers.clear()           # Remove all items

# Other operations
numbers = [3, 1, 4, 1, 5]
numbers.sort()            # Sort in place
sorted_list = sorted(numbers)  # Return new sorted list
numbers.reverse()         # Reverse in place
count = numbers.count(1)  # Count occurrences
index = numbers.index(4)  # Find index of value
```
# Dictionaries
- Dictionaries are <mark class="hltr-yellow">unordered collections of key-value pairs</mark>.
- Keys must be immutable (strings, numbers, tuples).
```python title='Dictionary operations'
# Creation
empty = {}
person = {"name": "Alice", "age": 30, "city": "NYC"}
dict_from_pairs = dict([("a", 1), ("b", 2)])
dict_comp = {x: x**2 for x in range(5)}

# Access
name = person["name"]              # Raises KeyError if not found
name = person.get("name")          # Returns None if not found
name = person.get("name", "Unknown")  # Default value

# Modification
person["age"] = 31                 # Update value
person["email"] = "alice@example.com"  # Add new key

# Removal
del person["city"]                 # Delete key
age = person.pop("age")            # Remove and return value
person.clear()                     # Remove all items

# Iteration
person = {"name": "Alice", "age": 30}
for key in person:
    print(key, person[key])

for key, value in person.items():
    print(f"{key}: {value}")

for key in person.keys():
    print(key)

for value in person.values():
    print(value)

# Merging dictionaries (Python 3.9+)
dict1 = {"a": 1, "b": 2}
dict2 = {"b": 3, "c": 4}
merged = dict1 | dict2  # {'a': 1, 'b': 3, 'c': 4}

# Update dictionary
dict1.update(dict2)
```
# Control Flow
## Conditional Statements
```python title='If-elif-else statements'
age = 25

if age < 18:
    print("Minor")
elif age < 65:
    print("Adult")
else:
    print("Senior")

# Ternary operator
status = "Adult" if age >= 18 else "Minor"

# Multiple conditions
if age >= 18 and age < 65:
    print("Working age")

# Check membership
fruits = ["apple", "banana", "orange"]
if "apple" in fruits:
    print("Apple found")
```
## Loops
```python title='For and while loops'
# For loop - iterate over sequence
for i in range(5):
    print(i)  # 0, 1, 2, 3, 4

for item in ["a", "b", "c"]:
    print(item)

# Enumerate - get index and value
for index, value in enumerate(["a", "b", "c"]):
    print(f"{index}: {value}")

# While loop
count = 0
while count < 5:
    print(count)
    count += 1

# Break and continue
for i in range(10):
    if i == 3:
        continue  # Skip 3
    if i == 7:
        break     # Stop at 7
    print(i)

# Else clause (executes if loop completes normally)
for i in range(5):
    print(i)
else:
    print("Loop completed")
```
# Functions
- Functions are <mark class="hltr-yellow">first-class objects</mark> in Python.
- Defined using `def` keyword.
```python title='Function definition and usage'
# Basic function
def greet(name):
    """Return greeting message."""
    return f"Hello, {name}!"

# Default arguments
def power(base, exponent=2):
    return base ** exponent

result = power(5)      # 25 (uses default exponent=2)
result = power(5, 3)   # 125

# Keyword arguments
def describe_person(name, age, city):
    return f"{name}, {age} years old, from {city}"

# Call with keyword arguments (order doesn't matter)
info = describe_person(age=30, name="Alice", city="NYC")

# Variable-length arguments (*args)
def sum_all(*numbers):
    """Accept any number of arguments."""
    return sum(numbers)

total = sum_all(1, 2, 3, 4, 5)  # 15

# Keyword variable-length arguments (**kwargs)
def print_info(**info):
    """Accept any number of keyword arguments."""
    for key, value in info.items():
        print(f"{key}: {value}")

print_info(name="Alice", age=30, city="NYC")

# Lambda functions (anonymous functions)
square = lambda x: x ** 2
add = lambda x, y: x + y

# Higher-order functions
numbers = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x**2, numbers))
evens = list(filter(lambda x: x % 2 == 0, numbers))
```
## Docstrings
```python title='Function documentation'
def calculate_average(numbers):
    """
    Calculate the average of a list of numbers.

    Args:
        numbers (list): List of numeric values

    Returns:
        float: Average value

    Raises:
        ValueError: If list is empty

    Example:
        >>> calculate_average([1, 2, 3, 4, 5])
        3.0
    """
    if not numbers:
        raise ValueError("List cannot be empty")
    return sum(numbers) / len(numbers)

# Access docstring
print(calculate_average.__doc__)
```
# File I/O
- Python provides built-in functions for <mark class="hltr-yellow">file reading and writing</mark>.
```python title='File operations'
# Reading files
# Using context manager (recommended - auto closes file)
with open("file.txt", "r") as f:
    content = f.read()           # Read entire file

with open("file.txt", "r") as f:
    lines = f.readlines()        # Read as list of lines

with open("file.txt", "r") as f:
    for line in f:               # Iterate line by line
        print(line.strip())

# Writing files
with open("output.txt", "w") as f:
    f.write("Hello, World!\n")
    f.write("Second line\n")

# Append to file
with open("output.txt", "a") as f:
    f.write("Appended line\n")

# Write multiple lines
lines = ["Line 1\n", "Line 2\n", "Line 3\n"]
with open("output.txt", "w") as f:
    f.writelines(lines)

# Binary files
with open("image.png", "rb") as f:
    data = f.read()

with open("copy.png", "wb") as f:
    f.write(data)

# Check if file exists
import os
if os.path.exists("file.txt"):
    print("File exists")
```
# Exception Handling
```python title='Try-except-finally'
# Basic exception handling
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Cannot divide by zero")

# Multiple exceptions
try:
    value = int("abc")
except (ValueError, TypeError) as e:
    print(f"Error: {e}")

# Catch all exceptions
try:
    risky_operation()
except Exception as e:
    print(f"An error occurred: {e}")

# Else clause (runs if no exception)
try:
    result = 10 / 2
except ZeroDivisionError:
    print("Error")
else:
    print(f"Result: {result}")

# Finally clause (always runs)
try:
    f = open("file.txt")
    content = f.read()
except FileNotFoundError:
    print("File not found")
finally:
    f.close()  # Always close file

# Raise exceptions
def validate_age(age):
    if age < 0:
        raise ValueError("Age cannot be negative")
    if age > 150:
        raise ValueError("Invalid age")
    return age

# Custom exceptions
class InvalidConfigError(Exception):
    pass

def load_config(path):
    if not path.endswith(".conf"):
        raise InvalidConfigError("Invalid config file extension")
```
# Modules and Imports
```python title='Importing modules'
# Import entire module
import os
import sys
import math

# Use with module prefix
files = os.listdir(".")
root = math.sqrt(16)

# Import specific items
from os import path, listdir
from math import sqrt, pi

# Import with alias
import numpy as np
import pandas as pd
from collections import Counter as C

# Import all (not recommended)
from math import *

# Import from package
from os.path import join, exists, dirname
from datetime import datetime, timedelta
```
# Common Standard Library Modules for Automation
## os - Operating System Interface
```python title='OS module for system operations'
import os

# Current directory
cwd = os.getcwd()

# Change directory
os.chdir("/tmp")

# List directory contents
files = os.listdir(".")
for file in files:
    print(file)

# Path operations
path = os.path.join("folder", "subfolder", "file.txt")
exists = os.path.exists(path)
is_file = os.path.isfile(path)
is_dir = os.path.isdir(path)
dirname = os.path.dirname(path)
basename = os.path.basename(path)

# Create directory
os.mkdir("new_folder")
os.makedirs("parent/child/grandchild")  # Create nested dirs

# Remove
os.remove("file.txt")        # Remove file
os.rmdir("empty_folder")     # Remove empty directory

# Environment variables
home = os.environ.get("HOME")
os.environ["MY_VAR"] = "value"

# Execute command (use subprocess instead for new code)
os.system("ls -la")
```
## sys - System-specific Parameters
```python title='Sys module for system info'
import sys

# Command-line arguments
script_name = sys.argv[0]
args = sys.argv[1:]  # All arguments except script name

# Exit program
sys.exit(0)          # Exit with code 0 (success)
sys.exit("Error!")   # Exit with message

# Python version
print(sys.version)
print(sys.version_info)

# Module search path
print(sys.path)

# Standard streams
sys.stdout.write("Output\n")
sys.stderr.write("Error\n")

# Platform information
print(sys.platform)  # 'linux', 'darwin', 'win32'
```
## pathlib - Object-Oriented Filesystem Paths
```python title='Pathlib for modern path operations'
from pathlib import Path

# Create Path objects
p = Path("folder/file.txt")
home = Path.home()
cwd = Path.cwd()

# Path operations
parent = p.parent
name = p.name
stem = p.stem        # Filename without extension
suffix = p.suffix    # File extension

# Check existence
if p.exists():
    print("Exists")

if p.is_file():
    print("Is a file")

if p.is_dir():
    print("Is a directory")

# Read/write files
content = p.read_text()
p.write_text("Hello, World!")

# List directory
for item in Path(".").iterdir():
    print(item)

# Glob pattern matching
for py_file in Path(".").glob("*.py"):
    print(py_file)

# Recursive glob
for py_file in Path(".").rglob("*.py"):
    print(py_file)

# Create directories
Path("new_folder").mkdir(exist_ok=True)
Path("parent/child").mkdir(parents=True, exist_ok=True)
```
## datetime - Date and Time
```python title='Datetime for time operations'
from datetime import datetime, timedelta, date, time

# Current date and time
now = datetime.now()
today = date.today()
current_time = datetime.now().time()

# Create specific datetime
dt = datetime(2024, 12, 25, 15, 30, 0)
d = date(2024, 12, 25)
t = time(15, 30, 0)

# Format datetime
formatted = now.strftime("%Y-%m-%d %H:%M:%S")
formatted = now.strftime("%B %d, %Y")  # "January 06, 2025"

# Parse datetime
dt = datetime.strptime("2024-12-25", "%Y-%m-%d")

# Arithmetic
tomorrow = today + timedelta(days=1)
week_ago = now - timedelta(weeks=1)
in_2_hours = now + timedelta(hours=2)

# Compare dates
if today > date(2024, 1, 1):
    print("After January 1, 2024")

# Extract components
year = now.year
month = now.month
day = now.day
hour = now.hour
weekday = now.weekday()  # 0=Monday, 6=Sunday
```
# Practical Automation Example
```python title='Complete file backup script'
#!/usr/bin/env python3
"""
Automated backup script with compression and rotation.
"""

import os
import sys
import shutil
import tarfile
from datetime import datetime
from pathlib import Path

def create_backup(source_dir, backup_dir, max_backups=5):
    """
    Create compressed backup of source directory.

    Args:
        source_dir: Directory to backup
        backup_dir: Where to store backups
        max_backups: Maximum number of backups to keep
    """
    # Validate source
    source = Path(source_dir)
    if not source.exists():
        print(f"Error: {source_dir} does not exist")
        sys.exit(1)

    # Create backup directory
    backup = Path(backup_dir)
    backup.mkdir(parents=True, exist_ok=True)

    # Generate backup filename with timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"backup_{source.name}_{timestamp}.tar.gz"
    backup_path = backup / backup_name

    print(f"Creating backup: {backup_path}")

    # Create compressed archive
    with tarfile.open(backup_path, "w:gz") as tar:
        tar.add(source, arcname=source.name)

    print(f"Backup created: {backup_path}")
    print(f"Size: {backup_path.stat().st_size / 1024 / 1024:.2f} MB")

    # Rotate old backups
    rotate_backups(backup, max_backups)

def rotate_backups(backup_dir, max_backups):
    """Remove old backups, keeping only the latest max_backups."""
    backups = sorted(backup_dir.glob("backup_*.tar.gz"))

    if len(backups) > max_backups:
        to_remove = backups[:-max_backups]
        for old_backup in to_remove:
            print(f"Removing old backup: {old_backup.name}")
            old_backup.unlink()

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: backup.py <source_dir> <backup_dir> [max_backups]")
        sys.exit(1)

    source = sys.argv[1]
    backup = sys.argv[2]
    max_backups = int(sys.argv[3]) if len(sys.argv) > 3 else 5

    create_backup(source, backup, max_backups)
```
***
# References
1. Python Documentation - https://docs.python.org/3/
2. Python Tutorial - https://docs.python.org/3/tutorial/
3. Real Python - https://realpython.com/
4. Python Standard Library - https://docs.python.org/3/library/
5. PEP 8 - Style Guide for Python Code - https://pep8.org/
