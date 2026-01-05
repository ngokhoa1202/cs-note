#linux #unix #shell #http #https #download #web #networking #shell

- `wget` (Web GET) downloads files from the web via HTTP, HTTPS, and FTP.
- <mark class="hltr-yellow">Non-interactive network downloader optimized for unstable connections</mark>.
- Supports recursive downloads, mirror websites, and resume interrupted transfers.

# Basic Syntax

```Shell title='wget command syntax'
wget [options] [URL...]
```

## Simple Download
```Shell title='Basic file download'
# Download single file
wget https://example.com/file.pdf

# Download with original filename
wget https://example.com/document.pdf
# Saves as: document.pdf

# Download multiple files
wget https://example.com/file1.pdf https://example.com/file2.pdf

# Download from URL list
wget -i urls.txt
```

# Download Options

## Save with Custom Filename
```Shell title='Specify output filename'
# Save with custom name
wget -O myfile.pdf https://example.com/document.pdf

# Save to stdout (pipe to other commands)
wget -O - https://example.com/data.json | jq .

# Save to specific directory
wget -P /downloads https://example.com/file.pdf
```

## Resume Interrupted Downloads
```Shell title='Continue partial downloads'
# Resume download
wget -c https://example.com/largefile.iso

# Resume with timeout protection
wget -c -t 0 https://example.com/largefile.iso
# -t 0: Infinite retries
```

## Background Downloads
```Shell title='Download in background'
# Download in background
wget -b https://example.com/largefile.zip
# Output: Continuing in background, pid 12345
# Output will be written to 'wget-log'

# Background with custom log
wget -b -o download.log https://example.com/file.zip

# Check background download progress
tail -f wget-log
```

## Download with Progress Display
```Shell title='Control progress output'
# Show progress bar (default)
wget https://example.com/file.zip

# Quiet mode (no output)
wget -q https://example.com/file.zip

# Show only errors
wget -nv https://example.com/file.zip
# nv = no verbose

# Detailed verbose output
wget -v https://example.com/file.zip
```

# Recursive Downloads

## Download Entire Website
```Shell title='Mirror website locally'
# Mirror website with default settings
wget --mirror https://example.com

# Mirror with better defaults
wget --mirror \
  --convert-links \
  --adjust-extension \
  --page-requisites \
  --no-parent \
  https://example.com

# Short form
wget -mkEpnp https://example.com
# m: mirror
# k: convert links
# E: adjust extension
# p: page requisites
# np: no parent
```

## Control Recursion Depth
```Shell title='Limit recursive download depth'
# Download page and one level of links
wget -r -l 1 https://example.com

# Download up to 3 levels deep
wget -r -l 3 https://example.com

# Infinite recursion (default for -r)
wget -r -l inf https://example.com

# Download page only (no recursion)
wget -l 0 https://example.com/page.html
```

## Filter by File Type
```Shell title='Download specific file types'
# Accept only PDFs
wget -r -A pdf https://example.com/documents/

# Accept multiple types
wget -r -A pdf,doc,docx https://example.com/files/

# Reject certain types
wget -r -R jpg,gif,png https://example.com/

# Case-insensitive matching
wget -r -A pdf,PDF https://example.com/
```

## Practical Use Case: Download Documentation
```Shell title='Download project documentation'
# Download all PDFs from documentation site
wget -r -l 2 \
  -A pdf \
  -P ~/Documents/project-docs \
  https://docs.example.com/

# Download static website for offline viewing
wget --mirror \
  --convert-links \
  --adjust-extension \
  --page-requisites \
  --no-parent \
  -P ~/offline-docs \
  https://docs.example.com/
```

# Authentication

## HTTP Authentication
```Shell title='Basic and digest authentication'
# HTTP Basic authentication
wget --user=username --password=password https://example.com/protected

# Prompt for password
wget --user=username --ask-password https://example.com/protected

# HTTP authentication from file
echo "username" > .wgetrc
echo "password" >> .wgetrc
chmod 600 .wgetrc
wget https://example.com/protected
```

## FTP Authentication
```Shell title='FTP login'
# FTP with credentials
wget ftp://username:password@ftp.example.com/file.tar.gz

# FTP with credentials in URL
wget ftp://user:pass@ftp.example.com/path/to/file.zip

# Anonymous FTP
wget ftp://ftp.example.com/pub/file.tar.gz
```

# Rate Limiting and Bandwidth

## Limit Download Speed
```Shell title='Control bandwidth usage'
# Limit to 100KB/s
wget --limit-rate=100k https://example.com/file.zip

# Limit to 1MB/s
wget --limit-rate=1m https://example.com/largefile.iso

# No limit (use all available bandwidth)
wget --limit-rate=0 https://example.com/file.zip
```

## Wait Between Requests
```Shell title='Add delays between downloads'
# Wait 2 seconds between downloads
wget -w 2 -r https://example.com/files/

# Random wait between 0.5 and 1.5 seconds
wget --random-wait -r https://example.com/

# Fixed wait time (10 seconds)
wget -w 10 -r https://example.com/files/
```

# HTTP Headers and User Agent

## Custom User Agent
```Shell title='Set User-Agent header'
# Specify custom user agent
wget --user-agent="Mozilla/5.0" https://example.com/file.zip

# Pretend to be Firefox
wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:91.0)" \
  https://example.com/

# Short form
wget -U "MyDownloader/1.0" https://example.com/file.zip
```

## HTTP Headers
```Shell title='Add custom HTTP headers'
# Add custom header
wget --header="Authorization: Bearer token123" \
  https://api.example.com/file.zip

# Multiple headers
wget --header="Authorization: Bearer token" \
  --header="X-Custom-Header: value" \
  https://api.example.com/protected

# Referer header
wget --referer="https://example.com" \
  https://example.com/download/file.zip
```

## Cookie Support
```Shell title='Handle cookies'
# Save cookies to file
wget --save-cookies cookies.txt \
  --keep-session-cookies \
  https://example.com/login

# Load and use cookies
wget --load-cookies cookies.txt \
  https://example.com/protected-page

# Save and load cookies
wget --save-cookies cookies.txt \
  --load-cookies cookies.txt \
  --keep-session-cookies \
  https://example.com/
```

# Retry and Timeout Options

## Retry Configuration
```Shell title='Configure retry behavior'
# Retry up to 5 times
wget --tries=5 https://example.com/file.zip

# Infinite retries
wget --tries=0 https://example.com/unstable-server/file.zip
# Use with -c for resume capability

# Wait between retries
wget --tries=10 --waitretry=30 https://example.com/file.zip
# Waits 30 seconds between retries
```

## Timeout Settings
```Shell title='Set timeout values'
# DNS timeout (10 seconds)
wget --dns-timeout=10 https://example.com/file.zip

# Connection timeout (15 seconds)
wget --connect-timeout=15 https://example.com/file.zip

# Read timeout (20 seconds)
wget --read-timeout=20 https://example.com/file.zip

# Combined timeout settings
wget --dns-timeout=10 \
  --connect-timeout=15 \
  --read-timeout=20 \
  https://example.com/file.zip
```

# FTP Downloads

## FTP Options
```Shell title='Download from FTP servers'
# Anonymous FTP download
wget ftp://ftp.example.com/pub/file.tar.gz

# FTP with authentication
wget --ftp-user=username --ftp-password=password \
  ftp://ftp.example.com/file.tar.gz

# Passive FTP mode
wget --passive-ftp ftp://ftp.example.com/file.tar.gz

# Recursive FTP download
wget -r ftp://ftp.example.com/pub/directory/
```

## FTP Glob Patterns
```Shell title='Download matching FTP files'
# Download all files matching pattern
wget ftp://ftp.example.com/pub/*.tar.gz

# Download files with glob
wget "ftp://ftp.example.com/pub/file-[0-9]*.tar.gz"

# Disable glob
wget --no-glob "ftp://ftp.example.com/pub/file*.tar.gz"
```

# SSL/TLS Options

## Certificate Verification
```Shell title='Handle SSL certificates'
# Skip certificate verification (insecure!)
wget --no-check-certificate https://self-signed.example.com/file.zip

# Specify CA certificate
wget --ca-certificate=ca-bundle.crt https://secure.example.com/file.zip

# Specify CA directory
wget --ca-directory=/etc/ssl/certs https://example.com/file.zip

# Use specific TLS version
wget --secure-protocol=TLSv1_2 https://example.com/file.zip
```

## Client Certificates
```Shell title='Client certificate authentication'
# Client certificate and key
wget --certificate=client.pem \
  --certificate-type=PEM \
  --private-key=client-key.pem \
  https://api.example.com/file.zip

# Client certificate with password
wget --certificate=client.p12 \
  --certificate-type=PEM \
  --private-key-type=PEM \
  --ask-password \
  https://secure.example.com/
```

# Practical Use Cases

## Use Case 1: Batch Download from List
```Shell title='Download multiple files from list'
# Create urls.txt with URLs (one per line)
cat > urls.txt << 'EOF'
https://example.com/file1.pdf
https://example.com/file2.pdf
https://example.com/file3.pdf
EOF

# Download all files
wget -i urls.txt

# Download with custom directory
wget -P ~/downloads -i urls.txt

# Download with retry and continue
wget -i urls.txt -c --tries=0
```

## Use Case 2: Download Latest GitHub Release
```Shell title='Download GitHub releases'
# Download latest release
wget https://github.com/user/repo/releases/latest/download/app.tar.gz

# Download specific release
wget https://github.com/user/repo/releases/download/v1.2.3/app.tar.gz

# Download all assets from release
wget -r -l 1 -A tar.gz,zip \
  https://github.com/user/repo/releases/latest/
```

## Use Case 3: Mirror Website for Offline Viewing
```Shell title='Create offline website copy'
#!/bin/bash
# Mirror website script

SITE="https://docs.example.com"
OUTPUT_DIR="offline-docs"

wget --mirror \
  --convert-links \
  --adjust-extension \
  --page-requisites \
  --no-parent \
  --no-host-directories \
  --restrict-file-names=windows \
  -P "$OUTPUT_DIR" \
  "$SITE"

echo "Website mirrored to $OUTPUT_DIR"
```

## Use Case 4: Scheduled Downloads
```Shell title='Automated daily downloads'
#!/bin/bash
# Daily backup download script

DATE=$(date +%Y%m%d)
URL="https://backup.example.com/daily/backup-latest.tar.gz"
DEST="/backups/backup-$DATE.tar.gz"

# Download with resume capability
wget -c -O "$DEST" "$URL"

# Verify download
if [ $? -eq 0 ]; then
  echo "Backup downloaded successfully: $DEST"

  # Remove old backups (keep 7 days)
  find /backups -name "backup-*.tar.gz" -mtime +7 -delete
else
  echo "Download failed!" | mail -s "Backup Download Failed" admin@example.com
fi
```

## Use Case 5: Download with Bandwidth Management
```Shell title='Download during off-peak hours'
#!/bin/bash
# Smart download script

HOUR=$(date +%H)

# Off-peak hours (midnight to 6am): full speed
# Peak hours: limited to 100KB/s
if [ $HOUR -ge 0 ] && [ $HOUR -lt 6 ]; then
  RATE_LIMIT=""
else
  RATE_LIMIT="--limit-rate=100k"
fi

wget $RATE_LIMIT \
  -c \
  --tries=0 \
  https://example.com/largefile.iso
```

## Use Case 6: Verify Download Integrity
```Shell title='Download and verify checksums'
#!/bin/bash
# Download and verify file integrity

FILE="app-1.2.3.tar.gz"
URL="https://releases.example.com/$FILE"
CHECKSUM_URL="$URL.sha256"

# Download file and checksum
wget "$URL"
wget "$CHECKSUM_URL"

# Verify checksum
if sha256sum -c "$FILE.sha256"; then
  echo "✓ Checksum verified"
  exit 0
else
  echo "✗ Checksum verification failed!"
  rm "$FILE"
  exit 1
fi
```

## Use Case 7: Recursive Download with Filters
```Shell title='Download specific content recursively'
# Download all PDFs from documentation site
wget -r -l 3 \
  -A pdf \
  --reject-regex="(old|archive)" \
  -P ~/docs \
  https://docs.example.com/

# Download images only
wget -r -l 2 \
  -A jpg,jpeg,png,gif \
  --no-parent \
  -P ~/images \
  https://gallery.example.com/

# Download with domain restriction
wget -r -l 2 \
  -D example.com,cdn.example.com \
  https://example.com/
```

# Advanced Filtering

## Include/Exclude Directories
```Shell title='Filter by directory path'
# Include specific directories
wget -r -I /docs,/downloads https://example.com/

# Exclude specific directories
wget -r -X /admin,/private https://example.com/

# Exclude using regex
wget -r --reject-regex="(admin|private|temp)" https://example.com/
```

## Domain and Host Restrictions
```Shell title='Limit download scope'
# Download from specific domains only
wget -r -D example.com,cdn.example.com https://example.com/

# Exclude specific domains
wget -r --exclude-domains=ads.example.com https://example.com/

# Don't span to other hosts
wget -r --span-hosts=no https://example.com/
```

## File Size Limits
```Shell title='Filter by file size'
# Skip files larger than 10MB
wget -r --reject-size=10M https://example.com/files/

# Accept files up to 100MB
wget --max-filesize=100M https://example.com/largefile.zip
```

# Logging and Output

## Logging Options
```Shell title='Control log output'
# Log to custom file
wget -o download.log https://example.com/file.zip

# Append to existing log
wget -a download.log https://example.com/file.zip

# Verbose logging
wget -d -o verbose.log https://example.com/file.zip

# No logging
wget -nv -o /dev/null https://example.com/file.zip
```

## Output Formatting
```Shell title='Customize output display'
# Show progress with dots
wget --progress=dot https://example.com/file.zip

# Show progress bar
wget --progress=bar https://example.com/file.zip

# Detailed progress with bytes
wget --progress=bar:force https://example.com/file.zip

# Minimal output
wget -q --show-progress https://example.com/file.zip
```

# Wget Configuration File

## Using .wgetrc
```Shell title='Configure wget defaults'
# Create ~/.wgetrc with default options:
# timestamping = on       # Don't re-download unchanged files
# no_clobber = on         # Don't overwrite existing files
# continue = on           # Resume partial downloads
# tries = 10              # Retry failed downloads
# timeout = 60            # Timeout after 60 seconds
# wait = 2                # Wait 2 seconds between requests
# limit_rate = 200k       # Limit download speed
# user_agent = Mozilla/5.0

# Disable .wgetrc for single command
wget --no-config https://example.com/file.zip
```

# Timestamp and File Comparison

## Preserve Server Timestamps
```Shell title='Maintain original file times'
# Preserve server timestamps
wget -S --timestamping https://example.com/file.zip

# Short form
wget -N https://example.com/file.zip

# Only download if newer
wget -N https://example.com/file.zip
# Skips download if local file is same or newer
```

## Conditional Downloads
```Shell title='Download only if changed'
# Download only if modified
wget -N https://example.com/data.json

# Check timestamp before downloading
wget --timestamping https://example.com/updates/file.zip

# Spider mode (check without downloading)
wget --spider https://example.com/file.zip
# Returns exit code 0 if file exists
```

# Debugging and Troubleshooting

## Debug Output
```Shell title='Diagnose download issues'
# Debug mode (verbose output)
wget -d https://example.com/file.zip

# Show server response headers
wget -S https://example.com/file.zip

# Show both request and response
wget --debug https://example.com/file.zip 2>&1 | tee debug.log
```

## Test Connections
```Shell title='Test without downloading'
# Spider mode (don't download)
wget --spider https://example.com/file.zip

# Check if URL exists
if wget --spider https://example.com/file.zip 2>/dev/null; then
  echo "File exists"
else
  echo "File not found"
fi

# Test recursive download structure
wget --spider -r -l 1 https://example.com/
```

## Common Issues
```Shell title='Fix common problems'
# SSL certificate error
wget --no-check-certificate https://example.com/file.zip

# Connection timeout
wget --timeout=60 --tries=5 https://example.com/file.zip

# Redirects not followed
wget --max-redirect=5 https://short.url/abc

# File already exists
wget -nc https://example.com/file.zip  # No clobber
wget -c https://example.com/file.zip   # Continue/resume

# Rate limiting / 429 errors
wget -w 5 --random-wait https://example.com/files/
```

# Wget vs Curl

## When to Use Wget
```Shell title='Wget advantages'
# Recursive downloads (wget is better)
wget -r -l 3 https://example.com/

# Resume downloads (wget is simpler)
wget -c https://example.com/largefile.iso

# Background downloads
wget -b https://example.com/file.zip

# Mirror websites
wget --mirror https://example.com/

# Robust handling of unstable connections
wget --tries=0 -c https://unstable.example.com/file.zip
```

## When to Use Curl
```Shell title='Curl advantages'
# API testing (curl is better)
curl -X POST -H "Content-Type: application/json" \
  -d '{"key":"value"}' https://api.example.com/

# Upload files
curl -F "file=@document.pdf" https://api.example.com/upload

# More HTTP methods support
curl -X PATCH https://api.example.com/resource/123

# Better header control
curl -H "Authorization: Bearer token" https://api.example.com/
```

| Feature | Wget | Curl |
|---------|------|------|
| Recursive downloads | ✅ Yes | ❌ No |
| Resume capability | ✅ Better | ✓ Basic |
| Background downloads | ✅ Yes | ❌ No |
| API testing | ✓ Basic | ✅ Excellent |
| Upload files | ❌ No | ✅ Yes |
| HTTP methods | ✓ GET, POST | ✅ All methods |
| Protocols | HTTP, HTTPS, FTP | ✅ More protocols |
| Library support | ❌ No | ✅ libcurl |

# Quick Reference

## Essential Options
| Option | Description | Example |
|--------|-------------|---------|
| `-O` | Save to file | `wget -O file.zip url` |
| `-P` | Save to directory | `wget -P /downloads url` |
| `-c` | Resume download | `wget -c url` |
| `-b` | Background download | `wget -b url` |
| `-q` | Quiet mode | `wget -q url` |
| `-i` | Download from list | `wget -i urls.txt` |
| `-r` | Recursive download | `wget -r url` |
| `-l` | Recursion depth | `wget -r -l 3 url` |
| `-A` | Accept file types | `wget -r -A pdf url` |
| `-R` | Reject file types | `wget -r -R jpg,png url` |
| `--limit-rate` | Limit speed | `wget --limit-rate=100k url` |
| `--tries` | Retry count | `wget --tries=10 url` |

## Common Patterns
```Shell title='Frequently used wget commands'
# Download file
wget https://example.com/file.tar.gz

# Resume interrupted download
wget -c https://example.com/largefile.iso

# Download from URL list
wget -i urls.txt

# Mirror website
wget -mkEpnp https://example.com

# Download all PDFs
wget -r -l 2 -A pdf https://example.com/docs/

# Background download with retry
wget -b -c --tries=0 https://example.com/file.zip

# Download with rate limit
wget --limit-rate=500k https://example.com/file.zip

# Download only if newer
wget -N https://example.com/data.json
```

***
# References
1. GNU Wget Manual - https://www.gnu.org/software/wget/manual/
2. `man wget` - Linux manual page
3. The Wget Guide - https://www.gnu.org/software/wget/
4. HTTP: The Definitive Guide - David Gourley - 2002 - O'Reilly
5. Unix Power Tools - Shelley Powers et al - 3rd Edition - 2002 - O'Reilly
6. https://www.gnu.org/software/wget/manual/html_node/
