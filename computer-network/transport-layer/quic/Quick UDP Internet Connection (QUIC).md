#computer-network  #transport-layer #protocol #udp #ongoing #http

- Incorporated with ==HTTP/3.==
- Based on [UDP](UDP.md)
- Incorporate TLSv1.3.
# HTTP/2 Limitations
- TCP handshake requires a full network round trip to ensure that the client and server are ready to exchange data.
- HTTP/2 pipelining allows for multiple HTTP requests using the same _TCP_ connection, but because data is treated as a single-b
- HTTP/2 pipelining does not completely resolves the head-of-line blocking problem, but only partially.
- 
# Characteristics
- Connection-oriented.
- Secure.
- Stream.
- Reliable data transfer, congestion control like TCP.
- ![](Pasted%20image%2020240519105322.png)
***
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
	1. Chapter 3. Transport layer.
2. https://http.dev/3 for HTTP/3.
3. [[HTTP Version#HTTP 2]] for HTTP/2.