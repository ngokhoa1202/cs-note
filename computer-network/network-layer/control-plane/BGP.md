#bgp #routing #network-layer #control-plane #computer-network #backend #site-reliability-engineering

# Border Gateway Protocol (BGP)

## Overview
- ==Inter-Autonomous System== (inter-AS) routing protocol
- De facto ==path-vector protocol== for Internet routing
- Operates over ==TCP port 179== for reliable session establishment
- Critical for multi-cloud connectivity, datacenter interconnection, and global load balancing

## BGP Types

### eBGP (External BGP)
- Routing between ==different Autonomous Systems==
- Direct peering between ISPs, cloud providers, enterprises
- TTL typically set to 1 (directly connected neighbors)
- **Use case**: Internet routing, cloud interconnect, multi-cloud peering

### iBGP (Internal BGP)
- Routing within ==same Autonomous System==
- Prevents routing loops using split-horizon (don't advertise iBGP-learned routes to iBGP peers)
- Requires ==full mesh== or route reflectors for scalability
- **Use case**: Enterprise campus networks, datacenter fabric, service provider core

```
AS 65001                    AS 65002
┌─────────────────┐        ┌─────────────────┐
│  R1 ←──iBGP──→ R2│        │  R3 ←──iBGP──→ R4│
│   ↑              │        │              ↑   │
│   │              │        │              │   │
│  iBGP            │        │            iBGP  │
│   │              │        │              │   │
│   ↓              │        │              ↓   │
│  R5              │        │              R6  │
└─────────────────┘        └─────────────────┘
        │                           │
        └─────────eBGP──────────────┘
```

## BGP Session Establishment

### BGP Finite State Machine
| State | Description | Next State |
|-------|-------------|------------|
| **Idle** | Initial state, waiting for Start event | Connect |
| **Connect** | TCP connection initiated | Active or OpenSent |
| **Active** | TCP connection retry | OpenSent or Idle |
| **OpenSent** | TCP established, OPEN sent | OpenConfirm or Idle |
| **OpenConfirm** | OPEN received, KEEPALIVE sent | Established or Idle |
| **Established** | Session active, exchanging UPDATEs | Active peering |

### BGP Messages
| Type | Purpose | Frequency |
|------|---------|-----------|
| **OPEN** | Initiate session, authenticate, negotiate parameters | Once per session |
| **UPDATE** | Advertise/withdraw routes | When topology changes |
| **KEEPALIVE** | Maintain session (default 60s) | Every hold-time/3 |
| **NOTIFICATION** | Error reporting, session teardown | On error or shutdown |

## BGP Attributes

### Well-Known Mandatory
- **AS_PATH**: List of ASNs traversed (loop prevention, path selection)
- **NEXT_HOP**: IP address of next-hop router
- **ORIGIN**: Route origin (IGP, EGP, Incomplete)

### Well-Known Discretionary
- **LOCAL_PREF**: ==Preference within AS== (higher = preferred), iBGP only
- **ATOMIC_AGGREGATE**: Route aggregated, some path info lost

### Optional Transitive
- **AGGREGATOR**: Router that performed aggregation
- **COMMUNITY**: Tag routes for policy application

### Optional Non-Transitive
- **MED** (Multi-Exit Discriminator): Suggest ==entry point into AS== (lower = preferred)

## BGP Route Selection Process

**Decision order** (first match wins):
1. **Highest LOCAL_PREF** (prefer paths with higher local preference)
2. **Shortest AS_PATH** (fewest AS hops)
3. **Lowest ORIGIN** (IGP < EGP < Incomplete)
4. **Lowest MED** (when comparing routes from same AS)
5. **eBGP over iBGP** (prefer external routes)
6. **Lowest IGP cost to NEXT_HOP** (closest next-hop router)
7. **Oldest route** (stability preference)
8. **Lowest router ID** (tie-breaker)

## BGP Communities

### Standard Communities (RFC 1997)
- 32-bit value: ==AS:Value== format (e.g., 65001:100)
- **NO_EXPORT** (0xFFFFFF01): Don't advertise to eBGP peers
- **NO_ADVERTISE** (0xFFFFFF02): Don't advertise to any peer
- **NO_EXPORT_SUBCONFED** (0xFFFFFF03): Don't export outside confederation

### Common Community Use Cases
```
Community           Purpose
65001:100          Mark routes from datacenter 1
65001:200          Mark routes from datacenter 2
65001:911          Emergency traffic engineering
65001:666          Blackhole traffic (DDoS mitigation)
```

### Example: Traffic Engineering with Communities
```bash
# Cisco IOS - Tag routes with community
router bgp 65001
 neighbor 10.0.0.2 remote-as 65002
 neighbor 10.0.0.2 send-community

route-map SET_COMMUNITY permit 10
 match ip address prefix-list DATACENTER_ROUTES
 set community 65001:100

# Apply route-map to outbound advertisements
router bgp 65001
 neighbor 10.0.0.2 route-map SET_COMMUNITY out
```

## BGP in Multi-Cloud Architecture

### AWS Transit Gateway BGP Peering
```bash
# Create Transit Gateway
aws ec2 create-transit-gateway \
  --options AmazonSideAsn=64512

# Attach VPN with BGP
aws ec2 create-vpn-connection \
  --type ipsec.1 \
  --customer-gateway-id cgw-xxxxx \
  --transit-gateway-id tgw-xxxxx \
  --options TunnelOptions='[{PreSharedKey=secret,TunnelInsideCidr=169.254.10.0/30}]'

# BGP session automatically established with:
# - AWS ASN: 64512
# - Customer ASN: from Customer Gateway
# - Hold time: 30 seconds
# - Keepalive: 10 seconds
```

### GCP Cloud Router BGP Peering
```bash
# Create Cloud Router with BGP
gcloud compute routers create my-router \
  --region us-central1 \
  --network my-vpc \
  --asn 65001

# Add BGP peer
gcloud compute routers add-bgp-peer my-router \
  --peer-name on-prem-peer \
  --peer-asn 65002 \
  --peer-ip-address 169.254.1.2 \
  --interface my-router-interface \
  --region us-central1

# Advertise custom routes
gcloud compute routers update-bgp-peer my-router \
  --peer-name on-prem-peer \
  --advertisement-mode CUSTOM \
  --set-advertisement-ranges 10.0.0.0/8
```

### Azure ExpressRoute BGP
```bash
# Create ExpressRoute circuit
az network express-route create \
  --resource-group myResourceGroup \
  --name myCircuit \
  --peering-location "Silicon Valley" \
  --bandwidth 100 Mbps \
  --provider "Equinix" \
  --sku-tier Premium \
  --sku-family MeteredData

# Configure BGP peering
az network express-route peering create \
  --circuit-name myCircuit \
  --peering-type AzurePrivatePeering \
  --peer-asn 65002 \
  --vlan-id 100 \
  --primary-peer-subnet 192.168.1.0/30 \
  --secondary-peer-subnet 192.168.1.4/30 \
  --resource-group myResourceGroup
```

## Anycast with BGP

### Global Load Balancing with Anycast
- Announce ==same IP prefix== from multiple locations
- BGP routes traffic to ==nearest location== (shortest AS_PATH)
- Critical for CDN, DNS (1.1.1.1, 8.8.8.8), DDoS mitigation

```
Anycast IP: 1.1.1.1/32

US West (AS 65001)     US East (AS 65002)     Europe (AS 65003)
    ↓                       ↓                       ↓
Announces 1.1.1.1/32   Announces 1.1.1.1/32   Announces 1.1.1.1/32
    ↓                       ↓                       ↓
User in California ────→ Routes to US West (shortest path)
User in New York ──────→ Routes to US East
User in London ────────→ Routes to Europe
```

### Anycast Configuration Example
```bash
# On multiple servers in different locations
# Configure loopback with anycast IP
ip addr add 1.1.1.1/32 dev lo

# Announce via BGP (Bird BGP daemon)
cat > /etc/bird/bird.conf <<'EOF'
protocol static {
    route 1.1.1.1/32 via "lo";
}

protocol bgp upstream {
    local as 65001;
    neighbor 203.0.113.1 as 174;  # ISP
    export all;
    import none;
}
EOF

systemctl restart bird
```

## BGP Route Filtering

### Prefix Lists
```bash
# Cisco IOS - Create prefix list
ip prefix-list ALLOW_DATACENTER permit 10.0.0.0/8 le 24
ip prefix-list ALLOW_DATACENTER deny 0.0.0.0/0 le 32

# Apply to BGP neighbor
router bgp 65001
 neighbor 10.0.0.2 remote-as 65002
 neighbor 10.0.0.2 prefix-list ALLOW_DATACENTER in
```

### AS_PATH Filtering
```bash
# Only accept routes originating from specific ASes
ip as-path access-list 1 permit ^65002$
ip as-path access-list 1 permit ^65003$
ip as-path access-list 1 deny .*

router bgp 65001
 neighbor 10.0.0.2 filter-list 1 in
```

### BGP Bogon Filtering
```bash
# Block bogon/martian networks
ip prefix-list BOGONS deny 0.0.0.0/8 le 32
ip prefix-list BOGONS deny 10.0.0.0/8 le 32
ip prefix-list BOGONS deny 127.0.0.0/8 le 32
ip prefix-list BOGONS deny 169.254.0.0/16 le 32
ip prefix-list BOGONS deny 172.16.0.0/12 le 32
ip prefix-list BOGONS deny 192.0.2.0/24 le 32
ip prefix-list BOGONS deny 192.168.0.0/16 le 32
ip prefix-list BOGONS deny 224.0.0.0/4 le 32
ip prefix-list BOGONS deny 240.0.0.0/4 le 32
ip prefix-list BOGONS permit 0.0.0.0/0 le 32

router bgp 65001
 neighbor 10.0.0.2 prefix-list BOGONS in
```

## BGP Monitoring & Troubleshooting

### Check BGP Session Status
```bash
# Cisco IOS
show ip bgp summary
show ip bgp neighbors 10.0.0.2

# Linux (Bird)
birdc show protocols
birdc show route protocol bgp1

# Check BGP routes
show ip bgp
show ip bgp 8.8.8.8/32

# Check specific AS_PATH
show ip bgp regexp ^65002$
```

### Common BGP Issues

#### Issue 1: BGP Session Not Establishing
```bash
# Symptoms
Router# show ip bgp summary
Neighbor        V    AS MsgRcvd MsgSent   State/PfxRcd
10.0.0.2        4 65002       0       0        Active

# Diagnosis
1. Check TCP connectivity: telnet 10.0.0.2 179
2. Verify AS numbers: show ip bgp neighbors 10.0.0.2 | include remote AS
3. Check firewall rules: show access-lists
4. Verify authentication: show run | section router bgp

# Solution
- Fix TCP connectivity (routing, firewall)
- Correct AS number mismatch
- Fix MD5 authentication password
```

#### Issue 2: Routes Not Being Advertised
```bash
# Symptoms
Router# show ip bgp neighbors 10.0.0.2 advertised-routes
# Empty output

# Diagnosis
show ip bgp                              # Route in BGP table?
show ip route bgp                        # Route in RIB?
show ip bgp neighbors 10.0.0.2 | include filter  # Filters applied?

# Solution
- Ensure route exists in BGP table
- Check outbound route-maps/prefix-lists
- Verify network statement or redistribution
- Use soft-reconfiguration for route refresh
```

#### Issue 3: Suboptimal Path Selection
```bash
# Symptoms
Router# show ip bgp 8.8.8.8
  Network          Next Hop            Metric LocPrf Weight Path
*  8.8.8.8/32       10.0.0.3            0              0 65002 65003 15169 i
*>                  10.0.0.2            0              0 65002 65004 65005 15169 i

# Diagnosis - Check attributes
show ip bgp 8.8.8.8
# Compare: LOCAL_PREF, AS_PATH, MED, IGP cost

# Solution - Adjust LOCAL_PREF
route-map PREFER_PATH1 permit 10
 match ip address prefix-list GOOGLE_ROUTES
 set local-preference 200

router bgp 65001
 neighbor 10.0.0.3 route-map PREFER_PATH1 in
```

### BGP Flapping Detection
```bash
# Monitor BGP session stability
show ip bgp neighbors 10.0.0.2 | include state changes
# Output: BGP state = Established, up for 5d12h; state changes: 23

# If state changes > 10 in 24 hours, investigate:
# - Physical link issues
# - Route flapping from upstream
# - Hold timer too aggressive
# - CPU/memory exhaustion
```

## BGP Security Best Practices

### 1. BGP Authentication
```bash
# Enable MD5 authentication
router bgp 65001
 neighbor 10.0.0.2 remote-as 65002
 neighbor 10.0.0.2 password SecurePassword123
```

### 2. Maximum Prefix Limit
```bash
# Prevent route table overflow attacks
router bgp 65001
 neighbor 10.0.0.2 maximum-prefix 1000 80 warning-only
 # Warns at 80% (800 routes), tears down at 1000
```

### 3. TTL Security (Generalized TTL Security Mechanism)
```bash
# Only accept BGP packets with TTL=255 (directly connected)
router bgp 65001
 neighbor 10.0.0.2 ttl-security hops 1
```

### 4. Route Origin Validation (ROV) with RPKI
```bash
# Validate routes against Resource Public Key Infrastructure
router bgp 65001
 bgp rpki server tcp 10.0.1.5 port 8282 refresh 600

# Drop invalid routes
route-map RPKI_VALIDATION deny 10
 match rpki invalid

router bgp 65001
 neighbor 10.0.0.2 route-map RPKI_VALIDATION in
```

## BGP Performance Tuning

### Timers Optimization
```bash
# Default: keepalive=60s, hold=180s
# Faster convergence (use with caution):
router bgp 65001
 neighbor 10.0.0.2 timers 10 30  # keepalive=10s, hold=30s

# For stable links, increase timers to reduce CPU:
router bgp 65001
 neighbor 10.0.0.2 timers 60 180
```

### Route Reflectors for iBGP Scalability
```bash
# Without RR: Full mesh = n(n-1)/2 sessions
# With RR: Star topology = n-1 sessions

# Configure Route Reflector
router bgp 65001
 neighbor 10.0.0.2 remote-as 65001
 neighbor 10.0.0.2 route-reflector-client

# Route Reflector client sees:
# - Routes from RR server (iBGP + eBGP + client routes)
```

## Monitoring BGP with Tools

### Prometheus BGP Exporter
```yaml
# docker-compose.yaml
services:
  bgp-exporter:
    image: syepes/bgp_exporter
    ports:
      - "9472:9472"
    environment:
      BGP_PEERS: "10.0.0.2:179,10.0.0.3:179"
    command:
      - '--bgp.peer-type=bird'
      - '--bgp.socket=/var/run/bird/bird.ctl'
    volumes:
      - /var/run/bird:/var/run/bird
```

### BGP Monitoring with tcpdump
```bash
# Capture BGP traffic
sudo tcpdump -i eth0 -n tcp port 179 -vv

# Monitor BGP UPDATEs
sudo tcpdump -i eth0 -n 'tcp port 179 and tcp[13] & 2 != 0' -vv
```

### BGP Route Analytics
```bash
# Check route diversity (multiple paths)
birdc show route all 8.8.8.8/32

# Monitor prefix count by AS
show ip bgp summary | awk '{sum+=$NF} END {print sum}'

# Detect BGP hijacking (unexpected AS_PATH)
show ip bgp regexp _65999_  # Check if AS 65999 in path
```

## Quick Reference

**Essential BGP Commands:**
```bash
show ip bgp summary              # Neighbor status
show ip bgp                      # All BGP routes
show ip bgp neighbors <ip>       # Detailed peer info
show ip route bgp                # BGP routes in RIB
clear ip bgp * soft              # Refresh routes
debug ip bgp updates             # Monitor UPDATE messages
```

**BGP State Troubleshooting:**
- **Idle**: Check basic IP connectivity, routing to neighbor
- **Active**: TCP connection failing (firewall, routing)
- **OpenSent**: Authentication failure (wrong password/AS)
- **Established**: Normal operation

**BGP Attributes Priority:**
1. LOCAL_PREF (higher wins) - internal policy
2. AS_PATH (shorter wins) - Internet routing
3. MED (lower wins) - inter-AS path preference

***
# References
1. [RFC 4271 - BGP-4](https://tools.ietf.org/html/rfc4271)
2. [RFC 1997 - BGP Communities Attribute](https://tools.ietf.org/html/rfc1997)
3. [RFC 6480 - RPKI](https://tools.ietf.org/html/rfc6480)
4. Computer Networking: A Top-Down Approach, 8th Edition - James F. Kurose, Keith W. Ross
	1. Chapter 5: Network Layer - The Control Plane
5. [AWS Transit Gateway BGP](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPNRoutingTypes.html)
6. [GCP Cloud Router](https://cloud.google.com/network-connectivity/docs/router/concepts/overview)
7. [Azure ExpressRoute BGP](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-routing)
