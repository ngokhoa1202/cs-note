#kvm #cloud #site-realibility-engineering #virtualization 

- A hypervisor is necessary to run a virtual machine.
# Kernel virtual machine
- KVM (for Kernel-based Virtual Machine) is a full <mark style="background: #e4e62d;">virtualization</mark> solution for Linux on x86 hardware containing virtualization extensions (Intel VT or AMD-V). 
- KVM is a <mark style="background: #e4e62d;">loadable virtualization module</mark> of the Linux kernel and it converts the kernel into a hypervisor capable of managing guest Virtual Machines. 
- Specific hardware virtualization extensions supported by most modern processors, such as Intel VT and AMD-V, have to be available and enabled for processors to support KVM. Although originally designed for the x86 hardware, it has also been ported to FreeBSD, S/390, PowerPC, IA-64, and ARM as well.
- ![](Pasted%20image%2020241128150754.png)
# KVM's features
- KVM is an open source software that provides hardware-assisted virtualization to support [various guest OSes](http://www.linux-kvm.org/page/Guest_Support_Status), such as Linux distributions, Windows, Solaris, etc.

- KVM enables device abstraction of network interfaces, disk, but not the processor. Instead, it exposes the `/dev/kvm` interface that can be used by an external user space host for emulation. [KubeVirt](https://kubevirt.io/), [QEMU](https://www.qemu.org/), and [virt-manager](https://virt-manager.org/) are examples of user space tools for [KVM Virtual Machine management](https://www.linux-kvm.org/page/Management_Tools).

- KVM supports [nested guests](https://www.linux-kvm.org/page/Nested_Guests), a feature that allows VMs to run within VMs. It also supports hotpluggable devices such as CPUs and PCI devices. [Overcommitting](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/chap-overcommitting_with_kvm) is possible as well for the allocation of additional virtualized resources that may not be available on the system. To achieve overcommitting for a VM, KVM dynamically swaps resources from another guest that is not using the type of resource that is needed.be available on the system. To achieve overcommitting for a VM, KVM dynamically swaps resources from another guest that is not using the type of resource needed.
# KVM's advantages
- Open-source.
- Efficient hardware-assisted virtualization for an array of guest OSes, such as Linux, BSD, Solaris, Windows, macOS, ReactOS, and Haiku.
- It provides para-virtualization of Ethernet cards, disk I/O controllers, and graphical interfaces for guest OSes.
- It is highly scalable.
- KVM employs advanced security features, utilizing SELinux. It provides MAC (Mandatory Access Control) security between Virtual Machines.
# References
1. https://linux-kvm.org/page/Main_Page
2. https://planet.virt-tools.org/
3. https://virt-manager.org/