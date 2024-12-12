
As we know, a container platform like Docker runs on different platforms and architectures: bare metal (both x86 and ARM), Linux, macOS, and Windows. We can also find pre-configured VM images to run Docker on popular cloud infrastructures and virtualization providers.

From the user perspective, the experience is seamless, regardless of the underlying platform. However, behind the scenes, components such as the container runtime, networking, and storage are connected to ensure this high-quality experience. Open source projects like [containerd](https://containerd.io/) and [libnetwork](https://github.com/moby/libnetwork) are part of the container platform and have their own release cycles and governing models. The question is, however, how can we take those individual components and build a container platform like Docker?

[Project Moby](https://mobyproject.org/) is the answer. It is an open source project that provides a framework for assembling different container systems to build a container platform like Docker. Individual container systems provide features such as image, container, and secret management.

# Components
Moby is particularly useful for engineers who want to build their own container-based system, to customize and patch an existing Docker build, or just to experiment with the latest container technologies. It uses a Lego-like approach to assemble various open source [toolkits](https://mobyproject.org/projects/), such as:

- LinuxKit - to build minimal Linux distributions for containers.
- InfraKit - to manage infrastructure in a declarative manner.
- SwarmKit - to orchestrate distributed systems at scale.
- containerd - as container runtime.
- runc - to spawn and run OCI-compliant containers.
- Notary - for trusted data sets.
- LibNetwork - for networking.

However, Moby is not recommended for application developers in search of an easy-to-use container system to run their containerized applications.