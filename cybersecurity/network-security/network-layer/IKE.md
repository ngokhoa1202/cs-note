#protocol #algorithm #network-layer #computer-network #cybersecurity #cryptography #asymmetric-cipher  #web-security #ongoing 

- Known as ISAKMP/Oakley
	- Internet ==Security Association== and ==Key Management== Protocol.
	- Oakley ==Key Determination== Protocol
- Based on [Diffie-Hellman key exchange.](Diffie-Hellman%20key%20exchange..md)
# Key determination protocol
- Based on [Diffie-Hellman key exchange.](Diffie-Hellman%20key%20exchange..md)
- Advanced:
	- cookie exchange:
		- support ==authentication== => thwart man-in-the-middle attacks.
		- support public-key exchange of Diffie-Hellman.
		- use ==nonce== => thwart replay attacks.
		- ==fast==.
		- ==group negotiation==.
- 
# IKEv2 exchanges
![](Pasted%20image%2020240516084013.png)
# IKE Datagram Format
## IKE Header Format
![](Pasted%20image%2020240516084414.png)
- Message ID: control retransmission of lost packets.
## IKE Payload Format
- Payload header: ![](Pasted%20image%2020240516084700.png)
- Next = 0 if last packet; otherwise next packet payload's type.
- Payload's type ![](Pasted%20image%2020240516084901.png)
