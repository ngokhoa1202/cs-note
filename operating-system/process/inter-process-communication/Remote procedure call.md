#rpc #operating-system #process #process-synchronization #client-server #computer-network #application-layer #transport-layer #streaming #grpc #interface-definition-language 

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
- [[programming/java/quarkus/gRPC for Quarkus|gRPC for Quarkus]]
## MIDL - Microsoft Interface Definition Language
- 
# Application
- Implements API gateway.
- Establish connections between services in microservice architecture.
***
# References
1.  
2. [[programming/java/quarkus/gRPC for Quarkus|gRPC for Quarkus]]