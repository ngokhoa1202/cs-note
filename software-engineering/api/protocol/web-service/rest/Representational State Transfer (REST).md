#protocol #software-engineering #software-architecture #http #computer-network #application-layer 
#best-practice 
- There are six constraints of RESTful architecture.
# Uniform interface
- A resource in the system should have only *one logical URI*.
- A resource should contain HATEOAS pointing to relative URIs to fetch related information.
- The resource representations across the system should follow specific guidelines such as *naming conventions*, *link formats*, or *data format*.
# Separation between client and server
- Servers and clients can be *independently* developed or replaced, as long as the *interface* between them is *not altered*.
# Statelessness
- No client context is stored on the server between requests. The client is responsible for managing the state of the application.
# Cacheable requests
- GET requests should be cachable by default – until a special condition arises. Usually, browsers treat all GET requests as cacheable.
- POST requests are not cacheable by default but can be made cacheable if either an `Expires` header or a `Cache-Control` header with a directive, to explicitly allows caching, is added to the response.
- PUT and DELETE requests are not cacheable at all.
# Transparency
- A client interacting with a REST API remains completely *unaware of the intermediary components* positioned between itself and the ultimate destination server.
# Code on demand
- Truly RESTful APIs are *infeasible* in practice.
-  All the constraints are optional.
***
# References
1. https://restfulapi.net/ for RESTful API tutorial.
2. https://restfulapi.net/resource-naming/ for RESTful API resource naming tutorial.
3. https://restfulapi.net/caching/ for RESTful API Caching tutorial.
4. https://datatracker.ietf.org/doc/html/rfc5988 for RFC 5988 Web Linking.
5. [[computer-network/application-layer/http/Hyper Text Transfer Protocol (HTTP)|Hyper Text Transfer Protocol (HTTP)]] for HTTP Protocol.
6. [[computer-network/application-layer/World Wide Web|World Wide Web]]
7. [[computer-network/application-layer/Web cache|Web cache]]
8. [[software-engineering/api/protocol/web-service/rest/Resource|Resource]]
9. [[software-engineering/api/protocol/web-service/rest/Hypermedia as the Engine of Application State (HATEOAS)|Hypermedia as the Engine of Application State (HATEOAS)]]
10. 