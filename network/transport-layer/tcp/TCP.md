#tcp #computer-network #transport-layer #client-server #protocol #reliable-data-transfer 

- Stands for ==Transmission Control Protocol==.
- ==Connection-oriented== protocol.
- Support reliable data transfer, 

# TCP Segment format
- ![](Pasted%20image%2020240517141956.png)
- In theory, total size is $2^{16}-1$, but limited by ==maximum transmission unit==.
- TCP Header: 20- 60 bytes (40 bytes optional)
	- `Source port`: 2 bytes + `Destination port`: 2 bytes $\Rightarrow$ 4 bytes.
	- `Sequence number`: 4 bytes.
	- `Acknowledgement number`: 4 bytes.
	- `Header length`: 4 bits + `Receive window`: 2 bytes + Flag fields: 6 bits $\Rightarrow$ 4 bytes
		- Flag field: 6 bit:
			- `ACK`: check ACK number is valid.
			- `RST`: reset connection.
			- `SYN`: used to establish connection.
			- `FIN`
			- `PSH`: push data to upper layer.
			- `URG`: urgent upper-layer data $\Rightarrow$ urgent data pointer field.
	- Internet checksum: 2 bytes + Urgent data pointer: 2 bytes $\Rightarrow$ 4 bytes.
	- Options: up to 40 bytes.
# TCP Sequence number
- TCP segments are structured as ==stream of bytes==.
- ![](Pasted%20image%2020240517145001.png)
- Segment's sequence number is the ==stream number of the first byte== in the segment.
# TCP ACK number
- ACK number is the ==next expected sequence number== (in byte).
# TCP Round trip time and timeout
- Ignore retransmitted packets.
- $\alpha=0.25$ 
- $$RTT_{estimated}=(1-\alpha) RTT_{estimated}+\alpha RTT_{sample}$$
- $\beta=0.25$ 
- $$RTT_{deviate}=(1-\beta)RTT_{deviate}+\beta|RTT_{sample}-RTT_{estimated}|$$
- Timeout inverval:
- $$Interval=RTT_{estimated}+4RTT_{deviate}$$
# TCP reliable data transfer
- Employs [Seletive repeat](Seletive%20repeat.md)
## TCP fast retransmit
- If receiver detects a packet loss, it ==sends duplicate ACK== of next expected sequence number.
- When sender ==receives 3 duplicate ACK== of that lost packet, it ==resends== that lost packet.
# TCP Flow control
- Purpose: ==avoids buffer overflow==
- Focuses on ==receive window==.
- Condition: $$RcvWnd = RcvBuffer-(LastByteRcv-LastByteRead) \geq 0$$
- Sender must ==send segment with one-byte data== when receiver's buffer is full.
# TCP Connection management
## Open connection - Handshake
- Employs ==3-way handshake==:
	1. Client sends a ==`SYN` segment== to server:
		- `SYN` bit = 1.
		- Client chooses a initial sequence number `client_isn` as `sequence number`.
	2. Server receives `SYN` segment, allocates variables and buffers and ==sends SYNACK segment== to client to grant permission to connection:
		- `SYN` = 1.
		- `ACK` = 1.
		- `Acknowledgement number` = `client_isn+1`.
		- Chooses `server_isn` as `sequence number`.
	4. Client receives `SYNACK` segment, allocate variables and buffers:
		- `SYN` = 0.
		- `Acknowledgement number = server_isn + 1`.
		- `Sequence number` = `client_isn + 1`.
		- May carry ==payload==.
- ![](Pasted%20image%2020240517154238.png)
## Close connection
1. Client sends `FIN` segment to tell server to close connection:
	- `FIN` = 1.
2. Server sends `ACK` segment:
3. Server sends `FIN` segment.
4. Client sends `AcK` segment, waits and dellocates variables and buffers. 
5. Server receives `ACK` segment, dellocates variables and buffers.
- ![](Pasted%20image%2020240518103548.png)
- 

# TCP congestion control
## Scenario
- original sending rate $\lambda_{in}$ 
- sending rate with ==restransmission== $\lambda '_{in} < \lambda_{in}$
- ==Finite buffer==
- ![](Pasted%20image%2020240517160321.png)
- $\lambda_{out} \to 0$ when $\lambda_{in} '$ is large.

## Principle
- Decrease sending rate if segment is lost.
- Insrease sending rate when receving ACK.
- Bandwith probing.
## TCP AIMD - TCP Reno
- ==Addtitive increase==, ==Multiplicative decrease==. (cộng để tăng, nhân/chia để giảm)
- ![](Pasted%20image%2020240517163253.png)
- 
### Slow start
- Sending rate $r = \frac{MSS}{RTT}$ , congestion window $cwnd=MSS$
- ==double== $cwnd$ when receiving ACK per $RTT$.
- If $cwnd \geq ssthres$ , turns to congestion control.
- ![](Pasted%20image%2020240517161633.png)
### Congestion avoidance
- Slow-start threshold $ssthres$
- $cwnd = cwnd + MSS\times\frac{MSS}{cwnd}$ 
- if duplicate ACK = 3, which means traffic is congested:
	- halve $ssthres=\frac{cwnd}{2}$.
	- set $cwnd=\frac{cwnd}{2} + 3MSS$ .
	- turns to fast recovery.
### Fast recovery
- double $cwnd$ for every RTT again.
-  if duplicate ACK = 3, which means traffic is congested:
	- halve $ssthres=\frac{cwnd}{2}$.
	- set $cwnd=\frac{cwnd}{2} + 3MSS$ .
	- turns to slow start.


## TCP Tahoe
- No fast recovery.
- If traffic is congested, set $cwnd=MSS$ and turns to slow start.
- ![](Pasted%20image%2020240517163754.png)
- 
## TCP Cubic
- Most popular.
- Maximum congestion window size $W_{max}$ 
- Time to reach $W_{max}$ again: $K$ .
- Current time $t$ 
- $cwnd=f((K-t)^3)$ $\Rightarrow$ quickly reach close to $W_{max}$, but then increase cautiously $\Rightarrow$ quickly probing.
- ![](Pasted%20image%2020240517163845.png)
# Network-assisted Explicit Congestion Nofication
- ==Type-of-service== field in IP datagram to indicate router.
- Router's ==policy== determines congestion control.
- Receiver ==replies with ECE== (Explicit Cogestion Nofication Echo) bit in its ACK.
- ![](Pasted%20image%2020240518104417.png)
# Delay-based Congestion control
- TCP Vegas:
	- "Keep the pipe full, but no fuller".
	- uncongested throughput rate: $$throughput=\frac{cwnd}{RTT_{min}}$$

# TCP Fairness
- $N$ TCP connections, throughput $R$
- Average throughput per connection: $$\frac{R}{N}$$ 
- Ideal TCP conforms to ==ping-pong effect== $\Rightarrow$ try to be fair among connections.
	- ![](Pasted%20image%2020240518105111.png)
- 

