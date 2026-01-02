#subnet #computer-network #network-layer #ip 
# Subnet definition
- An ==isolated== network of interfaces ==without router's intervention==.
# Subnet id
- ==Identifies a subnet== in a network
- Subnet id is a ==subset== of [Network id](Subnet%20class.md#Network%20id).
- Given an IP address in CIDR notation $$a.b.c.d/x$$ where $x$ is prefix length, we identify subnet id by these steps:
	1. Convert IP address to ==binary== format.
	2. Keep the prefix $x$ bits (subnet part) and set ==all host bits to 0==. 
	3. Rewrite subnet in octets $$a'.b'.c'.d'$$ ![](Pasted%20image%2020240522104945.png)

# Subnet format
- Employs 32-bit IP address ![](Pasted%20image%2020240521163018.png)
- Two parts:
	- Subnet id = Subnet address.
	- Host id.
- General format using CIDR $$a.b.c.d/x$$ where $x$ is the ==prefix length== or ==subnet length==. Each value $a$, $b$, $c$, $d$ is called an ==octet== $\equiv$ 8 bits.
# Subnet mask - Default mask
- 32-bit number created from IP address:
	- Set all subnet bits to 1.
	- Set all host bits to 0.
- Regularly written as ==four octets==. $$a.b.c.d$$ 
# Subnet class
- [Subnet class](Subnet%20class.md)
# Establish Subnet masks
## FLSM
- [Fixed length Subnet Mask (FLSM)](computer-network/network-layer/data-plane/subnet/Fixed%20length%20Subnet%20Mask%20(FLSM).md)
## VLSM
- [[computer-network/network-layer/data-plane/subnet/Variable length Subnet Mask (VLSM)|Variable length Subnet Mask (VLSM)]]
# DHCP
- [Dynamic Host Configuration Protocol](Dynamic%20Host%20Configuration%20Protocol.md)
***
# References
1. [[computer-network/application-layer/dhcp/Dynamic Host Configuration Protocol|Dynamic Host Configuration Protocol]]
2. [[computer-network/network-layer/data-plane/subnet/Variable length Subnet Mask (VLSM)|Variable length Subnet Mask (VLSM)]]
3. [[computer-network/network-layer/data-plane/subnet/Fixed length Subnet Mask (FLSM)|Fixed length Subnet Mask (FLSM)]]
4. [[computer-network/network-layer/data-plane/subnet/Subnet class|Subnet class]]
5. 

