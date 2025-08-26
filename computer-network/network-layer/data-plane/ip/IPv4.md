#ip  #network-layer #computer-network #protocol 

- Stands for ==Internet Protocol version 4==.
# IPv4 Address
- 32 bits $\equiv$ 4 octets in decimal ranging `0-255`.
- General format: $$a.b.c.d/x$$ using CIDR notation.
- Used for [Subnet](Subnet.md)
# IPv4 Datagram Format
- IP Header $\geq 20$ bytes + TCP Header $\geq$ 20 bytes  ![800x400](Pasted%20image%2020240521142232.png)
- `Version`: IP version = $4$ bits.
- `Header length` = $4$ bits.
- `Type of service`: [Network-assisted Explicit Congestion Nofication](TCP.md#Network-assisted%20Explicit%20Congestion%20Nofication) = 8 bits distinguish ==real-time vs non real-time packets==.
- `Total length` = 16 bits.
- `Identifier`, `flags`, `Fragment offet` = 16 bits: for IP fragmentation.
- `TTL` = 8 bits if reaches 0, drop packet.
- `Protocol` = 8 bits. Decides transport-layer protocol number when datagram reaches destination.
- `Header Checksum` = 16 bits.
- `Source IP` = 32 bits.
- `Destination IP` = 32 bits.
- `Option` $0 \to 40$ bytes for special routers.

# IP Allocation

## Static IP allocation

## DHCP
[Dynamic Host Configuration Protocol](Dynamic%20Host%20Configuration%20Protocol.md)

# NAT
[NAT](NAT.md)


