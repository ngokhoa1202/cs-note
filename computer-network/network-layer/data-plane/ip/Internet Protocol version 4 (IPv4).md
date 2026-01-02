#ip #network-layer #computer-network #protocol #backend #site-reliability-engineering
# Overview
- ==32-bit address== space (≈4.3 billion addresses)
- Represented as ==4 octets== in dotted-decimal notation (0-255)
- Uses ==CIDR notation== for subnet specification: `a.b.c.d/x`
- Primary internet protocol, gradually transitioning to IPv6
# Format
## Binary vs Decimal
```
Binary:    11000000.10101000.00000001.00001010
Decimal:   192.168.1.10
CIDR:      192.168.1.10/24
```
## Address Classes (Historical)
| Class | Range | Default Mask | Hosts | Use |
|-------|-------|--------------|-------|-----|
| A | 1.0.0.0 - 126.255.255.255 | /8 (255.0.0.0) | 16M | Large networks |
| B | 128.0.0.0 - 191.255.255.255 | /16 (255.255.0.0) | 65K | Medium networks |
| C | 192.0.0.0 - 223.255.255.255 | /24 (255.255.255.0) | 254 | Small networks |
| D | 224.0.0.0 - 239.255.255.255 | N/A | N/A | Multicast |
| E | 240.0.0.0 - 255.255.255.255 | N/A | N/A | Reserved |

**Note**: Classful addressing is ==obsolete==. Modern networks use ==CIDR==.

## Private IP Ranges (RFC 1918)

| Range | CIDR | Hosts | Common Use |
|-------|------|-------|------------|
| 10.0.0.0 - 10.255.255.255 | 10.0.0.0/8 | 16,777,216 | Enterprise, cloud VPC |
| 172.16.0.0 - 172.31.255.255 | 172.16.0.0/12 | 1,048,576 | Docker default, mid-size networks |
| 192.168.0.0 - 192.168.255.255 | 192.168.0.0/16 | 65,536 | Home networks, small office |

- Special Addresses:
    - `127.0.0.0/8` - Loopback (`127.0.0.1` = localhost)
    - `169.254.0.0/16` - Link-local (APIPA, auto-configuration)
    - `0.0.0.0/8` - Current network, default route
## CIDR (Classless Inter-Domain Routing)
### Subnet Mask Calculation
```
/24 = 11111111.11111111.11111111.00000000 = 255.255.255.0
/25 = 11111111.11111111.11111111.10000000 = 255.255.255.128
/26 = 11111111.11111111.11111111.11000000 = 255.255.255.192
/27 = 11111111.11111111.11111111.11100000 = 255.255.255.224
/28 = 11111111.11111111.11111111.11110000 = 255.255.255.240
```
### Usable Hosts Per Subnet
```
Formula: 2^(32 - prefix) - 2

/24 = 2^8  - 2 = 254 hosts
/25 = 2^7  - 2 = 126 hosts
/26 = 2^6  - 2 = 62 hosts
/27 = 2^5  - 2 = 30 hosts
/28 = 2^4  - 2 = 14 hosts
/29 = 2^3  - 2 = 6 hosts
/30 = 2^2  - 2 = 2 hosts (point-to-point links)
/31 = 2^1  - 0 = 2 hosts (RFC 3021, no network/broadcast)
/32 = 2^0  - 0 = 1 host (single IP)
```
- Subtract 2 for network address and broadcast address (except `/31`, `/32`).
### Common Subnet Reference

| CIDR | Mask            | Wildcard      | Hosts      | Use Case                           |
| ---- | --------------- | ------------- | ---------- | ---------------------------------- |
| /32  | 255.255.255.255 | 0.0.0.0       | 1          | Single host route                  |
| /31  | 255.255.255.254 | 0.0.0.1       | 2          | Point-to-point links               |
| /30  | 255.255.255.252 | 0.0.0.3       | 2          | Point-to-point links (traditional) |
| /29  | 255.255.255.248 | 0.0.0.7       | 6          | Tiny subnets                       |
| /28  | 255.255.255.240 | 0.0.0.15      | 14         | Small subnets                      |
| /27  | 255.255.255.224 | 0.0.0.31      | 30         | Department networks                |
| /26  | 255.255.255.192 | 0.0.0.63      | 62         | Small office                       |
| /25  | 255.255.255.128 | 0.0.0.127     | 126        | Medium networks                    |
| /24  | 255.255.255.0   | 0.0.0.255     | 254        | Standard subnet                    |
| /23  | 255.255.254.0   | 0.0.1.255     | 510        | Large office                       |
| /22  | 255.255.252.0   | 0.0.3.255     | 1,022      | Cloud subnets                      |
| /21  | 255.255.248.0   | 0.0.7.255     | 2,046      | Large cloud subnets                |
| /20  | 255.255.240.0   | 0.0.15.255    | 4,094      | Very large subnets                 |
| /16  | 255.255.0.0     | 0.0.255.255   | 65,534     | Enterprise networks, VPCs          |
| /8   | 255.0.0.0       | 0.255.255.255 | 16,777,214 | Largest private range              |
## Practical Subnetting Examples
### Example 1: Web Application Architecture
```
VPC: 10.0.0.0/16 (65,536 IPs)

├── 10.0.1.0/24  - Public subnet (web servers) - 254 hosts
├── 10.0.2.0/24  - Private subnet (app servers) - 254 hosts
├── 10.0.3.0/24  - Database subnet - 254 hosts
├── 10.0.4.0/28  - Management/bastion - 14 hosts
└── 10.0.5.0/28  - VPN gateway - 14 hosts
```

```
Network:    10.0.1.0
First IP:   10.0.1.1    (gateway)
Last IP:    10.0.1.254  (last usable)
Broadcast:  10.0.1.255
```
### Example 2: Multi-AZ Cloud Setup (AWS Style)
```
VPC: 172.16.0.0/16 (65,536 IPs)

Availability Zone A:
├── 172.16.0.0/20  - Public subnet AZ-A  (4,094 hosts)
├── 172.16.16.0/20 - Private subnet AZ-A (4,094 hosts)
└── 172.16.32.0/20 - Database subnet AZ-A (4,094 hosts)

Availability Zone B:
├── 172.16.48.0/20  - Public subnet AZ-B  (4,094 hosts)
├── 172.16.64.0/20  - Private subnet AZ-B (4,094 hosts)
└── 172.16.80.0/20  - Database subnet AZ-B (4,094 hosts)
```
### Example 3: Kubernetes Node Pools
```
VPC: 10.100.0.0/16

├── 10.100.0.0/22   - K8s worker nodes (1,022 nodes)
├── 10.100.4.0/22   - K8s master nodes (1,022 IPs)
├── 10.100.8.0/22   - Database nodes (1,022 IPs)
└── 10.100.64.0/18  - Pod CIDR range (16,382 pods)
```
**Pod IP Allocation:**
```
Each node gets /24 from 10.100.64.0/18
Node 1: 10.100.64.0/24  (254 pods)
Node 2: 10.100.65.0/24  (254 pods)
Node 3: 10.100.66.0/24  (254 pods)
...
```
## IPv4 Datagram Format
### Header Structure
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Version|  IHL  |Type of Service|          Total Length         |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         Identification        |Flags|      Fragment Offset    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  Time to Live |    Protocol   |         Header Checksum       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       Source Address                          |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Destination Address                        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                    Options                    |    Padding    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```
- **Minimum header**: 20 bytes (without options)
- **Maximum header**: 60 bytes (with maximum options)
### Key Fields

| Field | Bits | Description | Backend Relevance |
|-------|------|-------------|-------------------|
| **Version** | 4 | IP version (4 for IPv4) | Protocol identification |
| **IHL** | 4 | Header length (5-15 words) | Variable header size |
| **Type of Service (TOS)** | 8 | QoS, ECN flags | Traffic prioritization |
| **Total Length** | 16 | Packet size (max 65,535 bytes) | MTU considerations |
| **Identification** | 16 | Fragment identification | Fragmentation tracking |
| **Flags** | 3 | DF, MF flags | Fragmentation control |
| **Fragment Offset** | 13 | Fragment position | Reassembly |
| **TTL** | 8 | Hop count (0-255) | Loop prevention |
| **Protocol** | 8 | Upper-layer protocol | TCP=6, UDP=17, ICMP=1 |
| **Header Checksum** | 16 | Error detection | Packet integrity |
| **Source IP** | 32 | Sender address | Routing, filtering |
| **Destination IP** | 32 | Receiver address | Routing target |

### Type of Service (TOS) / DSCP
```
Original TOS (8 bits):
|Precedence (3)|Delay|Throughput|Reliability|Reserved (2)|

Modern DSCP (Differentiated Services Code Point):
|DSCP (6 bits)|ECN (2 bits)|

DSCP Values:
- EF (Expedited Forwarding): 46 - Voice traffic
- AF41 (Assured Forwarding): 34 - Video
- AF31: 26 - Streaming
- BE (Best Effort): 0 - Default traffic
```

**Cloud Platform Usage:**
```bash
# AWS VPC - QoS not directly configurable
# GCP - Premium vs Standard tier affects routing
# On-premises - Set DSCP for traffic classes

# Linux - Set DSCP on socket
setsockopt(sock, IPPROTO_IP, IP_TOS, &tos_value, sizeof(tos_value))
```
### TTL (Time to Live)
```
Default TTL values:
- Linux: 64
- Windows: 128
- Cisco IOS: 255

Purpose:
- Prevents routing loops
- Each router decrements TTL by 1
- Packet dropped when TTL=0
- Router sends ICMP Time Exceeded
```

```Shell title='Command to check TTL'
# Check TTL in ping response
ping google.com
# 64 bytes from google.com: icmp_seq=1 ttl=117

# Calculate hop count
Initial TTL = 128 (Windows origin)
Received TTL = 117
Hops = 128 - 117 = 11 hops
```
## IP Allocation Methods
### Static IP Assignment
```bash
# Linux - netplan (Ubuntu/Debian)
cat /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth0:
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]

# Apply configuration
sudo netplan apply

# Linux - ifconfig (legacy)
sudo ifconfig eth0 192.168.1.100 netmask 255.255.255.0

# Linux - ip command (modern)
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ip route add default via 192.168.1.1
```
### DHCP (Dynamic Host Configuration Protocol)
- Automatic IP assignment
- Lease-based allocation
- [DHCP details](../../../application-layer/dhcp/Dynamic%20Host%20Configuration%20Protocol.md)
## NAT (Network Address Translation)
- Private → Public IP mapping
- Critical for IPv4 conservation
- [NAT details](../subnet/Network%20Address%20Translation%20(NAT).md)
## Subnet Planning Best Practices

### Cloud VPC Design
```
VPC Size Guidelines:
- Development: /20 (4,094 hosts)
- Staging: /19 (8,190 hosts)
- Production: /16 (65,534 hosts)

Reserve space for growth:
- Allocate 2-3x current needs
- Plan for multi-AZ deployment
- Consider service expansion
```

### Kubernetes Cluster Sizing
```
Components:
1. Node subnet: Hosts for worker nodes
2. Pod CIDR: IP range for pods
3. Service CIDR: ClusterIP range

Example sizing:
Nodes: 100 nodes → /25 (126 IPs) with room to grow
Pods: 100 nodes × 110 pods/node = 11,000 pods → /18 (16,382 IPs)
Services: 1,000 services → /22 (1,022 IPs)
```
## Cloud Platform IPv4 Usage

### AWS VPC
```bash
# CIDR block: /16 - /28 allowed
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# Secondary CIDR (expand VPC)
aws ec2 associate-vpc-cidr-block \
  --vpc-id vpc-xxxxx \
  --cidr-block 10.1.0.0/16
```
**AWS Limitations:**
- VPC: /16 minimum, /28 maximum
- Subnet: Must be within VPC CIDR
- Reserved IPs per subnet: 5 (network, gateway, DNS, future, broadcast) 
### GCP VPC
```bash
# Auto mode: /20 subnets per region
# Custom mode: Choose your own

gcloud compute networks subnets create web-subnet \
  --network=my-vpc \
  --region=us-central1 \
  --range=10.0.1.0/24

# Expand subnet (can't shrink)
gcloud compute networks subnets expand-ip-range web-subnet \
  --region=us-central1 \
  --prefix-length=20
```
### Azure vNet
```bash
# Address space: 10.0.0.0/16
az network vnet create \
  --name MyVNet \
  --resource-group MyRG \
  --address-prefix 10.0.0.0/16 \
  --subnet-name WebSubnet \
  --subnet-prefix 10.0.1.0/24
```
***
# References
1. [RFC 791 - Internet Protocol](https://tools.ietf.org/html/rfc791)
2. [RFC 1918 - Address Allocation for Private Internets](https://tools.ietf.org/html/rfc1918)
3. [RFC 4632 - CIDR](https://tools.ietf.org/html/rfc4632)
4. Computer Networking: A Top-Down Approach, 8th Edition - James F. Kurose, Keith W. Ross
	1. Chapter 4: Network Layer - The Data Plane
5. [Subnet Calculator](https://www.subnet-calculator.com/)
6. [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
