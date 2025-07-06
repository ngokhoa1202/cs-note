#application-layer #http #web #computer-network #protocol #client-server 

# Definition
- HTTP, known as ==Hyper Text Transfer Protocol==, is a communication protocol which underlies the Web, providing a uni-directional communication channel over multiple TCP connections between a web client and web server.
- HTTP is ==stateless== but not session-less. Server does not maintain past requests from client with cookies or sessions
- HTTP ==default port is 80==. If the HTTP is upgraded to HTTPS, port 443 is used.
- ![A HTTP request from a client forwarded by several proxies to a server and a response taking the same route back to the client.](https://mdn.github.io/shared-assets/images/diagrams/http/overview/client-server-chain.svg)
# Persistent HTTP vs Non-persistent HTTP
## Non-persistent HTTP:
- At most ==one object sent per TCP connection== opened to server.
- $Response-time=2 \times RTT + file-transmission-time$ $\Rightarrow$ more ==overhead==.

## Persistent HTTP:
- ==Many objects per TCP connection== opened to server.
- Resolve HOL blocking.

# HTTP Format

- ![800x](Pasted%20image%2020240512181805.png)
## HTTP Request Format
- ![](Pasted%20image%2020240512095151.png)
- Request line: 
	- HTTP Methods.
	- URL: specify path, domain, port of resources, can be:
		- ==absolute path== with ==query string==.
		- complete URL (`GET https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages HTTP/1.1`)
		- authority form (`CONNECT developer---.mozilla.org:80 HTTP/1.1`).
		- Asterisk form. (`OPTIONS * HTTP/1.1`).
	- HTTP Version.
- Headers:
	- General Headers (like `Via`, `Connection`).
	- Request Headers (`User-agent`, `Accept`).
	- Representation Headers (`Content-Type`).
- Body:
	- Maybe empty (in case of `GET`).
## HTTP Response Format

![](Pasted%20image%2020240512100536.png)
- Status line:
	- Status code: `200`, `400`,...
	- Status text: `Forbidden`, `OK`,...

# HTTP Methods
- There are total 9 HTTP Methods:
	- [HTTP GET](#HTTP%20GET)
	- [HTTP POST](#HTTP%20POST)
	- [HTTP PUT](#HTTP%20PUT)
	- [HTTP DELETE](#HTTP%20DELETE)
	- [HTTP CONNECT](#HTTP%20CONNECT)
	- 
## HTTP GET
- Should be only used to ==resource data from server==.
- Safe.
- Cacheable.
- Idempotent $\equiv$ the same requests have the same side effects on server side.
- ==Limited length== to 8 KB.
- Has ==empty body==, data must be specified in ==URL query string== $\Rightarrow$ ==insecure==.
- Bookmarkable.
## HTTP POST
- Should be used to ==create or update resource==.
- Data is sent via a HTML ==form== and ==stored in request body==. $\Rightarrow$ ==more secure==.
- Not safe.
- ==Not idempotent==.
- Limited length is not documented, but specified by some server:
	- Nginx: 1 MB.
	- Apache: 2 GB.
	- IIS: 28.6 MB, 2048 bytes for query string
	- ...
- ==Not cacheable==.
- Not bookmarkable.
- Form encoding type:
	- `application/x-www-form-urlencoded`: store as key-value pairs `key1=value1&key2=value2`.
	- `text/plain`
	- **`multipart/form-data`**: support binary data (files, images,...).
## HTTP PUT
- Should be used to ==create or update resource==.
- Not safe.
- ==Idempotent==.
- Not cacheable.
- ==Not allowed in HTML Form==. If PUT is used, browser automatically converts to GET.
## HTTP DELETE
- Should be used to ==delete resource==.
- Not safe.
- Idempotent.
- Not cacheable.
- Indicated by `Accept-Patch` header.
- Not allowed in HTML Forms. If DELETE is used, browser automatically ==converts to GET==,
## HTTP HEAD
- Similar to [HTTP GET](#HTTP%20GET) but ==without body==.
- Examples:
	- If client requests a ==heavy file== from server, employ HTTP HEAD instead of GET to ==check its file size== by reading `Content-Length` without downloading.
- Safe.
- Idempotent.
- Cacheable.
- Bookmarkable.
## HTTP CONNECT

## HTTP PATCH
- Should be used ==modify some parts of resource==, but not whole.
- Not safe.
- Not idempotent.
- Not cacheable.
- Not allowed in HTML Forms. If PATCH is used, browser ==automatically converts it to GET==.

## HTTP OPTIONS
- Retrieves ==allowed http methods== for a given URL.
- Has empty body.
- Idempotent.
- Not cacheable.
---
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
2. https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages 
3. https://developer.mozilla.org/en-US/docs/Glossary/Idempotent for concept "idempotent".
4. https://www.w3schools.com/tags/ref_httpmethods.asp for comparison between post and get and all HTTP methods.
5. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET for HTTP Get.
6. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE for HTTP Delete.
7. https://developer.mozilla.org/en-US/docs/Glossary/Idempotent for Idempotent method.
8. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/OPTIONS for HTTP Options.
9. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH for HTTP Patch.
