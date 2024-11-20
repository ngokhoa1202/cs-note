#random-access #link-layer #computer-network 

- Stands for ==Carrier Sense Multiple Access==.

# Principle
- If channel is about to be idle $\Rightarrow$ send frame.
- If channel is about to be busy $\Rightarrow$ stop transmission.
- Suffers propagation delay.
- ![](Pasted%20image%2020240520145309.png)
# CSMA/CD
- CSMA with ==collision detection==, reduces time wasted in collisons.
- ![](Pasted%20image%2020240520145448.png)
# Ethernet CSMA/CD
- After detecting collisions, enters ==binary exponential backoff==:
	- After $m$th collision, chooses random $K \in \{0,1,2,...,2^m-1\}$ . Waits for $K \times 512$ bit times. Starts retransmitting.
- ![](Pasted%20image%2020240523090657.png)
# Advantage
- Simple.
- Fair.
- Decentralized.
- Good throughput for low traffic.
# Disadvantage
- Poor throughput for high traffic.