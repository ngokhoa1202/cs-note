#jakarta-ee  #software-architecture  #software-engineering #java #distributed-computing #cloud #dbms #web  #web-server
#dependency-injection  #java-servlet #layered-architecture #dependency-manager #bean 

# Distributed multitiered application
- Refers to [Three-tier Database architecture](Cloud%20computing.md#Three-tier%20Database%20architecture)
- ![800x600](Pasted%20image%2020240809091913.png)
- Client-tier components on ==client machine==.
- Web-tier components on ==Jakarta EE Server==.
- Business-tier components on Jakarta EE Server.
- Enterpise information system (EIS) - tier (or DBMS tier) on ==EIS Server==.
## Jakarta EE Components
### Jakarta EE Clients
- Either ==application client== or ==web client==.
#### Web client
- Composed of:
	- Dynamic web pages including HTML, XML,...
	- Web browser.
- Also known as ==Thin client== $\equiv$ minimal installation on client side.
#### Application client
- Richer GUI.
- Fat client because it is able to access enterprise beans in business tier.
#### Applets
- Obselete technology.
## Jakarta EE Server
### Web components - Web server
- Either ==Java Servlets== or Jakarta Server Pages.
### Business Components - EJB Server - Jakarta Enterprise Bean Server
- Includes Jakarta Persistence Context, Session beans and message-driven beans.

## Jakarta EE communication
- ![800x800](Pasted%20image%2020240809095407.png)
- 
# Jakarta EE Container
- Enhance ==reusability== $\implies$ assemble Jakarta EE modules and deploy them to a container:
	- Use Java Naming and Directory Interface (JNDI). $\implies$ dependency injection.
- ![800x500](Pasted%20image%2020240809101032.png)
### Application client container
- Client container is able to directly access Jakarta Enterprise Bean container.

### Web container

### EJB Container
---
# References
1. https://jakarta.ee/learn/docs/jakartaee-tutorial/9.1/jakarta-ee-tutorial.pdf for Jakarta EE official documentation.
2. 