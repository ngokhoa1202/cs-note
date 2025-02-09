#computer-network  #computer-network #application-layer #client-server #http #protocol  

- Refer to https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages 
- ![800x](Pasted%20image%2020240512181805.png)
# HTTP Request Format
- ![](Pasted%20image%2020240512095151.png)
- Request line: 
	- HTTP Methods.
	- URL: specify path, domain, port of resouces, can be:
		- ==absoluate path== with ==query string==.
		- complete URL (`GET https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages HTTP/1.1`)
		- authority form (`CONNECT developer.mozilla.org:80 HTTP/1.1`).
		- Asterisk form. (`OPTIONS * HTTP/1.1`).
	- HTTP Version.
- Headers:
	- General Headers (like `Via`, `Connection`).
	- Request Headers (`User-agent`, `Accept`).
	- Representation Headers (`Content-Type`).
- Body:
	- Maybe empty (in case of `GET`).
# HTTP Response Format

![](Pasted%20image%2020240512100536.png)
- Status line:
	- Status code: `200`, `400`,...
	- Status text: `Forbidden`, `OK`,...

---
# References
1. Computer Networking  A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose - Keith W. Ross.