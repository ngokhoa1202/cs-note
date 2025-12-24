#grpc #rpc #operating-system #computer-network #application-layer #software-engineering #interface-definition-language #google #cloud-computing #java #quarkus 
- gRPC stands for google Remote Procedure Call - a RPC-based <mark style="background: #e4e62d;">protocol</mark> implemented by Google.
# Architecture
- ![](Pasted%20image%2020241018143822.png)
- Both client and server must share the same message format - which is our `.proto` files.
## gRPC client
- Each client must run a gRPC stub, which <mark style="background: #e4e62d;">has already implemented</mark> by Google teams.
	- Whenever a `.proto` is compiled into `.class` file and executed, a process assumes the responsibility to invoke a remote procedure call $\implies$ called gRPC stubs.
	- <mark style="background: #e4e62d;">Do not re-implement</mark> these generated `.class` files. 
- A client can opt for non-blocking requests or blocking requests. Those requests may be in-memory requests (same host) or remote requests.
## gRPC server
- Implements its own gRPC service and and always listen for clients' messages.
- The fashion how the gRPC server handles messages must be <mark style="background: #e4e62d;">identical to that of the gRPC client</mark>.
	- If clients make non-blocking requests, then servers must asynchronously handle it.
# Implementation
## Java
### Quarkus
- [gRPC for Quarkus](gRPC%20for%20Quarkus.md).
***
# References
1. [[programming/java/quarkus/gRPC for Quarkus|gRPC for Quarkus]]
2. 