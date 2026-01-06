#python #regex #text-processing #parsing #automation #scripting
# Regular Expressions (regex)
- Regular expressions provide powerful <mark class="hltr-yellow">pattern matching and text manipulation</mark> capabilities.
- Python's `re` module implements regex functionality.
## Basic Pattern Matching
```python title='Simple regex patterns'
import re

text = "The price is $49.99"

# Search for pattern (returns Match object or None)
match = re.search(r'\$\d+\.\d+', text)
if match:
    print(match.group())  # $49.99
    print(match.start())  # Position: 13
    print(match.end())    # Position: 19

# Match at beginning of string
match = re.match(r'The', text)
if match:
    print("Starts with 'The'")

# Check if pattern exists
if re.search(r'\d+', text):
    print("Contains numbers")

# Find all matches
numbers = re.findall(r'\d+', text)  # ['49', '99']

# Find all with position info
for match in re.finditer(r'\d+', text):
    print(f"Found {match.group()} at {match.start()}")
```
## Common Regex Patterns
```python title='Frequently used regex patterns'
import re

# Email validation
email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
email = "user@example.com"
is_valid = bool(re.match(email_pattern, email))

# Phone number (US format)
phone_pattern = r'\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}'
phones = re.findall(phone_pattern, "Call (555) 123-4567 or 555.987.6543")

# IP address
ip_pattern = r'\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'
ips = re.findall(ip_pattern, "Server IPs: 192.168.1.1, 10.0.0.1")

# URL
url_pattern = r'https?://(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b[-a-zA-Z0-9()@:%_\+.~#?&//=]*'
urls = re.findall(url_pattern, text)

# Date (YYYY-MM-DD)
date_pattern = r'\d{4}-\d{2}-\d{2}'
dates = re.findall(date_pattern, "Events on 2024-01-15 and 2024-12-25")

# Time (HH:MM:SS)
time_pattern = r'\d{2}:\d{2}:\d{2}'
times = re.findall(time_pattern, "Logged at 14:30:00 and 18:45:30")

# Hashtags
hashtag_pattern = r'#\w+'
hashtags = re.findall(hashtag_pattern, "Check #python and #regex tags")

# HTML tags
tag_pattern = r'<([a-z]+).*?>(.*?)</\1>'
tags = re.findall(tag_pattern, "<p>Text</p><div>Content</div>", re.DOTALL)
```
## Regex Special Characters
```python title='Regex metacharacters and their meanings'
# Character classes
# \d - Digit [0-9]
# \D - Non-digit
# \w - Word character [a-zA-Z0-9_]
# \W - Non-word character
# \s - Whitespace [ \t\n\r\f\v]
# \S - Non-whitespace
# .  - Any character except newline

# Anchors
# ^  - Start of string
# $  - End of string
# \b - Word boundary
# \B - Non-word boundary

# Quantifiers
# *  - 0 or more
# +  - 1 or more
# ?  - 0 or 1 (optional)
# {n} - Exactly n times
# {n,} - n or more times
# {n,m} - Between n and m times

# Examples
text = "The email is user123@example.com"

# Extract username (word characters before @)
username = re.search(r'(\w+)@', text).group(1)  # user123

# Extract domain
domain = re.search(r'@([\w.]+)', text).group(1)  # example.com

# Match 2-4 digits
code = re.search(r'\d{2,4}', text).group()  # 123
```
## Grouping and Capturing
```python title='Capture groups in regex'
import re

text = "John Doe (john.doe@example.com)"

# Capture groups with parentheses
pattern = r'(\w+)\s+(\w+)\s+\(([^)]+)\)'
match = re.search(pattern, text)

if match:
    first_name = match.group(1)  # John
    last_name = match.group(2)   # Doe
    email = match.group(3)       # john.doe@example.com
    full_match = match.group(0)  # Entire match

# Named groups
pattern = r'(?P<first>\w+)\s+(?P<last>\w+)\s+\((?P<email>[^)]+)\)'
match = re.search(pattern, text)

if match:
    print(match.group('first'))  # John
    print(match.group('last'))   # Doe
    print(match.group('email'))  # john.doe@example.com
    print(match.groupdict())     # {'first': 'John', 'last': 'Doe', 'email': '...'}

# Non-capturing group
pattern = r'(?:Mr|Mrs|Ms)\.\s+(\w+)'
match = re.search(pattern, "Mr. Smith")
print(match.group(1))  # Smith (group 1, not 2)
```
## String Substitution
```python title='Replace text using regex'
import re

text = "The price is $49.99 and $99.99"

# Simple replacement
result = re.sub(r'\$', 'USD ', text)
# "The price is USD 49.99 and USD 99.99"

# Replace with captured groups
text = "2024-01-15"
result = re.sub(r'(\d{4})-(\d{2})-(\d{2})', r'\2/\3/\1', text)
# "01/15/2024"

# Replace with function
def increment_price(match):
    price = float(match.group(1))
    return f"${price * 1.1:.2f}"

text = "Item costs $49.99"
result = re.sub(r'\$(\d+\.\d+)', increment_price, text)
# "Item costs $54.99"

# Replace with count
text = "cat cat cat dog"
result = re.sub(r'cat', 'dog', text, count=2)
# "dog dog cat dog"

# Split by pattern
text = "one,two;three:four"
parts = re.split(r'[,;:]', text)  # ['one', 'two', 'three', 'four']
```
## Compiled Patterns
```python title='Compile regex for better performance'
import re

# Compile pattern for reuse
pattern = re.compile(r'\b\d{3}-\d{3}-\d{4}\b')

# Use compiled pattern
text1 = "Call 555-123-4567"
text2 = "Or 555-987-6543"

match1 = pattern.search(text1)
match2 = pattern.search(text2)

# With flags
pattern = re.compile(r'hello', re.IGNORECASE | re.MULTILINE)

# Common flags:
# re.IGNORECASE (re.I) - Case-insensitive
# re.MULTILINE (re.M) - ^ and $ match line boundaries
# re.DOTALL (re.S) - . matches newline
# re.VERBOSE (re.X) - Allow comments and whitespace
```
# String Parsing
## CSV Parsing
```python title='Parse CSV data'
import csv
import io

# Parse CSV string
csv_data = """name,age,city
Alice,30,NYC
Bob,25,LA
Charlie,35,Chicago"""

reader = csv.DictReader(io.StringIO(csv_data))
for row in reader:
    print(f"{row['name']}: {row['age']} years, {row['city']}")

# Parse with different delimiter
tsv_data = "name\tage\tcity\nAlice\t30\tNYC"
reader = csv.DictReader(io.StringIO(tsv_data), delimiter='\t')

# Parse without header
data = "Alice,30,NYC\nBob,25,LA"
reader = csv.reader(io.StringIO(data))
for row in reader:
    name, age, city = row
    print(f"{name}: {age}")
```
## JSON Parsing
```python title='Parse JSON data'
import json

# Parse JSON string
json_str = '{"name": "Alice", "age": 30, "hobbies": ["reading", "coding"]}'
data = json.loads(json_str)

print(data['name'])  # Alice
print(data['hobbies'][0])  # reading

# Handle parsing errors
try:
    data = json.loads('invalid json')
except json.JSONDecodeError as e:
    print(f"JSON parse error: {e}")

# Pretty print JSON
print(json.dumps(data, indent=2))
```
## XML Parsing
```python title='Parse XML data'
import xml.etree.ElementTree as ET

xml_data = """
<users>
    <user id="1">
        <name>Alice</name>
        <email>alice@example.com</email>
    </user>
    <user id="2">
        <name>Bob</name>
        <email>bob@example.com</email>
    </user>
</users>
"""

root = ET.fromstring(xml_data)

# Find all users
for user in root.findall('user'):
    user_id = user.get('id')
    name = user.find('name').text
    email = user.find('email').text
    print(f"User {user_id}: {name} ({email})")

# XPath-like queries
first_name = root.find('.//name').text  # Alice
all_emails = [elem.text for elem in root.findall('.//email')]
```
## YAML Parsing
```python title='Parse YAML data'
# pip install pyyaml

import yaml

yaml_data = """
database:
  host: localhost
  port: 5432
  credentials:
    username: admin
    password: secret

servers:
  - name: web1
    ip: 192.168.1.10
  - name: web2
    ip: 192.168.1.11
"""

data = yaml.safe_load(yaml_data)

print(data['database']['host'])  # localhost
print(data['servers'][0]['name'])  # web1

# Write YAML
config = {
    'version': '1.0',
    'settings': {
        'debug': True,
        'timeout': 30
    }
}

yaml_str = yaml.dump(config, default_flow_style=False)
```
# Log File Parsing
```python title='Parse and analyze log files'
import re
from collections import Counter
from datetime import datetime

# Apache/Nginx access log pattern
log_pattern = r'(\S+) - - \[(.*?)\] "(\S+) (.*?) (\S+)" (\d+) (\d+)'

def parse_access_log(log_file):
    """Parse Apache/Nginx access log."""
    ips = []
    methods = []
    status_codes = []
    paths = []

    with open(log_file) as f:
        for line in f:
            match = re.search(log_pattern, line)
            if match:
                ip = match.group(1)
                timestamp = match.group(2)
                method = match.group(3)
                path = match.group(4)
                status = match.group(6)

                ips.append(ip)
                methods.append(method)
                status_codes.append(status)
                paths.append(path)

    return {
        'top_ips': Counter(ips).most_common(10),
        'methods': Counter(methods),
        'status_codes': Counter(status_codes),
        'top_paths': Counter(paths).most_common(10)
    }

# Python log parsing
def parse_python_log(log_file, level='ERROR'):
    """Extract log entries of specific level."""
    pattern = rf'^(\d{{4}}-\d{{2}}-\d{{2}} \d{{2}}:\d{{2}}:\d{{2}}),\d+ - ({level}) - (.*)$'
    errors = []

    with open(log_file) as f:
        for line in f:
            match = re.match(pattern, line)
            if match:
                timestamp = match.group(1)
                message = match.group(3)
                errors.append((timestamp, message))

    return errors

# Syslog parsing
def parse_syslog(log_file):
    """Parse syslog format."""
    pattern = r'(\w+ \d+ \d+:\d+:\d+) (\S+) (\S+): (.*)'
    entries = []

    with open(log_file) as f:
        for line in f:
            match = re.match(pattern, line)
            if match:
                timestamp = match.group(1)
                host = match.group(2)
                process = match.group(3)
                message = match.group(4)
                entries.append({
                    'timestamp': timestamp,
                    'host': host,
                    'process': process,
                    'message': message
                })

    return entries
```
# Text Processing Utilities
## Word Frequency Analysis
```python title='Analyze word frequency in text'
import re
from collections import Counter

def word_frequency(text, top_n=10):
    """Count word frequency in text."""
    # Convert to lowercase and extract words
    words = re.findall(r'\b\w+\b', text.lower())

    # Remove common words (stopwords)
    stopwords = {'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for'}
    words = [w for w in words if w not in stopwords]

    # Count frequency
    freq = Counter(words)
    return freq.most_common(top_n)

text = """
Python is a high-level programming language.
Python supports multiple programming paradigms.
Python is widely used for automation and scripting.
"""

top_words = word_frequency(text, top_n=5)
for word, count in top_words:
    print(f"{word}: {count}")
```
## Text Cleaning
```python title='Clean and normalize text'
import re
import string

def clean_text(text):
    """Clean and normalize text."""
    # Convert to lowercase
    text = text.lower()

    # Remove URLs
    text = re.sub(r'http\S+|www\S+', '', text)

    # Remove email addresses
    text = re.sub(r'\S+@\S+', '', text)

    # Remove HTML tags
    text = re.sub(r'<[^>]+>', '', text)

    # Remove punctuation
    text = text.translate(str.maketrans('', '', string.punctuation))

    # Remove extra whitespace
    text = re.sub(r'\s+', ' ', text).strip()

    return text

dirty_text = "Check out https://example.com or email me@example.com!!! "
clean = clean_text(dirty_text)
print(clean)  # "check out or email"
```
## Template Processing
```python title='Process text templates'
from string import Template

# Simple variable substitution
template = Template("Hello, $name! Welcome to $place.")
result = template.substitute(name="Alice", place="Python")

# Safe substitution (no error if variable missing)
template = Template("Hello, $name! Welcome to $place.")
result = template.safe_substitute(name="Alice")  # $place remains

# Custom delimiter
class PercentTemplate(Template):
    delimiter = '%'

template = PercentTemplate("Hello, %name!")
result = template.substitute(name="Alice")

# Format strings (recommended for complex formatting)
template = "Hello, {name}! You are {age} years old."
result = template.format(name="Alice", age=30)

# f-strings (Python 3.6+)
name = "Alice"
age = 30
result = f"Hello, {name}! You are {age} years old."
```
# Practical Text Processing Examples
## Example 1: Log Analyzer
```python title='Comprehensive log analysis tool'
#!/usr/bin/env python3
"""Analyze web server logs."""

import re
from collections import Counter, defaultdict
from datetime import datetime

class LogAnalyzer:
    def __init__(self, log_file):
        self.log_file = log_file
        self.pattern = r'(\S+) - - \[(.*?)\] "(\S+) (.*?) (\S+)" (\d+) (\d+)'

    def analyze(self):
        """Analyze log file and return statistics."""
        ips = []
        timestamps = []
        methods = []
        paths = []
        status_codes = []
        bytes_sent = []
        errors = []

        with open(self.log_file) as f:
            for line_num, line in enumerate(f, 1):
                match = re.search(self.pattern, line)
                if match:
                    ip = match.group(1)
                    timestamp_str = match.group(2)
                    method = match.group(3)
                    path = match.group(4)
                    status = match.group(6)
                    bytes_val = int(match.group(7))

                    ips.append(ip)
                    methods.append(method)
                    paths.append(path)
                    status_codes.append(status)
                    bytes_sent.append(bytes_val)

                    # Parse timestamp
                    try:
                        ts = datetime.strptime(
                            timestamp_str.split()[0],
                            '%d/%b/%Y:%H:%M:%S'
                        )
                        timestamps.append(ts)
                    except:
                        pass

                    # Track errors (4xx, 5xx)
                    if status.startswith(('4', '5')):
                        errors.append((timestamp_str, ip, path, status))

        return {
            'total_requests': len(ips),
            'unique_ips': len(set(ips)),
            'top_ips': Counter(ips).most_common(10),
            'methods': dict(Counter(methods)),
            'status_codes': dict(Counter(status_codes)),
            'top_paths': Counter(paths).most_common(20),
            'total_bytes': sum(bytes_sent),
            'avg_bytes': sum(bytes_sent) / len(bytes_sent) if bytes_sent else 0,
            'errors': errors,
            'requests_by_hour': self._group_by_hour(timestamps)
        }

    def _group_by_hour(self, timestamps):
        """Group requests by hour."""
        by_hour = defaultdict(int)
        for ts in timestamps:
            hour = ts.strftime('%Y-%m-%d %H:00')
            by_hour[hour] += 1
        return dict(sorted(by_hour.items()))

    def print_report(self):
        """Print analysis report."""
        stats = self.analyze()

        print("=" * 60)
        print("LOG ANALYSIS REPORT")
        print("=" * 60)
        print(f"\nTotal Requests: {stats['total_requests']:,}")
        print(f"Unique IPs: {stats['unique_ips']:,}")
        print(f"Total Data Transferred: {stats['total_bytes'] / (1024**2):.2f} MB")

        print("\n--- Top 10 IP Addresses ---")
        for ip, count in stats['top_ips']:
            print(f"{ip:15s} {count:6,} requests")

        print("\n--- HTTP Methods ---")
        for method, count in stats['methods'].items():
            print(f"{method:6s} {count:6,}")

        print("\n--- Status Codes ---")
        for code, count in sorted(stats['status_codes'].items()):
            print(f"{code:3s} {count:6,}")

        print("\n--- Top 20 Requested Paths ---")
        for path, count in stats['top_paths']:
            print(f"{count:6,} {path}")

        if stats['errors']:
            print(f"\n--- Errors ({len(stats['errors'])}) ---")
            for ts, ip, path, status in stats['errors'][:10]:
                print(f"[{ts}] {ip:15s} {status} {path}")

# Usage
# analyzer = LogAnalyzer('/var/log/nginx/access.log')
# analyzer.print_report()
```
## Example 2: Configuration File Parser
```python title='Parse custom configuration format'
#!/usr/bin/env python3
"""Parse configuration files with sections."""

import re
from collections import defaultdict

def parse_config(config_file):
    """
    Parse INI-style configuration file.

    [section]
    key = value
    key2 = value2
    """
    config = defaultdict(dict)
    current_section = None

    with open(config_file) as f:
        for line_num, line in enumerate(f, 1):
            line = line.strip()

            # Skip empty lines and comments
            if not line or line.startswith('#'):
                continue

            # Section header
            section_match = re.match(r'\[([^\]]+)\]', line)
            if section_match:
                current_section = section_match.group(1)
                continue

            # Key-value pair
            kv_match = re.match(r'([^=]+?)\s*=\s*(.+)', line)
            if kv_match and current_section:
                key = kv_match.group(1).strip()
                value = kv_match.group(2).strip()

                # Handle quotes
                if value.startswith('"') and value.endswith('"'):
                    value = value[1:-1]

                config[current_section][key] = value

    return dict(config)

# Usage
# config = parse_config('app.conf')
# print(config['database']['host'])
```
## Example 3: Email Extractor
```python title='Extract and validate email addresses'
#!/usr/bin/env python3
"""Extract email addresses from text."""

import re

def extract_emails(text):
    """Extract all valid email addresses from text."""
    # Comprehensive email regex
    pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    emails = re.findall(pattern, text)
    return list(set(emails))  # Remove duplicates

def validate_email(email):
    """Validate email address format."""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))

def extract_emails_from_file(filename):
    """Extract emails from file."""
    with open(filename) as f:
        text = f.read()
    return extract_emails(text)

# Usage
text = """
Contact us at support@example.com or sales@example.org.
For urgent matters, reach out to admin@company.co.uk
"""

emails = extract_emails(text)
for email in emails:
    print(email)
```
## Example 4: Code Comment Stripper
```python title='Remove comments from source code'
#!/usr/bin/env python3
"""Strip comments from source code files."""

import re

def strip_python_comments(code):
    """Remove comments from Python code."""
    # Remove single-line comments
    code = re.sub(r'#.*$', '', code, flags=re.MULTILINE)

    # Remove docstrings
    code = re.sub(r'""".*?"""', '', code, flags=re.DOTALL)
    code = re.sub(r"'''.*?'''", '', code, flags=re.DOTALL)

    # Remove empty lines
    lines = [line for line in code.split('\n') if line.strip()]
    return '\n'.join(lines)

def strip_c_comments(code):
    """Remove comments from C/C++/Java code."""
    # Remove single-line comments
    code = re.sub(r'//.*$', '', code, flags=re.MULTILINE)

    # Remove multi-line comments
    code = re.sub(r'/\*.*?\*/', '', code, flags=re.DOTALL)

    return code

# Usage
python_code = """
# This is a comment
def hello():
    '''This is a docstring'''
    print("Hello")  # Inline comment
"""

clean_code = strip_python_comments(python_code)
```
***
# References
1. `re` - Regular expression operations - https://docs.python.org/3/library/re.html
2. `csv` - CSV File Reading and Writing - https://docs.python.org/3/library/csv.html
3. `json` - JSON encoder and decoder - https://docs.python.org/3/library/json.html
4. `xml.etree.ElementTree` - The ElementTree XML API - https://docs.python.org/3/library/xml.etree.elementtree.html
5. PyYAML - YAML parser and emitter - https://pyyaml.org/
6. Regular Expressions 101 - https://regex101.com/
7. RegExr - Learn, Build, & Test RegEx - https://regexr.com/
