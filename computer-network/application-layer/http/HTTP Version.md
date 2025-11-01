#http #application-layer #computer-network #web #protocol 

# HTTP 1.1
- The client sends multiple, <mark class="hltr-yellow">pipelined</mark> HTTP GET messages on a TCP connection.
- The traffic suffers Head-Of-Line blocking where one large object blocks transmission of other subsequent objects due to first-come-first-serve scheduling.
- ![](Pasted%20image%2020240512120421.png)
# HTTP 2
- HTTP/2 message is divided one objects into many frames to transmit as stream, then collects at server, which is also known as <mark class="hltr-yellow">multiplexed</mark>.
- ![](Pasted%20image%2020240512120444.png)
- The client can prioritize request.
- The server may have many responses for one request.
- The mechanism partially resolves head-of-line blocking.
# HTTP 3
- Relies on [Quick UDP Internet Connection (QUIC)](Quick%20UDP%20Internet%20Connection%20(QUIC).md).
- Faster than [HTTP 2](#HTTP%202) because UDP resolves TCP Head Of Line Blocking.
- Incorporates security.
- Fewer handshakes.
***
# Reference
1. https://cabulous.medium.com/http-3-quic-and-how-it-works-c5ffdb6735b4 for http 3.
2. https://gcore.com/learning/what-is-http-3/ for comparison.
3. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
	1. Chapter 2. Application layer.