#linux #shell #unix #ubuntu #operating-system #fedora #centos-stream #rhel #bash 
# Basic Concepts
- `cut` is a command-line utility that <mark class="hltr-yellow">extracts sections</mark> (or "cuts" columns) from each line of a file or piped data. It's particularly useful for processing structured, column-based data like CSVs or log files.
- It operates on a line-by-line basis and can select portions of a line based on bytes, characters, or fields delimited by a specific character.
### Execution Model

```mermaid
graph LR
    A[Input Stream] --> B{Apply cut options};
    B -- "-b / -c / -f" --> C[Extract Selected Portions];
    C --> D[Output Stream];
```

- **Selection**: The core function of `cut` is to select data using one of three modes: bytes (`-b`), characters (`-c`), or fields (`-f`).
- **Delimiter**: When using field-based selection, a delimiter character (like a comma or tab) is used to separate the fields.
# Basic Syntax
```Shell title="cut command structure"
cut [OPTION]... [FILE]...
```

**Common Options**:
- `-b LIST`: Select only these bytes.
- `-c LIST`: Select only these characters.
- `-f LIST`: Select only these fields.
- `-d DELIMITER`: Use DELIMITER instead of TAB for field delimiter.
- `--complement`: Complement the set of selected bytes, characters or fields.
- `-s`: Do not print lines not containing delimiters (for field-based cutting).

`LIST` can be a single number, a comma-separated list of numbers, or a range of numbers.
- `N`: The Nth byte, character, or field.
- `N-`: From the Nth byte, character, or field, to the end of the line.
- `N-M`: From the Nth to the Mth (included) byte, character, or field.
- `-M`: From the first to the Mth (included) byte, character, or field.
## Byte-based Selection (`-b`)
- Extracts specific bytes from a line. Useful for fixed-width data.
```Shell title="Cutting by byte"
# Extract the first 4 bytes of each line
cut -b 1-4 /etc/passwd

# Extract bytes 10 through 15
cut -b 10-15 /etc/passwd

# Extract the 5th byte and the 10th byte
cut -b 5,10 /etc/passwd

# Extract from the 3rd byte to the end of the line
cut -b 3- /etc/passwd
```
## Character-based Selection (`-c`)
- Extracts specific characters from a line. This is often more intuitive than bytes, especially with multi-byte characters.
```Shell title="Cutting by character"
# Extract the first 10 characters of each line
ls -l | cut -c 1-10

# Extract the 3rd character from each line in a file
cut -c 3 /etc/passwd

# Extract characters 1 to 5 and 10 to 15
cut -c 1-5,10-15 /etc/passwd
```
## Field-based Selection (`-f`)
- This is the most common use case. It extracts entire fields based on a delimiter. The default delimiter is a Tab character.
```Shell title="Cutting by field with default Tab delimiter"
# /etc/group is often tab-delimited
# Get the group name (first field)
cut -f 1 /etc/group

# Get the group name and group ID (fields 1 and 3)
cut -f 1,3 /etc/group
```
### Using a Custom Delimiter (`-d`)
- The `-d` option is used to specify a different delimiter. This is essential for formats like CSV.
```Shell title="Cutting by field with custom delimiter"
# Get usernames (field 1) from /etc/passwd using ':' as a delimiter
cut -d ':' -f 1 /etc/passwd

# Get username and home directory (fields 1 and 6)
cut -d ':' -f 1,6 /etc/passwd

# Get all fields from the 5th to the end
cut -d ':' -f 5- /etc/passwd
```
# Practical Use Cases
## Log File Analysis
```Shell title="Parsing an access log"
# Given a log line: 192.168.1.1 - - [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326

# Extract the IP address (first field, space delimited)
echo '192.168.1.1 - - ...' | cut -d ' ' -f 1

# Extract the requested path (field 7, space delimited)
echo '192.168.1.1 - - ... "GET /path/to/file ..."' | cut -d '"' -f 2 | cut -d ' ' -f 2
```
## CSV File Processing
```Shell title="Extracting data from a CSV"
# data.csv content:
# name,department,salary
# john,sales,50000
# jane,hr,60000
# peter,engineering,70000

# Get all names (first column)
cut -d ',' -f 1 data.csv

# Get names and salaries (columns 1 and 3)
cut -d ',' -f 1,3 data.csv
```
## System Administration
```Shell title="Working with system commands"
# List running processes and show only the PID
ps aux | awk 'NR>1' | tr -s ' ' | cut -d ' ' -f 2

# List mounted filesystems and their mount points
df -h | tr -s ' ' | cut -d ' ' -f 1,6

# Check the shells of all users
getent passwd | cut -d ':' -f 1,7
```
# Advanced Techniques
## Complementing a Selection
- The `--complement` flag inverts the selection, showing everything *except* what is specified.
```Shell title="Inverting the cut"
# Show all fields except the first one
cut -d ':' --complement -f 1 /etc/passwd

# Show all characters except the first 10
ls -l | cut -c 1-10 --complement
```
## Suppressing Lines without Delimiters (`-s`)
- The `-s` option prevents `cut` from printing lines that do not contain the specified delimiter when using field-based selection.
```Shell title="Handling lines without delimiters"
# file_with_mixed_lines.txt:
# field1:field2
# just a plain line
# fieldA:fieldB

# Without -s, the plain line is printed
cut -d ':' -f 1 file_with_mixed_lines.txt
# Output:
# field1
# just a plain line
# fieldA

# With -s, the plain line is suppressed
cut -s -d ':' -f 1 file_with_mixed_lines.txt
# Output:
# field1
# fieldA
```
# Common Pitfalls
## Distinguishing Tabs from Spaces
- The default delimiter is a single Tab character. If a file appears to have columns but is formatted with multiple spaces, `cut -f` will not work as expected.
- **Solution**: Use `tr -s ' '` to squeeze multiple spaces into a single space, then use `cut -d ' '`.

```Shell title="Handling space-delimited files"
# ls -l output uses multiple spaces
# This will likely fail to get the 9th field correctly
ls -l | cut -f 9

# Squeeze spaces first, then cut
ls -l | tr -s ' ' | cut -d ' ' -f 9
```

## Delimiter is Part of the Field
- If the delimiter character appears within a field (e.g., a comma in a quoted CSV field), `cut` will misinterpret it.
- `cut` is not sophisticated enough to handle quoting rules.
- **Solution**: Use a more powerful tool like `awk` or a dedicated CSV parser for complex formats.

```Shell title="Limitation with complex CSV"
# "Doe, John",sales,"50,000"
# cut will split "Doe, John" and "50,000" incorrectly
echo '"Doe, John",sales,"50,000"' | cut -d ',' -f 1,3
# Output: "Doe   "50

# awk is a better tool for this
echo '"Doe, John",sales,"50,000"' | awk -F, '{print $1, $3}'
# Output: "Doe  John" "50 000" (awk also has limitations with quoted delimiters)
```
***
# References
1. GNU `cut` Manual: https://www.gnu.org/software/coreutils/manual/html_node/cut-invocation.html
2. POSIX `cut` Specification.
