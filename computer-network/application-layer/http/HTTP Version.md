#http #application-layer #computer-network #web #protocol 

# HTTP 1.1
- ==Multiple, pipelined GETs== on a TCP connection.
- Suffer ==HOL== = Head-of-Line Blocking: ==one large object== blocks transmission of other objects (FCFS scheduling).
- ![](Pasted%20image%2020240512120421.png)
# HTTP 2
- Divided one objects into many ==frames== to transmit as stream, then collects at server.
- ![](Pasted%20image%2020240512120444.png)
- Can ==prioritize request==.
- May have ==many responses for one request==.
- Partially resolve HOL blocking.
# HTTP 3
- Relies on QUIC [QUIC overview](QUIC%20overview.md).
- Faster than [HTTP 2](#HTTP%202) because UDP resolves TCP HOL Blocking.
- Incorporates security.
- Fewer handshakes.

# Reference
1. https://cabulous.medium.com/http-3-quic-and-how-it-works-c5ffdb6735b4 for http 3.
2. https://gcore.com/learning/what-is-http-3/ for comparison.
3. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.