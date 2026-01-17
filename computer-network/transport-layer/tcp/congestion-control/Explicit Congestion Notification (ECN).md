#tcp #computer-network #transport-layer #congestion-control #protocol #network-layer #ecn
# Overview
- Explicit Congestion Notification (ECN) is a ==network-assisted congestion control mechanism==.
- Allows routers to signal congestion ==without dropping packets==.
- Requires cooperation between network layer (IP) and transport layer (TCP).
- Standardized in RFC 3168 ($2001$).
- Part of [TCP Congestion Control](TCP%20Congestion%20Control.md).
- Enhances performance of [TCP Reno](TCP%20Reno.md), [TCP Cubic](TCP%20Cubic.md), and other algorithms.
# Motivation
## Packet Loss as Congestion Signal
### Traditional Approach
- Loss-based algorithms detect congestion through packet drops.
- Routers drop packets when queues overflow.
- Packet loss indicates congestion ==after it occurred==.
### Problems
- ==Wasted bandwidth==: dropped packets consumed resources up to drop point.
- ==Retransmission overhead==: sender must retransmit lost data.
- ==Delayed reaction==: congestion already severe when detected.
- ==Binary signal==: no early warning of impending congestion.
## ECN Solution
- Router ==marks packets== instead of dropping them.
- ==Early congestion signal== before buffers overflow.
- Reduces packet loss while maintaining congestion control.
- Preserves packet delivery while signaling congestion.
# Architecture
## Three-Layer Involvement
### Network Layer (IP)
- IP header contains ==ECN field== ($2$ bits in Type of Service field).
- Routers mark packets experiencing congestion.
- Transparent to intermediate routers not supporting ECN.
### Transport Layer (TCP)
- TCP header contains ==ECN flags== ($3$ bits).
- Endpoints negotiate ECN capability during handshake.
- Sender reacts to congestion notifications.
### Application Layer
- Generally transparent to applications.
- Applications benefit from reduced packet loss.
- Some applications may access ECN information.
# ECN Bits in IP Header
## IP Header ECN Field
- Located in ==Type of Service (ToS)== field (now ==Differentiated Services Code Point==).
- $2$ bits designated for ECN:
	- Bit 6: ECT (ECN-Capable Transport).
	- Bit 7: CE (Congestion Experienced).
## ECN Codepoints
### Non-ECT (00)
- Not-ECT: ==Not ECN-Capable Transport==.
- Sender does not support ECN.
- Router treats normally, may drop on congestion.
- Default for legacy systems.
### ECT(0) (10)
- ECT (ECN-Capable Transport) codepoint $0$.
- Sender supports ECN.
- Router may mark instead of dropping.
- Standard codepoint for most implementations.
### ECT(1) (01)
- ECT (ECN-Capable Transport) codepoint $1$.
- Alternative ECN-capable codepoint.
- Used for experimental schemes (e.g., DCTCP).
- Distinguishes different ECN semantics.
### CE (11)
- ==Congestion Experienced==.
- Router marked packet due to congestion.
- Receiver must signal to sender.
- Triggers congestion response.
## ECN Codepoint Table
| Bits | Codepoint | Meaning | Usage |
|------|-----------|---------|-------|
| 00 | Non-ECT | Not ECN-capable | Legacy traffic |
| 01 | ECT(1) | ECN-capable (variant 1) | Experimental |
| 10 | ECT(0) | ECN-capable (standard) | Normal ECN |
| 11 | CE | Congestion Experienced | Congestion signal |
# ECN Bits in TCP Header
## TCP ECN Flags
- $3$ bits in TCP flags field:
	- ==ECE== (ECN-Echo): $1$ bit.
	- ==CWR== (Congestion Window Reduced): $1$ bit.
	- ==NS== (Nonce Sum): $1$ bit.
## ECN-Echo (ECE) Flag
- Set by ==receiver== to signal congestion to sender.
- Indicates CE-marked packet received.
- Continues to be set until CWR received.
- Provides reliable congestion notification.
## Congestion Window Reduced (CWR) Flag
- Set by ==sender== to acknowledge ECE.
- Indicates congestion window has been reduced.
- Signals receiver to stop sending ECE.
- Prevents duplicate congestion responses.
## Nonce Sum (NS) Flag
- Used for ==ECN nonce== (optional, rarely deployed).
- Protects against receiver misbehavior.
- Allows sender to verify receiver honesty.
- Complex mechanism, limited adoption.
# ECN Operation
## ECN Capability Negotiation
### Connection Establishment (Three-Way Handshake)
1. ==SYN packet== (client to server):
	- Set `ECE = 1` and `CWR = 1` in TCP header.
	- Indicates client ECN capability.
	- IP header: ECT(0) or Non-ECT (varies by implementation).
2. ==SYN-ACK packet== (server to client):
	- Set `ECE = 1` in TCP header if server supports ECN.
	- Clear `CWR = 0`.
	- Acknowledges ECN negotiation.
3. ==ACK packet== (client to server):
	- Clear `ECE = 0` and `CWR = 0`.
	- ECN enabled for connection.
### Negotiation Outcomes
- Both support ECN: ==ECN enabled== for connection.
- Either doesn't support: ==ECN disabled==, fallback to legacy behavior.
- Negotiation transparent to applications.
## Data Transfer with ECN
### Sender Behavior
1. Mark outgoing packets as ==ECT(0)== or ==ECT(1)== in IP header.
2. Monitor incoming ACKs for ==ECE flag==.
3. On receiving ACK with `ECE = 1`:
	- ==Reduce congestion window== (same as packet loss response):
$$cwnd = cwnd \times \beta$$
	- For Reno/Cubic: $\beta = 0.5$ (halve window).
	- Set ==CWR flag== in next outgoing packet.
	- Continue sending normally.
### Router Behavior
1. Monitor queue length and utilization.
2. Apply ==Active Queue Management (AQM)== algorithm (e.g., RED, PIE, CoDel).
3. When congestion threshold reached:
	- If packet has ECT(0) or ECT(1): ==mark as CE== instead of dropping.
	- If packet has Non-ECT: ==drop packet== as usual.
4. Forward marked packets normally.
### Receiver Behavior
1. Receive packet with ==CE marking==.
2. Set ==ECE flag== in next ACK packet.
3. Continue setting ECE in subsequent ACKs until receiving packet with ==CWR flag==.
4. Ensures reliable congestion signal delivery.
## ECN Feedback Loop
![](Pasted%20image%2020240518104417.png)
```Text
Sender → Router → Receiver
  ↑                  ↓
  └── ACK with ECE ──┘
```
1. Sender marks packets as ECT.
2. Router experiencing congestion marks packet as CE.
3. Receiver detects CE marking, sets ECE in ACK.
4. Sender receives ACK with ECE, reduces cwnd, sets CWR.
5. Receiver sees CWR, stops setting ECE.
# Active Queue Management (AQM)
## Purpose
- Determine ==when to mark/drop packets==.
- Maintain optimal queue length.
- Provide early congestion signal.
## Common AQM Algorithms
### Random Early Detection (RED)
- Pioneering AQM algorithm ($1993$).
- Probabilistically drops/marks packets based on average queue length.
- Parameters:
	- $min_{th}$: minimum threshold.
	- $max_{th}$: maximum threshold.
	- $max_p$: maximum marking probability.
- Marking probability:
$$p = \begin{cases}
0 & \text{if } avg\_queue < min_{th} \\
\frac{avg\_queue - min_{th}}{max_{th} - min_{th}} \times max_p & \text{if } min_{th} \leq avg\_queue < max_{th} \\
1 & \text{if } avg\_queue \geq max_{th}
\end{cases}$$
### PIE (Proportional Integral Controller Enhanced)
- Modern AQM algorithm ($2013$).
- Uses ==control theory== approach.
- Adjusts dropping/marking probability based on:
	- Current queue delay.
	- Queue delay trend.
- Better performance than RED.
### CoDel (Controlled Delay)
- Delay-based AQM ($2012$).
- Targets specific ==queuing delay== (default: $5$ ms).
- Drops/marks when packets experience excessive delay.
- Self-tuning, no manual parameter configuration.
- Effective against bufferbloat.
# Performance Benefits
## Reduced Packet Loss
- ECN-marked packets ==not dropped==.
- Avoids retransmission overhead.
- Improved throughput, especially in lossy networks.
## Lower Latency
- Early congestion signal prevents queue overflow.
- Shorter queue lengths reduce queuing delay.
- Benefits latency-sensitive applications.
## Improved Throughput
- Congestion response without packet loss.
- Faster recovery compared to loss-based detection.
- Studies show $10-30\%$ throughput improvement.
## Better Fairness
- More precise congestion signaling.
- Helps achieve fairer bandwidth allocation.
- Reduces impact of queue synchronization.
# Deployment Challenges
## Incomplete Deployment
- Requires support from:
	- ==Sender OS==: set ECT bits, react to ECE.
	- ==Router firmware==: implement AQM, mark CE bits.
	- ==Receiver OS==: detect CE, set ECE.
- Missing any component disables ECN.
## Middlebox Issues
### ECN Bleaching
- Some middleboxes ==clear ECN bits==.
- Breaks ECN signaling.
- Causes silent failure.
### SYN Packet Blocking
- Some firewalls ==block SYN packets== with ECN flags.
- Prevents connection establishment.
- Requires fallback mechanism.
## Fallback Mechanisms
- Modern TCP implementations detect ECN failures.
- Retry connection without ECN if SYN dropped.
- Degrades gracefully to legacy behavior.
## Measurement Studies
- ECN deployment increased over time.
- $2021$ measurements: $\approx 70\%$ of web servers support ECN.
- Router support varies by ISP.
- Mobile networks increasingly support ECN.
# ECN Variants and Extensions
## Data Center TCP (DCTCP)
- ECN variant optimized for ==data centers==.
- Uses ==ECT(1)== codepoint.
- More aggressive congestion response.
- Proportional marking:
$$cwnd = cwnd \times (1 - \frac{\alpha}{2})$$
- $\alpha$: fraction of marked packets.
- Achieves ==high burst tolerance== with ==low latency==.
## L4S (Low Latency, Low Loss, Scalable Throughput)
- Modern ECN-based architecture.
- Dual-queue AQM in routers.
- Supports both classic and scalable congestion control.
- Promises ==sub-millisecond latency== at high throughput.
## Accurate ECN (AccECN)
- Enhanced ECN feedback mechanism.
- Provides ==more detailed congestion information==.
- Three counters for ECT(0), ECT(1), CE packets.
- Better performance in high-BDP networks.
## ECN in QUIC
- QUIC protocol uses ECN by default.
- Simplified negotiation (no three-way handshake needed for UDP).
- Better ECN deployment due to user-space implementation.
# Configuration and Tuning
## Linux Configuration
### Enable ECN
```Shell
# Enable ECN (0=disabled, 1=enabled if negotiated, 2=always enabled)
sysctl -w net.ipv4.tcp_ecn=1

# Check current setting
sysctl net.ipv4.tcp_ecn
```
### ECN Modes
- `0`: ==Disabled==, do not use ECN.
- `1`: ==Request== ECN, fallback if not supported (default recommended).
- `2`: ==Always== use ECN, may cause connectivity issues.
## Router Configuration
### Enable AQM with ECN
- Depends on router platform and firmware.
- Common options:
	- FQ_CoDel (Linux): `tc qdisc add dev eth0 root fq_codel ecn`.
	- PIE: configure via platform-specific tools.
	- RED: legacy, not recommended.
## Verification
### Check ECN Negotiation
```Shell
# Capture packets during connection
tcpdump -i any -n 'tcp[tcpflags] & (tcp-syn) != 0'

# Look for ECE and CWR flags in SYN
```
### Measure ECN Effectiveness
- Monitor CE marking rate.
- Compare throughput and latency with/without ECN.
- Check packet loss reduction.
# ECN and TCP Variants
## ECN with TCP Reno
- Standard ECN implementation.
- Treats CE marking same as packet loss.
- Halves congestion window on ECE.
## ECN with TCP Cubic
- Similar to Reno.
- Multiplicative decrease: $cwnd = cwnd \times 0.7$.
- Fast recovery without actual packet loss.
## ECN with TCP BBR
- [TCP BBR](TCP%20BBR.md) can use ECN.
- BBR's model-based approach less reliant on ECN.
- ECN provides supplementary signal.
- Improves performance in ECN-enabled networks.
# Security and Misbehavior
## Potential Attacks
### ECN Suppression
- Malicious host ignores CE markings.
- Gains unfair bandwidth advantage.
- Difficult to detect remotely.
### Excessive CE Marking
- Malicious router over-marks packets.
- Forces legitimate flows to reduce rate.
- Enables denial-of-service.
## Countermeasures
### ECN Nonce
- Sender includes nonce in packets.
- Receiver must echo nonce correctly.
- Detects receiver misbehavior.
- Limited deployment due to complexity.
### Network Monitoring
- Monitor for abnormal CE marking rates.
- Detect routers behaving incorrectly.
- Anomaly detection systems.
# Future Directions
## Increased Deployment
- Growing adoption in data centers.
- Mobile networks enabling ECN.
- Cloud providers implementing ECN.
## L4S Standardization
- IETF working group active.
- Next-generation ECN architecture.
- Promise of ultra-low latency.
## Integration with 5G
- 5G networks designed with ECN support.
- Critical for latency-sensitive applications.
- Enables network slicing optimization.
***
# References
1. RFC 3168 - The Addition of Explicit Congestion Notification (ECN) to IP.
	1. https://www.rfc-editor.org/rfc/rfc3168
	2. Primary ECN specification.
2. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.7.2: Network-Assisted Explicit Congestion Notification.
3. RFC 8257 - Data Center TCP (DCTCP): TCP Congestion Control for Data Centers.
	1. https://www.rfc-editor.org/rfc/rfc8257
4. RFC 8311 - Relaxing Restrictions on Explicit Congestion Notification (ECN) Experimentation.
	1. https://www.rfc-editor.org/rfc/rfc8311
5. Sally Floyd, Van Jacobson. Random Early Detection Gateways for Congestion Avoidance. IEEE/ACM Transactions on Networking, 1993.
	1. RED algorithm paper.
6. Kathleen Nichols, Van Jacobson. Controlling Queue Delay. ACM Queue, 2012.
	1. CoDel algorithm paper.
7. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
8. Bob Briscoe, Koen De Schepper, Marcelo Bagnulo. Low Latency, Low Loss, Scalable Throughput (L4S) Internet Service: Architecture. RFC 9330, 2023.
	1. https://www.rfc-editor.org/rfc/rfc9330
