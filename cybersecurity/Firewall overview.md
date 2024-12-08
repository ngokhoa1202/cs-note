#computer-network #cybersecurity #firewall #network-layer #transport-layer  #application-layer #subnet  

# Service
- Service control: Web, mail service.
- Direction control: where traffic goes.
- User control: authentication.
- Behavior control: eleminate spam mails, restrict external access.
- Main roles:
	- Protect internal network from unauthorized external access.
	- Divide network.
# Types

## Packet-filtering firewalls.
-
 - ![](Pasted%20image%2020240516113849.png)
 - Based on:
	 - Source and destination socket = IP + port.
	 - IP protocol.
	 - Interface.
- Two policies:
	- ==Discard==: ghi gì allow cái đó, còn lại block..
	- ==Forward==: cái gì không cấm thì allow..
- Attack:
	- IP spoofing $\Rightarrow$ discard external packets.
	- source routing attack.
- Avantages:
	- Simple.
	- Lightweight.
## Stateful inspection firewall

- ![](Pasted%20image%2020240516135315.png)
- Packet-filtering firewall that ==stores connection state records==.
- ![](Pasted%20image%2020240516135500.png)
- 
## Application-level gateway
- [Web cache](Web%20cache.md) is a type of proxy server.
- Known as ==application proxy==. $\implies$ stay on the ==application layer==.
- ![](Pasted%20image%2020240516135354.png)
- Advantage:
	- More secure than packet filtering.
- Disvantage:
	- Overhead.
## Circuit-level gateway
- ![](Pasted%20image%2020240516140133.png)
- Stand-alone or function of application-level gateway.
- Establish two new TCP connections and relay TCP segments from one connection to other.
- Can be implemented: application-level gateway for inbound connections and circuit-level gateways for outbound connections $\Rightarrow$ reduce outgoing overhead.
# Firewall configuration
- Reference: https://securitywing.com/types-of-firewall/#:~:text=A%20bastion%20host%20is%20basically,only%20go%20to%20the%20Internet.

## Screened host
- Separate into subnets.
### Single-homed bastion host
- ![](Pasted%20image%2020240516154939.png)
- If firewall is compromised, ==private network is compromised==.
### Dual-homed bastion host
- Bastion host must have two NIC :
	- one for router connection.
	- one for private network connection.
- If firewall is compromised, private network ==remains unaffected== because it is an ==independent== zone.
- ![](Pasted%20image%2020240516155707.png)
### Screened subnet
- ![](Pasted%20image%2020240516141206.png)
- Most secure.
- Two firewalls:
	- external firewall: provide access control and protect DMZ network $\Rightarrow$ basic level.
	- internal firewall: stringent rules to protect servers and workstation and isolate from DMZ networks.


