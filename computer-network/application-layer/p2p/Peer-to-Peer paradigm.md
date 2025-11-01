#application-layer #computer-network #p2p 
# Peer
- One ==intermediary server== for ==peer lookup==.
- Each peer plays as a server and a client:
	- One ==server port (process)== for listening and response to request from other peers.
	- One ==client port (process)== to make request to other.
- Peers ==share== uploading a heavy file.
# File distribution time
- Server only sends ==one file copy size== $F$ with uploading rate $u_s$ $$T_{server}=\frac{F}{u_s}$$
- One client with low bandwidth downloads file copy with downloading rate $d_{min}$ $$T_{client}=\frac{F}{d_{min}}$$ 
  
- When many peers ==aggregate== uploading file $F$, uploading rate is: $$u_s+u_1+u_2+...+u_N$$ Also $N$ peers mean $NF$ size for average.
- Then, ==uploading time when there are many peers: ==$$T_{peer}=\frac{NF}{u_s + \sum {u_i}}$$
-  Distribution time grows but has upper bound $$T \geq max\{T_{server}, T_{client}, T_{peer}\}=\frac{NF}{u_s+\sum {u_i}} \to C$$ 
	 when $N \to \infty$ . 
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.