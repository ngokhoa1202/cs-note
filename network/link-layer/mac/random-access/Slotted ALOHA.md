#random-access #computer-network #link-layer #mac 

# Principle
- All frames have same size $L$
- Divides time into slots of size $\frac{L}{R} \space sec$ 
- Only transmit at the beginning of slot.
- Synchronized nodes $\Rightarrow$ all nodes detect a collision.
- At each node:
	- A node has to wait until the next slot to send a frame.
	- No collision, no retransmission.
	- When collision occurs, the node detects before the end of its slot. It ==retrasmits its frame in subsequent slots with probability $p$ until there is no collision==. $\Rightarrow$ choose $p$ problems.
# Advantage
- Decentralized.
- Simple.
- Effectively exploit throughput ==in short run==.
# Disadvantage
- Wasting slots for retransmission.
- Idle slots
- Clock synchronization.
- ==Poor throughput for long run== $\approx 0.37$ 

