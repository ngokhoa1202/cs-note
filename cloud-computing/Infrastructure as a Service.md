#cloud #iaas #software-engineering #os #linux #windows #virtualization 

# Concepts
- _Infrastructure as a Service_ (IaaS) is a cloud service model that provides on-demand physical and virtual computing resources, storage, network, firewall, and load balancers. 
- To provide virtual computing resources, IaaS uses <mark style="background: #e4e62d;">hypervisors</mark>, such as Xen, KVM, VMware ESXi, Hyper-V, or Nitro.
- IaaS enables developers to provision and destroy isolated test environments as needed, when needed, quickly, and safely.
# Examples
## Amazon EC2
### Amazon EC2
- [Amazon](https://aws.amazon.com/) [Web Services](https://aws.amazon.com/) (AWS) is one of the leading cloud services providers. Its cloud services, whether Platform, Software, DB, Containers, Serverless, or Machine Learning, to name a few, rely heavily on its Infrastructure. Part of Amazon's Infrastructure as a Service (IaaS) model is the [Amazon Elastic Compute Cloud](https://aws.amazon.com/ec2/) (Amazon EC2) service. Amazon EC2 service allows individual users and enterprises alike to build a reliable, flexible, and secure cloud infrastructure for their applications and workloads on Amazon's platform. AWS offers an easy-to-use [Console](https://aws.amazon.com/console/), which is a web interface for cloud resources management.

- Amazon EC2 instances are, in fact, Virtual Machines. When provisioning EC2 instances on the AWS infrastructure, we are provisioning VMs on top of hypervisors that run directly on Amazon's physical infrastructure. In addition to the web console, AWS also offers a [command line interface](https://aws.amazon.com/cli/) (CLI), a tool to manage resources with command line tools and scripts if necessary. 

- At the heart of Amazon EC2 service are various type-1 hypervisors, such as Xen, KVM, and [Nitro](https://aws.amazon.com/ec2/nitro/) (a newer KVM-based lightweight hypervisor that delivers close to bare-metal performance).

- Although Amazon EC2 is a paid service, new users are encouraged to try the AWS platform for free through [AWS Free Tier](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all) offerings. While not all of its services qualify for the free tier, the ones that are available for free do come with some limitations. Several such services are offered under [short-term free trials](https://aws.amazon.com/free/free-tier/); others are offered for [12 months free](https://aws.amazon.com/free/free-tier/), while a third group of services may be [always free](https://aws.amazon.com/free/free-tier/) to all users. The three types of free offerings have been designed to encourage users to take advantage of the free tier offerings to become familiar with the most popular services the AWS platform has to offer.
### Features
- When provisioning Amazon EC2 instances, users are able to manage several aspects of the instance, such as hardware profile, operating system image with software package, additional storage, the network attached to the instance, and firewall rules. 
#### Amazon Machine Image
- [Amazon Machine Images](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) (AMI) are preconfigured images with the information needed to launch EC2 instances. They include an Operating System and a collection of software packages. AMIs are stored in an AWS repository and are used to quickly launch instances. There are default images created and maintained by AWS, the user community, or custom images we can create ourselves.
#### Instance type
- [Instance Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) determine the virtualized hardware profile of the instance to be launched. Each instance type is preconfigured with different compute, memory, and storage capabilities. They are categorized in instance families such as:
	-  General purpose instances
        - Optimized instances for:  
            - Compute (CPU) - for CPU intensive applications such as high-performance computing (HPC), machine learning (ML), batch workloads, and media transcoding.  
            - Accelerated Computing (GPU) - for graphically intensive, scientific, and engineering applications, and for machine learning (ML).  
            - Memory (RAM) - for in-memory databases, in-memory caches, and real-time data processing. 
            - Storage (SSD) - for data-intensive workloads and distributed filesystems.
- When launching an EC2 instance, select an instance type based on the requirements of the application or software expected to run on the instance. 
#### Configuration
Additional configurable aspects of EC2 instances, related services, and tools may include: 
- [Virtual Private Cloud](https://aws.amazon.com/vpc/) (VPC) for network isolation.
- [Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) for VPC networks to control EC2 inbound/outbound traffic.
- [Amazon Elastic Block Store](https://aws.amazon.com/ebs/) (EBS) for persistent storage attachment.
- Dedicated hosts to provision instances on a physical machine reserved for our use.
- Elastic IP to remap a Static IP address automatically.
- [CloudWatch](https://aws.amazon.com/cloudwatch/) for monitoring resources and applications.
- [Auto Scaling](https://aws.amazon.com/autoscaling/) to dynamically resize resources.
---
# References
1. https://en.wikipedia.org/wiki/Hypervisor