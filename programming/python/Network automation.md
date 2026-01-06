#python #networking #api #http #automation #requests #web-scraping
# HTTP Requests with requests
- The `requests` library provides <mark class="hltr-yellow">elegant and simple HTTP client functionality</mark>.
- Install: `pip install requests`
## Basic Requests
```python title='Make HTTP requests'
import requests

# GET request
response = requests.get('https://api.github.com')
print(response.status_code)  # 200
print(response.text)         # Response body as string
print(response.json())       # Parse JSON response

# POST request
data = {'username': 'alice', 'password': 'secret'}
response = requests.post('https://api.example.com/login', json=data)

# PUT request
data = {'name': 'Updated Name'}
response = requests.put('https://api.example.com/users/1', json=data)

# DELETE request
response = requests.delete('https://api.example.com/users/1')

# Request with query parameters
params = {'q': 'python', 'sort': 'stars'}
response = requests.get('https://api.github.com/search/repositories', params=params)
# URL: https://api.github.com/search/repositories?q=python&sort=stars

# Request with headers
headers = {
    'Authorization': 'Bearer TOKEN',
    'User-Agent': 'My App/1.0'
}
response = requests.get('https://api.example.com/data', headers=headers)

# Response properties
print(response.status_code)     # 200, 404, etc.
print(response.headers)         # Response headers dict
print(response.url)             # Final URL
print(response.encoding)        # Character encoding
print(response.content)         # Binary response
print(response.text)            # Text response
print(response.json())          # JSON parsed response
```
## Advanced Requests
```python title='Timeouts, retries, and sessions'
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

# Timeout
try:
    response = requests.get('https://api.example.com', timeout=5)
except requests.Timeout:
    print("Request timed out")

# Retry logic
session = requests.Session()
retry = Retry(
    total=3,
    backoff_factor=0.3,
    status_forcelist=[500, 502, 503, 504]
)
adapter = HTTPAdapter(max_retries=retry)
session.mount('http://', adapter)
session.mount('https://', adapter)

response = session.get('https://api.example.com')

# Session for multiple requests (maintains cookies, headers)
session = requests.Session()
session.headers.update({'Authorization': 'Bearer TOKEN'})

# All requests in this session will include the Authorization header
response1 = session.get('https://api.example.com/users')
response2 = session.get('https://api.example.com/posts')

# File upload
files = {'file': open('document.pdf', 'rb')}
response = requests.post('https://api.example.com/upload', files=files)

# Stream large responses
response = requests.get('https://example.com/large-file.zip', stream=True)
with open('downloaded.zip', 'wb') as f:
    for chunk in response.iter_content(chunk_size=8192):
        f.write(chunk)

# Verify SSL certificates (default: True)
response = requests.get('https://example.com', verify=True)

# Disable SSL verification (not recommended for production)
response = requests.get('https://example.com', verify=False)
```
## REST API Interaction
```python title='Work with REST APIs'
import requests
import json

class GitHubAPI:
    """GitHub API client."""

    def __init__(self, token=None):
        self.base_url = 'https://api.github.com'
        self.headers = {
            'Accept': 'application/vnd.github.v3+json'
        }
        if token:
            self.headers['Authorization'] = f'token {token}'

    def get_user(self, username):
        """Get user information."""
        url = f'{self.base_url}/users/{username}'
        response = requests.get(url, headers=self.headers)
        response.raise_for_status()
        return response.json()

    def get_repos(self, username):
        """Get user repositories."""
        url = f'{self.base_url}/users/{username}/repos'
        response = requests.get(url, headers=self.headers)
        response.raise_for_status()
        return response.json()

    def create_repo(self, name, description='', private=False):
        """Create a new repository."""
        url = f'{self.base_url}/user/repos'
        data = {
            'name': name,
            'description': description,
            'private': private
        }
        response = requests.post(url, headers=self.headers, json=data)
        response.raise_for_status()
        return response.json()

# Usage
api = GitHubAPI(token='your_token_here')
user = api.get_user('torvalds')
print(f"Name: {user['name']}")
print(f"Followers: {user['followers']}")

repos = api.get_repos('torvalds')
for repo in repos[:5]:
    print(f"- {repo['name']}: {repo['description']}")
```
# Web Scraping
## BeautifulSoup for HTML Parsing
```python title='Parse HTML with BeautifulSoup'
# pip install beautifulsoup4

import requests
from bs4 import BeautifulSoup

# Fetch and parse webpage
url = 'https://example.com'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

# Find elements
title = soup.find('title').text
heading = soup.find('h1').text
links = soup.find_all('a')

# Extract data from links
for link in links:
    href = link.get('href')
    text = link.get_text()
    print(f"{text}: {href}")

# Find by class
articles = soup.find_all('div', class_='article')

# Find by id
header = soup.find(id='header')

# CSS selectors
articles = soup.select('.article')
first_link = soup.select_one('a.external')

# Navigate tree
parent = link.parent
siblings = link.find_next_siblings()
children = div.find_all(recursive=False)

# Extract table data
table = soup.find('table')
rows = table.find_all('tr')
for row in rows:
    cells = row.find_all('td')
    data = [cell.text.strip() for cell in cells]
    print(data)
```
## Advanced Web Scraping
```python title='Handle dynamic content and pagination'
import requests
from bs4 import BeautifulSoup
import time

def scrape_with_pagination(base_url, max_pages=5):
    """Scrape multiple pages."""
    all_items = []

    for page in range(1, max_pages + 1):
        url = f"{base_url}?page={page}"
        print(f"Scraping page {page}...")

        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')

        # Extract items
        items = soup.find_all('div', class_='item')
        all_items.extend(items)

        # Be polite - add delay
        time.sleep(1)

    return all_items

# Handle authentication
session = requests.Session()

# Login
login_data = {'username': 'user', 'password': 'pass'}
session.post('https://example.com/login', data=login_data)

# Now scrape authenticated pages
response = session.get('https://example.com/dashboard')
soup = BeautifulSoup(response.text, 'html.parser')

# Download images
img_urls = [img['src'] for img in soup.find_all('img')]
for url in img_urls:
    if not url.startswith('http'):
        url = f"https://example.com{url}"

    img_data = requests.get(url).content
    filename = url.split('/')[-1]

    with open(filename, 'wb') as f:
        f.write(img_data)
```
# Socket Programming
```python title='Low-level socket communication'
import socket

# TCP Client
def tcp_client(host, port):
    """Create TCP client socket."""
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    try:
        sock.connect((host, port))
        print(f"Connected to {host}:{port}")

        # Send data
        message = "Hello, Server!"
        sock.sendall(message.encode())

        # Receive response
        data = sock.recv(1024)
        print(f"Received: {data.decode()}")

    finally:
        sock.close()

# TCP Server
def tcp_server(host='0.0.0.0', port=8080):
    """Create TCP server socket."""
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind((host, port))
    sock.listen(5)

    print(f"Server listening on {host}:{port}")

    try:
        while True:
            client_sock, addr = sock.accept()
            print(f"Connection from {addr}")

            data = client_sock.recv(1024)
            print(f"Received: {data.decode()}")

            # Send response
            response = "Hello, Client!"
            client_sock.sendall(response.encode())
            client_sock.close()

    finally:
        sock.close()

# UDP Client
def udp_client(host, port):
    """Create UDP client socket."""
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    message = "Hello, UDP!"
    sock.sendto(message.encode(), (host, port))

    data, addr = sock.recvfrom(1024)
    print(f"Received: {data.decode()} from {addr}")

    sock.close()

# UDP Server
def udp_server(host='0.0.0.0', port=8080):
    """Create UDP server socket."""
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((host, port))

    print(f"UDP server listening on {host}:{port}")

    while True:
        data, addr = sock.recvfrom(1024)
        print(f"Received: {data.decode()} from {addr}")

        response = "Hello, UDP Client!"
        sock.sendto(response.encode(), addr)
```
# SSH and Remote Execution
```python title='Execute commands on remote servers via SSH'
# pip install paramiko

import paramiko

def ssh_execute(hostname, username, password, command):
    """Execute command on remote server via SSH."""
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        # Connect
        client.connect(
            hostname=hostname,
            username=username,
            password=password,
            timeout=10
        )

        # Execute command
        stdin, stdout, stderr = client.exec_command(command)

        # Get output
        output = stdout.read().decode()
        error = stderr.read().decode()
        exit_status = stdout.channel.recv_exit_status()

        return output, error, exit_status

    finally:
        client.close()

# SSH with key authentication
def ssh_execute_with_key(hostname, username, key_file, command):
    """Execute command using SSH key."""
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        # Load private key
        key = paramiko.RSAKey.from_private_key_file(key_file)

        # Connect
        client.connect(
            hostname=hostname,
            username=username,
            pkey=key
        )

        # Execute
        stdin, stdout, stderr = client.exec_command(command)
        return stdout.read().decode()

    finally:
        client.close()

# SFTP file transfer
def sftp_upload(hostname, username, password, local_path, remote_path):
    """Upload file via SFTP."""
    transport = paramiko.Transport((hostname, 22))
    transport.connect(username=username, password=password)

    sftp = paramiko.SFTPClient.from_transport(transport)

    try:
        sftp.put(local_path, remote_path)
        print(f"Uploaded {local_path} to {remote_path}")
    finally:
        sftp.close()
        transport.close()

# Usage
# output, error, status = ssh_execute(
#     'server.example.com',
#     'username',
#     'password',
#     'ls -la /var/log'
# )
# print(output)
```
# Email Automation
```python title='Send emails programmatically'
import smtplib
from email.message import EmailMessage
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# Simple text email
def send_email(subject, body, to_email, from_email, smtp_server, smtp_port=587, password=None):
    """Send simple text email."""
    msg = EmailMessage()
    msg.set_content(body)
    msg['Subject'] = subject
    msg['From'] = from_email
    msg['To'] = to_email

    # Send via SMTP
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        if password:
            server.starttls()
            server.login(from_email, password)
        server.send_message(msg)

# HTML email with attachment
def send_html_email_with_attachment(
    subject, html_body, to_email, from_email,
    smtp_server, password, attachment_path=None
):
    """Send HTML email with optional attachment."""
    msg = MIMEMultipart()
    msg['Subject'] = subject
    msg['From'] = from_email
    msg['To'] = to_email

    # HTML body
    html_part = MIMEText(html_body, 'html')
    msg.attach(html_part)

    # Attachment
    if attachment_path:
        with open(attachment_path, 'rb') as f:
            attachment = MIMEApplication(f.read())
            filename = attachment_path.split('/')[-1]
            attachment.add_header(
                'Content-Disposition',
                'attachment',
                filename=filename
            )
            msg.attach(attachment)

    # Send
    with smtplib.SMTP(smtp_server, 587) as server:
        server.starttls()
        server.login(from_email, password)
        server.send_message(msg)

# Example HTML email
html_content = """
<html>
  <body>
    <h1>System Report</h1>
    <p>The daily backup completed successfully.</p>
    <ul>
      <li>Files backed up: 1,234</li>
      <li>Size: 5.6 GB</li>
      <li>Duration: 15 minutes</li>
    </ul>
  </body>
</html>
"""

# send_html_email_with_attachment(
#     subject='Daily Backup Report',
#     html_body=html_content,
#     to_email='admin@example.com',
#     from_email='backup@example.com',
#     smtp_server='smtp.gmail.com',
#     password='app_password',
#     attachment_path='/var/log/backup.log'
# )
```
# DNS Operations
```python title='DNS queries and resolution'
import socket
import dns.resolver  # pip install dnspython

# Basic hostname resolution
def get_ip(hostname):
    """Get IP address from hostname."""
    try:
        ip = socket.gethostbyname(hostname)
        return ip
    except socket.gaierror:
        return None

# Reverse DNS lookup
def get_hostname(ip):
    """Get hostname from IP address."""
    try:
        hostname = socket.gethostbyaddr(ip)[0]
        return hostname
    except socket.herror:
        return None

# Advanced DNS queries
def dns_query(domain, record_type='A'):
    """Query DNS records."""
    resolver = dns.resolver.Resolver()

    try:
        answers = resolver.resolve(domain, record_type)
        return [str(rdata) for rdata in answers]
    except dns.exception.DNSException as e:
        return []

# Usage examples
ip = get_ip('google.com')
print(f"google.com: {ip}")

hostname = get_hostname('8.8.8.8')
print(f"8.8.8.8: {hostname}")

# Get MX records
mx_records = dns_query('gmail.com', 'MX')
for mx in mx_records:
    print(f"MX: {mx}")

# Get TXT records
txt_records = dns_query('google.com', 'TXT')
for txt in txt_records:
    print(f"TXT: {txt}")
```
# Practical Network Automation Examples
## Example 1: API Monitor
```python title='Monitor API endpoints and alert on failures'
#!/usr/bin/env python3
"""Monitor API endpoints."""

import requests
import time
import logging
from datetime import datetime

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class APIMonitor:
    def __init__(self, endpoints, check_interval=60):
        self.endpoints = endpoints
        self.check_interval = check_interval

    def check_endpoint(self, name, url, expected_status=200):
        """Check if endpoint is responding correctly."""
        try:
            response = requests.get(url, timeout=10)

            if response.status_code == expected_status:
                logging.info(f"✓ {name}: OK ({response.status_code}) - {response.elapsed.total_seconds():.2f}s")
                return True
            else:
                logging.warning(f"✗ {name}: Unexpected status {response.status_code}")
                return False

        except requests.Timeout:
            logging.error(f"✗ {name}: Timeout")
            return False
        except requests.RequestException as e:
            logging.error(f"✗ {name}: Error - {e}")
            return False

    def monitor(self):
        """Continuously monitor endpoints."""
        logging.info("Starting API monitor...")

        while True:
            for name, config in self.endpoints.items():
                self.check_endpoint(
                    name,
                    config['url'],
                    config.get('expected_status', 200)
                )

            time.sleep(self.check_interval)

# Configuration
endpoints = {
    'API Server': {
        'url': 'https://api.example.com/health',
        'expected_status': 200
    },
    'Database API': {
        'url': 'https://api.example.com/db/ping',
        'expected_status': 200
    },
    'Auth Service': {
        'url': 'https://auth.example.com/status',
        'expected_status': 200
    }
}

# Usage
# monitor = APIMonitor(endpoints, check_interval=60)
# monitor.monitor()
```
## Example 2: Webhook Handler
```python title='Create webhook server to receive events'
#!/usr/bin/env python3
"""Simple webhook receiver."""

from flask import Flask, request, jsonify  # pip install flask
import logging

app = Flask(__name__)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(message)s'
)

@app.route('/webhook', methods=['POST'])
def handle_webhook():
    """Handle incoming webhook."""
    data = request.json

    logging.info(f"Received webhook: {data}")

    # Verify signature (if required)
    signature = request.headers.get('X-Webhook-Signature')
    if signature:
        # Verify signature logic here
        pass

    # Process webhook data
    event_type = data.get('event')

    if event_type == 'deployment':
        handle_deployment(data)
    elif event_type == 'alert':
        handle_alert(data)
    else:
        logging.warning(f"Unknown event type: {event_type}")

    return jsonify({'status': 'received'}), 200

def handle_deployment(data):
    """Handle deployment webhook."""
    app_name = data.get('app')
    version = data.get('version')
    logging.info(f"Deployment: {app_name} v{version}")
    # Trigger deployment automation

def handle_alert(data):
    """Handle alert webhook."""
    severity = data.get('severity')
    message = data.get('message')
    logging.warning(f"Alert ({severity}): {message}")
    # Send notification

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```
## Example 3: Server Inventory Scanner
```python title='Scan network and catalog servers'
#!/usr/bin/env python3
"""Scan network for active servers and gather information."""

import socket
import subprocess
import concurrent.futures
from ipaddress import IPv4Network

def is_host_up(ip):
    """Check if host responds to ping."""
    result = subprocess.run(
        ['ping', '-c', '1', '-W', '1', str(ip)],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
    )
    return result.returncode == 0

def scan_port(ip, port, timeout=1):
    """Check if port is open on host."""
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(timeout)

    try:
        result = sock.connect_ex((str(ip), port))
        sock.close()
        return result == 0
    except:
        return False

def scan_host(ip):
    """Scan host for open ports and services."""
    if not is_host_up(ip):
        return None

    common_ports = {
        22: 'SSH',
        80: 'HTTP',
        443: 'HTTPS',
        3306: 'MySQL',
        5432: 'PostgreSQL',
        6379: 'Redis',
        27017: 'MongoDB'
    }

    open_ports = {}
    for port, service in common_ports.items():
        if scan_port(ip, port):
            open_ports[port] = service

    if open_ports:
        try:
            hostname = socket.gethostbyaddr(str(ip))[0]
        except:
            hostname = None

        return {
            'ip': str(ip),
            'hostname': hostname,
            'ports': open_ports
        }

    return None

def scan_network(network):
    """Scan entire network."""
    net = IPv4Network(network)
    results = []

    print(f"Scanning {network}...")

    with concurrent.futures.ThreadPoolExecutor(max_workers=50) as executor:
        futures = {executor.submit(scan_host, ip): ip for ip in net.hosts()}

        for future in concurrent.futures.as_completed(futures):
            result = future.result()
            if result:
                results.append(result)
                print(f"Found: {result['ip']} ({result['hostname']}) - Ports: {list(result['ports'].keys())}")

    return results

# Usage
# hosts = scan_network('192.168.1.0/24')
# print(f"\nFound {len(hosts)} active hosts")
```
## Example 4: REST API Testing Framework
```python title='Automated API testing'
#!/usr/bin/env python3
"""API testing framework."""

import requests
import json

class APITest:
    def __init__(self, base_url):
        self.base_url = base_url
        self.passed = 0
        self.failed = 0

    def assert_status(self, response, expected):
        """Assert response status code."""
        if response.status_code == expected:
            self.passed += 1
            print(f"✓ Status code: {response.status_code}")
        else:
            self.failed += 1
            print(f"✗ Expected {expected}, got {response.status_code}")

    def assert_json_key(self, response, key):
        """Assert JSON response contains key."""
        data = response.json()
        if key in data:
            self.passed += 1
            print(f"✓ Key '{key}' exists")
        else:
            self.failed += 1
            print(f"✗ Key '{key}' missing")

    def test_get_users(self):
        """Test GET /users endpoint."""
        print("\n--- Testing GET /users ---")
        response = requests.get(f"{self.base_url}/users")

        self.assert_status(response, 200)
        self.assert_json_key(response, 'users')

    def test_create_user(self):
        """Test POST /users endpoint."""
        print("\n--- Testing POST /users ---")
        data = {'name': 'Test User', 'email': 'test@example.com'}
        response = requests.post(f"{self.base_url}/users", json=data)

        self.assert_status(response, 201)
        self.assert_json_key(response, 'id')

    def run_all_tests(self):
        """Run all tests."""
        self.test_get_users()
        self.test_create_user()

        print(f"\n=== Results ===")
        print(f"Passed: {self.passed}")
        print(f"Failed: {self.failed}")

# Usage
# tester = APITest('https://api.example.com')
# tester.run_all_tests()
```
***
# References
1. `requests` - HTTP for Humans - https://requests.readthedocs.io/
2. `urllib3` - HTTP library with thread-safe connection pooling - https://urllib3.readthedocs.io/
3. Beautiful Soup - Web scraping library - https://www.crummy.com/software/BeautifulSoup/
4. `paramiko` - SSHv2 protocol library - https://www.paramiko.org/
5. `socket` - Low-level networking interface - https://docs.python.org/3/library/socket.html
6. `smtplib` - SMTP protocol client - https://docs.python.org/3/library/smtplib.html
7. `dnspython` - DNS toolkit - https://dnspython.readthedocs.io/
8. Flask - Web framework for APIs and webhooks - https://flask.palletsprojects.com/
