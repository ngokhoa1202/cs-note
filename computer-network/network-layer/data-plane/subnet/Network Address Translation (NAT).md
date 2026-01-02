#nat #network-layer #computer-network #data-plane #subnet #backend #site-reliability-engineering
# Overview
- Enables multiple hosts to share a ==single public IP address==
- Maps ==private IP addresses== to ==public IP addresses== for outbound traffic
- Router maintains ==NAT translation table== with WAN ↔ LAN address mappings
- Critical for IPv4 address conservation and security
# NAT Types
## Static NAT (One-to-One)
- Maps single private IP to single public IP permanently
- Bidirectional: external hosts can initiate connections
- **Use case**: Public-facing servers (web, mail, database)

```
Private IP      →  Public IP
192.168.1.10    →  203.0.113.10  (permanent mapping)
```
## Dynamic NAT (Pool-based)
- Maps private IPs to pool of public IPs dynamically
- First-come, first-served allocation
- **Limitation**: Pool exhaustion when all public IPs are in use
```
Private Network     Public IP Pool
192.168.1.0/24  →   203.0.113.10-20 (10 addresses)
```
## PAT (Port Address Translation)
- Also called ==NAT Overload== or ==NAPT==
- Maps multiple private IPs to single public IP using ==different ports==
- **Most common** NAT type in production environments

```
Source              →  NAT Router           →  Destination
192.168.1.10:4523   →  203.0.113.5:10234   →  8.8.8.8:53
192.168.1.11:4523   →  203.0.113.5:10235   →  8.8.8.8:53
192.168.1.12:8080   →  203.0.113.5:10236   →  1.1.1.1:443
```
## Carrier-Grade NAT (CGN / NAT444)
- Double NAT: ISP performs NAT, then customer gateway performs NAT
- **Issue**: Breaks applications requiring end-to-end connectivity
- **Common in**: Mobile networks, IPv4 address-constrained ISPs
# NAT Translation Table

**Example NAT Table (PAT):**
| Private IP:Port | Public IP:Port | Destination IP:Port | Protocol | Timeout |
|-----------------|----------------|---------------------|----------|---------|
| 192.168.1.10:5234 | 203.0.113.5:10234 | 8.8.8.8:53 | UDP | 60s |
| 192.168.1.10:4523 | 203.0.113.5:10235 | 1.1.1.1:443 | TCP | 300s |
| 192.168.1.11:8080 | 203.0.113.5:10236 | 10.0.5.3:80 | TCP | 300s |

**Timeout Values:**
- **UDP**: 30-60 seconds (stateless)
- **TCP Established**: 300-3600 seconds
- **TCP SYN**: 60 seconds
- **ICMP**: 30 seconds
## Port Forwarding (Destination NAT)
- Maps external port to internal host port
- Enables inbound connections to private network services
```bash
# Linux iptables example
iptables -t nat -A PREROUTING -p tcp --dport 80 \
  -j DNAT --to-destination 192.168.1.10:8080

# AWS Security Group + Target Group handles this automatically
# GCP Forwarding Rule maps external IP:port to internal instance
```

**Common Port Forwards:**
```
External          →  Internal
80 (HTTP)         →  192.168.1.10:8080 (web server)
443 (HTTPS)       →  192.168.1.10:8443
22 (SSH)          →  192.168.1.20:22
3306 (MySQL)      →  192.168.1.30:3306
```
***
# References
1. [RFC 1631 - The IP Network Address Translator (NAT)](https://tools.ietf.org/html/rfc1631)
2. [RFC 3022 - Traditional IP Network Address Translator](https://tools.ietf.org/html/rfc3022)
3. [RFC 4787 - NAT Behavioral Requirements for UDP](https://tools.ietf.org/html/rfc4787)
4. Computer Networking: A Top-Down Approach, 8th Edition - James F. Kurose, Keith W. Ross
	1. Chapter 4: Network Layer - The Data Plane
5. [AWS NAT Gateway Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
6. [GCP Cloud NAT Documentation](https://cloud.google.com/nat/docs/overview)
