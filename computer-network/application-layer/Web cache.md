#application-layer #computer-network #proxy-server #http #client-server 
# Web caching
- Cache server is also known as proxy server, staying in the middle of client and original server.
- Cache server caches regularly accessed objects to return to client without directly requesting to server, thereby reducing traffic to access link, response time and cost. 
- ![[Pasted image 20251025194137.png]]
- The validity of cache is explicitly included in HTTP Response Header `Cache-control`(or `Expires`)  which includes `max-age` property and `Last-Modified` so the browser  can caches the payload and the metadata.
# Conditional GET
- For the initial request, the browser asks the web server for a specific resource and the server returns it with headers `Last-Modified` (or `Expired`) and `Cache-Control`.
- ![[Pasted image 20251025193405.png]]
- On the subsequent visits, the browser first checks whether the cache lifetime has expired or not. If it has, the browser directly returns the object from cache without making further requests; otherwise, the browser sends a conditional HTTP GET to the web server.
- The Conditional GET includes `If-Modified-Since` so the web server can determine whether the requested object has been changed or not. If it has not, the server responds with `304 Not Modified`.
- Alternatively, the server may return an `ETag` header with a page. This header gives a tag that is a short name for the content of the page and similar to a checksum.
- ![[Pasted image 20251025212435.png]]
- The browser server checks the`If-Modified-Since:` header of the request;  in case it is not modified, the browser responses `HTTP 304 Not Modified` and forwards to proxy server.
***
# References
1. Computer Networking A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
2. Computer Networks - Tanenbaum Andrew S., Wetherall David J. Wetherhall - Prentice Hall Publisher (2011).
	1. Chapter 7. The application layer.
		1. Section 7.3. The World Wide Web.
