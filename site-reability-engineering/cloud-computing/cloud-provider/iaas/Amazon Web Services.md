#kvm #cloud #site-realibility-engineering #virtualization #operating-system  #aws #container #iaas #saas #paas 

# Introduction
-  [Amazon](https://aws.amazon.com/) [Web Services](https://aws.amazon.com/) (AWS) is one of the leading cloud services providers. Its cloud services, whether Platform, Software, DB, Containers, Serverless, or Machine Learning, to name a few, rely heavily on its Infrastructure. 
# Images
- [Amazon Machine Images](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) (AMI) are preconfigured images including an operating system and software packages. 
- AMIs are stored in an AWS repository and are used to quickly launch instances. 
# IaaS
## Amazon Elastic Compute Cloud
- Also known as <mark style="background: #e4e62d;">Amazon EC2.</mark>
- [Instance Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) determine the virtualized hardware profile of the instance to be launched. Each instance type is preconfigured with different compute, memory, and storage capabilities. They are categorized in instance families such as:

- General purpose instances
- Optimized instances for:  
	- Compute (CPU) - for CPU intensive applications such as high-performance computing (HPC), machine learning (ML), batch workloads, and media transcoding.  
	- Accelerated Computing (GPU) - for graphically intensive, scientific, and engineering applications, and for machine learning (ML).  
	- Memory (RAM) - for in-memory databases, in-memory caches, and real-time data processing.  
	- Storage (SSD) - for data-intensive workloads and distributed filesystems.
# Related services
Additional configurable aspects of EC2 instances, related services, and tools may include: 

- [Virtual Private Cloud](https://aws.amazon.com/vpc/) (VPC) for network isolation.
- [Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) for VPC networks to control EC2 inbound/outbound traffic.
- [Amazon Elastic Block Store](https://aws.amazon.com/ebs/) (EBS) for persistent storage attachment.
- Dedicated hosts to provision instances on a physical machine reserved for our use.
- Elastic IP to remap a Static IP address automatically.
- [CloudWatch](https://aws.amazon.com/cloudwatch/) for monitoring resources and applications.
- [Auto Scaling](https://aws.amazon.com/autoscaling/) to dynamically resize resources.
# References
1. https://aws.amazon.com/ec2/ for Amazon EC2 official documentation.
2. [Docker container](Docker%20container.md) 

