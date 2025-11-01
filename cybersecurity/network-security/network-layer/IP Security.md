#ip #protocol #network-layer #computer-network #cybersecurity 
 #ipsec #ike 
 
- Provide security services:
	- Access control.
	- Connectionless integrity.
	- Data origin authentication.
	- Rejection of replayed packets.
	- Confidentiality => limited traffic flow confidentiality.
# Architecture
- ![](Pasted%20image%2020240515150328.png)

## Security Association (SA)
- ==one-way logical connection== for sender and receiver.
- Uniquely identified by:
	- Security Parameter Index (SPI).
	- IP Destination Address.
	- Security Protocol Identifier.
## Security Association Database (SAD)
- Each entry may contain these fields:
	- SPI.
	- Sequence number counter.
	- Sequence counter overflow.
	- Anti-replay window.
	- AH information.
	- ESP Information
	- Lifetime of this SA.
	- IPsec protocol mode: tunnel, transport, wildcard.
	- Path Maximum Transmission Unit (MTU).
## Security Policy Database (SPD)
- Filter packets, idenfity SA and process IPSec.
- Each entry may contain these fields:
	- Remote IP address.
	- Local IP Address.
	- Next-Layer Protocol.
	- Name.
	- Local and Remote Ports.
- ![](Pasted%20image%2020240515152234.png)
# IP Traffic processing

- Outbound traffic: ![](Pasted%20image%2020240515152703.png)

- Inbound traffic: ![](Pasted%20image%2020240515163000.png)
- 
# ESP - Encapsulating Security Payload

- General format:
- ![](Pasted%20image%2020240515155139.png)
- If algorithm requires:
- ![](Pasted%20image%2020240515155431.png)
- $IV$ is usually not encrypted.
- $ICV$ is calculated after encryption to reduce DDOS.
## Padding
- If algorithm requires.
- Alignment.
- Traffic flow confidentiality.
## Anti-replay service
- Use sequence number.
- If reach limit $2^{N}-1$ ($2^{32}-1$) which is maximum sequence number, reset to $0$ and negotiates new SA with new key.
- Window size $W=64$ by default, valid sequence number $N-W+1 \leq seqnum \leq N$ 
## ESP Transport mode & Tunnel mode
- General:
	- ![](Pasted%20image%2020240515161112.png)
	- ESP Transport mode: ==Keep original IP heade==r, add new ESP header.
	- ESP Tunnel mode: ==Replace== original IP header ==with new IP header==, add new ESP header.
### Transport mode
![](Pasted%20image%2020240515161427.png)
- Protect only ==upper-layer protocol==.
- Intermediate routers cannot read payload because of encryption.
- ==Only destination== can decrypt and read message => ==End-to-end== encryption.
- Vulnerable to traffic analysis.
### Tunnel mode
![](Pasted%20image%2020240515162046.png)
- Protects ==entire IP datagram==. => configure firwalls or security gateways to ==protect== ==from external network==.
- Used to implement VPN <-> Virtual Private Network:
	- ==Encrypt== and compress all traffic ==going to the Internet==.
	- ==Decrypt== and decompress all traffic ==coming from its network==.
	- ![](Pasted%20image%2020240515162737.png)
# Combining SA
## Authentication and Confidentiality
- ESP can support two modes:
	- Transport mode: authenticate and encrypt only IP payload.
	- Tunnel mode: authenticate ==entire IP datagram== and encrypt IP payload.
- Authenticate ciphertext only.
### ESP with Authentication
#### Transport adjacency
- authentication after encryption.
- Two bundled transport SAs:
	- inner: ESP without authentication => encrypt IP payload
	- outer: AH => authenticate inner ESP.
#### Transport-tunnel bundle:
- authentication before encryption.
- One transport mode, one tunnel mode:
	- inner: AH transport SA => provide authentication for original I{ header.
	- outer: ESP tunnel SA => encrypt inner IP datagram and add new IP header for authentication.
## Combinations of SA
- ![](Pasted%20image%2020240516075259.png)

## Scenario 1:
- ==All== end systems must support IPSec => ==nested transport modes==, tunnel modes is optional.
- Combinations:
	- Transport AH.
	- Transport ESP.
	- Inner transport AH SA, outer ESP SA.
	- Above inside tunnel AH/ESP.
## Scenario 2:
- Only security ==gateways== support IPSec => VPN.
- Require a ==single tunnel SA between gateways==, nested tunnel is optional.
	- AH
	- ESP.
	- ESP with authentication.
## Scenario 3:
- Both ==gateways and end systems== support IPSec.
- Require ==tunnel modes between gateways==, optional SAs between devices.
- most popular.
## Scenario 4:
- Support ==remote access== to access to server behind firewalls.
- Require ==tunnel modes between host and firewall==s, can be nested.
# Internet key exchange
[IKE](IKE.md)
***
# References
1. 
