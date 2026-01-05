#linux #unix #shell #command #http #https #api #web #networking #shell

- `curl` (Client URL) transfers data to or from a server using URLs.
- <mark class="hltr-yellow">Supports HTTP, HTTPS, FTP, SFTP, and many other protocols</mark>.
- Primary tool for testing APIs, downloading files, and web automation.
# Basic Syntax
```Shell title='curl command syntax'
curl [options] [URL...]
```

## Simple Request
```Shell title='Basic HTTP GET request'
# Fetch webpage content
curl https://example.com

# Output webpage HTML to terminal
curl https://api.github.com

# Multiple URLs
curl https://example.com https://google.com
```

# HTTP Methods

## GET Request (Default)
```Shell title='HTTP GET requests'
# Simple GET request
curl https://api.example.com/users

# GET with query parameters
curl "https://api.example.com/search?q=linux&page=1"

# GET request showing only headers
curl -I https://example.com

# GET with verbose output
curl -v https://api.example.com/status
```

## POST Request
```Shell title='HTTP POST requests'
# POST with data
curl -X POST https://api.example.com/users \
  -d "name=John&email=john@example.com"

# POST with JSON data
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com"}'

# POST data from file
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d @data.json

# POST form data
curl -X POST https://api.example.com/upload \
  -F "file=@document.pdf" \
  -F "description=Important document"
```

## PUT Request
```Shell title='HTTP PUT requests'
# Update resource
curl -X PUT https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d '{"name":"John Updated","email":"john@example.com"}'

# PUT from file
curl -X PUT https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d @updated-user.json
```

## DELETE Request
```Shell title='HTTP DELETE requests'
# Delete resource
curl -X DELETE https://api.example.com/users/123

# Delete with authentication
curl -X DELETE https://api.example.com/users/123 \
  -H "Authorization: Bearer token123"
```

## PATCH Request
```Shell title='HTTP PATCH requests'
# Partial update
curl -X PATCH https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d '{"email":"newemail@example.com"}'
```

## HEAD Request
```Shell title='HTTP HEAD requests'
# Get only headers (no body)
curl -I https://example.com

# HEAD request explicitly
curl -X HEAD https://api.example.com/status

# Check if resource exists
curl -I https://example.com/file.pdf -o /dev/null -w '%{http_code}\n' -s
```

# Headers

## Send Custom Headers
```Shell title='Add custom headers'
# Single header
curl -H "Authorization: Bearer token123" https://api.example.com/protected

# Multiple headers
curl -H "Authorization: Bearer token123" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  https://api.example.com/users

# User-Agent header
curl -H "User-Agent: MyApp/1.0" https://example.com

# Custom header with spaces
curl -H "X-Custom-Header: value with spaces" https://api.example.com
```

## View Response Headers
```Shell title='Display response headers'
# Show headers only
curl -I https://example.com

# Show headers and body
curl -i https://api.example.com/users

# Verbose output (request and response headers)
curl -v https://api.example.com/users

# Save headers to file
curl -D headers.txt https://example.com
```

## Common Headers
```Shell title='Frequently used headers'
# JSON API request
curl https://api.example.com/data \
  -H "Content-Type: application/json" \
  -H "Accept: application/json"

# Authentication headers
curl https://api.example.com/protected \
  -H "Authorization: Bearer eyJhbGc..."

curl https://api.example.com/protected \
  -H "Authorization: Basic dXNlcjpwYXNz"

# API key header
curl https://api.example.com/data \
  -H "X-API-Key: your-api-key-here"

# Cookie header
curl https://example.com \
  -H "Cookie: session=abc123; user=john"
```

# Authentication

## Basic Authentication
```Shell title='HTTP Basic Auth'
# Using -u flag
curl -u username:password https://api.example.com/protected

# Using -u with prompt for password
curl -u username https://api.example.com/protected
# Enter host password for user 'username':

# Basic auth in URL (not recommended)
curl https://username:password@api.example.com/protected

# Base64 encoded (manual)
curl -H "Authorization: Basic $(echo -n user:pass | base64)" \
  https://api.example.com/protected
```

## Bearer Token Authentication
```Shell title='Token-based authentication'
# Bearer token
curl -H "Authorization: Bearer your-token-here" \
  https://api.example.com/protected

# OAuth 2.0 access token
curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..." \
  https://api.example.com/user/profile

# Token from file
curl -H "Authorization: Bearer $(cat token.txt)" \
  https://api.example.com/protected
```

## API Key Authentication
```Shell title='API key authentication'
# API key in header
curl -H "X-API-Key: your-api-key" https://api.example.com/data

# API key in query parameter
curl "https://api.example.com/data?api_key=your-api-key"

# Multiple authentication methods
curl "https://api.example.com/data?api_key=your-key" \
  -H "X-Client-ID: client123"
```

## Cookie-Based Authentication
```Shell title='Session cookies'
# Send cookies from file
curl -b cookies.txt https://example.com/dashboard

# Save cookies to file
curl -c cookies.txt https://example.com/login \
  -d "username=user&password=pass"

# Send and save cookies
curl -b cookies.txt -c cookies.txt https://example.com/page

# Inline cookie
curl -b "session=abc123" https://example.com/dashboard
```

# Downloading Files

## Save to File
```Shell title='Download and save files'
# Save with original filename
curl -O https://example.com/file.pdf

# Save with custom filename
curl -o myfile.pdf https://example.com/document.pdf

# Multiple files
curl -O https://example.com/file1.pdf -O https://example.com/file2.pdf

# Download with progress bar
curl -# -O https://example.com/largefile.zip
```

## Resume Download
```Shell title='Resume interrupted downloads'
# Resume partial download
curl -C - -O https://example.com/largefile.iso

# Resume with custom filename
curl -C - -o myfile.iso https://example.com/largefile.iso
```

## Download with Redirects
```Shell title='Follow HTTP redirects'
# Follow redirects
curl -L https://short.url/abc123

# Follow redirects and save
curl -L -O https://github.com/user/repo/releases/latest/file.tar.gz

# Limit redirect count
curl -L --max-redirs 5 https://example.com
```

## Practical Use Case: Download GitHub Release
```Shell title='Download latest GitHub release'
# Download latest release asset
curl -L -O https://github.com/user/repo/releases/latest/download/app.tar.gz

# Download specific version
curl -L -O https://github.com/user/repo/releases/download/v1.2.3/app.tar.gz

# Get download URL from API and download
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/user/repo/releases/latest \
  | grep "browser_download_url.*tar.gz" \
  | cut -d '"' -f 4)
curl -L -O "$DOWNLOAD_URL"
```
# Uploading Files
## Upload File (POST)
```Shell title='Upload files with POST'
# Upload single file
curl -F "file=@document.pdf" https://api.example.com/upload

# Upload with additional fields
curl -F "file=@photo.jpg" \
  -F "description=My photo" \
  -F "category=nature" \
  https://api.example.com/upload

# Upload multiple files
curl -F "file1=@doc1.pdf" \
  -F "file2=@doc2.pdf" \
  https://api.example.com/upload-multiple
```

## Upload File (PUT)
```Shell title='Upload with PUT method'
# Upload file content
curl -X PUT -T file.txt https://example.com/upload/file.txt

# Upload with authentication
curl -X PUT -T backup.tar.gz \
  -H "Authorization: Bearer token" \
  https://api.example.com/backups/backup.tar.gz

# Upload from stdin
cat file.txt | curl -X PUT -T - https://example.com/upload
```
## Upload Binary Data
```Shell title='Upload binary data'
# Upload binary file
curl -X POST https://api.example.com/upload \
  -H "Content-Type: application/octet-stream" \
  --data-binary @image.jpg

# Upload compressed data
curl -X POST https://api.example.com/logs \
  -H "Content-Type: application/gzip" \
  --data-binary @logs.tar.gz
```
# Working with JSON APIs
## GET JSON Data
```Shell title='Fetch JSON from API'
# Get JSON response
curl https://api.example.com/users

# Pretty print JSON (with jq)
curl https://api.example.com/users | jq .

# Get specific field
curl https://api.example.com/user/123 | jq '.name'

# Silent mode (no progress)
curl -s https://api.example.com/users | jq .
```

## POST JSON Data
```Shell title='Send JSON to API'
# POST JSON inline
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com","age":30}'

# POST JSON from file
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d @user.json

# POST JSON with variables
NAME="John"
EMAIL="john@example.com"
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$NAME\",\"email\":\"$EMAIL\"}"
```
## RESTful API Operations
```Shell title='Complete CRUD operations'
# CREATE - POST new user
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com"}'

# READ - GET user
curl https://api.example.com/users/123 | jq .

# UPDATE - PUT user
curl -X PUT https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d '{"name":"John Updated","email":"john@example.com"}'

# PARTIAL UPDATE - PATCH user
curl -X PATCH https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d '{"email":"newemail@example.com"}'

# DELETE - Remove user
curl -X DELETE https://api.example.com/users/123
```

# Response Handling

## Save Response to File
```Shell title='Save response output'
# Save to file
curl https://api.example.com/data -o response.json

# Save headers and body separately
curl -D headers.txt -o body.txt https://api.example.com/users

# Append to existing file
curl https://api.example.com/logs >> application.log
```

## Extract Response Information
```Shell title='Get response metadata'
# Get HTTP status code only
curl -s -o /dev/null -w '%{http_code}\n' https://example.com

# Get response time
curl -s -o /dev/null -w 'Time: %{time_total}s\n' https://example.com

# Multiple metrics
curl -s -o /dev/null -w '\
HTTP Code: %{http_code}\n\
Total Time: %{time_total}s\n\
Download Speed: %{speed_download} bytes/sec\n' \
https://example.com

# Save metrics to file
curl -w '@curl-format.txt' -o response.txt https://api.example.com
```

## Custom Output Format
```Shell title='Format output with -w'
# Create format file (curl-format.txt):
# time_namelookup:  %{time_namelookup}\n
# time_connect:  %{time_connect}\n
# time_appconnect:  %{time_appconnect}\n
# time_pretransfer:  %{time_pretransfer}\n
# time_starttransfer:  %{time_starttransfer}\n
# time_total:  %{time_total}\n

# Use format file
curl -w "@curl-format.txt" -o /dev/null -s https://example.com
```

# Error Handling and Retries

## Handle Errors
```Shell title='Error handling in scripts'
# Exit on HTTP error
curl -f https://api.example.com/users || echo "Request failed"

# Show error details
curl -S https://api.example.com/users

# Silent with errors shown
curl -sS https://api.example.com/users

# Check exit code
curl https://api.example.com/users
if [ $? -eq 0 ]; then
  echo "Success"
else
  echo "Failed"
fi
```

## Retry Failed Requests
```Shell title='Automatic retry on failure'
# Retry up to 3 times
curl --retry 3 https://api.example.com/unstable

# Retry with delay
curl --retry 5 --retry-delay 2 https://api.example.com/data

# Retry with exponential backoff
curl --retry 5 --retry-delay 1 --retry-max-time 60 \
  https://api.example.com/data

# Retry only on specific errors
curl --retry 3 --retry-connrefused https://api.example.com/data
```

## Timeout Settings
```Shell title='Configure timeouts'
# Connection timeout (10 seconds)
curl --connect-timeout 10 https://example.com

# Maximum time for operation (30 seconds)
curl --max-time 30 https://example.com/download

# Both timeouts
curl --connect-timeout 10 --max-time 60 https://example.com
```

# Advanced Features

## Follow Redirects with History
```Shell title='Track redirect chain'
# Show redirect history
curl -L -v https://bit.ly/short-url 2>&1 | grep "^< Location:"

# Follow redirects with referer
curl -L -e https://example.com https://redirect.example.com

# Don't follow redirects
curl https://redirect.example.com
```

## Rate Limiting
```Shell title='Limit transfer rate'
# Limit download speed (100KB/s)
curl --limit-rate 100k https://example.com/largefile.zip

# Limit upload speed
curl --limit-rate 50k -T file.tar.gz https://example.com/upload
```

## Custom DNS Resolution
```Shell title='Override DNS resolution'
# Force specific IP for hostname
curl --resolve example.com:443:93.184.216.34 https://example.com

# Multiple host overrides
curl --resolve api.example.com:443:1.2.3.4 \
  --resolve cdn.example.com:443:5.6.7.8 \
  https://api.example.com
```

## Proxy Configuration
```Shell title='Use proxy servers'
# HTTP proxy
curl -x http://proxy.example.com:8080 https://api.example.com

# SOCKS5 proxy
curl -x socks5://proxy.example.com:1080 https://api.example.com

# Proxy with authentication
curl -x http://user:pass@proxy.example.com:8080 https://api.example.com

# Bypass proxy for specific hosts
curl --noproxy localhost,127.0.0.1 https://localhost:3000
```

## SSL/TLS Options
```Shell title='SSL certificate handling'
# Ignore SSL certificate verification (insecure!)
curl -k https://self-signed.example.com

# Specify CA certificate
curl --cacert ca-bundle.crt https://secure.example.com

# Client certificate authentication
curl --cert client.pem --key client-key.pem https://api.example.com

# Show SSL certificate info
curl -v https://example.com 2>&1 | grep -A 10 "Server certificate"
```

# Practical Use Cases

## Use Case 1: API Testing
```Shell title='Test REST API endpoints'
# Test API health check
curl -f https://api.example.com/health || echo "API is down"

# Test with different methods
echo "Testing GET..."
curl -s https://api.example.com/users | jq '.[] | .name'

echo "Testing POST..."
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User"}' | jq .

echo "Testing authentication..."
curl -H "Authorization: Bearer token" \
  https://api.example.com/protected -w '\nHTTP: %{http_code}\n'
```

## Use Case 2: Web Scraping
```Shell title='Extract data from websites'
# Download webpage
curl -s https://example.com/products > products.html

# Extract specific content with grep
curl -s https://example.com/products | grep -o '<title>[^<]*' | sed 's/<title>//'

# Follow links and download
curl -s https://example.com | \
  grep -o 'href="[^"]*\.pdf"' | \
  cut -d'"' -f2 | \
  xargs -I {} curl -O https://example.com/{}
```

## Use Case 3: Monitoring and Health Checks
```Shell title='Monitor service availability'
#!/bin/bash
# Health check script

URL="https://api.example.com/health"
TIMEOUT=5

# Check endpoint
RESPONSE=$(curl -s -o /dev/null -w '%{http_code}' --max-time $TIMEOUT $URL)

if [ "$RESPONSE" = "200" ]; then
  echo "✓ Service is healthy (HTTP $RESPONSE)"
  exit 0
else
  echo "✗ Service is unhealthy (HTTP $RESPONSE)"
  # Send alert
  curl -X POST https://alerts.example.com/webhook \
    -H "Content-Type: application/json" \
    -d "{\"service\":\"api\",\"status\":\"down\",\"code\":$RESPONSE}"
  exit 1
fi
```

## Use Case 4: Batch Downloads
```Shell title='Download multiple files'
# Download from list of URLs
cat urls.txt | xargs -n 1 curl -O

# Download with progress tracking
while IFS= read -r url; do
  filename=$(basename "$url")
  echo "Downloading $filename..."
  curl -# -o "$filename" "$url"
done < urls.txt

# Parallel downloads
cat urls.txt | xargs -P 4 -n 1 curl -O
```

## Use Case 5: Webhook Testing
```Shell title='Test webhook endpoints'
# Send webhook payload
curl -X POST https://webhook.example.com/incoming \
  -H "Content-Type: application/json" \
  -H "X-Webhook-Secret: secret123" \
  -d '{
    "event": "user.created",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'",
    "data": {
      "user_id": 123,
      "email": "user@example.com"
    }
  }'

# Verify webhook signature
PAYLOAD='{"event":"test"}'
SIGNATURE=$(echo -n "$PAYLOAD" | openssl sha256 -hmac "secret" | cut -d' ' -f2)
curl -X POST https://webhook.example.com/incoming \
  -H "Content-Type: application/json" \
  -H "X-Signature: sha256=$SIGNATURE" \
  -d "$PAYLOAD"
```

## Use Case 6: API Performance Testing
```Shell title='Measure API performance'
#!/bin/bash
# API performance test

ENDPOINT="https://api.example.com/users"
ITERATIONS=100

echo "Testing $ENDPOINT ($ITERATIONS requests)..."

total_time=0
for i in $(seq 1 $ITERATIONS); do
  time=$(curl -s -o /dev/null -w '%{time_total}' $ENDPOINT)
  total_time=$(echo "$total_time + $time" | bc)

  if [ $((i % 10)) -eq 0 ]; then
    echo "Completed $i requests..."
  fi
done

avg_time=$(echo "scale=3; $total_time / $ITERATIONS" | bc)
echo "Average response time: ${avg_time}s"
```

## Use Case 7: Automated Deployment
```Shell title='Deploy via API'
#!/bin/bash
# Deploy application via API

API_BASE="https://api.deployment.example.com"
API_TOKEN="your-token-here"

# Upload artifact
echo "Uploading artifact..."
curl -X POST "$API_BASE/artifacts" \
  -H "Authorization: Bearer $API_TOKEN" \
  -F "file=@app.tar.gz" \
  -F "version=1.2.3" \
  -o upload-response.json

ARTIFACT_ID=$(jq -r '.artifact_id' upload-response.json)

# Trigger deployment
echo "Triggering deployment..."
curl -X POST "$API_BASE/deployments" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"artifact_id\": \"$ARTIFACT_ID\",
    \"environment\": \"production\",
    \"strategy\": \"blue-green\"
  }" | jq .

echo "Deployment initiated"
```

# Debugging and Troubleshooting

## Verbose Output
```Shell title='Debug request/response'
# Verbose mode (shows request and response headers)
curl -v https://api.example.com/users

# Extra verbose (shows even more details)
curl -vv https://api.example.com/users

# Trace ASCII
curl --trace-ascii trace.txt https://api.example.com/users

# Trace binary
curl --trace trace.bin https://api.example.com/users
```

## Test Connection
```Shell title='Diagnose connection issues'
# Test DNS resolution
curl -v https://example.com 2>&1 | grep "Trying"

# Test SSL handshake
curl -v https://example.com 2>&1 | grep -A 5 "SSL connection"

# Test specific TLS version
curl --tlsv1.2 https://example.com
curl --tlsv1.3 https://example.com

# Show timing breakdown
curl -w '\
DNS Lookup: %{time_namelookup}s\n\
TCP Connection: %{time_connect}s\n\
TLS Handshake: %{time_appconnect}s\n\
Server Processing: %{time_starttransfer}s\n\
Total: %{time_total}s\n' \
-o /dev/null -s https://example.com
```

## Common Issues
```Shell title='Troubleshoot common problems'
# SSL certificate error
curl -k https://self-signed.example.com  # Bypass verification (insecure)
curl --cacert ca.pem https://example.com  # Specify CA cert

# Connection refused
curl --connect-timeout 10 --retry 3 https://example.com

# Slow downloads
curl --limit-rate 1M https://example.com/file.zip  # Limit rate
curl --max-time 300 https://example.com/file.zip  # Set timeout

# 301/302 redirects not followed
curl -L https://example.com  # Follow redirects

# Cookie issues
curl -b cookies.txt -c cookies.txt https://example.com
```

# Configuration File

## Using .curlrc
```Shell title='Configure curl defaults'
# Create ~/.curlrc file with default options:
# --location           # Follow redirects
# --retry 3            # Retry failed requests
# --retry-delay 2      # Wait between retries
# --connect-timeout 10 # Connection timeout
# --max-time 300       # Maximum time
# --show-error         # Show errors
# --silent             # Silent mode

# Disable .curlrc for specific request
curl -q https://example.com
```

# Quick Reference

## Essential Options
| Option | Description | Example |
|--------|-------------|---------|
| `-X` | HTTP method | `curl -X POST url` |
| `-H` | Add header | `curl -H "Auth: token" url` |
| `-d` | Send data | `curl -d "key=value" url` |
| `-o` | Output to file | `curl -o file.txt url` |
| `-O` | Save with original name | `curl -O url/file.pdf` |
| `-u` | Authentication | `curl -u user:pass url` |
| `-i` | Include headers | `curl -i url` |
| `-I` | Headers only | `curl -I url` |
| `-v` | Verbose | `curl -v url` |
| `-L` | Follow redirects | `curl -L url` |
| `-s` | Silent mode | `curl -s url` |
| `-f` | Fail silently | `curl -f url` |

## Common Patterns
```Shell title='Frequently used curl commands'
# Download file
curl -L -O https://example.com/file.tar.gz

# API request with JSON
curl -X POST https://api.example.com/data \
  -H "Content-Type: application/json" \
  -d '{"key":"value"}'

# Authenticated API call
curl -H "Authorization: Bearer token" \
  https://api.example.com/protected

# Upload file
curl -F "file=@document.pdf" https://api.example.com/upload

# Check HTTP status
curl -s -o /dev/null -w '%{http_code}' https://example.com

# Download with progress bar
curl -# -O https://example.com/largefile.zip
```

***
# References
1. curl Documentation - https://curl.se/docs/
2. `man curl` - Linux manual page
3. Everything curl - Daniel Stenberg - https://everything.curl.dev/
4. HTTP: The Definitive Guide - David Gourley - 2002 - O'Reilly
5. RESTful Web APIs - Leonard Richardson - 2013 - O'Reilly
6. https://curl.se/docs/manual.html
7. https://curl.se/docs/httpscripting.html
