#hardware #network-layer #data-plane #computer-network 

- Connects input port to output port.
# Switching via shared memory
- ![](Pasted%20image%2020240519113855.png)
- Works like a computer.
	- Router process as CPU.
	- Port as I/O devices.
- Advantages:
	- Buffer management is simple.
- Disadvantage:
	- Sufficient memory.
	- Slow because of I/O operations.
# Switching via shared bus
- ![](Pasted%20image%2020240519115552.png)
- without router processor.
- All port receives, but only matching ports keep packet.
- Advantages:
	- Simple and cheap.
- Disvantage:
	- Bandwidth limited by bus space.
	- Bus contention.
# Switching via interconnection network (cross bar)
- ![](Pasted%20image%2020240519120055.png)
- $N$ buses for $N$ input ports, $N$ buses for $N$ output ports $\Rightarrow$ designed to ==intersect== each other.
- Exploits ==parallelism==.
- Advantage:
	- Fast due to parallelism.
	- Resolve HOL problems.
- Disadvantage:
	- Scalability due to cross points grow quadratically.
	- Complex.

---
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
	1. Chapter 4: Network Layer - The Data Plane.
2. 