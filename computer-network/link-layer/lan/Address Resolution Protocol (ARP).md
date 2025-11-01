#protocol  #link-layer #computer-network #lan 

- Maps ==IP address to MAC address== on each LAN.
# Principle
- ARP table contains mapping records. Each record has 3 fields:
	- IP.
	- MAC
	- TTL = Time to live.
- ![](Pasted%20image%2020240520154451.png)
## ARP within a LAN
- A wants to send datagram to B, he needs to know B's MAC address:
1. A ==broadcasts ARP== query, containing B's IP:
	- Destination MAC: `FF-FF-FF-FF-FF-FF` (default MAC broadcast).
	- all nodes within LAN will receive ARP frame.
2. B receives ARP broadcast frame, replies with an ==ARP response containing her MAC address==.
3. A maps B's IP to B's MAC and ==adds to ARP table==.
## ARP to another subnet
### Scenario
- ![](Pasted%20image%2020240520161447.png)
- A wants to send datagram to B, given that:
	- A knows first-hop router's IP (default gateway) and MAC via ARP broadcast.
	- A knows B's IP.
### Description
1. A creates IP datagram with IP source A, IP dest B; encapsulates it with ==frame containing MAC source A, MAC dest R==.
2. Router receives frame, extracts to datagram; ==determines outgoing interface==:
	- IP datagram still keeps IP source A, IP dest B.
	- But frame replaces MAC source with R's outgoing MAC; replaces MAC dest with B's MAC.
3. B receives frame, extracts to IP datagram.
***
# References
1. 

