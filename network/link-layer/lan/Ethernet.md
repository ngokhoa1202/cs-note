#computer-network  #lan #link-layer #ethernet

- ==Dominant== over wired LAN technologies.
- High speed.

# Ethernet frame format
- ![](Pasted%20image%2020240520165009.png)
- `Payload`: $46 \to 1500$ bytes $\leq MTU=1500$ (==Maximum Transmission Unit==).
- `Source address`: $6$ bytes source's MAC.
- `Destination address`: $6$ bytes destination's MAC.
- `Type`: multiplex network for upper-layer protocol.
- `CRC`: Cyclic redundancy check $4$ bytes.
- `Premable`: Clock synchronization $8$ bytes.
# Characteristics
- Connectionless $\equiv$ no handshake.
- Unreliable $\equiv$ not ACK.
- Employs [Ethernet CSMA/CD](CSMA%20-%20CSMACD.md#Ethernet%20CSMA/CD) as Multiple Access Channel protocol.
