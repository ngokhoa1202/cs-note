#ci-cd #cli #docker #software-architecture #client-server #application-layer #web-server  #dbms 
#binary-image  #operating-system #process #memory #virtual-memory #site-realibility-engineering #process-synchronization 

# Container 
- Operating-System-level virtualization allows us to run <mark style="background: #e4e62d;">multiple isolated user-space instances in paralle</mark>l, which is also known as <mark style="background: #e4e62d;">container</mark>.
- Containers include the application source code, required libraries, and the required runtime to run the application without any external dependencies. 
# Purpose
- Enhances <mark style="background: #e4e62d;">portability</mark>, when the application needs to work consistently on multiple hardware and platforms.
- ![](Pasted%20image%2020241211142025.png)
- ![](Pasted%20image%2020241211142035.png)
# Components
## Namespace
- A namespace wraps a particular global system resource:
	- pid - provides each namespace to have the same PIDs. Each container has its own PID 1.
	- net - allows each namespace to have its network stack. Each container has its own IP address.
	- mnt - allows each namespace to have its own view of the filesystem hierarchy.
	- ipc - allows each namespace to have its own interprocess communication.
	- uts - allows each namespace to have its own hostname and domain name. (**Unix Timesharing System**).
	- user - allows each namespace to have its own user and group ID number spaces. A _root_ user inside a container is not the _root_ user of the host on which the container is running.
## cgroups
- _Control groups_ are used to organize processes hierarchically and distribute system resources along the hierarchy in a controlled and configurable manner. The following cgroups are available for Linux:
	- blkio
	- cpu
	- cpuacct
	- cpuset
	- devices
	- freezer
	- memory.
## Union filesystem
- The Union filesystem allows files and directories of separate filesystems, known as <mark style="background: #e4e62d;">layers</mark>, to be transparently overlaid on top of each other, to create a new virtual filesystem. 
- At runtime a container is made of multiple layers merged to create a read-only filesystem. On top of a read-only filesystem, a container gets a read-write layer, which is an ephemeral layer and it is local to the container.
# Container runtimes
- A container runtime is necessary to run containers.
## History
- Namespaces and cgroups have existed in the Linux kernel for quite some time, but consuming them to create containers was not easy. Although the first steps towards containerization can be traced back to 1979 with the process isolation achieved through **chroot**, followed by Linux Containers (LXC) released in 2008, it was the launch of Docker in 2013 that allowed containers to become more popular. Docker was able to hide all the complexities in the background and came up with a simple workflow to share and manage both images and containers. Docker achieved this level of simplicity through a collection of tools that interact with a container runtime on behalf of the user. The container runtime ensures the containers' portability, offering a consistent environment for containers to run, regardless of the infrastructure. 

- Once containers have become popular and container orchestration was emerging as a concept with Kubernetes becoming its primary implementation, in 2014 we saw a new container runtime being born - rkt, implementing a newly introduced set of standards, the App Container (appc) specification defining the Application Container Image (ACI) format. Shortly after, a new standard has been introduced in 2015, the Open Container Initiative (OCI), setting the stage for several new projects such as Skopeo, Buildah, and Podman, all providing sets of open source tools to allow users a quicker, more secure, daemonless, and less resource-intensive containerization experience. Kaniko has also been introduced, a project aiming to integrate the Dockerfile-based container image build process with Kubernetes, or any other environment that cannot run a Docker daemon. While the containers landscape was evolving, a new container runtime has been introduced, CRI-O - a lightweight runtime implementing Kubernetes' Container Runtime Interface (CRI) standard to allow OCI-compliant containers to be run and managed by the container orchestrator.
## runc
- runc is a Go language-based tool that creates and starts container processes. 
- An OCI container runtime is expected to fork off the first process in the container, but Go does not have good support for the fork/exec model of computing. Go follows a threading model that expects programs to fork a second process and then to exec immediately.
## crun
- A much faster and low-memory footprint OCI-conformant runtime written in C. crun is lighter than runc because its C source code allows its compiled size to be 50x smaller and to run about 2x faster. C is not multi-threaded, but it follows the fork/exec model, meeting the OCI runtime expectation.
## containerd
- Containerd is an OCI-compliant container runtime with an emphasis on simplicity, robustness, and portability. As a high-level runtime, it runs as a daemon and manages the entire lifecycle of containers. It is available on both Linux and Windows operating systems. Docker, also run as a daemon, is a containerization platform that uses containerd as a runtime to manage runc containers.
---
# References
1. https://en.wikipedia.org/wiki/OS-level_virtualization
2. [Docker container](Docker%20container.md)
3. https://en.wikipedia.org/wiki/Open_Container_Initiative
4. https://github.com/opencontainers/runc
5. https://github.com/containers/skopeo
6. https://kubernetes.io/blog/2016/12/container-runtime-interface-cri-in-kubernetes/ for cri.
7. https://kubernetes.io/blog/2016/12/container-runtime-interface-cri-in-kubernetes/ for containerd.
8. 