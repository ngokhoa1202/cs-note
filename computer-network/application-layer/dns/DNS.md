#dns #computer-network #application-layer #client-server #udp 
- Stands for ==Domain Name System==.
- DNS service:
	- translates host to IP.
	- host alias.
	- mail alias.
	- load balancing: many IP for one domain name.
- Decentralized.
# Structure
- ![](Pasted%20image%2020240512185352.png)
- Three types:
	- root domain -> one organization, company manages.
	- top-level domain -> .net, .com, .edu, .gov,....
	- authoritative domain -> authoritative hostname...
# DNS Resolution
## Iterated query
![](Pasted%20image%2020240512185745.png)
## Recursive query
![](Pasted%20image%2020240512185942.png)
=> heavier load at root DNS server.
# DNS Caching
- When host receives IP of a domain => ==stores mapping== in local memory => super fast query.
# DNS Record
- General form: $(name, value, type, TTL)$   
## Type A:
- hostname $\mapsto$ IP address.
## Type CNAME 
- stands for ==canonical name== -> tên chính tắc (thay vì gọi là Ngô Vũ Anh Khoa thì gọi là Khoa Ngô).
- www.ibm.com  $\mapsto$ servereast.backup2.ibm.com
## Type NS
- stands for ==name server.==
- maps domain name to hostname of server.
- foo.com $\mapsto$ dns.foo.com
## Type MX
- maps ==mail server== to its canonical name.
- foo.com $\mapsto$  mail.bar.foo.com
# DNS Message Format

![](Pasted%20image%2020240514202035.png)

---
# References
1. Computer Networking_ A Top-Down Approach, Global Edition, 8th Edition - Chapter 2: Application layer - DNS Service.
2. 