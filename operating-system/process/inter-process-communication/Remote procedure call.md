#rpc #operating-system #process #process-synchronization #client-server #computer-network #application-layer #transport-layer #streaming #grpc 

- Adheres to client-server model.
- The data exchanged is called <mark style="background: #e4e62d;">messages</mark>.
# Remote procedure call
- Stands for Remote Procedure Call - a protocol staying on application layer in the TCP/IP model.
- Messages must be well-structured.
- Each message is addressed to an <mark style="background: #e4e62d;">RPC daemon</mark> listening to a port on the remote system, and each contains an identifier specifying the function to execute and the parameters to pass to that function. The function is then executed as requested, and any output is sent back to the requester in a separate message.
>[!Note]
> A message in RPC is equivalent to a request in HTTP; however their meanings may be slightly different.
- ![](Pasted%20image%2020241018143653.png)

# Mechanism
- The semantics of RPC s allows a client to invoke a procedure on a remote host as it would invoke a procedure locally.
- The RPC system hides the details by <mark style="background: #e4e62d;">providing a stub on the client side</mark>. Typically, a separate stub exists for each separate remote procedure. 
- When the client invokes a remote procedure, the RPC system calls the appropriate stub, passing it the parameters provided to the remote procedure. 
- This stub locates the port on the server and marshals the parameters. The <mark style="background: #e4e62d;">stub then transmits a message</mark> to the server using message passing. 
- A similar stub on the server side receives this message and invokes the procedure on the server.
# Use cases
## gRPC
- gRPC stands for google Remote Procedure Call - a RPC-based <mark style="background: #e4e62d;">protocol</mark> implemented by Google.
### Architecture
- ![](Pasted%20image%2020241018143822.png)
- Both client and server must share the same message format - which is our `.proto` files.
#### gRPC client
- Each client must run a gRPC stub, which <mark style="background: #e4e62d;">has already implemented</mark> by Google teams.
	- Whenever a `.proto` is compiled into `.class` file and executed, a process assumes the responsibility to invoke a remote procedure call $\implies$ called gRPC stubs.
	- <mark style="background: #e4e62d;">Do not re-implement</mark> these generated `.class` files. 
- A client can opt for non-blocking requests or blocking requests. Those requests may be in-memory requests (same host) or remote requests.
#### gRPC server
- Implements its own gRPC service and and always listen for clients' messages.
- The fashion how the gRPC server handles messages must be <mark style="background: #e4e62d;">identical to that of the gRPC client</mark>.
	- If clients make non-blocking requests, then servers must asynchronously handle it.
### Implementation
- [gRPC for Quarkus](gRPC%20for%20Quarkus.md)
## MIDL - Microsoft Interface Definition Language
- 
# Application
- Implements API gateway.
- Establish connections between services in microservice architecture.

# References
1. Operating System Concepts - Abraham Silberschatz - 10th - 2018 - Person Publisher.
	1. Chapter 3: Processes.
		1. Section 3.8.2: Remote Procedure Calls.
2. 