#application-layer #client-server #computer-network #web 

# Web architecture
- The web is a layered architecture from client to network infrastructure:
	- Client Layer (The Web):
		- HTML: Document structure and content.
		- CSS: Styling and presentation
		- Javascript: Client-side logic and interactivity
		- Web APIs: Browser interfaces (DOM, Fetch, etc.)
	- Application Layer:
		- HTTP: Application protocol for web communication
		- DNS: Domain name resolution to IP addresses
		- TLS: Encryption layer securing HTTP (HTTPS)
	- Transport/Network Layer:
		- TCP: Reliable, connection-oriented data transmission
		- UDP: Fast, connection-less transmission (used by DNS)
		- IP: Packet routing across networks
- ![[Pasted image 20250629071444.png]]
# Uniform Resource Locator (URL)
- URL has three parts:
	- The protocol (or scheme).
	- The domain name.
	- The path uniquely indicating the specific page.
- ![[Pasted image 20251022174322.png]]
- ![[Pasted image 20251023082221.png]]
# Execution flow
## Client side
- Given a URL `{URI} http://www.cs.washington.edu/index.html`, when a user clicks on a hyperlink, the browser performs a series of steps in order to fetch the web page:
1. The browser determines the URL.
2. The browser asks DNS for the IP address of the server `{URL} www.cs.washington.edu`.
3. DNS server replies with the server's IP address`128.208.3.88`.
4. The browser makes a TCP connection to `128.208.3.88` on port 80 (or 443 in case of HTTPS).
5. It sends over an HTTP request asking for the page `/index.html`.
6. The `www.cs.washington.edu` server sends the page as an HTTP response, for example, by sending the file `/index.html`.
7. If the page includes URLs that are needed for display, the browser fetches the other URLs using the same process. In this case, the URLs include multiple embedded images also fetched from `www.cs.washington.edu`, an embedded video from `youtube.com`, and a script from `google-analytics.com`.
8. The browser displays the page `/index.html`.
9. The TCP connections are released if there are no other requests to the same servers for a short period.
- ![[Pasted image 20251022103330.png]]
## Server side
- The server takes a series of steps to send its response to the client:
1. Accept a TCP connection from a client (a browser).
2. Get the path to the page, which is the name of the file requested.
3. Get the file (from disk).
4. Send the contents of the file to the client.
5. Release the TCP connection.
- Web servers are able to concurrently serve multiple requests by employing web cache and multi-threaded processing.
- ![[Pasted image 20251023084554.png]]
***
# References
1. Computer Networking A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
2. https://developer.mozilla.org/en-US/docs/Learn_web_development/Getting_started/Web_standards/The_web_standards_model for Web standard model.
3. [[HTTP]]
4. [[HTTPS]]
5. [[Domain name system]]
6. [[User Datagram Protocol (UDP)]]
7. [[TCP]]
8. [[IPv4]]
9. https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Overview
10. Computer Networks - Tanenbaum Andrew S., Wetherall David J. Wetherhall - Prentice Hall Publisher (2011).
	1. Chapter 7. The application layer.
		1. Section 7.3 The World Wide Web.
11. [[Web cache]]