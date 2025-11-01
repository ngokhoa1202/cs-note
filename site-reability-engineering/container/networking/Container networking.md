
- [Software-Defined Networking](Software-Defined%20Networking.md)
Similar to VMs, containers need to be able to communicate with containers running on the same host and with containers running on different hosts. The host uses the [network namespace](https://lwn.net/Articles/580893/) feature of the Linux kernel to isolate the network from one container to another on the host system. Network namespaces can be shared between containers, a feature extensively used even by container orchestration tools like Kubernetes.

On a single host, when using the virtual Ethernet (**vEth**) feature with Linux bridging, we can give a virtual network interface to each container and assign it an IP address. With technologies like [Macvlan](https://docs.docker.com/network/macvlan/) and [IPVlan](https://docs.docker.com/network/ipvlan/) we can configure each container to have a unique worldwide routable IP address.

As of now, multi-host networking with containers can be achieved by using some form of Overlay network driver, which encapsulates the Layer 2 traffic to a higher layer. Examples of this type of implementation are the Docker [Overlay](https://docs.docker.com/network/overlay/) Driver, [Flannel](https://github.com/flannel-io/flannel), and [Weave](https://www.weave.works/). Other types of implementations are also available, such as [Project Calico](https://www.tigera.io/project-calico/), which allows multi-host networking on Layer 3 using BGP (Border Gateway Protocol).

# Networking standards
Two distinct standards have been proposed for container networking:

- [Container Network Model](https://github.com/docker/libnetwork/blob/master/docs/design.md) (CNM)  
    Docker, Inc. is the primary driver for this networking model implemented using the [libnetwork](https://github.com/moby/libnetwork#libnetwork---networking-for-containers) project. Libnetwork standardizes the container network creation process through three main build components: a network sandbox, one or multiple endpoints, and one or multiple networks. Libnetwork is used in one of the following modes:

1. _Null_: NOOP implementation of the driver. It is used when no networking is required.
2. _Bridge_: It provides a Linux-specific bridging implementation based on Linux Bridge.
3. _Overlay/Swarm_: It provides [multi-host communication](https://github.com/docker/libnetwork/blob/master/docs/overlay.md) [](https://courses.edx.org/xblock/block-v1:LinuxFoundationX+LFS151.x+2T2023+type@vertical+block@b0c5bb699644497c8e60f6cca96b8694?dest_lang=en&exam_access=&jumpToId&preview=0&recheck_access=1&show_bookmark=0&show_title=0&src_lang=en&view=student_view#)over VXLAN.
4. _Remote_: It does not provide a driver. Instead, it provides a means of supporting drivers over a remote transport, by which we can write third-party drivers.

- [Container Networking Interface](https://github.com/containernetworking/cni) (CNI)  
    It is a Cloud Native Computing Foundation (CNCF) project which consists of specifications and libraries for writing plugins to configure network interfaces in Linux containers, along with a number of supported plugins. It is limited to providing network connectivity of containers and removing allocated resources when the container is deleted. As such, it has a wide range of support. It is used by projects like Kubernetes, OpenShift, and Cloud Foundry.

# Service discovery
Now that we provided an overview of networking, let's take a moment to discuss _service discovery_ as well. This becomes extremely important when we are looking to implement multi-host networking and use some form of container orchestration with Kubernetes or Swarm. 

Service discovery is a mechanism that enables processes and services to find each other automatically and to talk to each other. With respect to containers, it is used to map a container name with its IP address so that we can access the container directly by its name without worrying about its exact location (IP address), which may change during the life of the container. 

Service discovery is achieved in two steps:

- _Registration_  
    When a container starts, the container scheduler registers the container name to the container IP mapping in a key-value store such as etcd or Consul. And if the container restarts or stops, the scheduler updates the mapping accordingly.
- _Lookup_  
    Services and applications use _Lookup_ to retrieve the IP address of a container so that they can connect to it. Generally, this is supported by DNS (Domain Name Server), which is local to the environment. The DNS used resolves the requests by looking at the entries in the key-value store, which is used for _Registration_. Consul, CoreDNS, SkyDNS, and Mesos-DNS are examples of such DNS services.

# Single-host container networking
## Bridge driver
i Similarly to the hardware bridge network, we can <mark style="background: #e4e62d;">emulate a software bridge network</mark> on a Linux host. It can<mark style="background: #e4e62d;"> forward traffic between two networks based on MAC</mark> (hardware address) addresses. By default, Docker creates a **docker0** Linux bridge network. Each container running on a single host receives a unique IP address from this bridge network unless we specify some other network with the **--net=** option. Docker uses Linux's virtual Ethernet (**vEth**) feature to create a pair of two virtual interfaces, with the interface on one end attached to the container and the interface on the other end of the pair attached to the **docker0** bridge network.

- ![](Pasted%20image%2020241218094130.png)

Displaying the network configuration after installing Docker on a single host should reveal the default bridge network as illustrated below:

- ![](Pasted%20image%2020241218093529.png)
- ![](Pasted%20image%2020241218093714.png)
- ![](Pasted%20image%2020241218093821.png)
- ![](Pasted%20image%2020241218094112.png)
## Null driver
- As the name suggests, **NULL** means no networking. If we run a container with the **null** driver, then it would just get the loopback interface. It would not be accessible from any other network.
- ![](Pasted%20image%2020241218094256.png)
## Host driver
- The **host** driver allows us to share the host machine's network namespace with a container. By doing so, the container would have full access to the host's network, which is not a recommended approach due to its security implications. Running an **ifconfig** command inside the container lists all the interfaces of the host system.
- ![](Pasted%20image%2020241218094626.png)
## Shared container network namespace
- ![](Pasted%20image%2020241218095507.png)
- Now, if we start a new container with the `--net=container:CONTAINER` option, the second container will show the same IP address.
- ![](Pasted%20image%2020241218095528.png)

# Multi-host container networking
In addition to the single-host networking, Docker also supports multi-host networking which allows containers from one Docker host to communicate with containers from another Docker host when they are part of a Swarm. By default, Docker supports two drivers for multi-host networking:

- _Docker Overlay Driver_  
    With the [Overlay](https://docs.docker.com/network/overlay/) driver, Docker encapsulates the container's IP packet inside a host's packet while sending it over the wire. While receiving, Docker on the other host decapsulates the whole packet and forwards the container's packet to the receiving container. This is accomplished with libnetwork, a built-in VXLAN-based overlay network driver.

![Docker Overlay Driver](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/packetwalk.png)

**Docker Overlay Driver  
**(by Nigel Poulton, retrieved from [GitHub](https://raw.githubusercontent.com/docker/labs/master/networking/concepts/img/packetwalk.png))

- _Macvlan Driver_With the [Macvlan](https://docs.docker.com/network/macvlan/) driver, Docker assigns a MAC (physical) address for each container and makes it appear as a physical device on the network. As the containers appear in the same physical network as the Docker host, we can assign them an IP from the network subnet as the host. As a result, direct container-to-container communication is enabled between different hosts. Containers can also directly talk to hosts. However, we need hardware support to implement the Macvlan driver. For more information about Macvlan, please visit its [documentation available on the Docker website](https://docs.docker.com/network/macvlan/).
- 
# References
1. https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS151.x+2T2023/block-v1:LinuxFoundationX+LFS151.x+2T2023+type@sequential+block@b41cef0b7dbc4bec93da4c1a2ce253a7
2. 