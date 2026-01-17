#tcp #computer-network #transport-layer #client-server #protocol #reliable-data-transfer
# Overview
- TCP is a ==connection-oriented== protocol that provides ==reliable data transfer== over an unreliable network layer.
- Implements [Reliable data transfer principle](computer-network/transport-layer/tcp/reliable-data-transfer/Reliable%20data%20transfer%20principle.md) using [Selective repeat](computer-network/transport-layer/tcp/reliable-data-transfer/Selective%20repeat.md) protocol.
- Provides ==flow control==, ==congestion control==, and ==in-order delivery== of data.
# Segment Structure
## Segment Format
![](Pasted%20image%2020240517141956.png)
- Maximum segment size: $2^{16}-1$ bytes in theory, but limited by ==Maximum Transmission Unit (MTU)== in practice.
- Typical MTU: $1500$ bytes for Ethernet.
## Header Fields
### Fixed Header (20 bytes)
- `Source port` and `Destination port`: $2$ bytes each, total $4$ bytes.
- `Sequence number`: $4$ bytes.
	- Identifies the ==byte stream number of the first byte== in the segment's data field.
- `Acknowledgement number`: $4$ bytes.
	- Specifies the ==next expected sequence number== from the other side.
	- Uses ==cumulative acknowledgement==.
- `Header length`: $4$ bits.
	- Specifies the length of TCP header in $32$-bit words.
	- Minimum value: $5$ (20 bytes), maximum value: $15$ (60 bytes).
- `Reserved`: $3$ bits.
	- Reserved for future use, must be set to $0$.
- `Flag fields`: $9$ bits (6 primary flags + 3 ECN-related).
	- `URG`: ==Urgent pointer== field is valid.
	- `ACK`: ==Acknowledgement number== field is valid.
	- `PSH`: ==Push== data to upper layer immediately.
	- `RST`: ==Reset== the connection.
	- `SYN`: ==Synchronize== sequence numbers to establish connection.
	- `FIN`: ==Finish==, sender has no more data to send.
	- `CWR`: ==Congestion Window Reduced== flag.
	- `ECE`: ==ECN-Echo== flag.
	- `NS`: ==Nonce Sum== flag for ECN protection.
- `Receive window`: $2$ bytes.
	- Indicates the ==number of bytes== the receiver is willing to accept.
	- Used for ==flow control==.
- `Internet checksum`: $2$ bytes.
	- Error detection for the entire TCP segment.
- `Urgent data pointer`: $2$ bytes.
	- Points to the ==last byte of urgent data== when `URG` flag is set.
### Options Field (0-40 bytes)
- `Maximum Segment Size (MSS)`: Negotiates maximum segment size during connection establishment.
- `Window Scale`: Extends receive window size beyond $2^{16}$ bytes.
- `Selective Acknowledgement (SACK)`: Allows receiver to acknowledge non-contiguous blocks of data.
- `Timestamp`: Used for RTT measurement and PAWS (Protection Against Wrapped Sequence numbers).
- Padding ensures header length is a multiple of $32$ bits.
# Sequence Numbers and Acknowledgements
## Sequence Number
- TCP views data as an ==unstructured stream of bytes==.
- Sequence number represents the ==position of the first byte== in the segment within the entire byte stream.
![](Pasted%20image%2020240517145001.png)
- Example: If a segment contains bytes $[1000, 1999]$, its sequence number is $1000$.
## Acknowledgement Number
- Specifies the ==next expected byte== from the sender.
- Uses ==cumulative acknowledgement==: acknowledges all bytes up to (but not including) the ACK number.
- Example: `ACK=1000` acknowledges bytes $[0, 999]$ and expects byte $1000$ next.
## Initial Sequence Number (ISN)
- Chosen randomly during connection establishment to avoid confusion with previous connections.
- Both client and server choose their own ISN.
# Reliable Data Transfer
## Mechanisms
- TCP employs [Selective repeat](computer-network/transport-layer/tcp/reliable-data-transfer/Selective%20repeat.md) protocol with modifications.
- Combines techniques from both [Go Back N](computer-network/transport-layer/tcp/reliable-data-transfer/Go%20Back%20N.md) and Selective Repeat.
- Uses ==single retransmission timer== (like GBN) but ==buffers out-of-order segments== (like SR).
## Timeout Calculation
### Round-Trip Time (RTT) Estimation
- Measures time from segment transmission to ACK receipt.
- ==Ignores retransmitted packets== to avoid ambiguity.
- Exponential weighted moving average (EWMA) with $\alpha = 0.125$:
$$RTT_{estimated} = (1-\alpha) \times RTT_{estimated} + \alpha \times RTT_{sample}$$
### RTT Deviation
- Measures variability in RTT samples with $\beta = 0.25$:
$$RTT_{deviate} = (1-\beta) \times RTT_{deviate} + \beta \times |RTT_{sample} - RTT_{estimated}|$$
### Timeout Interval
- Conservative timeout interval prevents spurious retransmissions:
$$Timeout_{interval} = RTT_{estimated} + 4 \times RTT_{deviate}$$
- Initial timeout value: $1$ second.
- After timeout, interval is ==doubled== (exponential backoff).
## Fast Retransmit
- Detects packet loss without waiting for timeout.
- When receiver detects ==missing segment==, it sends ==duplicate ACK== with the next expected sequence number.
- When sender receives ==3 duplicate ACKs==, it immediately ==retransmits== the suspected lost segment.
- Reduces latency compared to waiting for timeout.
# Flow Control
## Purpose
- Prevents ==sender from overwhelming receiver's buffer==.
- Ensures sender does not transmit faster than receiver can process.
## Receive Window
- Receiver advertises available buffer space in `Receive window` field.
- Calculation:
$$RcvWindow = RcvBuffer - (LastByteRcvd - LastByteRead)$$
- Sender ensures:
$$LastByteSent - LastByteAcked \leq RcvWindow$$
## Zero Window Probing
- When receiver's buffer is full ($RcvWindow = 0$), sender must ==send probe segments== with $1$ byte of data.
- Prevents deadlock where receiver has space but sender is blocked waiting for window update.
- Probe segments are sent periodically until receiver advertises non-zero window.
# Connection Management
## Three-Way Handshake (Connection Establishment)
![](Pasted%20image%2020240517154238.png)
1. Client sends `SYN` segment:
	- `SYN = 1`.
	- `Sequence number = client_isn` (randomly chosen initial sequence number).
	- No application data.
2. Server receives `SYN`, allocates buffers and variables, sends `SYN-ACK` segment:
	- `SYN = 1`, `ACK = 1`.
	- `Sequence number = server_isn` (server's randomly chosen ISN).
	- `Acknowledgement number = client_isn + 1`.
	- Server allocates ==TCP connection resources==.
3. Client receives `SYN-ACK`, allocates buffers and variables, sends `ACK` segment:
	- `SYN = 0`, `ACK = 1`.
	- `Sequence number = client_isn + 1`.
	- `Acknowledgement number = server_isn + 1`.
	- ==May contain application data==.
## Connection Termination (Four-Way Handshake)
![](Pasted%20image%2020240518103548.png)
1. Client sends `FIN` segment:
	- `FIN = 1`.
	- No more data from client to server.
2. Server receives `FIN`, sends `ACK` segment:
	- `Acknowledgement number = client_sequence + 1`.
	- Server may continue sending data.
3. Server sends `FIN` segment:
	- `FIN = 1`.
	- Server has finished sending data.
4. Client receives `FIN`, sends `ACK` segment:
	- `Acknowledgement number = server_sequence + 1`.
	- Client enters ==TIME_WAIT== state for $2 \times MSL$ (Maximum Segment Lifetime).
5. Server receives `ACK`, deallocates resources.
6. Client deallocates resources after TIME_WAIT expires.
## Connection States
- `CLOSED`: No connection.
- `LISTEN`: Server waiting for connection request.
- `SYN_SENT`: Client sent SYN, waiting for SYN-ACK.
- `SYN_RCVD`: Server received SYN, sent SYN-ACK, waiting for ACK.
- `ESTABLISHED`: Connection established, data transfer can occur.
- `FIN_WAIT_1`: Waiting for FIN from remote TCP or ACK of previously sent FIN.
- `FIN_WAIT_2`: Waiting for FIN from remote TCP.
- `CLOSE_WAIT`: Waiting for local application to close.
- `CLOSING`: Waiting for FIN ACK from remote TCP.
- `LAST_ACK`: Waiting for ACK of FIN.
- `TIME_WAIT`: Waiting for enough time to ensure remote TCP received ACK of its FIN.
# Congestion Control
- TCP implements congestion control to prevent network overload and maintain stability.
- Detailed coverage in [TCP Congestion Control](congestion-control/TCP%20Congestion%20Control.md).
## Overview
- Regulates sending rate based on network conditions.
- Prevents ==congestion collapse== through adaptive rate control.
- Three main approaches:
	- ==Loss-based==: react to packet loss.
	- ==Delay-based==: react to RTT increase.
	- ==Model-based==: explicitly measure network properties.
## Congestion Window
- Sender maintains ==congestion window (cwnd)== limiting unacknowledged data.
- Effective window:
$$SendWindow = min(RcvWindow, cwnd)$$
- Sending rate approximately:
$$Rate \approx \frac{cwnd}{RTT}$$
## Loss-Based Algorithms
### TCP Tahoe
- First modern congestion control algorithm ($1988$).
- Introduced slow start and congestion avoidance.
- Always returns to slow start on packet loss.
- Detailed in [TCP Tahoe](congestion-control/TCP%20Tahoe.md).
### TCP Reno
- Enhancement of Tahoe with fast recovery ($1990$).
- Distinguishes between timeout and duplicate ACKs.
- ==AIMD== (Additive Increase, Multiplicative Decrease).
- Widely deployed historically.
- Detailed in [TCP Reno](congestion-control/TCP%20Reno.md).
### TCP Cubic
- ==Most widely deployed== algorithm in modern systems.
- Default in Linux since kernel $2.6.19$ ($2008$).
- Uses ==cubic function== for window growth.
- Optimized for high bandwidth-delay product networks.
- Detailed in [TCP Cubic](congestion-control/TCP%20Cubic.md).
## Delay-Based Algorithms
### TCP Vegas
- Pioneering delay-based algorithm ($1994$).
- Detects congestion through ==RTT increase==.
- Proactive: reacts before packet loss.
- "Keep the pipe full, but no fuller".
- Limited deployment due to fairness issues with loss-based flows.
- Detailed in [TCP Vegas](congestion-control/TCP%20Vegas.md).
### TCP BBR
- Modern model-based algorithm by Google ($2016$).
- Explicitly measures ==bottleneck bandwidth and RTT==.
- Achieves high throughput with low latency.
- Addresses bufferbloat problem.
- Growing deployment in modern networks.
- Detailed in [TCP BBR](congestion-control/TCP%20BBR.md).
## Network-Assisted Congestion Control
### Explicit Congestion Notification (ECN)
- Routers ==mark packets== instead of dropping them.
- Provides early congestion signal.
- Reduces packet loss while maintaining congestion control.
- Requires support from routers and end hosts.
- Detailed in [Explicit Congestion Notification (ECN)](congestion-control/Explicit%20Congestion%20Notification%20(ECN).md).
## TCP Fairness
- $N$ TCP connections sharing bottleneck link with capacity $R$.
- Fair allocation: each connection receives $\frac{R}{N}$ throughput.
- AIMD algorithm naturally converges to ==equal bandwidth sharing==.
### Fairness Challenges
- UDP traffic can starve TCP connections.
- Multiple parallel TCP connections receive more bandwidth.
- Short-lived flows may not reach fair share.
- RTT unfairness: shorter RTT flows get more bandwidth.
***
# References
1. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.5: Connection-Oriented Transport: TCP.
		2. Section 3.6: Principles of Congestion Control.
		3. Section 3.7: TCP Congestion Control.
2. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
3. RFC 793 - Transmission Control Protocol.
	1. https://www.rfc-editor.org/rfc/rfc793
4. RFC 5681 - TCP Congestion Control.
	1. https://www.rfc-editor.org/rfc/rfc5681
5. RFC 3168 - The Addition of Explicit Congestion Notification (ECN) to IP.
	1. https://www.rfc-editor.org/rfc/rfc3168
