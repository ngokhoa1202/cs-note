#ci-cd #cli #docker #software-architecture #client-server #application-layer #web-server  #dbms #binary-image  #operating-system #process #memory #virtual-memory #site-realibility-engineering 

# Architecture
- ![](Pasted%20image%2020240727204701.png)
- Docker client (agent) interacts with docker daemon on the same host (Unix sockets), or remotely (API call):
	- command line.
	- docker desktop.
- Docker daemon (`dockerd`) performs building, running and distributing container images. $\equiv$ Docker engine.
- Registry contains container images which provide a certain service.
- Container is a runnable instance of binary images $\implies$ can start, stop, move, delete.
# Image vs Container
- Docker image is the <mark style="background: #e4e62d;">runnable binary image</mark> of the application $\equiv$ program.
- Docker container is the <mark style="background: #e4e62d;">instance</mark> of that image loaded into the memory running as a process.
- Docker registry is the centralized repository to store and manage images.
	- A registry contains many repository.
	- A repository is made up of many images.
- ![](Pasted%20image%2020240729171716.png)

# References
