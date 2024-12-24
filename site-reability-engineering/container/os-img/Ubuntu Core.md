[Ubuntu Core](https://ubuntu.com/core) is a lightweight version of [Ubuntu](https://ubuntu.com/), predominantly designed for IoT embedded devices but also found in large container deployments. In comparison with other container OSes, its size of around 260MB places Ubuntu Core behind much lighter container OSes, such as Alpine Linux, but ahead of much larger OSes like CoreOS, sized around 800MB. Similar to Ubuntu Server and Ubuntu Desktop, Ubuntu Core works with software packages called snaps. 

Security is a top concern for the designers of Ubuntu Core, implemented by features such as:

- Hardened security with immutable packages and persistent digital signatures. 
- Strict application isolation.
- Reduced attack surface by keeping a small OS, stripped down to bare essentials.
- Automatic vulnerability scanning of packages.

In addition, Ubuntu Core was designed with extreme reliability, implemented by:

- Transactional updates that increase OS and data resiliency by allowing automated rollbacks when errors are encountered.  
- Automated restore points to allow returns to the last working boot in the case of an unsuccessful kernel update.
- Consistent application data snapshots.

Ubuntu Core was built for the enterprise by including secure app store management and license compliance. Developers using Core as their platform enjoy cross-platform portability of snaps from Desktop and Server to Core, together with CI/CD pipeline support.

# Components
Ubuntu Core is designed to run on bare-metal, on hypervisors such as KVM, or a wide range of hardware including Raspberry Pi and Qualcomm Snapdragon 410c. Its top features are:

- Immutable image for simple and consistent installation and deployment.
- Isolated applications run with explicit permissions, such as read-only access to the filesystem.
- Transactional updates for signed, autonomous, atomic, and flexible updates.
- Security implemented at snap level, from build and distribution to deployment.

Application security and isolation is implemented through:

- AppArmor
- Seccomp.

Snaps are secure, isolated, dependency-free, portable, software packages for Linux. They even include their own filesystems. Snaps benefits include:

- Automatic updates.
- Automated recovery in the case of failed updates.
- Critical update provision for unscheduled updates.
- Flexible hardware and network conditions support for unpredictable systems, including redundancy for roll-backs, and autonomous bootstrapping.

The snap packaging environment includes the following:

- snap - the application package format and the command line interface (CLI)
- snapd - the background service managing and maintaining snaps
- snapcraft - the framework including the command to build custom snaps
- Snap Store - the repository to store and share snaps.

There are several types of snap included in Ubuntu Core:

- kernel - defines the Linux kernel
- gadget - defines specific system properties
- core - the execution environment for application snaps
- app - including applications, daemons such as snapd, and various tools.

# Benefits
Key benefits of using Ubuntu Core are:

- It has a mid-sized footprint among the Micro OSes available.
- It supports automated updates and rollbacks.
- It is highly resilient.
- It boots the containers within seconds.
- It is highly secure and extremely reliable. 
- It provides application isolation through AppArmor and Seccomp.
- It integrates with CI/CD pipelines.