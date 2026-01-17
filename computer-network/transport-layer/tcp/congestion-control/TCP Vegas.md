#tcp #computer-network #transport-layer #congestion-control #protocol #delay-based
# Overview
- TCP Vegas is the ==first major delay-based congestion control algorithm==.
- Introduced by Lawrence Brakmo and Larry Peterson at University of Arizona in $1994$.
- Uses ==RTT measurements== to detect congestion before packet loss.
- Proactive approach: prevents congestion rather than reacting to it.
- Part of [TCP Congestion Control](TCP%20Congestion%20Control.md).
- Pioneered concepts used in modern algorithms like [TCP BBR](TCP%20BBR.md).
# Motivation
## Problems with Loss-Based Algorithms
### Reactive Nature
- [TCP Reno](TCP%20Reno.md) and [TCP Cubic](TCP%20Cubic.md) detect congestion ==after packet loss==.
- Network already congested when detection occurs.
- Packet loss wastes bandwidth and increases delay.
### Queuing Delays
- Loss-based algorithms fill router buffers before backing off.
- High queuing delays degrade user experience.
- ==Bufferbloat== problem exacerbated.
### Efficiency Loss
- Packet retransmissions consume bandwidth without delivering new data.
- Timeout penalties severely impact throughput.
- Suboptimal network utilization.
## Vegas Philosophy
- "Keep the ==pipe full, but no fuller==".
- Detect congestion through ==RTT increase== (queue buildup).
- Adjust sending rate ==before packet loss== occurs.
- Maintain low latency while maximizing throughput.
# Core Concept
## Expected Throughput
- Calculate expected throughput assuming no congestion:
$$Throughput_{expected} = \frac{cwnd}{RTT_{min}}$$
- $cwnd$: current congestion window (bytes).
- $RTT_{min}$: minimum observed RTT (baseline propagation delay).
## Actual Throughput
- Measure actual throughput over time window:
$$Throughput_{actual} = \frac{cwnd}{RTT_{current}}$$
- $RTT_{current}$: current measured RTT.
- Includes queuing delay if network congested.
## Extra Data in Network
- Compute difference to estimate queue buildup:
$$Extra = (Throughput_{expected} - Throughput_{actual}) \times RTT_{min}$$
- Equivalently:
$$Extra = cwnd \times \left(1 - \frac{RTT_{min}}{RTT_{current}}\right)$$
- ==Extra packets in network queues== beyond baseline.
# Algorithm Design
## Parameters
- $\alpha$: ==lower threshold==, typically $\alpha = 1$ packet.
- $\beta$: ==upper threshold==, typically $\beta = 3$ packets.
- $\gamma$: ==slow-start threshold==, typically $\gamma = 1$ packet.
- $RTT_{min}$: minimum observed RTT (updated throughout connection).
## Window Adjustment Rules
### If Extra < α (Network Underutilized)
- Network has capacity for more traffic.
- ==Linearly increase== congestion window:
$$cwnd = cwnd + 1 \text{ MSS per RTT}$$
- Similar to Reno's congestion avoidance.
### If Extra > β (Network Congested)
- Network queues building up.
- ==Linearly decrease== congestion window:
$$cwnd = cwnd - 1 \text{ MSS per RTT}$$
- Proactive rate reduction before packet loss.
### If α ≤ Extra ≤ β (Optimal Region)
- Network operating at ==optimal point==.
- Maintain current congestion window:
$$cwnd = cwnd$$
- Goldilocks zone: not too much, not too little buffering.
# Detailed Phases
## Slow Start Phase
### Modified Slow Start
- Vegas uses ==modified slow start== different from Reno.
- Performs comparison every other RTT.
- Checks if actual rate significantly below expected rate.
### Mechanism
1. Measure $RTT_{current}$ at end of every other RTT.
2. Calculate expected and actual throughput.
3. Compute difference:
$$Diff = (Throughput_{expected} - Throughput_{actual}) \times RTT_{min}$$
4. If $Diff > \gamma$:
	- Set $ssthresh = cwnd$.
	- Exit slow start, enter congestion avoidance.
5. Otherwise:
	- Continue exponential growth.
### Rationale
- Exits slow start earlier than Reno.
- Prevents excessive queue buildup.
- Smoother transition to congestion avoidance.
## Congestion Avoidance Phase
### RTT Measurement
- Measure RTT once per RTT interval.
- Use fine-grained timestamps.
- Update $RTT_{min}$ if new minimum observed.
### Window Adjustment
1. Calculate $Extra$ data in network.
2. Compare with thresholds $\alpha$ and $\beta$.
3. Adjust $cwnd$ accordingly:
	- $Extra < \alpha$: $cwnd++$ (per RTT).
	- $Extra > \beta$: $cwnd--$ (per RTT).
	- $\alpha \leq Extra \leq \beta$: maintain $cwnd$.
### Per-ACK Update
- Convert per-RTT adjustment to per-ACK:
$$\Delta cwnd_{per\_ACK} = \frac{\Delta cwnd_{per\_RTT}}{cwnd}$$
- Example: to increase by $1$ MSS per RTT:
$$cwnd = cwnd + \frac{MSS}{cwnd}$$
## Packet Loss Handling
### Loss Detection
- Vegas still detects loss via timeout or duplicate ACKs.
- Loss indicates severe congestion or measurement error.
### Response
- On ==3 duplicate ACKs==:
$$cwnd = \frac{cwnd}{2}$$
- On ==timeout==:
$$cwnd = 1 \text{ MSS}$$
- Similar to Reno's response.
- Return to slow start.
# Algorithm Pseudocode
```Text
# Initialization
cwnd = 1 MSS
ssthresh = 64 KB
RTT_min = infinity
alpha = 1
beta = 3
gamma = 1

# Update RTT_min
on RTT measurement:
    if RTT < RTT_min:
        RTT_min = RTT

# Slow Start
while (cwnd < ssthresh):
    on ACK:
        cwnd = cwnd + MSS

    every other RTT:
        Throughput_expected = cwnd / RTT_min
        Throughput_actual = cwnd / RTT_current
        Diff = (Throughput_expected - Throughput_actual) * RTT_min

        if Diff > gamma:
            ssthresh = cwnd
            transition to Congestion Avoidance

# Congestion Avoidance
while (cwnd >= ssthresh):
    every RTT:
        Throughput_expected = cwnd / RTT_min
        Throughput_actual = cwnd / RTT_current
        Extra = (Throughput_expected - Throughput_actual) * RTT_min

        if Extra < alpha:
            cwnd = cwnd + 1 MSS
        else if Extra > beta:
            cwnd = cwnd - 1 MSS
        else:
            # Maintain cwnd
            cwnd = cwnd

# Loss Handling
on 3 DupACKs:
    cwnd = cwnd / 2
    ssthresh = cwnd

on Timeout:
    ssthresh = cwnd / 2
    cwnd = 1 MSS
```
# Performance Characteristics
## Advantages
### Proactive Congestion Avoidance
- Detects congestion ==before packet loss==.
- Maintains lower queuing delays.
- Better latency for interactive applications.
### Lower Packet Loss
- Packet loss rate $10-50\%$ lower than Reno.
- Reduced retransmissions save bandwidth.
- More efficient network utilization.
### Stability
- Operates at stable equilibrium point.
- Less oscillation than loss-based algorithms.
- Smoother throughput over time.
### Better Utilization
- Can achieve $37-71\%$ better throughput than Reno in some scenarios.
- Particularly effective in low-loss networks.
- Efficient use of available bandwidth without excessive buffering.
## Disadvantages
### Fairness Issues with Loss-Based Flows
- ==Major limitation==: Vegas loses bandwidth competition with Reno.
- Vegas backs off on RTT increase while Reno continues growing.
- Reno fills buffers, forcing Vegas to reduce rate.
- Vegas ends up with significantly less bandwidth.
### Example: Vegas vs Reno
- Shared bottleneck link.
- Vegas detects queue buildup at $\alpha$ packets.
- Reno continues until packet loss.
- Result: Reno gets $\approx 70-80\%$ bandwidth, Vegas $\approx 20-30\%$.
### RTT Measurement Challenges
#### Minimum RTT Estimation
- $RTT_{min}$ may not reflect true propagation delay.
- Initial packets may experience queuing.
- Changing routes alter propagation delay.
- Requires careful $RTT_{min}$ tracking.
#### RTT Variability
- Wireless networks have variable transmission delays.
- Cross-traffic affects measurements.
- ACK compression distorts RTT samples.
- Measurement noise impacts accuracy.
### Reverse Path Congestion
- RTT includes both forward and reverse path delays.
- Reverse path congestion affects measurements.
- Cannot distinguish forward vs reverse path issues.
### Parameter Sensitivity
- Performance depends on $\alpha$ and $\beta$ values.
- Optimal values vary by network conditions.
- No universal optimal parameters.
- Requires tuning for specific environments.
## Deployment Challenges
### Limited Adoption
- Fairness issues prevent widespread deployment.
- Deployment in heterogeneous Internet problematic.
- Works well only when all flows use Vegas.
- Chicken-and-egg problem.
### Operating System Support
- Available in Linux as experimental module.
- Not default in any major OS.
- Limited testing and optimization.
- Primarily academic interest.
# Mathematical Analysis
## Equilibrium Point
- Vegas converges to equilibrium where:
$$\alpha \leq Extra \leq \beta$$
- Maintains $\alpha$ to $\beta$ packets in queue.
- Stable operating point.
## Throughput Model
- Average throughput at equilibrium:
$$Throughput \approx \frac{cwnd}{RTT_{min} + \frac{\alpha + \beta}{2} \times \frac{MSS}{Bandwidth}}$$
- Lower latency than loss-based algorithms.
- Predictable performance.
## Fairness Analysis
### Intra-Protocol Fairness
- Multiple Vegas flows converge to fair allocation.
- Jain's fairness index $> 0.99$.
- Better intra-protocol fairness than Reno.
### Inter-Protocol Fairness
- Poor fairness with loss-based algorithms.
- Vegas flows receive less than fair share.
- Fundamental incompatibility with loss-based approach.
# Variants and Extensions
## Vegas+
- Modified Vegas with improved fairness.
- Adjusts $\alpha$ and $\beta$ dynamically.
- Better coexistence with Reno flows.
## TCP Veno
- Hybrid of Vegas and Reno.
- Uses Vegas-like detection with Reno-like response.
- Improved performance over wireless links.
- Better fairness with Reno.
## FAST TCP
- Generalization of Vegas for high-speed networks.
- Scales $\alpha$ and $\beta$ with $RTT_{min}$.
- Better performance in high-BDP networks.
- Used in some research networks.
## TCP Compound
- Microsoft algorithm combining loss and delay signals.
- Dual congestion windows.
- Retains Vegas concepts with improved fairness.
# Comparison with Other Algorithms
| Feature | TCP Vegas | TCP Reno | TCP Cubic | TCP BBR |
|---------|-----------|----------|-----------|---------|
| Detection | RTT increase | Packet loss | Packet loss | Bandwidth & RTT |
| Approach | Proactive | Reactive | Reactive | Proactive |
| Queuing delay | Low | High | High | Low |
| Packet loss | Low | Moderate | Moderate | Low |
| Fairness with Reno | ==Poor== | N/A | Good | Varies |
| Deployment | Limited | Legacy | Widespread | Growing |
| Complexity | Moderate | Low | Moderate | High |
# Use Cases
## When Vegas Excels
- Homogeneous Vegas-only environments.
- Low-loss, latency-sensitive applications.
- Controlled networks (data centers, private networks).
- Research and educational settings.
## When Vegas Struggles
- Heterogeneous Internet with mixed algorithms.
- Competition with loss-based flows.
- Networks with high RTT variability.
- Wireless links with variable delays.
# Legacy and Influence
## Historical Impact
- Pioneered delay-based congestion control.
- Demonstrated viability of proactive approach.
- Influenced modern algorithms.
- Established importance of latency in congestion control.
## Influence on Modern Algorithms
### TCP BBR
- Google's [TCP BBR](TCP%20BBR.md) builds on Vegas concepts.
- Uses explicit bandwidth and RTT measurements.
- Addresses Vegas fairness issues.
- Achieves Vegas benefits with practical deployment.
### TIMELY
- Data center algorithm inspired by Vegas.
- Uses RTT gradient for congestion detection.
- Achieves microsecond-level latency.
### PCC (Performance-Oriented Congestion Control)
- Uses utility function optimization.
- Incorporates delay-based signals.
- Adaptive to network conditions.
## Educational Value
- Demonstrates alternative to loss-based approach.
- Clear illustration of proactive congestion control.
- Motivates discussion of fairness and incentives.
- Widely studied in networking courses.
***
# References
1. Lawrence S. Brakmo, Larry L. Peterson. TCP Vegas: End-to-End Congestion Avoidance on a Global Internet. IEEE Journal on Selected Areas in Communications, 1995.
	1. https://ieeexplore.ieee.org/document/464716
	2. Original TCP Vegas paper.
2. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross.
	1. Chapter 3: Transport Layer.
		1. Section 3.7.2: TCP Congestion Control.
3. Cheng Peng Fu, S. C. Liew. TCP Veno: TCP Enhancement for Transmission over Wireless Access Networks. IEEE Journal on Selected Areas in Communications, 2003.
	1. Vegas-based variant for wireless.
4. David X. Wei, Cheng Jin, Steven H. Low, Sanjay Hegde. FAST TCP: Motivation, Architecture, Algorithms, Performance. IEEE/ACM Transactions on Networking, 2006.
	1. Scalable Vegas variant.
5. HCMUT Computer Network Slides - Nguyễn Phương Duy.
	1. Chapter 3: Transport Layer.
6. Linux Kernel Documentation - TCP Vegas.
	1. https://www.kernel.org/doc/Documentation/networking/tcp-vegas.txt
