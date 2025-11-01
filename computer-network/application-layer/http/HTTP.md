#application-layer #http #web #computer-network #protocol #client-server 

# Definition
- HTTP, known as Hyper Text Transfer Protocol, is a communication protocol which underlies the Web, providing a uni-directional communication channel over multiple TCP connections between a web client and web server.
- HTTP is <mark class="hltr-yellow">stateless</mark> but not session-less. Server does not maintain past requests from client with cookies or sessions
- HTTP default port is 80. If the HTTP is upgraded to HTTPS, port 443 is used.
- ![A HTTP request from a client forwarded by several proxies to a server and a response taking the same route back to the client.](https://mdn.github.io/shared-assets/images/diagrams/http/overview/client-server-chain.svg)
# Persistent HTTP vs Non-persistent HTTP
## Non-persistent HTTP:
- At most ==one object sent per TCP connection== opened to server.
- $Response-time=2 \times RTT + file-transmission-time$ $\Rightarrow$ more ==overhead==.

## Persistent HTTP:
- ==Many objects per TCP connection== opened to server.
- Resolve head-of-line blocking.

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
	- [[#HTTP PATCH]]
	- [[#HTTP OPTIONS]]
	- [[#HTTP TRACE]]
	- [[#HTTP HEAD]]
>[!Important]
>A HTTP method is safe if and only if it does not change the state of resource on server.
>A HTTP method is idempotent if and only if multiple identical requests have the same side effect on resource.
>
> A safe HTTP method is definitely idempotent; however, the vice versa is not true.
## HTTP GET
### Purpose
- HTTP GET should be only used to retrieve resources from server.
### Characteristics
- Safe.
- Cacheable.
- Idempotent.
- Bookmarkable.
- Allowed in HTML Form.
- Limited length to 8 KB.
- The request body is empty; as a result, the data must be specified in the request URI $\implies$ insecure.
- The response may have body.
## HTTP POST
### Purpose
- The HTML Specification does not specify the purpose of HTTP POST. The server takes its responsibility for processing the request.
### Characteristics
- Data submitted in HTML is sent in the request body $\implies$ more secure than [[#HTTP GET]].
- Not safe.
- Not idempotent.
- Limited length is not documented, but specified by some server:
	- Nginx: 1 MB.
	- Apache: 2 GB.
	- Internet Information Service: 28.6 MB, 2048 bytes for query string
	- ...
- Employed by HTML Form by default.
- Not cacheable by default. Only cacheable when the freshness information including the validity duration is included.
- Not bookmarkable.
- The request may have body.
- The response may have body.
- Form encoding type:
	- `application/x-www-form-urlencoded`stores data as key-value pairs `key1=value1&key2=value2`.
	- `text/plain`
	- **`multipart/form-data`**: support binary data (files, images,...).
```HTTP title='URL-encoded form submission'
POST /test HTTP/1.1
Host: example.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 27

field1=value1&field2=value2
```

```HTTP title='Multipart form submission'
POST /test HTTP/1.1
Host: example.com
Content-Type: multipart/form-data;boundary="delimiter12345"

--delimiter12345
Content-Disposition: form-data; name="field1"

value1
--delimiter12345
Content-Disposition: form-data; name="field2"; filename="example.txt"

value2
--delimiter12345--
```
## HTTP PUT
### Purpose
- Should be used to create or update resource.
### Characteristics
- Not safe.
- Idempotent.
- Not cacheable.
- The request may have body.
- The response may have body.
- Not allowed in HTML Form. If HTTP PUT is used, browser automatically converts to GET.
## HTTP DELETE
### Purpose
- Should be used to ==delete resource==.
### Characteristics
- Not safe.
- Idempotent.
- Not cacheable.
- The request may have body.
- The response may have body.
- Indicated by `Accept-Patch` header.
- Not allowed in HTML Forms. If DELETE is used, browser automatically ==converts to GET==,
## HTTP HEAD
### Purpose
- Retrieves the metadata of a resource in the form of headers that the server would send if [[#HTTP GET]] were used instead.
### Characteristics
- Similar to [HTTP GET](#HTTP%20GET) but the request and the response has no body.
- Safe.
- Idempotent.
- Cacheable.
- Bookmarkable.
- Not allowed in HTML Forms. If HEAD is used, browser automatically converts to GET.
## HTTP CONNECT
### Purpose

### Characteristics
## HTTP PATCH
### Purpose
- Should be used to modify some parts of resource, but not whole.
### Characteristics
- Not safe.
- Not idempotent.
- Not cacheable.
- Not allowed in HTML Forms. If PATCH is used, browser automatically converts it to GET.
- The request may have body.
- The response may have body.
## HTTP OPTIONS
### Purpose
- Retrieves allowable communication options for a given URL or server, for instance, test the allowed HTTP methods for a request, or to determine whether a request would succeed when making a CORS prelighted request. 
- A client can specify a URL with this method, or an asterisk (`*`) to refer to the entire server.
```HTTP title='HTTP OPTIONS request'
OPTIONS / HTTP/2
Host: example.org
User-Agent: curl/8.7.1
Accept: */*
```

```HTTP title='HTTP Options response'
HTTP/1.1 204 No Content
Allow: OPTIONS, GET, HEAD, POST
Cache-Control: max-age=604800
Date: Thu, 13 Oct 2016 11:45:00 GMT
Server: EOS (lax004/2813)
```
### Characteristics
- The request has no body.
- The response may have body.
- Idempotent.
- Not cacheable.
- Not allowed in HTML Forms. If OPTIONS is used, browser automatically converts it to GET.
## HTTP TRACE
### Purpose
- Performs a message loop-back test along the path to the target resource.
- Most servers and web browsers disable the `TRACE` method for security concerns, especially cross-site tracing.
### Characteristics
- The request has no body.
- The response may have body.
- Safe.
- Idempotent.
- Not cacheable.
- Not allowed in HTML Forms.
# HTTP Status Code

***
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
2. https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages for HTTP message format.
3. https://developer.mozilla.org/en-US/docs/Glossary/Idempotent for concept "idempotent".
4. https://www.w3schools.com/tags/ref_httpmethods.asp for comparison between post and get and all HTTP methods.
5. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET for HTTP Get.
6. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE for HTTP Delete.
7. https://developer.mozilla.org/en-US/docs/Glossary/Idempotent for Idempotent method.
8. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/OPTIONS for HTTP Options.
9. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH for HTTP Patch.
10. https://httpwg.org/specs/rfc9110.html for HTML Semantics.
11. https://developer.mozilla.org/en-US/docs/Glossary/Safe/HTTP for Safe HTTP Methods.
12. https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Methods/CONNECT for HTTP Connect.
13. 
