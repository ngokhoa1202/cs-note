

# Introduction
[Photon OS™](https://vmware.github.io/photon/) is a minimal Linux container host provided by [VMware](https://www.vmware.com/), optimized for cloud-native applications. It is designed with a small footprint in order to boot extremely quickly on VMware vSphere deployments and on public cloud computing platforms. Photon OS can be deployed on Amazon AWS EC2, GCE, and Microsoft Azure instances, while supporting a variety of container formats as a container host or as a Kubernetes node.

Photon OS is available in two versions, a minimal and a full version:

- The minimal version is a lightweight container host runtime environment including a minimum of packaging and functionality to manage containers while still remaining a fast runtime environment.
	- The full version also includes packages of tools for the development, testing, and deployment of containerized applications.
# Features
- Photon OS is optimized for VMware products and cloud platforms. It relies on an open source, yum-compatible package manager called Tiny DNF ([tdnf](https://github.com/vmware/tdnf)), and it manages services with systemd.

- Photon OS is a security-hardened Linux. The kernel and other aspects of the Photon OS are built with an emphasis on security recommendations provided by the [Kernel Self-Protection Project](https://www.kernel.org/doc/html/latest/security/self-protection.html) (KSPP).

- It can be easily managed, patched, and updated. It also provides support for persistent volumes to store the data of cloud-native applications on VMware vSAN™.

- Although promoted as an enterprise-grade appliance operating system, Photon OS can be installed on Raspberry Pi, ARM64, and x86 as well.
# Benefits
Key benefits of using Photon OS are:

- It is an open source technology with a small footprint.
- It supports various container runtimes as a standalone container host, or as a Kubernetes cluster node.
- It includes Kubernetes in the full version, to allow for container cluster management, but it also supports Apache Mesos.
- It boots extremely quickly on VMware platforms.
- Its kernel is tuned for higher performance when it is running on VMware platforms.
- It provides efficient lifecycle management with a yum-compatible package manager.
- It is a security-enhanced Linux as its kernel and other aspects of the operating system are configured according to the security parameter recommendations given by the Kernel Self-Protection Project (KSPP).