#network-access-control  #eap #computer-network #cybersecurity 

- Known as ==**Extensible** Access Protocol==.
- Specified in ==IEEE 802.1X==
- ![](Pasted%20image%2020240512175447.png) Stays ==on top of data link layer== and used as a framework.
- ![](Pasted%20image%2020240512175314.png)
- Components:
	- EAP Peer <-> Supplicant.
	- ==EAP Authenticator.==
	- Authentication Server <-> RADIUS.
- ![](Pasted%20image%2020240512175755.png)
# EAP Message Format
- Code:
	- Request.
	- Response
	- Success.
	- Failure.
- Identifier.
- Length
- Data.
# EAPOL
- Known as ==EAP Over LAN==.
- EAPOL Frame Types:
	- *EAPOL-EAP*: encapsulates EAP packets.
	- *EAPOL-Start*: notify there is an authenticator requiring authentication or there is a device ready to join network.
	- *EAP-Logoff*: disconnect, need reauthetication.
	- *EAO-Key*: exchange key.
- ![](Pasted%20image%2020240512181224.png)
Four steps:
1. **Initialization** If new supplicant is detected, the port on authenticator is enabled and set to the "unauthorized" state. Only ==allow IEEE 802.1X traffic==.
2. **Initiation** The authenticator periodically transmits ==EAP-Request Identity== frames to a special Layer 2 address (01:80:C2:00:00:03) on the local network segment. The supplicant ==listens== at this address, and on receipt of the EAP-Request Identity frame, it ==responds with an EAP-Response Identity frame== containing an ==identifier== for the supplicant such as a User ID. The authenticator then encapsulates this Identity response in a [RADIUS](https://en.wikipedia.org/wiki/RADIUS "RADIUS") Access-Request packet and ==forwards it on to the authentication server==. The supplicant may also initiate or restart authentication by sending an EAPOL-Start frame to the authenticator, which will then reply with an EAP-Request Identity frame.
3. **Negotiation** _(Technically EAP negotiation)_ The authentication server sends a ==reply== (encapsulated in a [RADIUS](https://en.wikipedia.org/wiki/RADIUS "RADIUS") ==Access-Challenge packe==t) to the authenticator, containing an EAP Request specifying the EAP Method (The type of EAP based authentication it wishes the supplicant to perform). The authenticator encapsulates the EAP Request in an EAPOL frame and transmits it to the supplicant. At this point, the supplicant can start using the ==requested EAP Method==, ==or do a NAK== ("Negative Acknowledgement") and ==respond with the EAP Methods== it is willing to perform.
4. **Authentication** If the authentication server and supplicant agree on an EAP Method, EAP Requests and Responses are sent between the supplicant and the authentication server (translated by the authenticator) until the authentication server responds with either an ==EAP-Success message ==(encapsulated in a [RADIUS](https://en.wikipedia.org/wiki/RADIUS "RADIUS") Access-Accept packet), or ==an EAP-Failure messag==e (encapsulated in a [RADIUS](https://en.wikipedia.org/wiki/RADIUS "RADIUS") Access-Reject packet). If authentication is successful, the authenticator sets the port to the =="authorized" state== and ==normal traffic is allowed==, if it is unsuccessful the port remains in the "unauthorized" state. When the supplicant logs off, it sends an EAPOL-logoff message to the authenticator, the authenticator then sets the port to the =="unauthorized" state==, once again ==blocking all non-EAP traffic==.
# References
1. https://en.wikipedia.org/wiki/IEEE_802.1X
2. 