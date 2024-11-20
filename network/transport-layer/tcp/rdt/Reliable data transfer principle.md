#transport-layer #tcp #client-server #computer-network #reliable-data-transfer

- Used in [TCP](TCP.md)
- Provides transport layer with reliable data transfer, in the case that ==network layer channel is not reliable==. ![](Pasted%20image%2020240515082419.png)
- Employ FSM (==Finite State Machine==).

# Rdt 1.0
- Simple, perfect FSM.
- 1 state for sender, 1 state for receiver.
- ![](Pasted%20image%2020240515082653.png)
# Rdt 2.0
- Resolve bit errors by ==ACK== and ==NAK==.
- ==stop-and-wait== mechanism.
- Sender's side has 2 states ![](Pasted%20image%2020240515083054.png)
- Receiver's side has 1 state
- ![](Pasted%20image%2020240515083303.png)
# Rdt 2.1
- Resolve ==ACK or NAK corruption==.
- Resolve ==duplicate packet==s => use ==sequence number==.
- Sender's side
- ![](Pasted%20image%2020240515083807.png)
- Receiver's side
- ![](Pasted%20image%2020240515114040.png)
# Rdt 2.2
- ==NAK-free== protocol => only ACK and sequence number.
- Sender's side ![](Pasted%20image%2020240515114459.png)
- Receiver's side
- ![](Pasted%20image%2020240515114539.png)
# Rdt 3.0
## Stop-and-wait protocol
- ==Timeout== event => ==timer==.
- Still ==stop-and-wait== protocol $\iff$ ==Head-of-Line blocking==, needs optimizing again.
	- Sender's utilization $U_{sender}$ , we have: $$U_{sender}=\frac{\frac{L}{R}}{RTT+\frac{L}{R}}$$
	- $RTT$ is much larger than $\frac{L}{R}$ $\Rightarrow$ $U_{sender}$ is small.
 
- Sender's side ![](Pasted%20image%2020240515114835.png)
- Receiver's side:
	
### Scenario
#### Packet loss
![](Pasted%20image%2020240515115309.png)
- If $pkt_1$ is lost => sender ==resends $pkt_1$ after timeout event==. Receiver normally sends $ACK_1$ 
#### ACK Loss
![](Pasted%20image%2020240515115805.png)
- If $ACK_1$ is lost:
	- Sender ==resends $pkt_1$ after timeout event==.
	- If receiver successfully receives $pkt_1$ , it ==detects duplicate== $ACK_1$ and ==resends $ACK_1$== to sender.

#### Premature timeout
![](Pasted%20image%2020240515120208.png)
- If timeout occurs before $ACK_1$ is received:
	- When timeout occurs, ==sender resends== $pkt_1$ 
	- If receiver successfully receives $pkt_1$ , it ==detects duplicate== $pkt_1$ and ==resends== $ACK_1$ .
	- At the same time, sender may receive expired $ACK_1$. Sender ==continues sending== $pkt_0$ as normal.
	- Sender can also receive resent $ACK_1$ from receiver. It detects duplicate $ACK_1$ and does nothing.
	- ...
## Pipelined protocol
- Allows sender to send ==multiple packets== at the same time $\Rightarrow$ ==much higher utilization==.
- Resolve HOL blocking.
-  ![](Pasted%20image%2020240517115029.png)
### Go Back N
[Go Back N](Go%20Back%20N.md)
### Selective repeat
