#multiple-access-channel #computer-network #link-layer 

- Known as LAN address, ==physical address==.
# MAC Address Format
- 6 bytes long = 48 bits.
- Default ==broadcast MAC address== `FF-FF-FF-FF-FF-FF`.
- First 24 bits (3 bytes) managed by IEEE.
- ==Unique per NIC interface== (maybe per host) and ==never changes==.
- ![](Pasted%20image%2020240520153915.png)
# Types of MAC address
## Unitcast address
- Frame is sent from a single NIC source interface to ==a single NIC destination interface==
- ![](Pasted%20image%2020240523092641.png)
## Multicast address
- Frame is sent from a single NIC source interface to ==multiple NIC destination interfaces==.
- ![](Pasted%20image%2020240523092902.png)
## Broadcast MAC address
- Frame is sent from a single NIC interface to ==all NIC destination interfaces within a LAN==.
- ![](Pasted%20image%2020240523092826.png)
- 
# References
1. https://www.geeksforgeeks.org/mac-address-in-computer-network/ for unicast, multicast and broadcast MAC address.
2. 