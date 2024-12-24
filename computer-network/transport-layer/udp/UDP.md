#udp #protocol #transport-layer #computer-network 

- Stands for ==User Datagram Protocol==.
- Simple, ==Connectionless== protocol.
- "Best-effort" protocol:
	- no congestion control.
	- no reliable data transfer.
	- no connection state.
- Commonly used in ==lightweight==, ==multimedia apps==, 
- ![](Pasted%20image%2020240515081121.png)
- 
- 
# UDP Segment format
![](Pasted%20image%2020240514204620.png)
- Total size: $2^{16}-1$ in theory, but limited by ==maximum transmission unit==.
- UDP Header: ==8 bytes== contains:
	- `Source port`: 2 bytes
	- `Destination port`: 2 bytes.
	- `Length`: 2 bytes.
	- `Checksum`: 2 bytes.
# UDP Fairness
- UDP is ==not fair==.
- Many mulmedia apps running over UDP ==grasp as much bandwidth== as they can.
---
# References
1. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross