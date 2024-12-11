#application-layer #computer-network #proxy-server #http #client-server 

- Known as ==proxy server==.
- Stays in the ==middle== of client and original server.
- ==Caches regularly accessed objects== to return to client without directly requesting to server.
- ![](Pasted%20image%2020240512112728.png)
- Purpose:
	- reduce ==**traffic to access link**== => reduce response time and cost. 
- Explicitly included in HTTP Header `Cache-control`.

# Conditional GET
- ==Does not send request== if browser has already ==cached objects==.
- Header `If-Modified-Since: `=> check header.
- If not modified and browser caches objects, server responses `HTTP 304 Not Modified` and forwards to proxy server.

---
# References
1. Computer Networking A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.