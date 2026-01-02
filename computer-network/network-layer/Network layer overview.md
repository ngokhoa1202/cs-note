#network-layer #computer-network #router #control-plane #data-plane #backend #site-reliability-engineering
# Network Layer Overview
## Core Concepts
- Provides ==best-effort delivery== service (no guarantees on delivery, order, or timing)
- Operates in network ==core== using ==routers== for packet forwarding
- Packets are called ==datagrams== at this layer
- Two primary functions:
	- **Forwarding (Data Plane)**: Move packets from input to correct output interface
	- **Routing (Control Plane)**: Determine end-to-end path through network
## Architecture
### Data Plane
- **Function**: Local, ==per-router== packet forwarding decisions
- **Speed**: Nanosecond timescale (hardware-based)
- **Scope**: Single router operation
- [Data plane overview](data-plane/subnet/Data%20plane%20overview.md)

**Key Components:**
- [Router](data-plane/Router.md) - Packet forwarding device
- [IPv4](data-plane/ip/Internet%20Protocol%20version%204%20(IPv4).md) - Primary internet protocol
- [IPv6](data-plane/ip/Internet%20Protocol%20version%206%20(IPv6).md) - Next-generation internet protocol
- [NAT](data-plane/subnet/Network%20Address%20Translation%20(NAT).md) - Address translation for private networks
- [Subnet](data-plane/subnet/Subnet.md) - Network segmentation
### Control Plane
- **Function**: Network-wide routing and management decisions
- **Speed**: Second to minute timescale (software-based)
- **Scope**: Entire network topology
### Key protocol
- [ICMP](control-plane/ICMP.md) - Network diagnostics and error reporting
- [BGP](control-plane/BGP.md) - Inter-domain routing (Internet backbone)
- [OSPF](control-plane/OSPF.md) - Intra-domain routing (enterprise networks)
- [SDN](computer-network/network-layer/Software-Defined%20Networking%20(SDN).md) - Programmable network control
***
# References
1. Computer Networking: A Top-Down Approach, 8th Edition - James F. Kurose, Keith W. Ross
	1. Chapter 4: Network Layer - The Data Plane
	2. Chapter 5: Network Layer - The Control Plane
2. [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
3. [RFC 791 - Internet Protocol](https://tools.ietf.org/html/rfc791)
4. [RFC 1918 - Private Address Space](https://tools.ietf.org/html/rfc1918)
