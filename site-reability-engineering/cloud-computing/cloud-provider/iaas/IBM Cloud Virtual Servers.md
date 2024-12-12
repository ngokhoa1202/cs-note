#kvm #cloud #site-realibility-engineering #virtualization #os #ibm 

[IBM Cloud](https://www.ibm.com/cloud) is one of the leading cloud services providers for enterprises and academic institutions. It includes the typical service models, the Infrastructure as a Service (IaaS), Software as a Service (SaaS), and Platform as a Service (PaaS) offered through public, private, and hybrid cloud delivery models. Part of the IBM Cloud IaaS model is the [IBM Cloud Virtual Servers](https://www.ibm.com/cloud/virtual-servers) service, also known as Virtual Machines, one of the many services providing cloud Compute services. IBM Cloud Virtual Servers provide interoperability between virtual and bare-metal servers by being deployed on the same VLANs as the physical servers. When you create an IBM Cloud Virtual Server, you can choose between multi-tenancy or single-tenancy environments, and also high-performance local disks or enterprise SAN storage.

IBM Cloud is the successor of two joined technologies - the IBM mainframe and virtualization. IBM treats virtualization with some level of flexibility. While it uses IBM z/VM and IBM PowerVM, two powerful hypervisors, to manage its own virtual workload, the users of IBM Cloud are allowed to choose between XenServer, VMware, and Hyper-V hypervisors when managing bare-metal instances. This level of hypervisor flexibility is one of the advantages of IBM Cloud, and one of the top reasons why users pick IBM Cloud over another cloud service provider.

IBM Cloud services are available at a cost, however, the [IBM Cloud Free Tier](https://www.ibm.com/cloud/free) offer allows users to explore always-free cloud services in combination with a predetermined amount of free credits available short-term to be used towards specific cloud resources.

# Features
When provisioning IBM Cloud Virtual Servers, users are able to manage different server aspects, such as profile, image, software package add-ons, attached storage, network interface bandwidth, internal and external firewall rules, IP addresses, and VPN. Most of these server aspects are available for the four supported types of virtual servers: 
- Public for multi-tenants
- Dedicated for single-tenants
- Transient for ephemeral multi-tenants
- Reserved for multi-tenants committed for a pre-specified term.

Profiles specify the size of the virtual server and are associated with predefined resource amounts that the servers get launched with. While there are popular profiles specifying a balanced collection of compute, memory, and storage resources, there are optimized profiles aimed at specific workload types:

- Balanced for common cloud workloads requiring a balance between performance and scalability with network-attached storage (NAS).
- Balanced local storage for medium to large databases that require high I/O, with local HDD storage.
- Compute for compute-intensive deployments such as moderate to high-traffic web servers.
- Memory for caching and analytics workloads.
- Variable compute for workloads without constant high-CPU performance.
- GPU for high-performance deployments.

Virtual server images are preconfigured with the information needed to launch IBM Cloud Virtual Servers. They include an Operating System such as a Linux distribution or Windows and optional software package add-ons.

# Benefits
Key benefits of using IBM Cloud Virtual Servers are:
- It is an easy-to-use IaaS solution.
- It is flexible and scalable.
- It provides guest OS options such as several Linux distributions and Windows.
- It provides a secure and robust functionality for your compute resources.
- It enables automation.
- It is cost-effective: only pay for the time and resources used.
- It is designed to work in conjunction with other IBM Cloud components and services.