#web-socket #protocol #computer-network #application-layer #web #http #tcp
#transport-layer 
# Definition
- WebSocket is a computer communications protocol, providing a <mark class="hltr-yellow">simultaneous bi-directional</mark> communication channel *over a single TCP connection*.
# URI Scheme
- The WebSocket protocol defines two URI schemes for traffic between server and client:
	- `ws`, used for unencrypted connections.
	- `wss`, used for secure, encrypted connections over Transport Layer Security (TLS).
```URI title='URI scheme of WebSocket protocol'
wss://example.com:443/websocket/demo?foo=bar
└─┘   └──────────┘ └─┘ └────────────┘ └─────┘
 │         │        │        │           │
 │         │        │        │           └── Query
 │         │        │        └───────────── Path
 │         │        └────────────────────── Port
 │         └─────────────────────────────── Host
 └───────────────────────────────────────── Scheme
```
# Architecture
- The base WebSocket protocol consists of an opening <mark class="hltr-yellow">handshake</mark> (upgrading the connection from HTTP to WebSockets), followed by data transfer.
- After the client and server successfully negotiate the opening handshake, the WebSocket connection acts as a <mark class="hltr-yellow">persistent full-duplex</mark> communication channel where each side can, independently, send data at will. 
- Clients and servers transfer messages back and forth , which, can consist of one or more frames. Once the WebSocket connection has served its purpose, it can be terminated via a <mark class="hltr-yellow">closing handshake</mark>.
```Shell title='Web socket protocol activity diagram'
        ┌──────────┐                    ┌──────────┐
        │  Client  │                    │  Server  │
        └────┬─────┘                    └────┬─────┘
             │                               │
             │      Initial HTTP             │
             │       handshake               │
             ├──────────────────────────────►│
             │◄──────────────────────────────┤
             │                               │
             │      WebSockets               │
             │      full-duplex              │
             │      persistent               │
             │◄─────────────────────────────►│
             │                               │
             │         Close                 │
             ├──────────────────────────────►│
             │◄──────────────────────────────┤
```
## Opening handshake
### HTTP 1.1 Upgrade handshake
- The client issues a WebSocket handshake request, which is just a specially formatted HTTP GET request. The server, if it supports the WebSocket protocol and is willing to establish a connection with the client, responds with a WebSocket handshake response.
- The server must returns an `HTTP 101 Switching Protocol` response for the connection to be successfully established; otherwise, the handshake failed and the connection is not established.
```Shell title='HTTP 1.1 Upgrade handshake of WebSocket'
   ┌──────────┐                              ┌──────────┐
   │  Client  │                              │  Server  │
   └──────┬───┘                              └──────┬───┘
         │                                          │
         │  GET /chat HTTP/1.1                      │
         │  Host: example.com                       │
         │  Upgrade: websocket                      │
         │  Connection: Upgrade                     │
         │  Sec-WebSocket-Key: [base64]             │
         │  Sec-WebSocket-Version: 13               │
         ├─────────────────────────────────────────►│
         │                                          │
         │  HTTP/1.1 101 Switching Protocols        │
         │  Upgrade: websocket                      │
         │  Connection: Upgrade                     │
         │  Sec-WebSocket-Accept: [hash]            │
         │◄─────────────────────────────────────────┤
         │                                          │
         │       WebSocket Connection               │
         │◄────────────────────────────────────────►│
         │                                          │
```
#### Client handshake request
- A WebSocket handshake request is a specially formatted HTTP GET request
```HTTP title='Client handshake request format'
GET /chat HTTP/1.1
Host: example.com:8000
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
Sec-WebSocket-Version: 13
```
- The request includes the following headers:
	- `Upgrade: websocket` - indicates that the client wants to upgrade the connection to use the WebSocket protocol.
	- `Connection: Upgrade` - tells proxies or other intermediaries to also upgrade the connection.
	- `Sec-WebSocket-Key` - a Base64-encoded random value that helps the server prove it’s a WebSocket-capable server.
	- `Sec-WebSocket-Version` - the version of the WebSocket protocol the client wishes to use.
- In addition to these mandatory headers, the client might also include:
	- `Sec-WebSocket-Protocol` - a list of sub-protocols that the client wishes to speak, ordered by preference.
	- `Sec-WebSocket-Extensions` - a list of extensions the client wishes to use.
#### Server handshake response
- If the server understands the WebSocket protocol and accepts the request to upgrade, it sends back a HTTP response
```HTTP title='Server handshake response format'
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=
```
- The response includes:
	- `HTTP/1.1 101 Switching Protocols` - indicates the successful upgrade from HTTP to WebSocket.
	- `Upgrade: websocket` - confirms the protocol upgrade.
	- `Connection: Upgrade` - indicates that the connection has been upgraded.
	- `Sec-WebSocket-Accept` - a hashed value calculated from the client’s Sec-WebSocket-Key, which helps verify that the server understood the WebSocket handshake request.
- If the client requested a sub-protocol, the server includes the `Sec-WebSocket-Protocol` header with the name of the chosen sub-protocol. If the client requested extensions, the server may include the `Sec-WebSocket-Extensions` header with the extensions it has agreed to use.
## Data framing
- Once the WebSocket connection is established, the client and server can send WebSocket **data frames** back and forth in either direction. Each message consists of one or more frames. There are different types of frames:
	- Text frames - contain UTF-8 encoded text data.
	- Binary frames - contain binary data.
	- Control frames - used for protocol-level signaling, such as pings, pongs, and close frames.
### Frame structure
- The base framing protocol breaks down a frame into the following components:
	-  `FIN` bit - indicates whether this is the final fragment in a message (1) or not (0).
	- `RSV1`, `RSV2`, `RSV3` bits - reserved for extensions; must be 0 unless an extension is negotiated.
	- `Opcode` (4 bits) - indicates the type of frame:
	    - `0x0`: continuation frame
	    - `0x1`: text frame
	    - `0x2`: binary frame
	    - `0x8`: connection close
	    - `0x9`: ping
	    - `0xA`: pong
	- `MASK` bit - indicates whether the payload data is masked (1) or not (0).
	- `Payload length` - the length of the payload data.
	- `Masking key` (optional, 32 bits) - included only if the MASK bit is set to 1.
	- `Payload data` - the actual data.
### Message fragmentation
- WebSocket messages can be split into multiple frames, which can be useful for sending large messages without having to buffer the entire message on the sender’s side. When a message is fragmented:
    - The first frame has an opcode indicating the message type (text or binary).
    - Following frames have an opcode of 0 (continuation frame).
    - The final frame has the FIN bit set to 1.
## Control frames
- Control frames are used for **protocol-level signaling** within the WebSocket connection. They are always un-fragmented (FIN bit set to 1) and have a maximum payload length of 125 bytes.
### Ping-pong frames
- Ping (opcode `0x9`) and Pong (opcode `0xA`) frames are used for checking that the connection is still **alive** or for measuring latency. When a peer receives a Ping frame, it must send back a Pong frame with the same payload as soon as possible.
### Close frames
- Close frames (opcode `0x8`) are used to initiate the closing handshake, which indicates the beginning of the process to terminate the WebSocket connection.
- A close frame may contain a status code and a reason for closing in its payload. The status code is a 16-bit unsigned integer. Refers to https://developer.mozilla.org/en-US/docs/Web/API/CloseEvent/code
## Closing handshake
- The closing handshake is initiated when either the client or server sends a close frame. The peer that receives the close frame should send back another close frame in response.
- After sending a close frame, the peer should not send any more data frames. 
- After both sides have exchanged close frames, the TCP connection is closed.
# Protocol extensions

# Sub-protocols
- Sub protocols define the high-level semantics of the communication over WebSockets. They are application-specific protocols layered on top of WebSockets. Common sub protocols include:
	- *MQTT over WebSockets* - for IoT and messaging applications.
	- *STOMP over WebSockets* - for messaging applications.
	- *JSON-RPC over WebSockets* - for remote procedure calls.
***
# References
1. https://datatracker.ietf.org/doc/html/rfc6455 for standard WebSocket documentation.
2. https://developer.mozilla.org/en-US/docs/Web/API/CloseEvent/code for WebSocket Close frames status code.
3. [[Link layer overview]]
4. [[computer-network/transport-layer/tcp/Transmission Control Protocol (TCP)]]
5. https://socket.io/ for WebSocket in JavaScript.
6. https://websocket.org/guides/websocket-protocol/ for WebSocket protocol fundamentals.
7. https://datatracker.ietf.org/doc/html/rfc8441 - Bootstrapping WebSockets with HTTP/2 - for WebSocket based on HTTP/2.