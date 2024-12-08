#ssh #cybersecurity #application-layer #computer-network #application-layer #protocol #client-server #transport-layer #ongoing #mac #tcp 

- Stands for ==Secure SHell==.
- ![](Pasted%20image%2020240514093804.png)
# SSH Transport Layer Protocol
### Host keys
- Managed by:
	- Local database for each host.
	- ==Hostname-to-key mappings== by CA (Certificate authorities: DigiCert, Cloudfare,...).
## Packet format
![](Pasted%20image%2020240514095017.png)
- Sequence number: init to 0, 32-bit number.
### Packet exchange
- 
![](Pasted%20image%2020240514094721.png)

- **Identification string exchange**
	- SSH-{protocol-version}-{software-version} SPACE comments CARRIGE LINE-FEED.
- **Algorithm negotiation**
	- ![](Pasted%20image%2020240514100640.png)
- **Key exchange**
	- ...
- **End of key exchange**
	- ...
- **Service request**
	- employ  SSH User Authetication Protocol or SSH Connection Protocol.
# Connection protocol
- Used a ==secure authentication connection== called **tunnel**.
- ![](Pasted%20image%2020240514112830.png)
- **Open a channel**
	- SSH_MSG_CHANNEL_OPEN.
	- channel type -> string
	- sender channel -> uint32.
	- initial window size -> uint32.
	- maximum packet size -> uint32.
- ==**Channel type**==:
	- **session**: remote program execution.
	- **x11**: X Window System, support GUI.
	- **forwarded-tcpip**: remote port forwarding.
	- **direct-tcpip**: local port forwarding.
- ==**Port forwarding**==
	- ![](Pasted%20image%2020240514120205.png)
	- Forwad insecure TCP default port to ==secure SSH port== and connects via a ==SSH tunnel==.
	- Two types:
		- ==**Local forwarding**==: SSH port and insecure TCP port are forwarded ==on the same host==.
		- ==**Remote forwarding**==: 
	- Tunnel mode means that all the payload is encrypted.