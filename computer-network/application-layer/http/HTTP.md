#application-layer #http #web #computer-network #protocol #client-server #white-box-testing 
#software-testing 

# Definition
- HTTP, known as Hyper Text Transfer Protocol, is a communication protocol which underlies the Web, providing a uni-directional communication channel over multiple TCP connections between a web client and web server.
- HTTP is <mark class="hltr-yellow">stateless</mark> but not session-less. Server does not maintain past requests from client with cookies or sessions
- HTTP default port is 80. If the HTTP is upgraded to HTTPS, port 443 is used.
- ![A HTTP request from a client forwarded by several proxies to a server and a response taking the same route back to the client.](https://mdn.github.io/shared-assets/images/diagrams/http/overview/client-server-chain.svg)
# Persistent HTTP vs Non-persistent HTTP
## Non-persistent HTTP:
- At most <mark class="hltr-yellow">one object</mark> is allowed to be sent *on a single TCP connection* opened to server.
- $\text{Response time}=2 \times RTT + \text{File transmission time}$ $\Rightarrow$ more ==overhead==.
## Persistent HTTP:
- <mark class="hltr-yellow">Multiple objects</mark> are allowed to be sent *on a single TCP connection* opened to server.
- Resolves head-of-line blocking.
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
- ![](Pasted%20image%2020240512100536.png)
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
## Informational responses (`100` - `199`)
- Responses with status codes that are defined as *heuristically cacheable* (e.g., 200, 203, 204, 206, 300, 301, 308, 404, 405, 410, 414, and 501 in this specification)
### 101 Switching protocols
- This code is sent in response to an `Upgrade`request header from the client and indicates the protocol the server is switching to.
## Successful responses (`200` - `299`)
### 200 OK
- The request succeeded. 
- The result and meaning of "success" depends on the semantics of HTTP method:
	- `GET`: The resource has been fetched and transmitted in the message body.
	- `HEAD`: Representation headers are included in the response without any message body.
	- `PUT`or `POST`: The resource describing the result of the action is transmitted in the message body.
	- `TRACE`: The message body contains the request as received by the server.
### 201 Created
- The request succeeded, and a new resource was created as a result. This is typically the response sent after `POST`requests, or some `PUT`requests.
- The HTTP response will optionally contain the `Location` header field to indicate the URL of the created resource.
### 202 Accepted
- The request has been received but <mark class="hltr-yellow">not yet caused any side effect</mark>. It is <mark class="hltr-yellow">noncommittal</mark>, since there is *no way in HTTP to later send an asynchronous response* indicating the outcome of the request.
- It is intended for cases where another process or server handles the request, or for batch processing.
### 204 No Content
- There is no content to send for this request, but the headers are useful.
## Re-directional messages (`300` - `399`)
### 301 Moved Permanently
- The *URL* of the requested resource has been <mark class="hltr-yellow">changed permanently.</mark> 
- The new URL is given in the response `Location` header.
### 302 Found
- This response code means that the URI of requested resource has been changed _temporarily_.
- The new URL is given in the response `Location` header.
### 303 See Other
- The server sent this response to <mark class="hltr-yellow">direct</mark> the client to get the requested *resource at another URI* with a `GET` request.
### 304 Not Modified
- The response has not been modified, so the client can continue to use the <mark class="hltr-yellow">same cached version</mark> of the response.
### 307 Temporary Redirect
- This has the same semantics as the `302 Found` response code, with the exception that the user agent _must not_ change the HTTP method used.
### 308 Permanent Redirect
- This has the same semantics as the `301 Moved Permanently` HTTP response code, with the exception that the user agent _must not_ change the HTTP method used.
## Client error responses (`400` - `499`)
### 400 Bad Request
- The server cannot or will not process the request due to client errors.
- This error is generic for client error fallback.
### 401 Unauthorized
- Although the HTTP standard specifies "unauthorized", semantically this response means "unauthenticated".  That is, the client <mark class="hltr-yellow">must authenticate</mark> itself to get the requested response.
### 403 Forbidden
- The client does not have permissions to access the content; that is, it is unauthorized, so the server is refusing to give the requested resource.
- Unlike `401 Unauthorized`, the client's identity is known to the server.
### 404 Not Found
- The server cannot find the requested resource. 
	- In the browser, this means the URL is not recognized.'
	- In an API, this can also mean that the endpoint is valid but the resource itself does not exist.
### 405 Method Not Allowed
- The request method is known by the server but is not supported by the target resource.
### 407 Proxy authentication required
- This status code is the same as `401 Unauthorzed` but authentication needs to be done by a proxy.
### 408 Request Timeout
- This response is sent on an *idle connection* by some servers, even without any previous request by the client. The server would like to <mark class="hltr-yellow">shut down</mark> this unused <mark class="hltr-yellow">connection</mark>.
### 409 Conflict
- This response is sent when a request conflicts with the current state of the server.
### 415 Unsupported Media Type
- The media format of the requested data is not supported by the server, so the server rejects the request.
### 422 Unprocessable Content
- The request was well-formed but was unable to be followed due to semantic errors such as invalid file content.
### 423 Locked
- The resource that is being accessed is locked.
### 451 Unavailable Legal Reasons
- The user agent requested a resource that cannot legally be provided, such as a web page censored by a government.
## Server error responses (`500` - `599`)
### 500 Internal Server Error
- The server has encountered a situation it does not know how to handle. 
- This error is generic, indicating that the server cannot find a more appropriate `5XX` status code to respond with.
### 502 Bad Gateway
- The server, while working as a gateway to get a response needed to handle the request, got an invalid response.
### 503 Service Unavailable
- The server is not ready to handle the request. Common causes are a server that is down for maintenance or that is overloaded.
- This response should be used for temporary conditions and the `Retry-After` HTTP header should, if possible, contain the estimated time before the recovery of the service.
### 504 Gateway Timeout
- This error response is returned when the server is acting as a gateway and cannot get a response in time.
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
13. https://httpwg.org/specs/rfc9110.html#overview.of.status.codes: RFC 9110 - HTTP Semantics 
	1. Section 15. Status Codes.
14. https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml: Hypertext Transfer Protocol (HTTP) Status Code Registry
15. https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status for HTTP status code tutorial.