#dhcp #subnet #data-plane #computer-network #protocol  #application-layer 
#client-server #network-layer 

- Stands for ==Dynamic Host Configuration Protocol==.
- ==Automatically allocates IP address== for host within a network.
- Runs on ==application layer==.
# Characteristics
 - ==Client-server== protocol, requires:
	- a DHCP server.
	- DHCP relay agents (router).
	- client hosts.
- Employ [UDP](UDP.md), ==port 68 on client and port 67 on server==.
# Principle
1. *Discover DHCP Server*:
	 - Client joins network and ==broadcasts DHCP discover message==:
		 - `IP source`: `0.0.0.0`.
		 - `IP dest`: `255.255.255.255`
2. *DHCP Server responses*:
	- When receiving DHCP discover message, DHCP ==unicasts DHCP offer message== to client.
		- `Your IP Address`: IP address will be allocated (e.g `192.168.31.150`).
		- `Transaction ID`: (e.g: `0xf41c91c4`)
		- `IP address lease time`: time length IP is still valid (e.g: `43200s`= 12h).
		- Client's MAC address.
3. *Client request IP*
	- Client ==broadcasts DHCP request message== to request IP address.
		- `IP source`: `0.0.0.0`.
		- `IP dest`: `255.255.255.255`.
		- `Request IP address` : in DHCP offer message.
		- `Hostname`;...
4. *Server acknowledges*
	- Server ==unicasts DHCP ACK message== to acknowledge client that IP allocation is successful.
- ![](Pasted%20image%2020240522151346.png)
***
# References
1. 





