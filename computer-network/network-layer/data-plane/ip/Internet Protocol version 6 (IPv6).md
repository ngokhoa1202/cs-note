#ip #computer-network #network-layer #protocol #backend #site-reliability-engineering
# Overview
- ==128-bit address== space (340 undecillion addresses).
- Designed to replace IPv4 due to address exhaustion
- Eliminates need for NAT with vast address space
- Simplified header structure for routing efficiency
- Mandatory IPsec support for security
# Format
## Notation
```
Full format:     2001:0db8:0000:0000:0000:ff00:0042:8329
Compressed:      2001:db8::ff00:42:8329
```
## Compression Rules
- Leading zeros in each block can be omitted
- Consecutive blocks of zeros replaced by `::`
- `::` can only appear once in address.
```
2001:0db8:0000:0042:0000:0000:0000:0001
↓
2001:db8:0:42::1

fe80:0000:0000:0000:0202:b3ff:fe1e:8329
↓
fe80::202:b3ff:fe1e:8329
```
## Address Types
### Unicast
- ==Single interface== destination
- Global unicast: Routable on internet
- Link-local: Local network only (`fe80::/10`)
- Unique local: Private networks (`fc00::/7`)
### Multicast
- ==Multiple interfaces== (one-to-many)
- Prefix: `ff00::/8`
- Replaces IPv4 broadcast.
```
ff02::1    - All nodes on link
ff02::2    - All routers on link
ff02::1:2  - All DHCP servers
```
### Anycast
- ==Nearest interface== from group
- Same address assigned to multiple interfaces
- Routing delivers to closest instance
- **Use case**: CDN, DNS root servers, load balancing
## Address Scopes

| Scope | Prefix | Description | Routing |
|-------|--------|-------------|---------|
| **Global Unicast** | `2000::/3` | Public internet | Globally routable |
| **Unique Local** | `fc00::/7` | Private networks | Not routable |
| **Link-Local** | `fe80::/10` | Same link only | Not routable |
| **Multicast** | `ff00::/8` | Group communication | Link/site/global |
| **Loopback** | `::1/128` | Localhost | Node-local |
| **Unspecified** | `::/128` | No address assigned | N/A |

## Special Addresses

```
::1/128              - Loopback (localhost)
::/128               - Unspecified address
::ffff:0:0/96        - IPv4-mapped IPv6 (::ffff:192.0.2.1)
fe80::/10            - Link-local unicast
ff00::/8             - Multicast
2001:db8::/32        - Documentation prefix
```
# Header Format
## Structure (40 bytes fixed)
```
 0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|Version| Traffic Class |           Flow Label                  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|         Payload Length        |  Next Header  |   Hop Limit   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                                                               +
|                                                               |
+                         Source Address                        +
|                                                               |
+                                                               +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                                                               +
|                                                               |
+                      Destination Address                      +
|                                                               |
+                                                               +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## Key Differences from IPv4

| Feature           | IPv4                   | IPv6                       |
| ----------------- | ---------------------- | -------------------------- |
| **Header Size**   | Variable (20-60 bytes) | Fixed (40 bytes)           |
| **Checksum**      | Yes                    | ==No== (offloaded to L4)   |
| **Fragmentation** | Router or sender       | ==Sender only==            |
| **Options**       | In header              | Extension headers          |
| **Broadcast**     | Yes                    | ==No== (multicast instead) |
| **Address**       | 32-bit                 | 128-bit                    |

## Header Fields

### Version (4 bits)
- Always `6` for IPv6

### Traffic Class (8 bits)
- Similar to IPv4 TOS/DSCP
- QoS classification
- ECN support
### Flow Label (20 bits)
- ==Identifies packet flow== for QoS
- Real-time traffic optimization
- Per-flow handling by routers
### Payload Length (16 bits)
- Extension headers + upper-layer data
- Maximum: 65,535 bytes
- Jumbo payload option for larger packets

### Next Header (8 bits)
- Protocol of next header (TCP=6, UDP=17, ICMPv6=58)
- Or extension header type
### Hop Limit (8 bits)
- Same as IPv4 TTL
- Decremented by each router
- Packet dropped when reaches 0
# Extension Headers
## Purpose
- Optional headers between IPv6 header and payload
- Processed only by destination (not routers)
- More efficient than IPv4 options
## Common Extension Headers

| Type | Next Header Value | Purpose |
|------|-------------------|---------|
| **Hop-by-Hop Options** | 0 | Processed by every router |
| **Routing** | 43 | Source routing |
| **Fragment** | 44 | Fragmentation info |
| **Destination Options** | 60 | Destination processing |
| **Authentication (AH)** | 51 | IPsec authentication |
| **ESP** | 50 | IPsec encryption |

## Header Chaining
```
IPv6 Header
  → Hop-by-Hop Options
    → Routing Header
      → Fragment Header
        → Authentication Header
          → Destination Options
            → TCP Header
```

***
# References
1. [RFC 8200 - IPv6 Specification](https://tools.ietf.org/html/rfc8200)
2. [RFC 4291 - IPv6 Addressing Architecture](https://tools.ietf.org/html/rfc4291)
3. [RFC 4862 - IPv6 SLAAC](https://tools.ietf.org/html/rfc4862)
4. [RFC 4941 - Privacy Extensions](https://tools.ietf.org/html/rfc4941)
5. Computer Networking: A Top-Down Approach, 8th Edition - James F. Kurose, Keith W. Ross
	1. Chapter 4: Network Layer - The Data Plane
6. [IPv6 Test](https://test-ipv6.com/)
7. [Google IPv6 Statistics](https://www.google.com/intl/en/ipv6/statistics.html)
