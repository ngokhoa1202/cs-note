
The current technological trend is to run applications in containers, aiming for light weight isolated environments for applications. In this context, it makes a lot of sense to eliminate all the packages and services of the host Operating System (OS), which are not essential for running containers. With that in mind, various vendors have come forward with specialized minimal OSes to run just containers.

Once we remove the packages that are not essential to boot the base OS and to run container-related services, we are left with specialized OSes, which are referred to as _Micro OSes for containers_. However, such specialized OSes may also be used as container OSes as they allow for fast container startups and provide a lightweight container environment that is secure and easy to customize. Popular examples of Micro OSes are:
- Alpine Linux
- Busybox
- Fedora CoreOS
- Flatcar Container Linux
- k3OS
- Ubuntu Core
- VMware Photon OS.
![](Pasted%20image%2020241212134210.png)