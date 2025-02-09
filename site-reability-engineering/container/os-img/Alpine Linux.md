
# Introduction
 [Alpine Linux](https://www.alpinelinux.org/about/) is an independent, non-commercial, Linux distribution designed for security, simplicity and resource efficiency. Built on top of the capabilities of BusyBox, Alpine Linux combines the security features of a Linux-based Operating System with a collection of small footprint, yet fully functional utilities. 

Although small, between 5 MB to 8 MB per container, or 130 MB as a minimal standalone OS install, it is more resource-efficient than typical distributions. Users can control which binary packages to install, thus ensuring a small yet efficient system.

Alpine Linux uses its own package manager called apk, the OpenRC init system, and set-up scripts. Users can add packages as needed such as PVR, iSCSI storage controllers, a mail server container, or an embedded switch.

Alpine Linux was designed with security in mind with embedded proactive security features that prevent the exploitation of entire classes of zero-day and other vulnerabilities.

# Features
Alpine Linux is available in many flavors:
- Standard  
    It requires a network connection.
- Extended  
    Includes the most used packages, and runs from RAM.
- Netboot  
    Includes kernel, initramfs, and modloop.
- Mini root filesystem  
    Minimal for containers and chroots.
- Virtual  
    Lighter kernel than Standard.
- Xen  
    Supports the Xen hypervisor.
- Raspberry Pi  
    Includes the Raspberry Pi kernel.
- Generic ARM  
    Includes the default ARM kernel with the uboot bootloader.
Comparing the two base image sizes, we conclude that the **alpine** base image is approximately ten times smaller than the **debian** base image. Using smaller sized images helps to reduce download times and conserve storage space on the container host.

# Benefits


# References
1. https://hub.docker.com/_/kong/tags 