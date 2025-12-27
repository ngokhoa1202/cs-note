#application-layer #computer-network #cybersecurity #web #web-security #http #https  #protocol #client-server 

- Default port: 443.
- Provides:
	- Encryption.
	- Data integrity.
	- Authentication.
# Open connection
- User agent as HTTP Client or TLS Client.
- Client first Client Hello => HTTP data seen as TLS data.
- Keep all HTTP behavior. 
# Close connection
- `Connection: Close` header in HTTP Client => two sides send TLS alert close_notify .
- If close before waiting to other to send alert => incomplete close.
***
# References
1. [Secure Socket Layer (SSL) - Transport Layer Security (TLS)](Secure%20Socket%20Layer%20(SSL)%20-%20Transport%20Layer%20Security%20(TLS).md) for the underlying transport layer protocol.
2. [Hyper Text Transfer Protocol (HTTP)](Hyper%20Text%20Transfer%20Protocol%20(HTTP).md)