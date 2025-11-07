#http #application-layer #computer-network #web #protocol 

# HTTP 1.0
- The HTTP connection is <mark class="hltr-yellow">non-persistent</mark>.
- HTTP transmission is prohibitively costly.
- ![[Pasted image 20251103114501.png]] 
# HTTP 1.1
- The client sends multiple, <mark class="hltr-yellow">pipelined</mark> HTTP GET messages on a <mark class="hltr-yellow">persistent</mark> TCP connection.
- The traffic suffers Head-Of-Line blocking where one large object blocks transmission of other subsequent objects due to first-come-first-serve scheduling.
- ![](Pasted%20image%2020240512120421.png)
# HTTP 2
- HTTP/2 message is *divided one object into many frames* to transmit as a <mark class="hltr-yellow">stream</mark> on a single TCP connection, then collects that stream data into the original object at server. This mechanism is also known as <mark class="hltr-yellow">multiplexed</mark>.
- ![](Pasted%20image%2020240512120444.png)
- The client can prioritize request.
- The server may have many responses for one request.
- The mechanism <mark class="hltr-yellow">partially</mark> resolves head-of-line blocking, but not completely tackle the problem.
# HTTP 3
- Relies on [Quick UDP Internet Connection (QUIC)](Quick%20UDP%20Internet%20Connection%20(QUIC).md).
- Faster than [HTTP 2](#HTTP%202) because UDP completely resolves TCP Head Of Line Blocking.
- Incorporates security.
- Fewer handshakes.
***
# Reference
1. https://cabulous.medium.com/http-3-quic-and-how-it-works-c5ffdb6735b4 for http 3.
2. https://gcore.com/learning/what-is-http-3/ for comparison.
3. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
	1. Chapter 2. Application layer.
4. [[HTTP#Persistent HTTP vs Non-persistent HTTP]] for Persistent HTTP and Non-persistent HTTP.
5. Computer Networks - Tanenbaum Andrew S., Wetherall David J. Wetherhall - Prentice Hall Publisher (2011).
	1. Chapter 7. The application layer.
		1. Section 7.3. The World Wide Web.
			1. Section 7.3.4. HTTP - The HyperText Transfer Protocol.
6. https://httpwg.org/specs/rfc7540.html: RFC 7540 Hypertext Transfer Protocol Version 2 (HTTP/2)