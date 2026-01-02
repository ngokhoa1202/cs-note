#protocol #network-layer #control-plane #icmp #troubleshooting #backend #site-reliability-engineering

# Internet Control Message Protocol (ICMP)

## Overview
- ==Network layer== protocol for error reporting and diagnostics
- Operates alongside IP (not a transport layer protocol)
- Used by routers and hosts to communicate network-layer information
- Critical for network troubleshooting and monitoring

## ICMP Message Structure
```
0                   1                   2                   3
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|     Type      |     Code      |          Checksum             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                         Message Body                          |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

## ICMP Message Types

### Common Types for SRE

| Type | Code | Description | Use Case |
|------|------|-------------|----------|
| 0 | 0 | Echo Reply | Response to ping |
| 3 | 0-15 | Destination Unreachable | Network/host/port unreachable |
| 3 | 3 | Port Unreachable | Service not listening on port |
| 3 | 4 | Fragmentation Needed | MTU discovery |
| 5 | 0-3 | Redirect | Route optimization |
| 8 | 0 | Echo Request | Ping command |
| 11 | 0 | TTL Expired | Traceroute, routing loops |
| 11 | 1 | Fragment Reassembly Time Exceeded | Fragmentation issues |
| 12 | 0 | Parameter Problem | Malformed IP header |

### Destination Unreachable (Type 3) Codes

| Code | Meaning | Common Cause |
|------|---------|--------------|
| 0 | Network Unreachable | Routing issue, network down |
| 1 | Host Unreachable | Host down, ARP failure |
| 2 | Protocol Unreachable | Protocol not supported |
| 3 | Port Unreachable | Service not running |
| 4 | Fragmentation Needed but DF Set | MTU mismatch |
| 9 | Network Administratively Prohibited | Firewall/ACL blocking |
| 10 | Host Administratively Prohibited | Host firewall blocking |
| 13 | Communication Administratively Prohibited | Policy-based blocking |

## Ping - Network Connectivity Test

### Basic Usage
```bash
# Linux - Basic ping
ping google.com

# Send specific number of packets
ping -c 4 google.com

# Set packet size
ping -s 1400 google.com

# Set interval (default 1 second)
ping -i 0.5 google.com

# Flood ping (root only) - stress testing
sudo ping -f google.com

# Don't fragment flag (MTU testing)
ping -M do -s 1472 google.com
```

```powershell
# Windows - Basic ping
ping google.com

# Send specific number of packets
ping -n 4 google.com

# Set packet size
ping -l 1400 google.com

# Don't fragment flag
ping -f -l 1472 google.com

# Continuous ping (Ctrl+C to stop)
ping -t google.com
```

### Advanced Ping Scenarios

**1. MTU Path Discovery**
```bash
# Find maximum MTU to destination
# Start with 1500, decrease until ping succeeds
ping -M do -s 1472 <destination>  # 1472 + 28 (ICMP+IP headers) = 1500
ping -M do -s 1450 <destination>
ping -M do -s 1400 <destination>

# Note: 1472 bytes is typical for Ethernet (1500 MTU - 28 bytes headers)
```

**2. Latency Monitoring**
```bash
# Continuous ping with timestamps
ping -D google.com              # Linux (timestamps)
ping google.com | while read line; do echo "$(date): $line"; done

# Statistics-only output
ping -c 100 -q google.com       # Quiet mode, shows summary only
```

**3. Multi-destination Monitoring**
```bash
# Monitor multiple hosts
for host in web1.example.com web2.example.com db.example.com; do
    echo "Pinging $host"
    ping -c 3 $host
done
```

### Ping Output Analysis

```bash
$ ping -c 4 google.com
PING google.com (142.250.185.78) 56(84) bytes of data.
64 bytes from lga25s78-in-f14.1e100.net (142.250.185.78): icmp_seq=1 ttl=117 time=10.2 ms
64 bytes from lga25s78-in-f14.1e100.net (142.250.185.78): icmp_seq=2 ttl=117 time=10.5 ms
64 bytes from lga25s78-in-f14.1e100.net (142.250.185.78): icmp_seq=2 ttl=117 time=10.3 ms
64 bytes from lga25s78-in-f14.1e100.net (142.250.185.78): icmp_seq=4 ttl=117 time=10.4 ms

--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 10.187/10.350/10.519/0.130 ms
```

**Key Metrics:**
- **TTL (117)**: Hops remaining (started at ~128-255, decreased by routers)
- **Time (10.2 ms)**: Round-trip time (latency)
- **Packet loss (0%)**: Network reliability indicator
- **mdev (0.130 ms)**: Standard deviation (jitter indicator)

## Traceroute - Path Discovery

### How Traceroute Works
1. Sends packets with incrementing TTL values (TTL=1, TTL=2, TTL=3, ...)
2. Each router decrements TTL; when TTL=0, router sends ==ICMP Type 11 Code 0== (TTL Expired)
3. Final destination sends ==ICMP Type 3 Code 3== (Port Unreachable) or normal response
4. Source host calculates RTT for each hop

### Basic Usage

```bash
# Linux - Uses UDP by default
traceroute google.com

# Use ICMP instead of UDP
traceroute -I google.com

# Use TCP SYN packets (bypass some firewalls)
sudo traceroute -T -p 443 google.com

# Set max hops
traceroute -m 15 google.com

# Set number of probes per hop
traceroute -q 1 google.com

# Don't resolve hostnames (faster)
traceroute -n google.com
```

```powershell
# Windows - Uses ICMP by default
tracert google.com

# Don't resolve hostnames
tracert -d google.com

# Set max hops
tracert -h 15 google.com
```

### Advanced Traceroute Tools

**MTR (My TraceRoute) - Combines ping + traceroute**
```bash
# Continuous traceroute with statistics
mtr google.com

# Report mode (send 10 packets, then exit)
mtr -r -c 10 google.com

# Use TCP instead of ICMP
mtr -T -P 443 google.com

# No DNS resolution
mtr -n google.com

# CSV output for monitoring
mtr --csv -r -c 100 google.com > mtr-report.csv
```

### Traceroute Output Analysis

```bash
$ traceroute google.com
traceroute to google.com (142.250.185.78), 30 hops max, 60 byte packets
 1  router.local (192.168.1.1)  1.234 ms  1.156 ms  1.089 ms
 2  10.0.0.1 (10.0.0.1)  8.234 ms  8.156 ms  8.089 ms
 3  * * *
 4  72.14.213.25 (72.14.213.25)  12.234 ms  12.156 ms  12.089 ms
 5  142.250.185.78 (142.250.185.78)  13.234 ms  13.156 ms  13.089 ms
```

**Interpretation:**
- **Hop 1**: Local gateway (1ms latency)
- **Hop 2**: ISP router
- **Hop 3**: `* * *` = Timeout (router doesn't respond to ICMP or drops UDP probes)
- **Hop 4-5**: Path to destination
- **Three times per hop**: Three probes sent for reliability

## Common ICMP Issues & Troubleshooting

### Issue 1: Ping Works, But Service Unreachable

**Symptoms:**
```bash
$ ping web.example.com
PING web.example.com (10.0.1.5) 56(84) bytes of data.
64 bytes from web.example.com (10.0.1.5): icmp_seq=1 ttl=64 time=0.5 ms

$ curl http://web.example.com
curl: (7) Failed to connect to web.example.com port 80: Connection refused
```

**Diagnosis:**
- ICMP is allowed but service is down or port is blocked
- Check if service is running: `sudo netstat -tlnp | grep :80`
- Check firewall: `sudo iptables -L -n -v`
- Test specific port: `telnet web.example.com 80` or `nc -zv web.example.com 80`

### Issue 2: Intermittent Packet Loss

**Symptoms:**
```bash
$ ping google.com
64 bytes from google.com: icmp_seq=1 ttl=117 time=10 ms
64 bytes from google.com: icmp_seq=2 ttl=117 time=10 ms
Request timeout for icmp_seq 3
64 bytes from google.com: icmp_seq=4 ttl=117 time=10 ms
Request timeout for icmp_seq 5
```

**Diagnosis:**
- Network congestion or unstable link
- Use `mtr` for continuous monitoring: `mtr -r -c 100 google.com`
- Check interface errors: `ifconfig eth0` or `ip -s link show eth0`
- Monitor system load: `top`, `vmstat`

### Issue 3: Destination Host Unreachable

**Symptoms:**
```bash
$ ping 10.0.2.5
From 10.0.1.1 icmp_seq=1 Destination Host Unreachable
```

**Common Causes:**
1. **No route to destination**: Check routing table `ip route show`
2. **ARP failure**: Host is on local network but not responding to ARP
   - Check ARP cache: `arp -a` or `ip neigh show`
   - Verify MAC address: `arping 10.0.2.5`
3. **Host is down**: Physical connectivity issue or host powered off
4. **Firewall blocking**: Security group or network ACL blocking traffic

### Issue 4: Fragmentation Needed

**Symptoms:**
```bash
$ ping -M do -s 1500 remote.example.com
PING remote.example.com (10.0.3.5) 1500(1528) bytes of data.
From router.local (192.168.1.1) icmp_seq=1 Frag needed and DF set (mtu = 1400)
```

**Solution:**
- Path has MTU smaller than packet size
- Adjust MTU on interface: `sudo ip link set eth0 mtu 1400`
- Enable Path MTU Discovery in applications
- For VPN/tunnels: Account for encapsulation overhead (typically 50-100 bytes)

### Issue 5: TTL Expired (Routing Loop)

**Symptoms:**
```bash
$ ping 10.0.5.5
From 10.0.2.1 icmp_seq=1 Time to live exceeded
```

**Diagnosis:**
```bash
# Traceroute shows repeating hops
$ traceroute 10.0.5.5
 5  router1 (10.0.2.1)  10 ms  10 ms  10 ms
 6  router2 (10.0.2.2)  11 ms  11 ms  11 ms
 7  router1 (10.0.2.1)  12 ms  12 ms  12 ms  # Loop!
 8  router2 (10.0.2.2)  13 ms  13 ms  13 ms  # Loop!
```

**Solution:**
- Fix routing tables on affected routers
- Check route metrics and preferences
- Verify route advertisement (BGP/OSPF)

## ICMP in Cloud Environments

### AWS Security Groups & ICMP
```bash
# Allow ping (ICMP Echo Request/Reply)
aws ec2 authorize-security-group-ingress \
  --group-id sg-xxxxx \
  --protocol icmp \
  --port -1 \  # -1 means all ICMP types
  --cidr 0.0.0.0/0

# Allow only specific ICMP types (e.g., Type 3 Code 4 for PMTUD)
aws ec2 authorize-security-group-ingress \
  --group-id sg-xxxxx \
  --ip-permissions IpProtocol=icmp,FromPort=3,ToPort=4,IpRanges='[{CidrIp=0.0.0.0/0}]'
```

### GCP Firewall & ICMP
```bash
# Allow ICMP from everywhere
gcloud compute firewall-rules create allow-icmp \
  --direction=INGRESS \
  --priority=1000 \
  --network=default \
  --action=ALLOW \
  --rules=icmp \
  --source-ranges=0.0.0.0/0
```

### Azure NSG & ICMP
```bash
# Allow ICMP inbound
az network nsg rule create \
  --resource-group myResourceGroup \
  --nsg-name myNSG \
  --name allow-icmp \
  --priority 100 \
  --source-address-prefixes '*' \
  --destination-port-ranges '*' \
  --access Allow \
  --protocol Icmp
```

## ICMP Best Practices for SRE

### Security
1. **Don't disable ICMP completely** - breaks PMTUD and troubleshooting
2. **Rate-limit ICMP** - prevent ICMP flood attacks
3. **Allow ICMP Type 3 Code 4** - required for Path MTU Discovery
4. **Filter ICMP redirects (Type 5)** - prevent routing table manipulation
5. **Log ICMP unreachable messages** - useful for debugging

### Monitoring
```bash
# Monitor ICMP traffic with tcpdump
sudo tcpdump -i eth0 icmp -n

# Monitor specific ICMP type (e.g., unreachable messages)
sudo tcpdump -i eth0 'icmp[icmptype] == 3'

# Monitor with verbose output
sudo tcpdump -i eth0 -vv icmp
```

### Health Checks
```bash
# Simple availability check
if ping -c 1 -W 2 service.example.com > /dev/null 2>&1; then
    echo "Service is reachable"
else
    echo "Service is unreachable"
fi

# Latency threshold alert
latency=$(ping -c 1 service.example.com | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
if (( $(echo "$latency > 100" | bc -l) )); then
    echo "High latency: ${latency}ms"
fi
```

## ICMP Alternatives & Limitations

### When ICMP is Blocked
Many networks block ICMP for security reasons. Alternatives:

**TCP Ping (using nc or telnet):**
```bash
# Check if port 443 is open
nc -zv example.com 443
timeout 2 bash -c "</dev/tcp/example.com/443" && echo "Port 443 open"
```

**HTTP-based Healthchecks:**
```bash
# Check HTTP endpoint
curl -I --max-time 5 https://example.com/health

# Get response time
curl -w "@-" -o /dev/null -s https://example.com/health <<'EOF'
time_namelookup:  %{time_namelookup}\n
time_connect:  %{time_connect}\n
time_starttransfer:  %{time_starttransfer}\n
time_total:  %{time_total}\n
EOF
```

**TCPtraceroute:**
```bash
# Traceroute using TCP SYN packets
sudo tcptraceroute example.com 443
```

### ICMP Limitations
1. **No guarantee of delivery** - ICMP messages can be dropped
2. **Rate limiting** - routers may rate-limit ICMP to prevent abuse
3. **Security filtering** - firewalls often block or rate-limit ICMP
4. **Path changes** - ICMP path may differ from actual data path
5. **Asymmetric routing** - return path may differ from forward path

## Quick Reference

**Essential ICMP Types:**
- Type 0: Echo Reply (ping response)
- Type 3: Destination Unreachable
- Type 8: Echo Request (ping)
- Type 11: Time Exceeded (TTL=0)

**Common Commands:**
```bash
ping -c 4 <host>                    # Basic connectivity test
traceroute -n <host>                # Path discovery
mtr -r -c 100 <host>                # Combined ping + traceroute
ping -M do -s 1472 <host>           # MTU discovery
tcpdump -i eth0 icmp                # Capture ICMP traffic
```

***
# References
1. [RFC 792 - Internet Control Message Protocol](https://tools.ietf.org/html/rfc792)
2. [RFC 1122 - Requirements for Internet Hosts](https://tools.ietf.org/html/rfc1122)
3. [RFC 1191 - Path MTU Discovery](https://tools.ietf.org/html/rfc1191)
4. Computer Networking: A Top-Down Approach, 8th Edition - James F. Kurose, Keith W. Ross
	1. Chapter 5: Network Layer - The Control Plane
5. [IANA ICMP Parameters](https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml)
