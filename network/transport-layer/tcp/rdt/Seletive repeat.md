#protocol #computer-network #reliable-data-transfer #transport-layer 

# Scenario
- Sequence number starts from $0$
- Window size: $N$.
- Oldest unacknowledged packet: $base$
- Smallest unused sequence number: $nextseqnum$
- ![](Pasted%20image%2020240517120231.png)
- Receiver's base $rcv\_base$ may be distinct from $base$
- ==Distinct timers== for each packet.
- ![](Pasted%20image%2020240517133936.png)
# Mechanism
- Like [Go Back N](Go%20Back%20N.md), sender continue sending packets if window is not full.
- If timeout occurs, sender ==resends only that suspiciously lost packet==.
- If sender receives an ACK, it simply moves window forward.
- Receiver reacknowledges received packets and buffers out-of-order packets.
- ![](Pasted%20image%2020240517135250.png)
# Selective Repeat Dilemma
## Problem
- Distinguish new packet with retransmitted packet having the same sequence number? 
## Solution
- $$window-size \leq \frac{maximum-sequence-number}{2}$$
- But in practice, a really large sequence number is applied to avoid this dilemma
