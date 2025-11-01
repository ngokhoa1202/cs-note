#vanilla-javascript #cookie #computer-network #http #https #javascript #typescript #browser #application-layer
#software-engineering #software-architecture 

- `document.cookie` is a string containing a semicolon-separated list of all cookies (i.e., `key=value` pairs).
# Essential key-value pairs
- `;max-age=max-age-in-seconds`: The maximum age of the cookie in seconds.
- `;expire=time-to-expire`: The timestamp that the cookie will be automatically invalidated.
>[!Importatnt]+  Cookie`max-age=;expire=`
>By default, if a cookie doesn’t have one of these attributes, it disappears when the browser/tab is closed. Such cookies are called “session cookies”
- `;samesite`: The `SameSite` attribute of a `Set-Cookie` header can be set by a server to specify when the cookie will be sent. Possible values are `lax`, `strict` or `non`.
	- The `lax` value will send the cookie for *all same-site requests* and top-level navigation GET requests. This is default value.
	- The `strict` value will prevent the cookie from being sent by the browser to the target site in *all cross-site browsing contexts*, even when following a regular link.
	- The `none` value explicitly states *no restrictions* will be applied. The cookie will be sent in all requests—both cross-site and same-site, which prevents Cross-Site Request Forgery attack.
- `;secure`: Specifies that the cookie should only be transmitted over a secure protocol such as HTTPS.
- `;httpOnly:` Forbids any Javascript access to the cookie so that `document.cookie` cannot see it.
# Reading cookie
- The value of `document.cookie` consists of `name=value` pairs, delimited by `;`. Each one is a separate cookie.
```Javascript title='Reading cookie'
// so there should be some cookies
alert( document.cookie ); // cookie1=value1; cookie2=value2;...
```
# Writing cookie
- A write operation to `document.cookie` *updates only the cookie mentioned* in it and doesn’t touch other cookies.
```Javascript title='Write a single cookie'
let name = "my name";
let value = "John Smith"

// encodes the cookie as my%20name=John%20Smith
document.cookie = encodeURIComponent(name) + '=' + encodeURIComponent(value);

alert(document.cookie); // ...; my%20name=John%20Smith

// set max age
let date = new Date(Date.now() + 86400e3).toUTCString();
document.cookie = "user=John; expires=" + date;
```
- Cookie size should not exceed 4 KB.
# References
1. https://javascript.info/cookie
2. [[computer-network/application-layer/http/Cookie|Cookie]]
3. https://developer.mozilla.org/en-US/docs/Web/API/Document/cookie
4. https://developer.mozilla.org/en-US/docs/Glossary/CSRF