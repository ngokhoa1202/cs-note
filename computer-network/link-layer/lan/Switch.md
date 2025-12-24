#computer-network #link-layer #lan  #hardware 

- ==Transparent== to end user.
- ==Receives and forwards frames== on correct links.
- ==Self-learning==. 
# Principle
- All hosts must be connected to switch.
- Implemented Ethernet on each link $\Rightarrow$ collision ==occurs within a link==.
- Each switch has its ==switch table== to filter and forward frame to correct interface:
	- Each entry includes `(MAC-addr, Interface, TTL)`
	- Filter and forward.
## Filter and forward
- $A$ with $MAC_A$ on interface $a$ and $B$ with $MAC_B$ on interface $b$
	1.  ==Learning phase==:
		- A sends a frame to B, containing $MAC_A$ as source and $MAC_B$ as destination.
		- Switch records $MAC_A \to a$ on switch table.
		- $MAC_B$ is not found on switch table $\Rightarrow$ Switch ==floods== the frame to all interfaces except interface $a$ .
		- $B$ replies with frame containing $MAC_B$ on interface $b$. The mapping is ==stored== on switch table.
	2. ==Forwarding phase==:
		- A sends a frame to B.
		- The mapping $MAC_B \to b$ has been already stored switch table $\Rightarrow$ switch ==directly forwards== frame to interface $b$ and ==does not flood==.
	3. ==Filtering phase==:
		- If A sends a frame to another host which is on the ==same== interface $a$ as A, switch ==drops== the frame.