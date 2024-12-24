#application-layer #http #web #computer-network #protocol 

# Concept
- Known as ==HyperText Transfer Protocol==.
- Based on ==TCP== protocol and ==Client-Server== paradigm.
- ==Stateless== protocol. Server does not maintain past requests from client (without cookie or session techniques).
- ==Default port: 80==. If employ HTTPS, port 443.

# Persistent HTTP vs Non-persistent HTTP
## Non-persistent HTTP:
- At most ==one object sent per TCP connection== opened to server.
- $Response-time=2 \times RTT + file-transmission-time$ $\Rightarrow$ more ==overhead==.

## Persistent HTTP:
- ==Many objects per TCP connection== opened to server.
- Resolve HOL blocking.

# HTTP Format
[HTTP Format](HTTP%20Format.md)

# HTTP Methods
[HTTP Methods](HTTP%20Methods.md)

---
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.