#computer-network #transport-layer #reliable-data-transfer #protocol #pipelined
# Overview
- Go-Back-N (GBN) is a ==pipelined reliable data transfer protocol==.
- Implements ==sliding window== mechanism for flow control.
- Uses ==cumulative acknowledgement== to confirm packet delivery.
- Retransmits ==all unacknowledged packets== on timeout.
- Part of [Reliable data transfer principle](computer-network/transport-layer/tcp/reliable-data-transfer/Reliable%20data%20transfer%20principle.md).
# Window Structure
## Parameters
- Window size: $N$ (maximum number of unacknowledged packets).
- Oldest unacknowledged packet: $base$.
- Next sequence number to be used: $nextseqnum$.
- Sequence number starts from $0$.
![](Pasted%20image%2020240517120231.png)
## Sequence Number Ranges
- $[0, base - 1]$: ==acknowledged packets== (successfully received).
- $[base, nextseqnum - 1]$: ==sent but unacknowledged packets== (in-flight).
- $[nextseqnum, base + N - 1]$: ==usable but unsent== sequence numbers.
- $[base + N, \infty)$: ==unusable== sequence numbers (outside window).
## Window Range
- Current window: $[base, base + N - 1]$.
- Window ==slides forward== when ACK is received.
- Typical window size in practice: $N = 32$.
# Sender Operations
## Sending Packets
- If $nextseqnum < base + N$ (window not full):
	- Create packet with sequence number $nextseqnum$.
	- Send packet to receiver.
	- Start timer if this is the first unacknowledged packet.
	- Increment $nextseqnum$.
- If $nextseqnum = base + N$ (window full):
	- Refuse data from upper layer.
	- Wait for ACK to free window space.
## Receiving ACK
- ACK packet contains sequence number $n$.
- Uses ==cumulative acknowledgement==: ACK $n$ confirms all packets up to and including sequence number $n$.
- Update $base = n + 1$.
- Slide window forward.
- If $base = nextseqnum$ (all packets acknowledged):
	- Stop timer.
- Otherwise:
	- Restart timer for remaining unacknowledged packets.
## Timeout Event
- Indicates potential packet loss.
- ==Retransmit all unacknowledged packets== in range $[base, nextseqnum - 1]$.
- Restart timer.
- Maximum retransmissions: $N$ packets.
# Receiver Operations
## Receiving Packets
### In-Order Packet
- Sequence number matches expected sequence number $expectedseqnum$.
- Deliver packet to upper layer.
- Send ==ACK== with $expectedseqnum$.
- Increment $expectedseqnum$.
### Out-of-Order Packet
- Sequence number $\neq expectedseqnum$ (packet arrived early or is duplicate).
- ==Discard packet== (do not buffer).
- Resend ACK for ==most recently received in-order packet== ($expectedseqnum - 1$).
## Acknowledgement Strategy
- Receiver sends ACK for the ==highest in-order packet== received.
- ==Duplicate ACKs== signal missing packet to sender.
- Simple receiver design: no buffering of out-of-order packets required.
# Protocol Visualization
![](Pasted%20image%2020240517121739.png)
- Sender maintains sliding window of size $N$.
- Timer monitors oldest unacknowledged packet.
- Cumulative ACK allows efficient acknowledgement.
- Out-of-order packets are discarded, simplifying receiver.
# Performance Characteristics
## Advantages
- Simple receiver implementation (no buffering).
- Efficient acknowledgement with cumulative ACKs.
- Bounded sender window prevents overwhelming receiver.
- Single timer simplifies implementation.
## Disadvantages
- ==Pipeline stall== on packet loss: must retransmit all subsequent packets even if received correctly.
- Bandwidth waste: retransmits successfully received packets.
- Large window size increases retransmission overhead on timeout.
## Example Scenario
- Window size $N = 4$.
- Packet $2$ is lost.
- Receiver sends duplicate ACK $1$ for packets $3$, $4$, $5$.
- Sender timeout occurs.
- Sender retransmits packets $2$, $3$, $4$, $5$ even though $3$, $4$, $5$ were received correctly.
# Sequence Number Space
## Minimum Requirements
- Sequence numbers must be sufficient to distinguish packets.
- Minimum sequence number space: $N + 1$.
- Typically use $2^k$ sequence numbers for efficient modulo arithmetic.
## Modulo Arithmetic
- Sequence numbers wrap around using modulo $2^k$.
- Example: $k = 3$, sequence numbers: $0, 1, 2, 3, 4, 5, 6, 7, 0, 1, \ldots$
- Must ensure $N \leq 2^k$ to avoid ambiguity.
# Comparison with Stop-and-Wait
## Stop-and-Wait
- Special case of GBN with $N = 1$.
- No pipelining: wait for ACK before sending next packet.
- Low utilization in high-latency networks.
## Go-Back-N
- Pipelining with $N > 1$.
- Higher utilization: multiple packets in flight.
- Improved throughput compared to stop-and-wait.
## Utilization
- GBN utilization:
$$U_{sender} = \frac{N \times \frac{L}{R}}{RTT + \frac{L}{R}}$$
- $N$: window size.
- $L$: packet length.
- $R$: transmission rate.
- $RTT$: round-trip time.
***
# References
1. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.4.3: Go-Back-N (GBN).
2. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
3. RFC 1323 - TCP Extensions for High Performance.
	1. https://www.rfc-editor.org/rfc/rfc1323
