#computer-network #transport-layer #reliable-data-transfer #pipeline 

# Scenario
- Sequence number starts from $0$
- Window size: $N$.
- Oldest unacknowledged packet: $base$
- Smallest unused sequence number: $nextseqnum$
- ![](Pasted%20image%2020240517120231.png)
- $[0, base-1]$ : acknowledged packets.
- $[base,nextseqnum-1]$ : sent but unacknowledged packets.
- $[nextseqnum, base+N-1]$ : used but unsent packets.
- ==Window range== $[base, base+N-1]$ 
- In reality, $N=32$ 
# Mechanism
- If window is not full, sender continues sending $\Rightarrow$ sends maximum $N$ packets.
- If sender receives an ACK, it employs ==cumulative acknowledgement== and ==slides window forward.==
- If timeout occurs, sender ==resent all sent but unacknowledged packets==, maximum $N$ packets.
- If receiver receives out-of-order packets:
	- ==Discard==s that packet.
	- Resends ==most recently acknowledged packets==.
- ![](Pasted%20image%2020240517121739.png)
