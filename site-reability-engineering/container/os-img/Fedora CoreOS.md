
# Introduction
[Fedora CoreOS](https://getfedora.org/en/coreos/) (FCOS) is an open source project partnered with the [Fedora Project](https://getfedora.org/en/). It was formerly known as Red Hat CoreOS and CoreOS Container Linux prior to that. It combines the best of both CoreOS Container Linux and [Fedora Atomic Host](https://www.projectatomic.io/) (FAH) while aiming to provide the best container host to run containerized workloads securely and at scale.

Fedora CoreOS is a minimal operating system for running containerized workloads, that updates automatically and is available on multiple platforms. Although a container-focused operating system, by design, CoreOS is operable in both clusters and standalone instances. In addition, it is optimized to work with Kubernetes, but it also works very well without the containerized workload orchestrator.

# Components
Fedora CoreOS (FCOS) combines features of both CoreOS Container Linux and Fedora Atomic Host (FAH). In order to provide a robust container host to run containerized workloads securely and at scale, it integrates the following:

- _Ignition_ from CoreOS Container Linux  
    A provisioning utility designed specifically for CoreOS Container Linux, which allows users to manipulate disks during early boot, such as partitioning disks, formatting partitions, writing files, and configuring users. Ignition runs early in the boot process (in the initramfs) and runs its configuration before the userspace boot, which provides advanced features to administrators.
- _rpm-ostree_ from FAH  
    One cannot manage individual packages on Atomic Host, as there is no **rpm** or other related commands. To get any required service, you would have to start a respective container. Atomic Host has two bootable, immutable, and versioned filesystems; one is used to boot the system and the other is used to fetch updates from upstream. **rpm-ostree** is the tool to manage these two versioned filesystems.
- _SELinux hardening_ from FAH   
    Containers secured with SELinux provide close-to-VM isolation, security, increased flexibility, and efficiency.

FCOS offers multiple installation methods:

- _Cloud launchable_   
    To launch directly on Amazon's AWS platform.
- _Bare metal and virtualized_   
    For bare-metal installs from ISO, PXE (Preboot Execution Environment) or Raw, and virtual installs on OpenStack, QEMU, Raspberry Pi 4, VirtualBox, or VMware.
- _For cloud operators_   
    Optimized for the following cloud services providers: Alibaba Cloud, AWS, Azure, DigitalOcean, Exoscale, GCP, IBM Cloud, OpenStack, and Vultr.

# Benefits
Key benefits of using Fedora CoreOS are:

- It is an OS designed to run containerized applications, in both clustered environments or stand-alone.
- It enables us to perform quick updates and rollbacks.
- It provides increased security through SELinux.
- It can be installed on bare metal, virtual environments, and the cloud.
- It combines features of both Fedora Atomic Host and CoreOS Container Linux.
- It works well with Kubernetes.
- It uses Ignition as a provisioning tool for early boot disk partitioning, formatting, and other administrative configuration tasks.