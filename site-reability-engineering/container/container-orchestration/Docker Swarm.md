[Docker Swarm](https://docs.docker.com/engine/swarm/) is a native container orchestration solution from [Docker, Inc](https://www.docker.com/). Docker, in swarm mode, logically groups multiple Docker Engines into a swarm, or cluster, that allows for applications to be deployed and managed at scale.

![Swarm Cluster Components](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/Swarm_Cluster_Components.png)

**Swarm Cluster Components  
**(by Docker, Inc., retrieved from [docker.com](https://docs.docker.com/engine/swarm/images/swarm-diagram.png))

The above illustration depicts two major components of a swarm:

- _Swarm Manager Nodes_Accept commands on behalf of the cluster and make scheduling decisions. They also maintain the cluster state and store it using the _Internal Distributed State Store_, which uses the [Raft](https://raft.github.io) consensus algorithm. One or more nodes can be configured as managers for fault-tolerance. When multiple managers are present they are configured in _active_/_passive_ modes.
- _Swarm Worker Nodes_  
    Run the Docker Engine and the sole purpose of the worker nodes is to run the container workload dispatched by the manager node(s).
# Docker Swarm solutions
Following the acquisition of the Docker Enterprise product by [Mirantis](https://www.mirantis.com/), the Docker Swarm product, an essential component of the Enterprise offering, also became part of Mirantis' portfolio. While the Docker Enterprise product ended up rebranded as Mirantis Kubernetes Engine, many organizations heavily vested in Swarm expressed concerns that the container orchestration product may end up rebranded as well, severely impacting their business continuity. Mirantis, however, in response to the feedback received from their clients, announced that they will continue the support and development of Swarm, with the possibility of releasing new features as well.

Swarm is a Docker native feature, integrated with the Docker Engine, allowing Docker users to deploy containers on a distributed cluster of docker hosts - swarm, instead of the single docker host approach to containerized applications deployment. A distributed deployment model helps applications to achieve high availability, fault tolerance, scalability, and redundancy.

A swarm can be created from the Docker CLI by enabling swarm mode within the Docker Engine (available as part of the Docker [subscription products](https://www.docker.com/pricing)), or it can be found integrated with Mirantis orchestration solutions:

- [Swarm Mode](https://docs.docker.com/engine/swarm/)  
    A cluster management and orchestration feature embedded in the Docker Engine.
- Swarm solutions by Mirantis:

- Enterprise Swarm - [Mirantis Container Cloud](https://www.mirantis.com/software/mirantis-container-cloud/)  
    A Container Platform that runs on any public cloud, private cloud, or bare-metal and deploys both Kubernetes and Swarm clusters. 
- Production Swarm - [Mirantis Kubernetes Engine](https://www.mirantis.com/software/mirantis-kubernetes-engine/) (formerly Docker Enterprise/UCP)  
    An Enterprise Kubernetes Platform that allows in mixed-mode for both Kubernetes and Swarm container orchestrators to run in parallel on the same cluster, or easily switch between them to suit the needs of the software solution.****