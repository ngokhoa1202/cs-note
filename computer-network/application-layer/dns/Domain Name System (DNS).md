#dns #computer-network #application-layer #client-server #udp #protocol #name-resolution
## Overview

The ==Domain Name System (DNS)== is a hierarchical, distributed database system that translates human-readable domain names (like `www.google.com`) into machine-readable IP addresses (like `142.250.185.206`). DNS operates as a ==critical infrastructure service== for the Internet, functioning primarily over ==UDP port 53== for queries and ==TCP port 53== for zone transfers.

**Core Functions:**
- **Name Resolution**: Translates hostnames to IP addresses (forward DNS) and IP addresses to hostnames (reverse DNS)
- **Mail Server Mapping**: Maps domain names to mail server addresses via MX records
- **Load Distribution**: Enables load balancing by mapping one domain to multiple IP addresses
- **Service Discovery**: Supports service location through SRV records
- **Alias Management**: Provides canonical name resolution for domain aliases

## DNS Architecture

### Hierarchical Structure

![](Pasted%20image%2020240512185352.png)

The DNS namespace forms a ==tree structure== with the following characteristics:

- **Root Domain**: Represented by an empty label (written as `.`), maintained by 13 root server clusters worldwide
- **Top-Level Domains (TLDs)**: First level below root, includes generic TLDs (`.com`, `.org`, `.net`) and country-code TLDs (`.vn`, `.us`, `.uk`)
- **Second-Level Domains**: Registered domain names (`google` in `google.com`)
- **Subdomains**: Any domains below second-level (`www` in `www.google.com`, `mail.example.com`)

**Naming Constraints:**
- Each label (domain component) can be up to ==63 characters== long
- Full Fully Qualified Domain Name (FQDN) must not exceed ==255 characters==
- Labels are case-insensitive but case-preserving
- Valid characters: letters, digits, hyphens (cannot start or end with hyphen)

### DNS Server Types

DNS infrastructure consists of four primary server types:

**1. Root Name Servers**
- 13 logical root server clusters (labeled A through M)
- Managed by organizations like ICANN, Verisign, NASA
- Return authoritative referrals to TLD servers
- Distributed globally using anycast routing

**2. Top-Level Domain (TLD) Servers**
- Manage TLD zones (`.com`, `.org`, `.edu`, etc.)
- Verisign operates `.com` and `.net` TLD servers
- Educause operates `.edu` TLD servers
- Return referrals to authoritative name servers

**3. Authoritative Name Servers**
- Provide definitive answers for domains they control
- Maintained by organizations or DNS hosting providers
- Contain actual DNS records (A, AAAA, MX, etc.)
- Can be primary (master) or secondary (slave)

**4. Recursive Resolvers (Local DNS Servers)**
- Perform recursive lookups on behalf of clients
- Typically operated by ISPs or public DNS providers (Google DNS, Cloudflare)
- Implement caching to improve performance
- Handle the iterative query process across DNS hierarchy
## DNS Resolution Process
- DNS resolution is the process of translating a domain name into an IP address. Two primary query methods exist: ==iterative== and ==recursive==.
### Iterative Query
- In an ==iterative query==, the client's DNS resolver queries multiple DNS servers sequentially, with each server providing referrals to the next server in the hierarchy.
#### Resolution flow
1. Client host sends query to ==local DNS server== (recursive resolver)
2. Local DNS server queries ==root name server== for TLD server address
3. Root returns referral: "I don't know, but ask the `.com` TLD server at `192.5.6.30`"
4. Local DNS server queries ==TLD server== for authoritative server address
5. TLD returns referral: "Ask `ns1.example.com` at `93.184.216.34`"
6. Local DNS server queries ==authoritative name server== for final answer
7. Authoritative server returns IP address: `93.184.216.34`
8. Local DNS server returns result to client
- ![](Pasted%20image%2020240512185745.png)
#### Practical example
```Shell title='Using dig with +trace to see iterative resolution'
$ dig +trace www.example.com

; <<>> DiG 9.18.12 <<>> +trace www.example.com
;; global options: +cmd
.                       518400  IN      NS      a.root-servers.net.
.                       518400  IN      NS      b.root-servers.net.
;; Received 228 bytes from 192.168.1.1#53(192.168.1.1) in 12 ms

com.                    172800  IN      NS      a.gtld-servers.net.
com.                    172800  IN      NS      b.gtld-servers.net.
;; Received 839 bytes from 198.41.0.4#53(a.root-servers.net) in 45 ms

example.com.            172800  IN      NS      a.iana-servers.net.
example.com.            172800  IN      NS      b.iana-servers.net.
;; Received 590 bytes from 192.5.6.30#53(a.gtld-servers.net) in 78 ms

www.example.com.        86400   IN      A       93.184.216.34
;; Received 62 bytes from 199.43.135.53#53(a.iana-servers.net) in 23 ms
```
#### Characteristics
- Distributes query load across DNS infrastructure
- Root servers only provide referrals (minimal processing)
- Most commonly used method in production
### Recursive Query
- In a ==recursive query==, each DNS server takes full responsibility for resolving the query, forwarding requests up the hierarchy as needed.
#### Resolution flow
1. Client sends query to local DNS server: "What is `www.example.com`?"
2. Local DNS server forwards query to root server recursively
3. Root server queries TLD server on behalf of local DNS server
4. TLD server queries authoritative server on behalf of root server
5. Authoritative server returns answer to TLD server
6. TLD server returns answer to root server
7. Root server returns answer to local DNS server
8. Local DNS server returns answer to client

![](Pasted%20image%2020240512185942.png)

**Drawbacks:**
- Places heavy load on root DNS servers
- Root servers must handle full resolution burden
- Rarely used in practice (most resolvers use iterative)

**Comparison Table:**

| Aspect | Iterative Query | Recursive Query |
|--------|----------------|-----------------|
| **Query burden** | Distributed across hierarchy | Concentrated on upstream servers |
| **Root server load** | Low (only referrals) | High (full resolution) |
| **Network efficiency** | More DNS traffic | Less DNS traffic |
| **Common usage** | Standard in production | Rare (specific scenarios) |
| **Client complexity** | Handled by resolver | Minimal client work |
## DNS Caching

==DNS caching== is a mechanism that stores DNS query results temporarily to reduce latency, decrease network traffic, and minimize load on DNS servers. Caches exist at multiple levels in the DNS resolution chain.

**Caching Levels:**
- **Browser Cache**: Modern browsers cache DNS records (typically 60 seconds)
- **Operating System Cache**: OS-level DNS cache maintained by system resolver
- **Router Cache**: Home/office routers often cache DNS responses
- **ISP Resolver Cache**: Recursive resolvers maintain extensive caches
- **Authoritative Server Cache**: Some servers cache glue records and delegations

**Time-To-Live (TTL):**

Each DNS record includes a ==TTL value== (in seconds) that specifies how long the record can be cached before requiring revalidation.

```Shell title='Viewing TTL values with dig'
$ dig example.com A

;; ANSWER SECTION:
example.com.            86400   IN      A       93.184.216.34
                        ^^^^^
                        TTL in seconds (24 hours)
```

**Cache Management Examples:**

```Shell title='Flush DNS cache on Linux'
# Ubuntu/Debian (systemd-resolved)
$ sudo systemd-resolve --flush-caches
$ sudo systemctl restart systemd-resolved

# Clear local DNS cache
$ sudo resolvectl flush-caches
```

```Shell title='Flush DNS cache on macOS'
# macOS Monterey and later
$ sudo dscacheutil -flushcache
$ sudo killall -HUP mDNSResponder
```

```Shell title='Flush DNS cache on Windows'
# Windows Command Prompt (Administrator)
> ipconfig /flushdns

Windows IP Configuration
Successfully flushed the DNS Resolver Cache.
```

**Cache Poisoning Protection:**

Modern DNS implementations include protections against cache poisoning:
- ==Query ID randomization==: Random 16-bit identifier for each query
- ==Source port randomization==: Random UDP source port (not just 53)
- ==DNSSEC validation==: Cryptographic verification of DNS responses
- ==0x20 encoding==: Mixed-case randomization in domain names

## DNS Records

DNS records are stored in zone files on authoritative name servers. Each record follows the format:

```Text
name    TTL    class    type    value
```

Standard form: $(name, value, type, TTL)$

### A Record (Address Record)

Maps ==hostname to IPv4 address==. Most common DNS record type.

**Format:** `hostname` $\mapsto$ `IPv4 address`

```Text title='A record example'
www.example.com.    3600    IN    A    93.184.216.34
example.com.        3600    IN    A    93.184.216.34
```

```Shell title='Query A records'
$ dig example.com A +short
93.184.216.34

$ nslookup example.com
Server:         8.8.8.8
Address:        8.8.8.8#53

Non-authoritative answer:
Name:   example.com
Address: 93.184.216.34
```

### AAAA Record (IPv6 Address Record)

Maps ==hostname to IPv6 address==.

**Format:** `hostname` $\mapsto$ `IPv6 address`

```Text title='AAAA record example'
www.example.com.    3600    IN    AAAA    2606:2800:220:1:248:1893:25c8:1946
```

```Shell title='Query AAAA records'
$ dig example.com AAAA +short
2606:2800:220:1:248:1893:25c8:1946
```

### CNAME Record (Canonical Name)

Creates ==alias== for another domain name. Maps alias to ==canonical name==.

**Format:** `alias` $\mapsto$ `canonical hostname`

```Text title='CNAME record example'
www.example.com.        3600    IN    CNAME    example.com.
blog.example.com.       3600    IN    CNAME    hosting.provider.com.
cdn.example.com.        3600    IN    CNAME    d111111abcdef8.cloudfront.net.
```

```Shell title='Query CNAME records'
$ dig www.github.com

;; ANSWER SECTION:
www.github.com.         3600    IN    CNAME    github.com.
github.com.             60      IN    A        140.82.121.4
```

**Important Constraints:**
- CNAME cannot coexist with other records at the same name
- CNAME cannot be placed at zone apex (`example.com`)
- CNAME chains should be avoided (maximum 2-3 levels)

### NS Record (Name Server)

Specifies ==authoritative name servers== for a domain or zone.

**Format:** `domain` $\mapsto$ `nameserver hostname`

```Text title='NS record example'
example.com.        172800    IN    NS    a.iana-servers.net.
example.com.        172800    IN    NS    b.iana-servers.net.
subdomain.example.com.  86400    IN    NS    ns1.hosting.com.
```

```Shell title='Query NS records'
$ dig example.com NS +short
a.iana-servers.net.
b.iana-servers.net.
```

### MX Record (Mail Exchange)

Maps domain to ==mail server== with priority values. Lower priority number means higher preference.

**Format:** `domain` $\mapsto$ `priority mail-server`

```Text title='MX record example'
example.com.    3600    IN    MX    10    mail1.example.com.
example.com.    3600    IN    MX    20    mail2.example.com.
example.com.    3600    IN    MX    30    backup-mail.example.com.
```

```Shell title='Query MX records'
$ dig example.com MX +short
10 mail1.example.com.
20 mail2.example.com.

$ dig gmail.com MX
;; ANSWER SECTION:
gmail.com.        3600    IN    MX    5  gmail-smtp-in.l.google.com.
gmail.com.        3600    IN    MX    10 alt1.gmail-smtp-in.l.google.com.
```

### TXT Record (Text Record)

Stores ==arbitrary text data==. Used for SPF, DKIM, DMARC, domain verification.

```Text title='TXT record examples'
example.com.    3600    IN    TXT    "v=spf1 include:_spf.google.com ~all"
example.com.    3600    IN    TXT    "google-site-verification=abc123xyz"
_dmarc.example.com. 3600 IN   TXT    "v=DMARC1; p=reject; rua=mailto:dmarc@example.com"
```

```Shell title='Query TXT records'
$ dig example.com TXT +short
"v=spf1 -all"
"wgyf8z8cgvm2qmxpnbnldrcltvk4xqfn"
```

### PTR Record (Pointer Record)

Provides ==reverse DNS lookup== (IP address to hostname). Used in `in-addr.arpa` zones.

**Format:** `reversed-IP.in-addr.arpa` $\mapsto$ `hostname`

```Text title='PTR record example'
34.216.184.93.in-addr.arpa.    86400    IN    PTR    example.com.
```

```Shell title='Reverse DNS lookup'
$ dig -x 8.8.8.8 +short
dns.google.

$ host 8.8.8.8
8.8.8.8.in-addr.arpa domain name pointer dns.google.
```

### SRV Record (Service Record)

Specifies ==location of services== (hostname and port).

**Format:** `_service._protocol.domain` $\mapsto$ `priority weight port target`

```Text title='SRV record example'
_http._tcp.example.com.    3600    IN    SRV    10 60 80 server1.example.com.
_ldap._tcp.example.com.    3600    IN    SRV    10 50 389 ldap.example.com.
_sip._tcp.example.com.     3600    IN    SRV    10 60 5060 sipserver.example.com.
```

### SOA Record (Start of Authority)

Contains ==zone information== including primary name server, admin email, serial number, and timing parameters.

```Text title='SOA record example'
example.com.    3600    IN    SOA    ns1.example.com. admin.example.com. (
                                    2024051401 ; Serial
                                    3600       ; Refresh (1 hour)
                                    900        ; Retry (15 minutes)
                                    604800     ; Expire (1 week)
                                    86400 )    ; Minimum TTL (1 day)
```

**DNS Record Type Summary:**

| Type | Purpose | Example |
|------|---------|---------|
| **A** | IPv4 address | `example.com` $\mapsto$ `93.184.216.34` |
| **AAAA** | IPv6 address | `example.com` $\mapsto$ `2606:2800:220:1:248:...` |
| **CNAME** | Alias to canonical name | `www.example.com` $\mapsto$ `example.com` |
| **MX** | Mail server | `example.com` $\mapsto$ `10 mail.example.com` |
| **NS** | Authoritative name server | `example.com` $\mapsto$ `ns1.example.com` |
| **TXT** | Text information | SPF, DKIM, verification |
| **PTR** | Reverse DNS | `93.184.216.34` $\mapsto$ `example.com` |
| **SRV** | Service location | `_http._tcp` $\mapsto$ `80 server.example.com` |
| **SOA** | Zone authority | Zone metadata |
| **CAA** | Certificate authority | Authorized CAs for SSL |

## DNS Message Format

DNS messages use a binary format for both queries and responses. Both share the same structure.

![](Pasted%20image%2020240514202035.png)

**Message Structure:**

```Text title='DNS message format'
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
|                    Header                     |
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
|                   Question                    |  (Query section)
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
|                    Answer                     |  (Response section)
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
|                   Authority                   |  (NS records)
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
|                  Additional                   |  (Glue records)
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
```

**Header Section (12 bytes):**

| Field | Size | Description |
|-------|------|-------------|
| **ID** | 16 bits | Query identifier (matched in response) |
| **Flags** | 16 bits | QR, Opcode, AA, TC, RD, RA, Z, RCODE |
| **QDCOUNT** | 16 bits | Number of questions |
| **ANCOUNT** | 16 bits | Number of answer records |
| **NSCOUNT** | 16 bits | Number of authority records |
| **ARCOUNT** | 16 bits | Number of additional records |

**Header Flags:**
- **QR (1 bit)**: Query (0) or Response (1)
- **Opcode (4 bits)**: Query type (0=standard, 1=inverse, 2=status)
- **AA (1 bit)**: Authoritative Answer
- **TC (1 bit)**: Truncation (message was truncated)
- **RD (1 bit)**: Recursion Desired
- **RA (1 bit)**: Recursion Available
- **Z (3 bits)**: Reserved (must be zero)
- **RCODE (4 bits)**: Response code (0=success, 3=NXDOMAIN)

**Response Codes (RCODE):**

| Code | Name | Meaning |
|------|------|---------|
| 0 | NOERROR | No error |
| 1 | FORMERR | Format error |
| 2 | SERVFAIL | Server failure |
| 3 | NXDOMAIN | Non-existent domain |
| 4 | NOTIMP | Not implemented |
| 5 | REFUSED | Query refused |

## Practical DNS Tools and Examples

### Command-Line Tools

**dig (Domain Information Groper)**

The most powerful DNS query tool for detailed DNS information.

```Shell title='Basic dig usage'
# Query A record
$ dig example.com

# Short answer only
$ dig example.com +short
93.184.216.34

# Query specific record type
$ dig example.com MX
$ dig example.com NS
$ dig example.com TXT

# Query specific DNS server
$ dig @8.8.8.8 example.com

# Reverse DNS lookup
$ dig -x 8.8.8.8

# Trace full resolution path
$ dig +trace example.com

# Query with detailed statistics
$ dig example.com +stats

# Query multiple domains
$ dig example.com google.com
```

**nslookup (Name Server Lookup)**

Cross-platform interactive DNS query tool.

```Shell title='nslookup usage'
# Simple query
$ nslookup example.com

# Query specific server
$ nslookup example.com 8.8.8.8

# Query specific record type
$ nslookup -type=MX example.com
$ nslookup -type=NS example.com
$ nslookup -type=TXT example.com

# Reverse lookup
$ nslookup 8.8.8.8

# Interactive mode
$ nslookup
> set type=MX
> example.com
> exit
```

**host Command**

Simple DNS lookup utility.

```Shell title='host command usage'
# Basic lookup
$ host example.com

# Query specific type
$ host -t MX example.com
$ host -t NS example.com
$ host -t AAAA example.com

# Reverse lookup
$ host 8.8.8.8

# Verbose output
$ host -v example.com

# Query all record types
$ host -a example.com
```

### Programming DNS Queries

**Python DNS Resolution:**

```Python title='DNS queries with dnspython library'
import dns.resolver
import dns.reversename

# Basic A record query
def query_a_record(domain):
    try:
        answers = dns.resolver.resolve(domain, 'A')
        for rdata in answers:
            print(f'IP address: {rdata.address}')
    except dns.resolver.NXDOMAIN:
        print(f'Domain {domain} does not exist')
    except dns.resolver.NoAnswer:
        print(f'No A record found for {domain}')

query_a_record('example.com')
# Output: IP address: 93.184.216.34

# Query MX records
def query_mx_records(domain):
    answers = dns.resolver.resolve(domain, 'MX')
    for rdata in answers:
        print(f'Priority: {rdata.preference}, Mail server: {rdata.exchange}')

query_mx_records('gmail.com')
# Output:
# Priority: 5, Mail server: gmail-smtp-in.l.google.com.
# Priority: 10, Mail server: alt1.gmail-smtp-in.l.google.com.

# Reverse DNS lookup
def reverse_dns(ip_address):
    addr = dns.reversename.from_address(ip_address)
    answers = dns.resolver.resolve(addr, 'PTR')
    for rdata in answers:
        print(f'Hostname: {rdata.target}')

reverse_dns('8.8.8.8')
# Output: Hostname: dns.google.

# Query with specific nameserver
def query_with_server(domain, nameserver):
    resolver = dns.resolver.Resolver()
    resolver.nameservers = [nameserver]
    answers = resolver.resolve(domain, 'A')
    for rdata in answers:
        print(f'IP: {rdata.address}')

query_with_server('example.com', '8.8.8.8')

# Get DNS TTL
def get_ttl(domain):
    answers = dns.resolver.resolve(domain, 'A')
    print(f'TTL: {answers.rrset.ttl} seconds')

get_ttl('example.com')
# Output: TTL: 86400 seconds
```

**Node.js DNS Resolution:**

```JavaScript title='DNS queries with Node.js dns module'
const dns = require('dns').promises;
const { Resolver } = require('dns');

// Basic DNS lookup
async function lookupDomain(domain) {
    try {
        const addresses = await dns.resolve4(domain);
        console.log('IP addresses:', addresses);
    } catch (error) {
        console.error('Lookup failed:', error.message);
    }
}

lookupDomain('example.com');
// Output: IP addresses: [ '93.184.216.34' ]

// IPv6 lookup
async function lookupIPv6(domain) {
    const addresses = await dns.resolve6(domain);
    console.log('IPv6 addresses:', addresses);
}

lookupIPv6('example.com');
// Output: IPv6 addresses: [ '2606:2800:220:1:248:1893:25c8:1946' ]

// MX records
async function getMXRecords(domain) {
    const records = await dns.resolveMx(domain);
    records.forEach(record => {
        console.log(`Priority: ${record.priority}, Exchange: ${record.exchange}`);
    });
}

getMXRecords('gmail.com');

// NS records
async function getNSRecords(domain) {
    const nameservers = await dns.resolveNs(domain);
    console.log('Nameservers:', nameservers);
}

getNSRecords('example.com');
// Output: Nameservers: [ 'a.iana-servers.net', 'b.iana-servers.net' ]

// TXT records
async function getTXTRecords(domain) {
    const records = await dns.resolveTxt(domain);
    records.forEach(record => {
        console.log('TXT:', record.join(''));
    });
}

getTXTRecords('example.com');

// Reverse DNS
async function reverseLookup(ip) {
    const hostnames = await dns.reverse(ip);
    console.log('Hostnames:', hostnames);
}

reverseLookup('8.8.8.8');
// Output: Hostnames: [ 'dns.google' ]

// Custom DNS server
async function queryCustomServer(domain) {
    const resolver = new Resolver();
    resolver.setServers(['8.8.8.8', '8.8.4.4']);

    const addresses = await resolver.resolve4(domain);
    console.log('Addresses:', addresses);
}

queryCustomServer('example.com');

// CNAME resolution
async function getCNAME(domain) {
    try {
        const cnames = await dns.resolveCname(domain);
        console.log('CNAME:', cnames);
    } catch (error) {
        console.log('No CNAME record');
    }
}

getCNAME('www.github.com');
// Output: CNAME: [ 'github.com' ]
```

**Java DNS Resolution:**

```Java title='DNS queries with Java InetAddress'
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Arrays;

public class DNSResolver {

    // Basic hostname to IP resolution
    public static void resolveHostname(String hostname) {
        try {
            InetAddress address = InetAddress.getByName(hostname);
            System.out.println("IP Address: " + address.getHostAddress());
            System.out.println("Hostname: " + address.getHostName());
        } catch (UnknownHostException e) {
            System.err.println("Unknown host: " + hostname);
        }
    }

    // Get all IP addresses for a hostname
    public static void getAllAddresses(String hostname) {
        try {
            InetAddress[] addresses = InetAddress.getAllByName(hostname);
            System.out.println("All addresses for " + hostname + ":");
            Arrays.stream(addresses)
                  .forEach(addr -> System.out.println("  " + addr.getHostAddress()));
        } catch (UnknownHostException e) {
            System.err.println("Unknown host: " + hostname);
        }
    }

    // Reverse DNS lookup
    public static void reverseLookup(String ip) {
        try {
            InetAddress address = InetAddress.getByName(ip);
            String hostname = address.getCanonicalHostName();
            System.out.println("IP: " + ip + " -> Hostname: " + hostname);
        } catch (UnknownHostException e) {
            System.err.println("Invalid IP: " + ip);
        }
    }

    // Get local hostname
    public static void getLocalHostInfo() {
        try {
            InetAddress localhost = InetAddress.getLocalHost();
            System.out.println("Local hostname: " + localhost.getHostName());
            System.out.println("Local IP: " + localhost.getHostAddress());
        } catch (UnknownHostException e) {
            System.err.println("Cannot determine localhost");
        }
    }

    public static void main(String[] args) {
        resolveHostname("example.com");
        // Output:
        // IP Address: 93.184.216.34
        // Hostname: example.com

        getAllAddresses("google.com");
        reverseLookup("8.8.8.8");
        getLocalHostInfo();
    }
}
```

## DNS Security

### DNSSEC (DNS Security Extensions)

==DNSSEC== adds cryptographic signatures to DNS records to prevent tampering and cache poisoning attacks. It provides ==data origin authentication== and ==data integrity== but not confidentiality.

**DNSSEC Record Types:**
- **RRSIG**: Contains cryptographic signature for a DNS record set
- **DNSKEY**: Public key used to verify RRSIG records
- **DS (Delegation Signer)**: Hash of child zone's DNSKEY, stored in parent zone
- **NSEC/NSEC3**: Authenticated denial of existence

```Shell title='Query DNSSEC records'
# Check if domain has DNSSEC
$ dig example.com +dnssec

# Query DNSKEY records
$ dig example.com DNSKEY +short

# Validate DNSSEC chain
$ dig +dnssec +multi example.com

# Check DS records in parent zone
$ dig com DS | grep example
```

**DNSSEC Validation Process:**
1. Resolver queries DNS with DO (DNSSEC OK) flag set
2. Authoritative server returns answer with RRSIG signature
3. Resolver fetches DNSKEY from authoritative server
4. Resolver validates DNSKEY using DS record from parent zone
5. Resolver verifies RRSIG signature using DNSKEY
6. Chain of trust established from root to target domain

### DNS over HTTPS (DoH)

==DNS over HTTPS== encrypts DNS queries using HTTPS protocol (port 443), preventing eavesdropping and tampering.

**Public DoH Providers:**
- **Cloudflare**: `https://1.1.1.1/dns-query`
- **Google**: `https://dns.google/dns-query`
- **Quad9**: `https://dns.quad9.net/dns-query`

```Shell title='DNS over HTTPS with curl'
# Query using Cloudflare DoH
$ curl -H 'accept: application/dns-json' \
  'https://1.1.1.1/dns-query?name=example.com&type=A'

# Output (JSON):
{
  "Status": 0,
  "TC": false,
  "RD": true,
  "RA": true,
  "AD": false,
  "CD": false,
  "Question": [{"name": "example.com", "type": 1}],
  "Answer": [
    {"name": "example.com", "type": 1, "TTL": 86400, "data": "93.184.216.34"}
  ]
}

# Query using Google DoH
$ curl 'https://dns.google/resolve?name=example.com&type=A'
```

```Python title='DoH client in Python'
import requests

def doh_query(domain, record_type='A', server='https://1.1.1.1/dns-query'):
    """Query DNS using DNS over HTTPS"""
    headers = {'accept': 'application/dns-json'}
    params = {'name': domain, 'type': record_type}

    response = requests.get(server, headers=headers, params=params)
    data = response.json()

    if data['Status'] == 0:  # NOERROR
        answers = data.get('Answer', [])
        for answer in answers:
            print(f"{answer['name']} -> {answer['data']} (TTL: {answer['TTL']})")
    else:
        print(f"Query failed with status: {data['Status']}")

doh_query('example.com')
# Output: example.com -> 93.184.216.34 (TTL: 86400)

doh_query('example.com', 'AAAA')
doh_query('gmail.com', 'MX')
```

### DNS over TLS (DoT)

==DNS over TLS== encrypts DNS queries using TLS protocol over ==port 853==.

```Shell title='DNS over TLS with kdig'
# Query using DNS over TLS (requires knot-dnsutils)
$ kdig -d @1.1.1.1 +tls example.com

# OpenSSL verification of DoT
$ openssl s_client -connect 1.1.1.1:853
```

**DoH vs DoT Comparison:**

| Feature | DoH | DoT |
|---------|-----|-----|
| **Port** | 443 (HTTPS) | 853 (dedicated) |
| **Protocol** | HTTPS | TLS |
| **Firewall detection** | Hard to block | Easy to identify |
| **Performance** | HTTP overhead | Minimal overhead |
| **Browser support** | Native in browsers | Requires configuration |
| **Network visibility** | Hidden in HTTPS traffic | Visible as DNS traffic |

## Performance Considerations

### DNS Query Optimization

**Best Practices:**
- Use ==appropriate TTL values== (3600-86400 seconds for stable records)
- Implement ==multiple nameservers== (minimum 2, recommended 4)
- Use ==anycast routing== for global distribution
- Configure ==EDNS0== for larger response sizes (up to 4096 bytes)
- Minimize CNAME chains (each adds additional query)
- Use ==DNS prefetching== in web applications

**DNS Prefetching in HTML:**

```HTML title='DNS prefetch hints'
<!DOCTYPE html>
<html>
<head>
    <!-- Prefetch DNS for external resources -->
    <link rel="dns-prefetch" href="//cdn.example.com">
    <link rel="dns-prefetch" href="//api.example.com">
    <link rel="dns-prefetch" href="//fonts.googleapis.com">
</head>
<body>
    <!-- Page content -->
</body>
</html>
```

**DNS Load Balancing:**

```Text title='Round-robin DNS for load distribution'
www.example.com.    300    IN    A    192.0.2.1
www.example.com.    300    IN    A    192.0.2.2
www.example.com.    300    IN    A    192.0.2.3
www.example.com.    300    IN    A    192.0.2.4
```

### Performance Metrics

**Typical DNS Query Latency:**
- **Local cache hit**: < 1 ms
- **ISP resolver cache hit**: 10-30 ms
- **Full recursive resolution**: 50-200 ms
- **International queries**: 100-500 ms

```Shell title='Measure DNS query time'
# Using dig to measure query time
$ dig example.com | grep "Query time"
;; Query time: 23 msec

# Benchmark multiple queries
$ for i in {1..10}; do dig example.com | grep "Query time"; done

# Time full resolution with +trace
$ time dig +trace example.com > /dev/null
```

## Common DNS Issues and Troubleshooting

### Troubleshooting Workflow

**1. Verify DNS Resolution:**

```Shell title='Test DNS resolution'
# Test basic resolution
$ dig example.com +short

# Check if DNS server responds
$ dig @8.8.8.8 example.com +short

# Verify all record types
$ dig example.com ANY
```

**2. Check DNS Propagation:**

```Shell title='Check multiple DNS servers'
# Query different public DNS servers
$ dig @8.8.8.8 example.com +short       # Google
$ dig @1.1.1.1 example.com +short       # Cloudflare
$ dig @208.67.222.222 example.com +short # OpenDNS

# Check authoritative servers
$ dig @$(dig example.com NS +short | head -1) example.com
```

**3. Investigate TTL and Caching:**

```Shell title='Check TTL values'
# Monitor TTL countdown
$ watch -n 1 'dig example.com | grep -A1 "ANSWER SECTION"'

# Clear local cache and retest
$ sudo systemd-resolve --flush-caches
$ dig example.com
```

### Common DNS Problems

**Problem: NXDOMAIN (Non-Existent Domain)**

```Shell title='Diagnose NXDOMAIN errors'
$ dig nonexistent.example.com

;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 12345
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 0

# Check if parent domain exists
$ dig example.com SOA

# Verify DNS server configuration
$ cat /etc/resolv.conf
```

**Problem: SERVFAIL (Server Failure)**

```Shell title='Debug SERVFAIL responses'
# Test with different DNS servers
$ dig @8.8.8.8 example.com
$ dig @1.1.1.1 example.com

# Check DNSSEC validation
$ dig +dnssec example.com

# Disable DNSSEC validation
$ dig +cd example.com
```

**Problem: Slow DNS Resolution**

```Shell title='Diagnose slow queries'
# Measure query time
$ dig example.com +stats

# Test different nameservers
$ time dig @8.8.8.8 example.com
$ time dig @1.1.1.1 example.com

# Check network path
$ traceroute 8.8.8.8
```

**Problem: DNS Cache Poisoning**

```Shell title='Verify DNS response authenticity'
# Check DNSSEC validation
$ dig +dnssec +multiline example.com

# Verify response from authoritative server
$ dig @$(dig example.com NS +short | head -1) example.com

# Compare responses from multiple sources
$ diff <(dig @8.8.8.8 example.com) <(dig @1.1.1.1 example.com)
```

### DNS Debugging Script

```Bash title='Comprehensive DNS diagnostic script'
#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

echo "=== DNS Diagnostic Report for $DOMAIN ==="
echo ""

echo "1. Basic A Record:"
dig $DOMAIN A +short
echo ""

echo "2. All Record Types:"
dig $DOMAIN ANY +noall +answer
echo ""

echo "3. Nameservers:"
dig $DOMAIN NS +short
echo ""

echo "4. MX Records:"
dig $DOMAIN MX +short
echo ""

echo "5. TXT Records:"
dig $DOMAIN TXT +short
echo ""

echo "6. Query from Multiple Resolvers:"
echo "  Google DNS (8.8.8.8):"
dig @8.8.8.8 $DOMAIN +short
echo "  Cloudflare (1.1.1.1):"
dig @1.1.1.1 $DOMAIN +short
echo ""

echo "7. TTL Values:"
dig $DOMAIN | grep -A 1 "ANSWER SECTION"
echo ""

echo "8. Authoritative Answer:"
AUTH_NS=$(dig $DOMAIN NS +short | head -1)
dig @$AUTH_NS $DOMAIN +short
echo ""

echo "9. DNSSEC Status:"
dig $DOMAIN +dnssec +short
echo ""

echo "10. Reverse DNS for first IP:"
IP=$(dig $DOMAIN A +short | head -1)
if [ ! -z "$IP" ]; then
    dig -x $IP +short
fi
```
***
# References
1. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross - Pearson (2021)
	1. Chapter 2: Application Layer
		1. Section 2.4: DNS - The Internet's Directory Service
2. Computer Networks - Andrew S. Tanenbaum, David J. Wetherall - Prentice Hall Publisher (2011)
	1. Chapter 7: The Application Layer
		1. Section 7.1: The Domain Name System
3. DNS and BIND, 5th Edition - Cricket Liu, Paul Albitz - O'Reilly Media (2006)
	1. Comprehensive guide to DNS administration and BIND configuration
4. RFC 1034 - Domain Names: Concepts and Facilities (1987)
	1. https://www.rfc-editor.org/rfc/rfc1034 for DNS architecture and concepts
5. RFC 1035 - Domain Names: Implementation and Specification (1987)
	1. https://www.rfc-editor.org/rfc/rfc1035 for DNS protocol specification
6. RFC 4033, 4034, 4035 - DNS Security Extensions (DNSSEC)
	1. https://www.rfc-editor.org/rfc/rfc4033 for DNSSEC introduction
	2. https://www.rfc-editor.org/rfc/rfc4034 for resource records
	3. https://www.rfc-editor.org/rfc/rfc4035 for protocol modifications
7. RFC 8484 - DNS Queries over HTTPS (DoH)
	1. https://www.rfc-editor.org/rfc/rfc8484 for DoH specification
8. RFC 7858 - Specification for DNS over Transport Layer Security (DoT)
	1. https://www.rfc-editor.org/rfc/rfc7858 for DoT specification
9. https://www.iana.org/domains/root/servers for 13 root domain name servers
10. https://www.cloudflare.com/learning/dns/what-is-dns/ for DNS concepts and security
11. https://www.cloudflare.com/learning/dns/dns-server-types/ for DNS server types
12. https://developers.google.com/speed/public-dns for Google Public DNS documentation
13. https://developers.cloudflare.com/1.1.1.1/ for Cloudflare DNS resolver documentation
14. https://www.isc.org/bind/ for BIND DNS server software
15. https://dnspython.readthedocs.io/ for dnspython library documentation
16. https://nodejs.org/api/dns.html for Node.js DNS module documentation