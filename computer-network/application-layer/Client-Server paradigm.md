#client-server #computer-network #application-layer 
# Server
- Static IP address.
- Always online.
- Employs one port to listen and response to client's request.
# Client
- Employs one port to make request to server.
- Maybe online or offline.
- IP address may be dynamic or static.
- Does not communicate directly with each other.
# File distribution time
- Server must sequentially transmit $N$ file copies, each copy has size $F$ uploading rate $u_s$ 
- Time server uploads $$T_s=N \times \frac{F}{u_s}$$
- Client downloads with downloading rate $d_{min}$  $$T_c=\frac{F}{d_{min}}$$
- Time to distribute file $F$ ==grows linearly==: $$T\geq max\{T_c, T_s\} = \frac{NF}{u_s}$$ when $N \to \infty$ 
- Compares to [File distribution time](Peer-to-Peer%20paradigm.md#File%20distribution%20time) 
***
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
