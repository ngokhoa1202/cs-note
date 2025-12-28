#hardware #network-layer #data-plane 
# Router architecture
- Three main components:
	- ==Routing processor==: network-specialized computer, executes algorithm.
	- ==Switch fabric==: connects inbound port to outbound ports.
	- Ports: router interface
		- Inbound port.
		- Outbound port.
	- (Bus): connect CPU to memory (like computer).
- ![](Pasted%20image%2020240519111737.png)
# Switching fabric
- [Switching fabric](Switching%20fabric.md)
# Input port processing
- Router employs ==forwarding table== to look up for outbound ports.
- ![](Pasted%20image%2020240519113114.png)
### Destination-based forwarding
- Employs ==longest prefix matching==.
- In practice, use ==TCAM== device (Ternary Content Addressable Memories).
- ![](Pasted%20image%2020240519113627.png)
# NAT Router
- [Network Address Translation (NAT)](computer-network/network-layer/data-plane/subnet/Network%20Address%20Translation%20(NAT).md)
***
# References
1. 
