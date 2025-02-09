#computer-network #network-layer #data-plane #traffic #router #data-plane 

# Buffer

- Buffer packets if $arrival-rate > forwarding-rate$ .
- Buffer size $B$ should be $$B=\frac{RTT \times C}{\sqrt{N}}$$ where $C$ is link capacity, $RTT$ is round-trip time, $N$: number of TCP Flows
# Bufferbloat
- Real-time apps continuously send requests, ==making buffer persistently full==.
- Long delay.
- ![](Pasted%20image%2020240519122134.png)