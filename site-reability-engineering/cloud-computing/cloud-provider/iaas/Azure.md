#kvm #cloud #site-realibility-engineering #virtualization #operating-system #azure #microsoft  #container #iaas #saas #paas 

# Introduction

- [Microsoft Azure](https://azure.microsoft.com/) is a leading cloud services provider, with products in different domains, such as compute, web and mobile, data and storage, Internet of Things (IoT), and many others. The [Azure Virtual Machine](https://docs.microsoft.com/en-us/azure/virtual-machines/) service allows individual users and enterprises alike to provision and manage compute resources, both from a web [Portal](https://azure.microsoft.com/en-us/features/azure-portal/) or the [Azure Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview), a flexible command line utility configurable to use either Bash or PowerShell.

Azure cloud services are enabled by the Azure Hypervisor, a customized version of Microsoft Hyper-V type-1 hypervisor. The Azure Hypervisor promises high efficiency, performance, and scalability over a small footprint thanks to the optimization of the custom Hyper-V hypervisor coupled with its tight integration with the physical infrastructure. 

# IaaS
## Window/Linux VM
- The VM [Image](https://azuremarketplace.microsoft.com/en-us/marketplace/apps?filters=virtual-machine-images) field defines the base Operating System or the application for the VM. 
- General purpose for development and testing environments, low traffic web servers, and small databases.
	- Optimized VMs for:  
		- Compute (for CPU intensive applications) for medium traffic web servers, batch processes and application servers.  
		- GPU for heavy graphic rendering, video editing, and deep learning.  
		- Memory (RAM) for relational databases and in-memory analysis.  
		- High Performance Compute (HPC).  
		- Storage for data warehousing and large transactional databases.
- Additional configurable aspects of VMs:  
	- Network security groups to manage network traffic.
	- SSD or HDD for persistent storage attachment, with optional encryption.
	- Dedicated hosts to provision VMs on a physical machine reserved for our use.
	- Accelerated networking for low latency and high throughput.
	- Virtual network for network isolation.
	- Monitoring resources and applications.
	- Resource Manager templates for VM deployment.
	- Seamless hybrid connections.
	- Automated backups.
---
# References
1. https://azure.microsoft.com/ for azure repository.
2. 