#http #protocol #application-layer #computer-network #web #web-security #web-security #ongoing  #web-security 

- There are total 9 HTTP Methods:
	- [HTTP GET](#HTTP%20GET)
	- [HTTP POST](#HTTP%20POST)
	- [HTTP PUT](#HTTP%20PUT)
	- [HTTP DELETE](#HTTP%20DELETE)
	- [HTTP CONNECT](#HTTP%20CONNECT)
	- 
# HTTP GET
- Should be only used to ==resource data from server==.
- Safe.
- Cacheable.
- Idempotent $\equiv$ the same requests have the same side effects on server side.
- ==Limited length== to 8KB.
- Has ==empty body==, data must be specified in ==url query string== $\Rightarrow$ ==insecure==.
- Bookmarkable.
# HTTP POST
- Should be used to ==create or update resource==.
- Data is sent via a HTML ==form== and ==stored in request body==. $\Rightarrow$ ==more secure==.
- Not safe.
- ==Not idempotent==.
- Limited length is not documented, but specified by some server:
	- Nginx: 1MB.
	- Apache: 2GB.
	- IIS: 28.6MB, 2048 bytes for query string
	- ...
- ==Not cacheable==.
- Not bookmarkable.
- Form encoding type:
	- `application/x-www-form-urlencoded`: store as key-value pairs `key1=value1&key2=value2`.
	- `text/plain`
	- **`multipart/form-data`**: support binary data (files, images,...).
# HTTP PUT
- Should be used to ==create or update resource==.
- Not safe.
- ==Idempotent==.
- Not cacheable.
- ==Not allowed in HTML Form==. If PUT is used, browser automatically converts to GET.
# HTTP DELETE
- Should be used to ==delete resource==.
- Not safe.
- Idempotent.
- Not cacheable.
- Indicated by `Accept-Patch` header.
- Not allowed in HTML Forms. If DELETE is used, browser automatically ==converts to GET==,
# HTTP HEAD
- Similar to [HTTP GET](#HTTP%20GET) but ==without body==.
- Examples:
	- If client requests a ==heavy file== from server, employ HTTP HEAD instead of GET to ==check its file size== by reading `Content-Length` without downloading.
- Safe.
- Idempotent.
- Cacheable.
- Bookmarkable.
# HTTP CONNECT

# HTTP PATCH
- Should be used ==modify some parts of resource==, but not whole.
- Not safe.
- Not idempotent.
- Not cacheable.
- Not allowed in HTML Forms. If PATCH is used, browser ==automatically converts it to GET==.

# HTTP OPTIONS
- Retrieves ==allowed http methods== for a given URL.
- Has emtpy body.
- Idempotent.
- Not cacheable.

---
# References
1. https://developer.mozilla.org/en-US/docs/Glossary/Idempotent for concept "idempotent".
2. https://www.w3schools.com/tags/ref_httpmethods.asp for comparison between post and get and all HTTP methods.
3. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET for HTTP Get.
4. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE for HTTP Delete.
5. https://developer.mozilla.org/en-US/docs/Glossary/Idempotent for Idempotent method.
6. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/OPTIONS for HTTP Options.
7. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.
8. https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH for HTTP Patch.

