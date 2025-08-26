#cybersecurity #web-security #web-server #application-layer #client-server  #network-layer #computer-network 

# Purpose
- Causes our server-side application make request to ==unintended location==.
- Make internal network connect external network to leak sensitive data.
- ![800x600](Pasted%20image%2020240820160146.png)
# Intruder's exploitation
- Poses modification threat [Interruption vs. Interception vs. Modification vs. Fabrication](Interruption%20vs.%20Interception%20vs.%20Modification%20vs.%20Fabrication.md).
- Apparently, this is man-in-the-middle attack.
## SSRF against server itself
- Obviously and implicitly, a host always trust its own network $\implies$ ==bypass== all access control mechanism or firewall.
- Causes server to make loopback request `127.0.0.1`
### Cause
- Access control failed to prevent external access:
	- Bad configuration for production environment.
- Intruder granted administrative role.
## SSRF against internal API
- Typically, after passing the network router, internal back-end systems are the weakest.
### Cause
- Lack necessary isolation.
## Blind SSRF vulnerability
- Induce servers to make requests to a dangerous URL. However, the intruder himself ==does not directly== see the response from server but ==infers== from indirect methods.
- Used to gain remote code execution.
### Cause
- 
# Lab
## localhost with adminitrative permission
### Requirement - localhost
- Access the adminitrative endpoint `/admin`.
- ![](Pasted%20image%2020240829074556.png)
### Solution
- Intercept the traffic when check the stock of a product.
- Then change its url to `http://localhost/admin`.
## Internal API
### Requirement
- Delete an item with admin permission granted.
### Solution
- Probe for the IP address of admin.
- Use that API to delete item `http://192.168.0.222:8080/admin/delete?username=carlos`
# Prevention - circumvention
## Employs DNS Service
- Replace `localhost` or `127.0.0.1` by a domain name, which ends up being mapped into an registered IP.
- [Domain name system](Domain%20name%20system.md)
## Upgrade to HTTPS
- Always upgrade to HTTPS and register certificate with a CA (Cloudfare, DigiCert, Google, ...).
- [HTTPS](HTTPS.md)
## Blocks all suspected traffic, domain,...
- Allows any traffic except ... (e.g: block `127.0.0.1`)
- For Java on application layer, use:
	- Method [InetAddressValidator.isValid](http://commons.apache.org/proper/commons-validator/apidocs/org/apache/commons/validator/routines/InetAddressValidator.html#isValid(java.lang.String)) from the [Apache Commons Validator](http://commons.apache.org/proper/commons-validator/) library.
	- Method [DomainValidator.isValid](https://commons.apache.org/proper/commons-validator/apidocs/org/apache/commons/validator/routines/DomainValidator.html#isValid(java.lang.String)) from the [Apache Commons Validator](http://commons.apache.org/proper/commons-validator/) library.
- Prepare black-list.
## Allows only trusted traffic, domain,...
- Allow inputs that match, a whitelist of permitted values,... $\implies$ white list.
- Stringently block all DNS resolution from domain, traffic which are not in the white list.
## Always URL-encoded
- Don't trust client inputs.
- URL encode and validation is key.
## Out-of-band technique
- Hire a third-party service to receive requests and exchange data with that service.
- Monitor logs and requests from that service.

--- 
# References
1. https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html for SSRF Overview.
2. https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html for Java validating traffic API.
3. [Firewall overview](Firewall%20overview.md) for Firewall overview.
4. [Domain name system](Domain%20name%20system.md) for DNS service.