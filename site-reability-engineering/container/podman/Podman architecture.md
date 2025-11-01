#ci-cd #cli #docker #software-architecture #client-server #application-layer #web-server  #dbms #binary-image  #operating-system #process #memory #virtual-memory #site-realibility-engineering 

# Podman
- [Podman](https://podman.io/), or Pod Manager, is an open source, daemonless tool designed to simplify the searching, running, building, sharing and deploying of applications using Open Containers Initiative (OCI) containers and container images. 
- Podman also relies on an OCI-compliant Container Runtime such as runc to create the running containers.
- Podman is rootless and daemonless.

- Red Hat, the developers of Podman, created two additional open source tools designed to operate within the container images landscape. [Buildah](https://buildah.io/) supports container image builds one step at a time by taking an interactive approach to processing Dockerfile instructions, while [Skopeo](https://github.com/containers/skopeo) is a tool designed to work with container images in both local and remote repositories.

- ![](Pasted%20image%2020241211145736.png)
-  Alternative: The containerd runtime came paired with the [ctr](https://github.com/projectatomic/containerd/tree/master/ctr) client, which was no match for Docker and Podman clients. While the ctr project is no longer maintained, a newer client, [nerdctl](https://github.com/containerd/nerdctl), advertised as a Docker-compatible client for containerd aims to make containerd more user friendly. Eventually, another client, [crictl](https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md), was created to support CRI-O. However, crictl can be configured for containerd and Docker as well.
# References
1. https://developer.ibm.com/tutorials/multi-architecture-cri-o-container-images-for-red-hat-openshift/