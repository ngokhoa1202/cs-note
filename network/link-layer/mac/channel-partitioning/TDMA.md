#channel-partitioning #mac #link-layer #computer-network 

- Stands for ==Time Division Multiple Access==.

# Principle
- Divides time into ==time frames==.
- Divides each time frame into $N$ ==time slots==.
- Each station has certain fixed slots.
- ![](Pasted%20image%2020240520140640.png)
# Advantage
- Fair, each node is allocated throughput $\frac{R}{N} \space bps$ 
- Decentralized.
- Simple.
# Disadvantage
- Allocation is unchanged $\Rightarrow$ ==each node's throughput is unchanged==, even if there is only one node wanting to send while there are ==many idle slots==.