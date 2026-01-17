#tcp #computer-network #transport-layer #congestion-control #protocol
# Overview
- TCP congestion control prevents network congestion by regulating transmission rate.
- Operates ==end-to-end== without explicit network feedback (in basic form).
- Three primary goals:
	- ==Efficiency==: utilize available bandwidth.
	- ==Fairness==: share bandwidth equitably among flows.
	- ==Stability==: avoid persistent congestion collapse.
- Essential component of [Transmission Control Protocol (TCP)](../Transmission%20Control%20Protocol%20(TCP).md).
# Network Congestion
## Congestion Definition
- Network congestion occurs when ==aggregate demand exceeds network capacity==.
- Results in:
	- ==Increased packet delay== due to queuing.
	- ==Packet loss== due to buffer overflow.
	- ==Reduced throughput== despite increased offered load.
	- ==Network instability== and potential congestion collapse.
## Congestion Scenarios
### Scenario 1: Infinite Buffer
- Router has unlimited buffer space.
- No packet loss, but ==unbounded queuing delay==.
- As offered load increases, delay approaches infinity.
- Throughput saturates at link capacity.
### Scenario 2: Finite Buffer
![](Pasted%20image%2020240517160321.png)
- Realistic scenario with limited buffer space.
- Original sending rate: $\lambda_{in}$.
- Effective sending rate with retransmissions: $\lambda'_{in} > \lambda_{in}$.
- As $\lambda'_{in}$ increases, throughput $\lambda_{out} \to 0$.
- ==Retransmissions consume bandwidth== without delivering new data.
### Scenario 3: Multi-Hop Networks
- Packets traverse multiple routers.
- Packet drop at downstream router ==wastes upstream bandwidth==.
- Cascading effect amplifies congestion.
- Congestion in one link affects entire path.
## Congestion Collapse
- Severe network degradation where ==useful throughput approaches zero==.
- Caused by:
	- Excessive retransmissions consuming bandwidth.
	- Packets dropped after consuming upstream resources.
	- Unfair bandwidth allocation causing starvation.
- Occurred in early Internet (1980s), motivating TCP congestion control.
# Congestion Control Principles
## Detection Mechanisms
### Loss-Based Detection
- Packet loss signals network congestion.
- Detected via:
	- ==Timeout==: ACK not received within expected time.
	- ==Duplicate ACKs==: receiver signals missing packet.
- Assumption: loss primarily due to congestion, not corruption.
### Delay-Based Detection
- RTT increase indicates growing queues.
- Proactive approach: detect congestion ==before packet loss==.
- Used in [TCP Vegas](TCP%20Vegas.md) and [TCP BBR](TCP%20BBR.md).
### Explicit Notification
- Network devices explicitly signal congestion.
- Implemented via [Explicit Congestion Notification (ECN)](Explicit%20Congestion%20Notification%20(ECN).md).
- Requires router and end-host support.
## Response Strategies
### Decrease Sending Rate
- ==Reduce transmission rate== upon detecting congestion.
- Prevents congestion from worsening.
- Allows network queues to drain.
### Increase Sending Rate
- ==Gradually increase rate== when network is underutilized.
- Probes for available bandwidth.
- Maximizes throughput without causing congestion.
### Bandwidth Probing
- Continuously adjust sending rate to find optimal operating point.
- Balance between efficiency and congestion avoidance.
- Dynamic adaptation to changing network conditions.
# Congestion Window
## Definition
- ==Congestion window (cwnd)==: sender's limit on unacknowledged data.
- Measured in bytes or Maximum Segment Size (MSS) units.
- Dynamically adjusted based on congestion signals.
## Effective Window
- Sender's actual window limited by both flow control and congestion control:
$$SendWindow = min(RcvWindow, cwnd)$$
- $RcvWindow$: receiver's advertised window (flow control).
- $cwnd$: congestion window (congestion control).
## Sending Rate
- Approximate sending rate:
$$Rate \approx \frac{cwnd}{RTT}$$
- $cwnd$: congestion window in bytes.
- $RTT$: round-trip time.
- Larger $cwnd$ → higher sending rate.
- Larger $RTT$ → lower sending rate.
# AIMD Algorithm
## Additive Increase, Multiplicative Decrease
- Fundamental principle underlying most TCP variants.
- Two-phase approach:
	- ==Additive Increase (AI)==: linearly increase $cwnd$ when no congestion.
	- ==Multiplicative Decrease (MD)==: exponentially decrease $cwnd$ upon congestion.
## Additive Increase
- Increment $cwnd$ by fixed amount per RTT.
- Typical increase: $1$ MSS per RTT.
- Per-ACK increase:
$$cwnd = cwnd + \frac{MSS \times MSS}{cwnd}$$
- Results in linear growth over time.
## Multiplicative Decrease
- Decrease $cwnd$ by multiplicative factor upon congestion.
- Typical decrease: $cwnd = \frac{cwnd}{2}$ (halving).
- Aggressive response to prevent further congestion.
## Convergence to Fairness
- AIMD naturally converges to fair bandwidth allocation.
- Two competing flows eventually achieve equal throughput.
- Mathematical proof based on fluid model analysis.
## Sawtooth Pattern
- AIMD creates characteristic ==sawtooth throughput pattern==.
- Oscillates around optimal operating point.
- Trade-off between efficiency and stability.
# Loss-Based Congestion Control Algorithms
## Overview
- Detect congestion through packet loss.
- Include:
	- [TCP Tahoe](TCP%20Tahoe.md): conservative, no fast recovery.
	- [TCP Reno](TCP%20Reno.md): fast recovery for duplicate ACKs.
	- [TCP Cubic](TCP%20Cubic.md): cubic growth function, optimized for high-bandwidth networks.
## Common Phases
### Slow Start
- Exponential growth phase.
- Initial $cwnd = 1$ MSS or $10$ MSS (modern default).
- Double $cwnd$ every RTT until reaching threshold.
- Purpose: quickly probe available bandwidth.
### Congestion Avoidance
- Linear growth phase.
- Increase $cwnd$ by $1$ MSS per RTT.
- Conservative probing after reaching threshold.
- Maintains network stability.
### Fast Recovery
- Quick recovery from packet loss detected via duplicate ACKs.
- Maintains higher throughput than slow start.
- Not present in all variants (e.g., absent in TCP Tahoe).
# Delay-Based Congestion Control Algorithms
## Overview
- Detect congestion through RTT increase.
- Proactive approach: react ==before packet loss==.
- Include:
	- [TCP Vegas](TCP%20Vegas.md): pioneering delay-based algorithm.
	- [TCP BBR](TCP%20BBR.md): modern Google algorithm.
## Advantages
- Lower packet loss rates.
- Reduced queuing delays.
- Better performance in bufferbloat scenarios.
- Proactive congestion avoidance.
## Challenges
- ==Fairness issues== when competing with loss-based flows.
- Loss-based flows may consume more bandwidth.
- Requires accurate RTT measurement.
- Sensitive to RTT fluctuations.
# Hybrid Approaches
## TCP NewReno
- Enhancement of TCP Reno.
- Improved fast recovery handling multiple packet losses.
- Remains loss-based but more robust.
## TCP Compound
- Microsoft algorithm combining loss and delay signals.
- Dual congestion windows:
	- ==Loss-based window==: reacts to packet loss.
	- ==Delay-based window==: reacts to RTT increase.
- Better performance in high-bandwidth, high-delay networks.
## TCP Westwood
- Uses bandwidth estimation to set $cwnd$ after loss.
- More aggressive recovery than Reno.
- Better performance over wireless links.
# Network-Assisted Congestion Control
## Explicit Congestion Notification (ECN)
- Detailed in [Explicit Congestion Notification (ECN)](Explicit%20Congestion%20Notification%20(ECN).md).
- Router marks packets instead of dropping.
- Reduces packet loss while signaling congestion.
- Requires support from:
	- Network routers.
	- Transport layer protocols.
	- Applications.
## Benefits
- Early congestion detection.
- Reduced packet loss.
- Improved throughput and latency.
- Better fairness.
# TCP Fairness
## Fairness Goal
- $N$ TCP connections sharing bottleneck link with capacity $R$.
- Fair allocation: each connection receives $\frac{R}{N}$ throughput.
## AIMD and Fairness
- AIMD algorithm converges to equal bandwidth sharing.
- Additive increase: all connections increase at same rate.
- Multiplicative decrease: connections decrease proportionally.
- Creates oscillation around fairness line.
## Fairness Challenges
### UDP Competition
- UDP does not implement congestion control.
- Can starve TCP connections by consuming excessive bandwidth.
- Requires application-level or network-level rate limiting.
### Multiple TCP Connections
- Applications opening multiple parallel connections receive more bandwidth.
- Example: $10$ parallel connections get $\approx 10\times$ more bandwidth.
- ==Fairness per connection==, not per application.
### Short-Lived vs Long-Lived Flows
- Short-lived flows may complete during slow start.
- Never reach fair share in congestion avoidance.
- Long-lived flows dominate bandwidth allocation.
- Web traffic patterns exacerbate this issue.
### RTT Unfairness
- Flows with shorter RTT increase $cwnd$ faster.
- AIMD not RTT-fair: favors low-latency connections.
- Geographic distance affects fairness.
# Performance Metrics
## Throughput
- Amount of data successfully delivered per unit time.
- Measured in bits per second (bps).
- Higher throughput indicates better performance.
## Latency
- Time for packet to travel from sender to receiver.
- Includes:
	- ==Propagation delay==: physical transmission time.
	- ==Queuing delay==: time spent in router buffers.
	- ==Processing delay==: router processing time.
- Lower latency improves user experience.
## Packet Loss Rate
- Fraction of packets lost in transit.
- Metric for network reliability.
- Lower loss rate reduces retransmissions.
## Fairness Index
- Jain's fairness index:
$$F = \frac{(\sum_{i=1}^{n} x_i)^2}{n \times \sum_{i=1}^{n} x_i^2}$$
- $x_i$: throughput of flow $i$.
- $n$: number of flows.
- $F = 1$: perfectly fair.
- $F < 1$: unfair allocation.
## Link Utilization
- Fraction of link capacity used.
- Ideal: high utilization without congestion.
- Trade-off with latency (bufferbloat).
# Algorithm Comparison
## Summary Table
| Algorithm | Type | Growth Function | Use Case | Advantages | Disadvantages |
|-----------|------|-----------------|----------|------------|---------------|
| [TCP Tahoe](TCP%20Tahoe.md) | Loss-based | Linear | Legacy | Simple, stable | Slow recovery |
| [TCP Reno](TCP%20Reno.md) | Loss-based | Linear | General purpose | Fast recovery | Poor for high-loss |
| [TCP Cubic](TCP%20Cubic.md) | Loss-based | Cubic | High BDP | Fast probing, scalable | Complex |
| [TCP Vegas](TCP%20Vegas.md) | Delay-based | Linear | Low-loss networks | Proactive, low loss | Fairness issues |
| [TCP BBR](TCP%20BBR.md) | Delay-based | Model-based | Modern networks | Optimal throughput+latency | New, requires tuning |
- BDP: Bandwidth-Delay Product.
## Evolution Timeline
- **1988**: TCP Tahoe introduced (Van Jacobson).
- **1990**: TCP Reno adds fast recovery.
- **1994**: TCP Vegas introduces delay-based control.
- **2005**: TCP Cubic becomes Linux default.
- **2016**: TCP BBR released by Google.
- **2020s**: Continued evolution with QUIC and HTTP/3.
# Modern Developments
## Active Queue Management (AQM)
- Router-based techniques to manage queue length.
- Algorithms:
	- ==Random Early Detection (RED)==: probabilistic early dropping.
	- ==CoDel==: controlled delay management.
	- ==PIE==: proportional integral controller enhanced.
- Reduces bufferbloat without requiring ECN.
## Bufferbloat Problem
- Excessive buffering in network devices.
- Causes ==high latency== despite low packet loss.
- Modern algorithms (BBR, AQM) address this issue.
## Congestion Control in QUIC
- QUIC protocol uses pluggable congestion control.
- Default: similar to TCP Cubic.
- Supports BBR and other algorithms.
- Faster deployment due to user-space implementation.
***
# References
1. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.6: Principles of Congestion Control.
		2. Section 3.7: TCP Congestion Control.
2. TCP Congestion Control - RFC 5681.
	1. https://www.rfc-editor.org/rfc/rfc5681
3. Van Jacobson. Congestion Avoidance and Control. SIGCOMM 1988.
	1. https://dl.acm.org/doi/10.1145/52324.52356
4. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
5. Sally Floyd, Van Jacobson. Random Early Detection Gateways for Congestion Avoidance. IEEE/ACM Transactions on Networking, 1993.
6. Kathleen Nichols, Van Jacobson. Controlling Queue Delay. ACM Queue, 2012.
	1. CoDel algorithm paper.
