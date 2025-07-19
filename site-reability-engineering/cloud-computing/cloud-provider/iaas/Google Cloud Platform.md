#kvm #cloud #site-realibility-engineering #virtualization #operating-system #google 

[Google Cloud Platform](https://cloud.google.com/) (GCP) is one of the leading cloud services providers. Its infrastructure is the foundation for all other cloud services, whether Platform, Software, Containers, Serverless, Artificial Intelligence, Machine Learning, to name a few. Part of Google's Infrastructure as a Service (IaaS) model is the Compute Engine service. [Google Compute Engine](https://cloud.google.com/compute) (GCE) service allows individual users and enterprises alike to build a reliable, flexible, and secure cloud infrastructure for their applications and workloads on Google's platform. GCP offers an easy-to-use [Console](https://console.cloud.google.com/), which is a web interface for cloud resources management.

GCE instances are, in fact, Virtual Machines. When provisioning GCE instances on the GCP infrastructure, we are provisioning VMs on top of hypervisors that run directly on Google's physical infrastructure. In addition to the web Console, GCP also offers a command line interface (CLI), a tool to manage resources with command line tools and scripts if necessary. 

GCE services are enabled by the KVM type-1 hypervisor, running directly on Google's physical infrastructure and allowing for VMs to be launched with Linux and Windows guest Operating Systems.

GCE is a paid service; however, new users are encouraged to try the GCP platform for free through the [GCP Free Tier](https://cloud.google.com/free) offering. The Free Tier offers new users a chance to become familiar with the most popular services the Google Cloud Platform has to offer with the help of short-term initial free credits and several products that are always free within predefined usage limits.

# Feature
Google Compute Engine service allows users to configure many of the VM instance characteristics, such as machine profile, image, storage, network, security, and access control. 

GCE [Machine Types](https://cloud.google.com/compute/docs/machine-types) determine the virtualized hardware configuration for VMs to be provisioned. Based on available configurations, VMs are categorized in various _machine type families_ aimed to support specific types of applications and workloads:

- General-purpose machines offer the best price-performance ratio. This family includes machine types N1, N2, N2D, E2.
- Memory-optimized designed for memory-intensive workloads.
- Compute-optimized for compute-intensive workloads.
- Accelerator-optimized for machine learning (ML), high-performance computing (HPC), and GPU-dependent workloads.
- Shared-core for cost-effective light-weight applications. Several machine types from the N1 and E2 machine families share a physical core to minimize costs.

GCE [Images](https://cloud.google.com/compute/docs/images) determine the guest Operating System of the VMs. While there are several public images available to launch VMs, users can create custom Images as well.

Additional configurable aspects of GCE VMs, and related services:  

- Storage Disks for VM attached storage volumes.
- Networking VPC and Firewalls for network isolation and security.
- Snapshots for fast GCE persistent disk backups and recovery.
- Cloud Security Scanner to scan applications for security vulnerabilities.
- Health Checks to probe VMs health.
- Sole-tenant Nodes for dedicated physical Compute Engines.
- Network Endpoint Group representing collections of IP addresses for load balancing, firewalls, and logging purposes.
# Benefits

- It is flexible and allows you to scale your applications easily.
- Fast boot time.
- It is very secure, encrypting all data stored.
- It enables automation.
- It provides guest OS options such as several Linux distributions and Windows.
- It is cost-effective: only pay for the time and resources used.
- It supports custom machine types.
- It supports Virtual Private Cloud, Load Balancers, etc.

---
# References
1. https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS151.x+2T2023/block-v1:LinuxFoundationX+LFS151.x+2T2023+type@sequential+block@f96eae2afb994f7981c496b990fbd587/block-v1:LinuxFoundationX+LFS151.x+2T2023+type@vertical+block@1d87af49db424203ae4ea6242ccc02e2
2. 