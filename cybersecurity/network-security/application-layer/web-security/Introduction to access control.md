#access-control #cybersecurity #computer-network #session #application-layer  #asymmetric-cipher #symmetric-cipher 

# Concepts
- Access control means someone is <mark style="background: #e4e62d;">granted authorization</mark> to <mark style="background: #e4e62d;">access</mark> something.
- Broad topics:
	- [Secure Shell (SSH)](cybersecurity/network-security/application-layer/Secure%20Shell%20(SSH).md)
	- [Secure Socket Layer (SSL) - Transport Layer Security (TLS)](Secure%20Socket%20Layer%20(SSL)%20-%20Transport%20Layer%20Security%20(TLS).md)
- In terms of web security (<mark style="background: #e4e62d;">application layer</mark>), there are 2 main topics:
	- authentication.
	- session.
## Vertical access control
- Restrict sensitve <mark style="background: #e4e62d;">fuctionality</mark>:
	- adminstrator permission.
	- third-party involvement and their responsibility.
## Horizontal access control
- Restrict sensitive <mark style="background: #e4e62d;">resource</mark>:
	- Business confidentiality.
	- Asset management.
## Context-dependent access control
- Restrict user action as a business requirement, both its functionality and resource.
- Example: Banking transaction <mark style="background: #ADCCFFA6;">prevents user from interacting</mark> with the app during the whole payment.

# Lab
## Unprotected admin functionality
- `robots.txt` may contain sensitive information on server side.
## Bypass hidden URL by script modification
- Anchor element `<a>` may contain <mark style="background: #e4e62d;">sensitive hyperlink</mark>.
## Parameter-based access control
- A raw query string.
- An insecure cookie.
- A field in request header:
	- Authorization header.
	- ...
### Cookie-based access control
- Capture requests sent from client, modify `Admin` field in cookie and forward them to server.
- Capture responses from server, modify `Admin` field in cookie and forward to client.
### Payload-based access control
- Capture, modify and forward payload.
### Header-based access control (mis-configuration)
- Non-standard HTTP Header may <mark style="background: #e4e62d;">overwrite</mark> given URL:
	- `X-Original-URL`.
	- `X-Rewrite-URL` .
	- `DENY`
### Token-based access control
- Request modification and client's public key retrieval.
- Resource key type:
	- UUID.
- Authentication key type:
	- Pseudorandomly generated $\equiv$ session key $\equiv$ symmetric key [Email security scenario](Email%20security%20scenario.md). $\implies$ secret key.
	- Generated according to an asymmetric cipher (such as [RSA](RSA.md)). $\implies$ public key.
- Replace session key and change HTTP method from POST to POSTX and finally to GET.

# References
1. https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/05-Authorization_Testing/02-Testing_for_Bypassing_Authorization_Schema for non-standard HTTP headers.
2. https://cheatsheetseries.owasp.org/cheatsheets/Clickjacking_Defense_Cheat_Sheet.html for Deny header.
3. 




