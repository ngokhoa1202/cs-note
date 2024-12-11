#application-layer #computer-network #dash #streaming 

- Stands for ==Dynamic, Adaptive Streaming over HTTP==.

# Server
- ==Distributed server== stores replicate files.
- Files divided into ==chunks==. Each chunk is encoded at ==different bit rate==. 
- One file has many bit rate.
- Stores ==manifest file== containing url for chunks of different bit rate.
# Client
- Select ==closest server==.
- Periodically ==checks bandwidth==.
- ==Request one chunk== at a time.
- Based on manifest file, ==choose suitable bit rate== for chunks.
![](Pasted%20image%2020240513113706.png)

---
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.