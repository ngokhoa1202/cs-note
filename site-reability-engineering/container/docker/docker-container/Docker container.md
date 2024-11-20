#ci-cd #software-engineering #os #ubuntu  #cli  #kurbenetes  #process #thread #docker #software-architecture 

# Purpose
- Platform independence, 
- Isolation, 
- Adaptive to changing.

# OCI
- Stands for Open Container Initiative.
- Contains 3 specifications:
	- the Runtime specification.
	- the Image specification.
	- the Distribution specification.
- Implicitly understood as "container".
# Docker - Container
- In contain apps, ==container is the isolation layer==, staying on top of OS. 
- A container itself ==encapsulates== the binary image of the application and additional libraries to deploy them ==as a single software== $\implies$ higher abstraction.
- ![](Pasted%20image%2020240727202345.png)
- Three main innovations:
	- Easy app ==packaging== $\implies$ container image using [HMAC](HMAC.md).
	- Easy app ==running== $\implies$ container isolation.
	- Easy app ==distribution== $\implies$ container image registry.
- Works for a single server.
# Kurbenetes
- Known as ==container orchestration platform==.
- Works for a multi-server clustering system.
- ![](Pasted%20image%2020240727203026.png)


---
# References
1. https://opencontainers.org/about/overview/ for OCI Concepts.
2. https://www.bretfisher.com/kubernetes-vs-docker/ for docker and k8s original ideas.
3. https://github.com/BretFisher/udemy-docker-mastery/blob/main/intro/quick-container-run/quick-container-run.md for testing docker container.
4. https://github.com/BretFisher/udemy-docker-mastery/blob/main/intro/why-docker/why-docker.md Why Docker?
5. https://www.aquasec.com/blog/a-brief-history-of-containers-from-1970s-chroot-to-docker-2016/ for container history.