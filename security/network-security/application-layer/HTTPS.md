#application-layer #computer-network #cybersecurity #web #web-security #http #https  #protocol #client-server 

- Stands for ==HTTP over SSL==.
- Default port: 443.
- Provides:
	- Encryption.
	- Data integrity.
	- Authentication.
- Refer: [SSL-TLS](SSL-TLS.md) 
# Open connection
- User agent as HTTP Client or TLS Client.
- Client first ClientHello => HTTP data seen as TLS data.
- Keep all HTTP behavior. 
# Close connection
- `Connection: Close` header in HTTP Client => two sides ==send TLS alert close_notify== .
- If close before waiting to other to send alert => ==incomplete close==.
---
# References
1. [SSL-TLS](SSL-TLS.md) for the underlying transport layer protocol.
2. [HTTP](HTTP.md)