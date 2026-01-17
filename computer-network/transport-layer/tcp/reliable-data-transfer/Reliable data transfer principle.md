#transport-layer #tcp #computer-network #reliable-data-transfer #protocol
# Overview
- Reliable data transfer (RDT) provides ==guaranteed delivery== over an unreliable network layer channel.
- Used in [Transmission Control Protocol (TCP)](../Transmission%20Control%20Protocol%20(TCP).md).
- Employs ==Finite State Machine (FSM)== to model protocol behavior.
- Network layer may introduce ==bit errors==, ==packet loss==, and ==packet reordering==.
![](Pasted%20image%2020240515082419.png)
# RDT 1.0 - Perfectly Reliable Channel
## Assumptions
- Underlying channel is ==perfectly reliable==.
- No bit errors, no packet loss.
## FSM Design
![](Pasted%20image%2020240515082653.png)
- Sender has $1$ state:
	- Waits for data from upper layer.
	- Sends packet to receiver.
- Receiver has $1$ state:
	- Waits for packet from sender.
	- Delivers data to upper layer.
## Characteristics
- Simplest protocol, no error handling required.
- Not practical for real-world networks.
# RDT 2.0 - Channel with Bit Errors
## Assumptions
- Channel may corrupt packet bits.
- Packets are delivered in order.
- No packet loss.
## Mechanisms
- ==Acknowledgement (ACK)==: receiver signals successful packet reception.
- ==Negative acknowledgement (NAK)==: receiver signals corrupted packet.
- ==Stop-and-wait==: sender waits for ACK or NAK before sending next packet.
- ==Retransmission==: sender retransmits packet upon receiving NAK.
## Sender FSM
![](Pasted%20image%2020240515083054.png)
- Two states:
	1. Wait for call from upper layer.
	2. Wait for ACK or NAK.
- On NAK: retransmit packet.
- On ACK: move to next packet.
## Receiver FSM
- One state:
	- Check packet integrity using checksum.
	- Send ACK if packet is uncorrupted.
	- Send NAK if packet is corrupted.
![](Pasted%20image%2020240515083303.png)
## Limitations
- Cannot handle ==ACK or NAK corruption==.
- No mechanism for duplicate detection.
# RDT 2.1 - Handling ACK/NAK Corruption
## Problem
- ACK or NAK packets may be corrupted.
- Sender cannot distinguish corrupted ACK from corrupted NAK.
## Solution
- Introduce ==sequence numbers== to detect duplicate packets.
- Sequence numbers alternate between $0$ and $1$ (sufficient for stop-and-wait).
- Sender retransmits packet if ACK/NAK is corrupted.
- Receiver discards duplicate packets.
## Sender FSM
![](Pasted%20image%2020240515083807.png)
- Four states (two for each sequence number):
	1. Wait for call $0$ from upper layer.
	2. Wait for ACK or NAK $0$.
	3. Wait for call $1$ from upper layer.
	4. Wait for ACK or NAK $1$.
- On receiving corrupted ACK/NAK: retransmit current packet.
- On receiving correct ACK: move to next sequence number.
## Receiver FSM
![](Pasted%20image%2020240515114040.png)
- Two states (one for each expected sequence number):
	1. Wait for packet $0$.
	2. Wait for packet $1$.
- On receiving packet with ==correct sequence number==: send ACK, deliver data, move to next state.
- On receiving packet with ==wrong sequence number==: send ACK for previous packet (duplicate).
# RDT 2.2 - NAK-Free Protocol
## Motivation
- Simplify protocol by eliminating NAK.
- Use ACK with sequence number instead.
## Mechanism
- Receiver sends ==ACK with sequence number== of last correctly received packet.
- ==Duplicate ACK== signals packet corruption or loss.
- Sender retransmits on receiving duplicate ACK.
## Sender FSM
![](Pasted%20image%2020240515114459.png)
- Similar to RDT 2.1 but uses only ACKs.
- Retransmits when receiving ACK for wrong sequence number.
## Receiver FSM
![](Pasted%20image%2020240515114539.png)
- Sends ACK with sequence number of correctly received packet.
- On receiving duplicate or out-of-order packet: resend previous ACK.
# RDT 3.0 - Channel with Bit Errors and Packet Loss
## Assumptions
- Channel may corrupt bits.
- Channel may lose packets.
## Mechanisms
- ==Timer==: sender starts timer when sending packet.
- ==Timeout event==: sender retransmits packet if ACK not received within timeout period.
- Still uses ==stop-and-wait== protocol.
## Sender FSM
![](Pasted%20image%2020240515114835.png)
- Starts timer after sending packet.
- On timeout: retransmit packet and restart timer.
- On ACK: cancel timer and move to next packet.
## Performance Analysis
### Utilization
- Sender utilization (fraction of time sender is busy):
$$U_{sender} = \frac{\frac{L}{R}}{RTT + \frac{L}{R}}$$
- $L$: packet size in bits.
- $R$: transmission rate in bits per second.
- $\frac{L}{R}$: transmission time.
- $RTT$: round-trip time.
### Limitation
- Stop-and-wait suffers from ==Head-of-Line (HOL) blocking==.
- $RTT \gg \frac{L}{R} \Rightarrow U_{sender}$ is very small.
- Example: $L = 8000$ bits, $R = 1$ Gbps, $RTT = 30$ ms.
$$U_{sender} = \frac{0.008 \text{ ms}}{30.008 \text{ ms}} \approx 0.027\%$$
## Scenarios
### Packet Loss
![](Pasted%20image%2020240515115309.png)
- Packet is lost during transmission.
- Sender timeout expires.
- Sender retransmits packet.
- Receiver sends ACK upon receiving retransmitted packet.
### ACK Loss
![](Pasted%20image%2020240515115805.png)
- Packet is received successfully but ACK is lost.
- Sender timeout expires.
- Sender retransmits packet.
- Receiver detects ==duplicate packet== using sequence number.
- Receiver resends ACK.
### Premature Timeout
![](Pasted%20image%2020240515120208.png)
- ACK is delayed but not lost.
- Sender timeout expires before ACK arrives.
- Sender retransmits packet.
- Receiver detects duplicate and resends ACK.
- Sender may receive original ACK (now expired) and ignore it.
- Sender may receive duplicate ACK and continue normally.
# Pipelined Protocols
## Motivation
- Resolve ==Head-of-Line blocking==.
- Allow sender to transmit ==multiple packets== without waiting for ACK.
- Achieve ==much higher utilization==.
![](Pasted%20image%2020240517115029.png)
## Characteristics
- Sender maintains ==window== of unacknowledged packets.
- ==Sequence number range== must be increased.
- Sender and receiver must ==buffer multiple packets==.
## Utilization Improvement
- With pipelining of $N$ packets:
$$U_{sender} = \frac{N \times \frac{L}{R}}{RTT + \frac{L}{R}}$$
- Example: $N = 3$, utilization increases from $0.027\%$ to $0.081\%$.
- Example: $N = 100$, utilization increases to $2.7\%$.
## Pipelined Protocol Variants
### Go-Back-N (GBN)
- Described in [Go Back N](computer-network/transport-layer/tcp/reliable-data-transfer/Go%20Back%20N.md).
- Uses ==cumulative acknowledgement==.
- Retransmits ==all unacknowledged packets== on timeout.
- Receiver ==discards out-of-order packets==.
### Selective Repeat (SR)
- Described in [Selective repeat](computer-network/transport-layer/tcp/reliable-data-transfer/Selective%20repeat.md).
- Uses ==individual acknowledgement== for each packet.
- Retransmits ==only lost packet==.
- Receiver ==buffers out-of-order packets==.
***
# References
1. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.4: Principles of Reliable Data Transfer.
2. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
3. [[computer-network/transport-layer/tcp/Transmission Control Protocol (TCP)]]
4. 
