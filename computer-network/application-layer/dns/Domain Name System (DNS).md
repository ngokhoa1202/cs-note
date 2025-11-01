#dns #computer-network #application-layer #client-server #udp 

# Purpose
- Domain Name System performs the translation from hostname to IP address and does the mapping between hosts and mail servers.
- Domain Name System also takes the responsibility of load balancing where one domain name is mapped in multiple IP addresses, each of which represents a host.
# Structure
- ![](Pasted%20image%2020240512185352.png)
- Each domain is named by the path upward from it to the unnamed root.
- Component names can be up to 63 characters long, and full path names must not exceed 255 characters.
- All the domains are represented by a tree structure. The leaf represents domains which have no sub-domains. It can a single host or a cluster of hosts.
- Three types:
	- root domain represents one organization, company manages.
	- top-level domain such as `.net, .com, .edu, .gov,...`.
	- authoritative domain is equivalent to authoritative hostname.
# DNS Resolution
## Iterated query
- The client host first queries the local DNS server the IP address of a specific website.
- The local DNS server <mark class="hltr-yellow">iteratively</mark> queries the root DNS server to retrieve the IP of top-level-domain DNS server, queries the top-level-domain DNS server to retrieve the IP address of authoritative DNS server, queries the IP address of the authoritative to retrieve the IP of available server host.
- The IP address of the host is finally returned from the local DNS server to the client host.
- ![](Pasted%20image%2020240512185745.png)
## Recursive query
- The host first queries the local DNS server the IP address of a specific website. The local DNS server forwards that request to the root DNS server.
- The root DNS keeps forwarding the request to the top-level-domain DNS server. This recursive request continues being forwarded until the IP address of the server host is returned or no server is found.
- Then, the root DNS server returned that IP address to the local DNS server. The address ends up being delivered to the client host.
- ![](Pasted%20image%2020240512185942.png)
- As a result, the root DNS server has to take more traffic load.
# DNS Caching
- When host receives IP of a domain, it ==stores mapping== in local memory to boost the speed of DNS queries.
# DNS Record
- DNS record has the general form of $(name, value, type, TTL)$   
## Type A:
- hostname $\mapsto$ IP address.
## Type CNAME 
- stands for ==canonical name==.
- www.ibm.com  $\mapsto$ `servereast.backup2.ibm.com`
## Type NS
- stands for ==name server.==
- maps domain name to hostname of server.
- foo.com $\mapsto$ `dns.foo.com`
## Type MX
- maps ==mail server== to its canonical name.
- `foo.com` $\mapsto$  `mail.bar.foo.com`
# DNS Message Format
- ![](Pasted%20image%2020240514202035.png)
***
# References
1. Computer Networking_ A Top-Down Approach, Global Edition, 8th Edition - Chapter 2: Application layer - DNS Service.
2. https://www.iana.org/domains/root/servers for 13 root domain name servers.
3. Computer Networks - Tanenbaum Andrew S., Wetherall David J. Wetherhall - Prentice Hall Publisher (2011).
	1. Chapter 7. The Application Layer.
		1. Chapter 7.1. The domain name system.
4. https://www.cloudflare.com/learning/dns/dns-server-types/ for DNS server types.