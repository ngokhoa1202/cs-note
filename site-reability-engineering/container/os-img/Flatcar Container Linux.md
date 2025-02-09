# Introduction
[Flatcar Container Linux](https://www.flatcar-linux.org/) is a container-optimized OS with a minimal image size, including only the tools needed to run containers. Its name, "Flatcar", represents a flat and open railcar that is used in container transportation. Flatcar's greatest strengths are its immutable filesystem and automated atomic updates. 

Flatcar Container Linux is a drop-in replacement for Red Hat CoreOS Container Linux, being directly derived from CoreOS and enabling a seamless in-place migration. Users of CoreOS can effortlessly migrate to Flatcar Container Linux either by modifying a deployment to install Flatcar Container Linux, or by updating directly from Red Hat CoreOS Container Linux. 

Flatcar Container Linux became increasingly popular once Red Hat announced the end-of-life of the CoreOS Container Linux.

# Benefits
Key benefits of using Flatcar Container Linux are:

- It is a container-optimized Linux OS distribution.
- An immutable/read-only filesystem makes it less vulnerable.
- A minimal OS implies a minimized attack surface.
- It receives automated security updates and patches.
- As a CoreOS successor it supports two easy migration methods from Red Hat CoreOS Container Linux to Flatcar Container Linux. 
- It runs on bare-metal, and virtualization platforms such as QEMU, libVirt, VirtualBox, and Vagrant.
- It runs on public clouds such as Amazon EC2, GCE, Azure, Equinix, VMware, and DigitalOcean.
- Its first-time boot is supported by the [Ignition](https://coreos.github.io/ignition/) provisioning utility.
- Supports containerd and Docker container runtimes for Kubernetes clusters.