#tcp #computer-network #transport-layer #congestion-control #protocol #loss-based
# Overview
- TCP Cubic is ==most widely deployed== congestion control algorithm.
- Introduced in $2005$, became Linux default in kernel $2.6.19$ ($2008$).
- Optimized for ==high bandwidth-delay product (BDP)== networks.
- Uses ==cubic function== for window growth instead of linear increase.
- Part of [TCP Congestion Control](TCP%20Congestion%20Control.md).
- Successor to [TCP Reno](TCP%20Reno.md) and [TCP Tahoe](TCP%20Tahoe.md).
# Motivation
## Limitations of TCP Reno
### Linear Growth Problem
- Reno increases $cwnd$ by $1$ MSS per RTT in congestion avoidance.
- Too slow for high-speed networks.
- Example: $10$ Gbps link, $100$ ms RTT, $1500$ byte MSS:
	- Required $cwnd \approx 83,333$ packets.
	- Time to reach from $cwnd = 1$: $\approx 2.3$ hours.
### RTT Unfairness
- Reno's rate: $\frac{cwnd}{RTT}$.
- Flows with shorter RTT dominate bandwidth.
- AIMD not RTT-fair.
## High BDP Networks
- Modern networks have high bandwidth-delay product.
- $BDP = Bandwidth \times RTT$.
- Example: $1$ Gbps link, $100$ ms RTT:
	- $BDP = 12.5$ MB.
	- Reno too conservative for efficient utilization.
# Key Innovation
## Cubic Growth Function
- Replaces linear growth with ==cubic function==.
- Window growth depends on ==elapsed time since last loss==, not RTT.
- Creates characteristic S-shaped growth curve.
- Three regions:
	1. ==Concave region==: rapid increase when far from $W_{max}$.
	2. ==Inflection point==: cautious approach near $W_{max}$.
	3. ==Convex region==: aggressive probing beyond $W_{max}$.
## RTT Independence
- Growth rate primarily depends on time, not RTT.
- Improves fairness between flows with different RTTs.
- Better than Reno's RTT-dependent behavior.
# Algorithm Design
## Core Variables
- $W_{max}$: ==maximum window size== before last congestion event.
- $W_{cubic}$: current window size calculated by cubic function.
- $K$: ==time to reach $W_{max}$== again if no further loss.
- $C$: ==cubic parameter== (scaling factor), typically $C = 0.4$.
- $\beta$: multiplicative decrease factor, typically $\beta = 0.7$ (Cubic) vs $0.5$ (Reno).
- $t$: elapsed time since last window reduction.
## Cubic Function
$$W_{cubic}(t) = C \times (t - K)^3 + W_{max}$$
- $t$: time elapsed since last congestion event.
- $K = \sqrt[3]{\frac{W_{max} \times \beta}{C}}$: time to reach $W_{max}$.
- When $t = K$: $W_{cubic}(K) = W_{max}$.
## Calculation of K
$$K = \sqrt[3]{\frac{W_{max} \times (1 - \beta)}{C}}$$
- With $\beta = 0.7$, $C = 0.4$:
$$K = \sqrt[3]{\frac{W_{max} \times 0.3}{0.4}} = \sqrt[3]{0.75 \times W_{max}}$$
# Window Growth Phases
## Phase 1: Concave Region ($t < K$)
### Characteristics
- Occurs when $cwnd < W_{max}$.
- Cubic function has negative second derivative.
- ==Rapid increase== when far from $W_{max}$.
- Gradually slowing as approaching $W_{max}$.
### Behavior
- Fast recovery toward previous operating point.
- Assumes network conditions haven't changed significantly.
- More aggressive than Reno initially.
### Formula
- For $t < K$:
$$W_{cubic}(t) = W_{max} - C \times (K - t)^3$$
- Negative term indicates below $W_{max}$.
- Decreasing magnitude of negative term → approaching $W_{max}$.
## Phase 2: Inflection Point ($t = K$)
### Characteristics
- Occurs at $t = K$: $W_{cubic}(K) = W_{max}$.
- ==Minimum growth rate== of cubic function.
- Most cautious region.
### Behavior
- Carefully probes around previous maximum.
- Uncertain if network capacity changed.
- Similar to Reno's behavior at this point.
## Phase 3: Convex Region ($t > K$)
### Characteristics
- Occurs when $cwnd > W_{max}$.
- Cubic function has positive second derivative.
- ==Accelerating increase==.
- Explores new capacity.
### Behavior
- Aggressive probing for increased bandwidth.
- Assumes network capacity may have increased.
- Faster than Reno in this region.
### Formula
- For $t > K$:
$$W_{cubic}(t) = W_{max} + C \times (t - K)^3$$
- Positive term indicates above $W_{max}$.
- Accelerating growth rate.
# Cubic vs Reno Comparison
## TCP-Friendly Region
- Cubic includes ==TCP-friendly mode== for fairness with Reno flows.
- When Cubic would grow slower than Reno, switch to Reno-like behavior.
- Ensures Cubic doesn't unfairly lose bandwidth to Reno.
## Reno-Equivalent Window
$$W_{Reno}(t) = W_{max} \times \beta + \frac{3 \times (1 - \beta)}{1 + \beta} \times \frac{t}{RTT}$$
- Linear growth similar to Reno.
- Used when $W_{Reno}(t) > W_{cubic}(t)$.
## Hybrid Growth
$$W(t) = max(W_{cubic}(t), W_{Reno}(t))$$
- Take maximum of cubic and Reno calculations.
- Ensures competitiveness with Reno flows.
- Maintains Cubic advantages in high-BDP networks.
# Congestion Window Update
## On ACK Received (No Loss)
### Calculate Target Window
1. Compute time since last congestion event: $t = now - t_{last\_loss}$.
2. Calculate cubic window:
$$W_{cubic} = C \times (t - K)^3 + W_{max}$$
3. Calculate Reno-equivalent window:
$$W_{Reno} = W_{max} \times \beta + \frac{3 \times (1 - \beta)}{1 + \beta} \times \frac{t}{RTT}$$
4. Choose target:
$$W_{target} = max(W_{cubic}, W_{Reno})$$
### Update Congestion Window
- Per-ACK update:
$$cwnd = cwnd + \frac{W_{target} - cwnd}{cwnd}$$
- Smooth convergence to target window.
## On Packet Loss (3 DupACKs)
### Fast Recovery Entry
1. Record current window:
$$W_{max} = cwnd$$
2. Reduce window:
$$cwnd = cwnd \times \beta$$
- Typically $\beta = 0.7$ (less aggressive than Reno's $0.5$).
3. Set slow-start threshold:
$$ssthresh = cwnd$$
4. Reset time:
$$t = 0$$
5. Recompute $K$:
$$K = \sqrt[3]{\frac{W_{max} \times (1 - \beta)}{C}}$$
### Fast Recovery Phase
- Similar to [TCP Reno](TCP%20Reno.md) fast recovery.
- Inflate window for each duplicate ACK.
- Retransmit lost packet.
- Exit on new ACK, return to cubic growth.
## On Timeout
### Severe Congestion Response
1. Do ==not update $W_{max}$==:
	- Timeout may indicate transient issue.
	- Preserve previous $W_{max}$ for faster recovery.
2. Reduce window drastically:
$$cwnd = 1 \text{ MSS}$$
3. Enter slow start.
4. Exit slow start at $ssthresh = W_{max} \times \beta$.
# Visualization
- ![](Pasted%20image%2020240517163845.png)
## Growth Curve
- S-shaped cubic curve.
- Steep increase far from $W_{max}$.
- Plateau near $W_{max}$.
- Accelerating increase beyond $W_{max}$.
## Comparison with Reno
- Cubic initially faster than Reno.
- Cubic slower near $W_{max}$ (more cautious).
- Cubic faster beyond $W_{max}$ (more aggressive).
# Algorithm Pseudocode
```Text
# Initialization
cwnd = 1 MSS
ssthresh = 64 KB
W_max = 0
t = 0
C = 0.4
beta = 0.7

# On ACK Received (Congestion Avoidance)
t = current_time - last_reduction_time
K = cube_root((W_max * (1 - beta)) / C)

# Cubic window
W_cubic = C * (t - K)^3 + W_max

# Reno-equivalent window
W_reno = W_max * beta + (3 * (1 - beta) / (1 + beta)) * (t / RTT)

# Target window
W_target = max(W_cubic, W_reno)

# Update cwnd
cwnd = cwnd + (W_target - cwnd) / cwnd

# On 3 Duplicate ACKs
W_max = cwnd
cwnd = cwnd * beta
ssthresh = cwnd
t = 0
retransmit lost packet
enter fast recovery

# On Timeout
# Do not update W_max
cwnd = 1 MSS
ssthresh = W_max * beta
enter slow start

# On New ACK (Fast Recovery Exit)
cwnd = ssthresh
exit fast recovery
continue cubic growth
```
# Performance Characteristics
## Advantages
### Scalability
- Efficient in high bandwidth-delay product networks.
- Fast recovery to previous operating point.
- Suitable for long-distance, high-speed links.
### RTT Fairness
- Growth primarily time-based, not RTT-based.
- Better fairness between flows with different RTTs.
- Reduces geographic bias.
### TCP-Friendly
- Competes fairly with Reno flows.
- Hybrid mode ensures compatibility.
- Smooth coexistence in mixed environments.
### Stability
- Cubic function provides smooth, predictable growth.
- Less aggressive decrease ($\beta = 0.7$ vs Reno's $0.5$).
- Faster recovery after transient congestion.
### Simple Implementation
- Relatively simple cubic calculation.
- No per-packet timestamps required.
- Efficient computation.
## Disadvantages
### Bufferbloat
- Aggressive growth can fill network buffers.
- Increases latency in buffered networks.
- May cause queuing delays.
- Addressed by Active Queue Management (AQM) or [TCP BBR](TCP%20BBR.md).
### Loss-Based Limitation
- Still relies on packet loss for congestion detection.
- Reactive rather than proactive.
- Cannot distinguish congestion loss from random loss.
### Wireless Performance
- Packet loss due to channel errors misinterpreted as congestion.
- Unnecessary rate reduction.
- Requires cross-layer optimization or link-layer retransmission.
### Complexity vs Reno
- More complex than Reno.
- Requires additional state ($W_{max}$, $K$, $t$).
- Cubic function computation overhead.
# Performance Metrics
## Throughput Model
- Average throughput approximation:
$$Throughput \approx \frac{C \times (1 - \beta)^{3/4}}{\sqrt[4]{RTT^3 \times p}}$$
- $p$: packet loss rate.
- $C$: cubic parameter.
- $\beta$: multiplicative decrease factor.
- Less sensitive to RTT than Reno.
## Convergence Time
- Time to reach $W_{max}$ from $\beta \times W_{max}$:
$$T_{convergence} = K = \sqrt[3]{\frac{W_{max} \times (1 - \beta)}{C}}$$
- Example: $W_{max} = 1000$ packets, $C = 0.4$, $\beta = 0.7$:
$$K = \sqrt[3]{\frac{1000 \times 0.3}{0.4}} = \sqrt[3]{750} \approx 9.1 \text{ seconds}$$
## Comparison with Reno
- Cubic achieves $10-40\%$ higher throughput than Reno in high-BDP networks.
- Similar performance in low-BDP networks.
- Better fairness across different RTTs.
# Real-World Deployment
## Operating Systems
- ==Linux==: default since kernel $2.6.19$ ($2008$).
- ==Android==: default (based on Linux kernel).
- ==FreeBSD==: available as option.
- ==Windows==: Windows 10 and Server 2016+ use Cubic-based algorithm.
## Internet Dominance
- Majority of Internet traffic uses Cubic.
- Deployed on major content providers (Google, Facebook, etc.).
- Standard for data center traffic.
## Data Center Networking
- Optimized for intra-datacenter communication.
- High bandwidth, low latency environment.
- May be supplemented by data-center-specific variants (DCTCP).
# Parameter Tuning
## Cubic Parameter (C)
- Default: $C = 0.4$.
- Higher $C$: more aggressive growth.
- Lower $C$: more conservative growth.
- Typical range: $[0.3, 0.5]$.
## Multiplicative Decrease Factor (β)
- Default: $\beta = 0.7$.
- Higher $\beta$: less aggressive decrease (faster recovery).
- Lower $\beta$: more aggressive decrease (more conservative).
- Reno uses $\beta = 0.5$ for comparison.
## Initial Congestion Window
- Modern default: $cwnd = 10$ MSS (RFC 6928).
- Improves performance for short flows.
- Trade-off with potential congestion.
# Extensions and Variants
## HyStart (Hybrid Slow Start)
- Enhancement to Cubic's slow start phase.
- Exits slow start earlier to prevent overshoot.
- Two detection mechanisms:
	- ==ACK train==: measures RTT increase.
	- ==Delay increase==: detects queuing.
- Reduces packet loss during slow start.
## CUBIC+
- Research extension with improved fairness.
- Enhanced RTT-independence.
- Better coexistence with Reno.
## Data Center TCP (DCTCP)
- ECN-based variant for data centers.
- Uses explicit congestion notification.
- More precise congestion response.
- Lower latency, higher throughput in DC environment.
***
# References
1. Sangtae Ha, Injong Rhee, Lisong Xu. CUBIC: A New TCP-Friendly High-Speed TCP Variant. ACM SIGOPS Operating Systems Review, 2008.
	1. https://dl.acm.org/doi/10.1145/1400097.1400105
	2. Original CUBIC paper.
2. RFC 8312 - CUBIC for Fast Long-Distance Networks.
	1. https://www.rfc-editor.org/rfc/rfc8312
	2. Official CUBIC specification.
3. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.7: TCP Congestion Control.
4. Linux Kernel Documentation - TCP Congestion Control.
	1. https://www.kernel.org/doc/Documentation/networking/tcp.txt
5. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
6. Injong Rhee, Lisong Xu. CUBIC TCP.
	1. https://www.cs.princeton.edu/courses/archive/fall16/cos561/papers/Cubic08.pdf
