#faq  #cybersecurity #software-engineering 
- Reference: https://www.baeldung.com/cs/security-interruption-interception-modification-fabrication
- Normal transmission

![](Pasted%20image%2020240517192131.png)

# Interception threat
- ![](Pasted%20image%2020240517192233.png)
- An intruder can ==access your confidential data==, but not affect data integrity.
- Examples:
	- eavesdrop.
- Violation: mainly confidentiality.
# Interruption threat
- ![](Pasted%20image%2020240517192856.png)
- An intruder can ==steal and damage== your data. User is ==unable to access== your resource.
- Examples:
	- DDOS.
	- Hardware diruption.
	- 
- Violation: mainly availability.
# Modification threat
- ![](Pasted%20image%2020240517193056.png)

- An intruder can not only steal and damage, but he can also ==modify i==t and send to your user.
- Example:
	- Cross-Site Scripts.
- Violation: availability and mainly integrity.

# Fabrication threat
- ![](Pasted%20image%2020240517193339.png)
- An intruder can ==masquerade a normal user== by ==injecting bogus data== or false trail into system.
- Example:
	- Phishing
	- SQL Injection.
	- IP Spoofing.
	- Replay Attacks.
- Violation: authentication, availability.
# Summary
- ![](Pasted%20image%2020240517194244.png)
- ![](Pasted%20image%2020240517194333.png)
# References
1. https://www.baeldung.com/cs/security-interruption-interception-modification-fabrication 