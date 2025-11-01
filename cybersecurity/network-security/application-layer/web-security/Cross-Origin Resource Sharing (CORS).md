#web-security #cybersecurity #computer-network #web #browser #javascript #cookie 

# Origin
## Definition
- Web content's origin is defined by the _scheme_ (protocol), _hostname_ (domain), and _port_ of the URL used to access it.
- Two objects have the same origin only when their schemes, hostnames, and ports are identical.
## Example
### Example 1 - Same origin
- The two URLs have the same origin because their schemes, domains and ports are identical. The relative path does not matter.
```URL title='Two same-origin URLs'
http://example.com/app1/index.html
http://example.com/app2/index.html 
```
### Example 2 - Same origin, default HTTP port
- The two URLs have the same origin because their schemes, domains and ports are identical. The HTTP default port is 80.
```URL title='Two same-origin URLs with default HTTP port 80'
http://example.com:80
http://example.com
```
### Example 3 - Different origins, different domains
```URL title='Different origin URLs because of different domains'
http://example.com
http://www.example.com
http://myapp.example.com
```
# Same-origin policy
## Definition
- Same-origin policy is a browser security mechanism that <mark class="hltr-yellow">restricts</mark> a document or script loaded by *one origin* <mark class="hltr-yellow">from accessing resources</mark> of *another origin*.
- It helps isolate potentially malicious documents, thereby reducing possible attack vectors. For example, it prevents a malicious website on the Internet from running JavaScript in a browser to read data from a third-party mail service in which the user is signed or a company intranet and relaying that data to the attacker.
- ![[Pasted image 20251023111946.png]]
## Inherited origins
- Scripts executed from pages with an `about:blank` or [[javascript URL]] inherit the origin of the document containing that URL since these types of URLs do not contain information about an origin server.
## File origins
### Mechanism
- Files uploaded from the client host using `{URL} file:///` scheme is treated as opaque origins by browsers.
- When a local file (`file:///`) is opened, there is no host specified so the browser is unable to determine whether other files are from the same origin.  To ensure the security of the website, file schemes are not the same origin.
>[!Note]
>The opacity of file origins explains why the `index.html` file should always be loaded with a web server rather than being opened in the form of `file:///` scheme. The latter execution will result in CORS errors because all the files are treated as coming from different opaque origins, even though they are in the same folder.
>
### Example
- Assume there are two files in the same folder `src`: `index.html` and `data.json`.
```HTML title='index.html'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script defer>
      fetch("data.json")
        .then((res) => res.json())
        .then((data) => console.log(data));
    </script>
    <title>Document</title>
  </head>

  <body>
    <h1>This is a testing page for Javascript</h1>
    <div id="progress"></div>
  </body>
</html>
```
- If the `index.html` is directly opened without a local web server, the website fails to load the resource `data.json` because the two files are considered as coming from different origins.
- ![[Pasted image 20251101153906.png]] 
# Cross-origin resource sharing
## Definition
- Cross-Origin Resource Sharing (CORS) is a browser security mechanism which enables a document or a script to <mark class="hltr-yellow">gain controlled access to resources from another origin</mark>.
- ![[Pasted image 20251023111946.png]]
- CORS mechanism allows these types of HTTP requests to bypass [[#Same-origin policy]]:
	- `fetch()` or `XMLHttpRequest`.
	- Web fonts.
	- WebGL textures.
	- Images/video frames drawn to a canvas using `drawImage()`.
	- CSS Shapes from images.
## Mechanism
- CORS adds new HTTP headers, thus allows a server to _explicitly specify_ which other origins are allowed to access its resources.
### Simple requests
- Simple requests are requests which do not trigger a CORS preflighted request.
- However, the server still must opt-in using `Access-Control-Allow-Origin` to _share_ the response with the script.
- A request is *simple* if and only if it meets all the following conditions:
	- Must be one of HTTP methods: GET, POST, HEAD.
	- Has CORS-safelisted request-headers manually set except the headers which are automatically set by user agent such as (`Connection`, `User-Agent`, `Origin`, etc):
		- `Accept`.
		- `Accept-Language`.
		- `Content-Language`.
		- `Content-Type`: must be one of the following types:
			- `application/x-www-form-urlencoded`.
			- `multipart/form-data`.
			- `text/plain`.
		- `Range`. 
	- If the request is made using an `XMLHttpRequest`object, no event listeners are registered on the object returned by the `XMLHttpRequest.upload` property used in the request.
	- No `ReadableStream`object is used in the request.
- ![Diagram of simple CORS GET request](https://mdn.github.io/shared-assets/images/diagrams/http/cors/simple-request.svg)
- 
### Preflighted requests
- The browser first sends a preflighted HTTP request using OPTIONS method to probe the resource on the other origin and determine whether the following main request is safe to send or not.
```JavaScript title='CORS request will be preflighted'
const fetchPromise = fetch("https://bar.other/doc", {
  method: "POST",
  mode: "cors",
  headers: {
    "Content-Type": "text/xml",
    "X-PINGOTHER": "pingpong",
  },
  body: "<person><name>Arun</name></person>",
});

fetchPromise.then((response) => {
  console.log(response.status);
});
```
- 
- ![Diagram of a request that is preflighted](https://mdn.github.io/shared-assets/images/diagrams/http/cors/preflight-correct.svg)
### Requests with credentials
***
# References
1. https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS for CORS tutorial.
2. https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy for Same Original Policy tutorial.
3. [[World Wide Web#Uniform Resource Locator (URL)]] for URL.
4. [[javascript URL]] for `javascript:` URL schemes.
5. https://fetch.spec.whatwg.org/#http-cors-protocol for Cross-Origin Sharing Resource specification for HTTP request and response in the latest `fetch` specification.
6. https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_shapes/Shapes_from_images for CSS Shapes from images.
7. https://www.w3.org/TR/2014/REC-cors-20140116/#terminology for old CORS specification.
8. https://developer.mozilla.org/en-U for S/docs/Web/HTTP/Reference/Headers/Access-Control-Allow-Origin for `Access-Control-Allow-Origin` header.
9. [[HTTP#HTTP Methods]] for HTTP Methods.
10. 