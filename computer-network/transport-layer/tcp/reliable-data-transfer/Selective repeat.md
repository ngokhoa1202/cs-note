#protocol #computer-network #reliable-data-transfer #transport-layer #pipelined
# Overview
- Selective Repeat (SR) is a ==pipelined reliable data transfer protocol==.
- More efficient than [Go Back N](computer-network/transport-layer/tcp/reliable-data-transfer/Go%20Back%20N.md) by ==retransmitting only lost packets==.
- Uses ==individual acknowledgement== for each packet.
- Receiver ==buffers out-of-order packets== for in-order delivery to upper layer.
- Part of [Reliable data transfer principle](computer-network/transport-layer/tcp/reliable-data-transfer/Reliable%20data%20transfer%20principle.md).
- Used as basis for [TCP](../Transmission%20Control%20Protocol%20(TCP).md) reliable data transfer.
# Window Structure
## Parameters
- Window size: $N$ (maximum number of unacknowledged packets).
- Sender's oldest unacknowledged packet: $send\_base$.
- Next sequence number to be used: $nextseqnum$.
- Receiver's expected sequence number: $rcv\_base$.
- Sequence number starts from $0$.
![](Pasted%20image%2020240517120231.png)
## Sender Window
- $[0, send\_base - 1]$: ==acknowledged packets==.
- $[send\_base, nextseqnum - 1]$: ==sent but unacknowledged packets==.
- $[nextseqnum, send\_base + N - 1]$: ==usable but unsent== sequence numbers.
- $[send\_base + N, \infty)$: ==unusable== sequence numbers.
- Window range: $[send\_base, send\_base + N - 1]$.
## Receiver Window
- $[0, rcv\_base - 1]$: ==received and delivered== packets.
- $[rcv\_base, rcv\_base + N - 1]$: ==acceptable packets== (may be buffered if out-of-order).
- $[rcv\_base + N, \infty)$: ==not yet acceptable== packets.
- $rcv\_base$ may differ from $send\_base$ due to packet loss or delays.
# Sender Operations
## Sending Packets
- If $nextseqnum < send\_base + N$ (window not full):
	- Create packet with sequence number $nextseqnum$.
	- Send packet to receiver.
	- Start ==individual timer== for this packet.
	- Increment $nextseqnum$.
- If $nextseqnum = send\_base + N$ (window full):
	- Refuse data from upper layer.
	- Wait for ACK to free window space.
## Receiving ACK
- ACK packet acknowledges specific sequence number $n$.
- If $n$ is in window $[send\_base, send\_base + N - 1]$:
	- Mark packet $n$ as acknowledged.
	- Stop timer for packet $n$.
	- If $n = send\_base$:
		- Slide window forward to next unacknowledged packet.
		- Update $send\_base$ to smallest unacknowledged sequence number.
## Timeout Event
- Each packet has ==separate timer==.
- On timeout for packet $n$:
	- ==Retransmit only packet $n$== (not entire window).
	- Restart timer for packet $n$.
- Multiple timers allow fine-grained retransmission control.
# Receiver Operations
## Receiving Packets
### In-Window Packet ($rcv\_base \leq n < rcv\_base + N$)
- Packet sequence number $n$ falls within receiver window.
- Send ==selective ACK== for packet $n$.
- If $n$ has not been received before:
	- Buffer packet $n$.
	- If $n = rcv\_base$ (expected packet):
		- Deliver packet $n$ and any consecutive buffered packets to upper layer.
		- Slide window forward.
		- Update $rcv\_base$ to next expected sequence number.
### Out-of-Window Packet
#### Below Window ($n < rcv\_base$)
- Packet is a ==duplicate== or delayed acknowledgement.
- Send ACK for packet $n$.
- Discard packet (already delivered to upper layer).
#### Above Window ($n \geq rcv\_base + N$)
- Packet is ==too far ahead==.
- ==Ignore packet== (do not acknowledge).
- Packet will be retransmitted when it falls within window.
# Protocol Visualization
![](Pasted%20image%2020240517135250.png)
- Sender maintains individual timers for each packet.
- Receiver buffers out-of-order packets.
- Individual ACKs allow efficient retransmission.
- Both sender and receiver windows slide independently.
# Performance Characteristics
## Advantages
- ==Efficient bandwidth usage==: retransmits only lost packets.
- No pipeline stall: continues sending while waiting for retransmission.
- Better throughput than GBN in lossy networks.
- Optimal for high-latency, high-loss environments.
## Disadvantages
- ==Complex implementation==:
	- Requires ==multiple timers== (one per packet).
	- Receiver must ==buffer out-of-order packets==.
	- More memory usage at receiver.
- ==Individual ACKs== increase overhead compared to cumulative ACKs.
- Requires larger sequence number space than GBN.
## Comparison with Go-Back-N
| Feature | Go-Back-N | Selective Repeat |
|---------|-----------|------------------|
| Retransmission | All unacknowledged packets | Only lost packet |
| Receiver buffering | No buffering | Buffers out-of-order packets |
| Timers | Single timer | Individual timers per packet |
| ACK type | Cumulative | Individual (selective) |
| Complexity | Simple | Complex |
| Bandwidth efficiency | Lower (wasteful retransmissions) | Higher (targeted retransmissions) |
# Selective Repeat Dilemma
## Problem Statement
- How to distinguish ==new packet== from ==retransmitted packet== with the same sequence number?
- Finite sequence number space causes wraparound ambiguity.
## Example Scenario
- Window size $N = 3$.
- Sequence numbers: $0, 1, 2, 3$ (modulo $4$).
- Sender transmits packets $0, 1, 2$.
- All ACKs are lost.
- Sender retransmits packet $0$ (timeout).
- Receiver has moved window to $[3, 0, 1]$.
- Receiver cannot distinguish:
	- Retransmitted packet $0$ (old).
	- New packet $0$ (wrapped around).
## Solution
- Constraint on sequence number space:
$$N \leq \frac{sequence\_number\_space}{2}$$
- Ensures no ambiguity between old and new packets.
- Example: for $N = 3$, need at least $6$ sequence numbers.
## Practical Implementation
- TCP uses $32$-bit sequence numbers ($2^{32}$ possible values).
- With $32$-bit space, SR dilemma is ==practically avoided==.
- Sequence numbers count bytes, not packets.
- Wraparound occurs after $\approx 4$ GB of data.
# TCP Implementation of Selective Repeat
## Hybrid Approach
- TCP combines elements of both GBN and SR.
- Uses ==cumulative acknowledgements== (like GBN).
- ==Buffers out-of-order segments== (like SR).
- Employs ==single retransmission timer== (like GBN).
- Supports ==selective acknowledgement (SACK)== option for enhanced performance.
## SACK Option
- TCP extension defined in RFC 2018.
- Allows receiver to acknowledge ==non-contiguous blocks== of data.
- Sender can ==selectively retransmit== only missing segments.
- Improves performance without full SR complexity.
## Differences from Pure SR
- TCP uses ==byte-oriented== sequence numbers, not packet numbers.
- Timer management is simplified (single timer for oldest unacknowledged segment).
- Fast retransmit mechanism uses ==duplicate ACKs== instead of only timeouts.
***
# References
1. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.4.4: Selective Repeat (SR).
2. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
3. RFC 2018 - TCP Selective Acknowledgment Options.
	1. https://www.rfc-editor.org/rfc/rfc2018
4. RFC 793 - Transmission Control Protocol.
	1. https://www.rfc-editor.org/rfc/rfc793
5. [[computer-network/transport-layer/tcp/Transmission Control Protocol (TCP)]]
6. 