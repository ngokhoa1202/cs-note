#cloud #iaas #software-engineering #operating-system #linux #windows #virtualization

- Framework to build a cloud computing platform.

# Introduction

- [OpenStack](https://www.openstack.org/) allows users to <mark style="background: #e4e62d;">build a cloud computing platform</mark> for both public and private clouds. OpenStack was started as a joint project between [Rackspace](https://www.rackspace.com/) and [NASA](http://www.nasa.gov/) in 2010. In 2012, a non-profit corporate entity, the OpenStack Foundation, was formed to manage it while receiving the support of more than 500 organizations. OpenStack is an open source software platform released under an [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0), and it is currently part of the [OpenInfra Foundation](https://openinfra.dev/).

# Components
- [Nova](https://www.openstack.org/software/releases/zed/components/nova)  
    Compute service that implements scalable and on-demand access to compute resources, including bare metal, virtual machines, and containers.
- [Ironic](https://www.openstack.org/software/releases/zed/components/ironic)  
    Bare metal provisioning service part of Hardware lifecycle services.
- [Cyborg](https://www.openstack.org/software/releases/zed/components/cyborg)  
    Lifecycle management service for GPU and ASIC-based devices, part of Hardware lifecycle services.
- [Swift](https://www.openstack.org/software/releases/zed/components/swift)  
    Object store part of Storage services that provides a highly available, distributed, eventually consistent object/blob store.
- [Cinder](https://www.openstack.org/software/releases/zed/components/cinder)  
    The block storage part of Storage services provides an abstraction layer over the management of block storage devices through a self-service API.
- [Manila](https://www.openstack.org/software/releases/zed/components/manila)  
    Shared filesystem part of Storage services, provides coordinated access to shared or distributed filesystems.
- [Neutron](https://www.openstack.org/software/releases/zed/components/neutron)  
    Networking service, a Software Defined Networking (SDN) delivering networking as a service (NaaS) in virtual compute environments.
- [Octavia](https://www.openstack.org/software/releases/zed/components/octavia)  
    Load balancer part of Networking services delivers on-demand and horizontal scaling load balancing as a service (LBaaS) to fleets of VMs, containers, or bare-metal servers.
- [Designate](https://www.openstack.org/software/releases/zed/components/designate)  
    DNS-as-a-Service part of Networking services.
- [Keystone](https://www.openstack.org/software/releases/zed/components/keystone)  
    Identity service part of Shared services, provides authentication, service discovery, and authorization. It supports LDAP, OAuth, OpenID Connect, SAML, and SQL.
- [Glance](https://www.openstack.org/software/releases/zed/components/glance)  
    Image service part of Shared services, provides VM image discovery, registration, and retrieval.
- [Heat](https://www.openstack.org/software/releases/zed/components/heat)  
    Orchestration service provides orchestration of infrastructure resources for cloud applications that also supports autoscaling.
- [Senlin](https://www.openstack.org/software/releases/zed/components/senlin)  
    Clustering service part of Orchestration services eases the orchestration of clusters of similar objects. 
- [Magnum](https://www.openstack.org/software/releases/zed/components/magnum)  
    Container orchestration engine provisioning service part of Workload provisioning services provisions Docker Swarm, Kubernetes or Apache Mesos to run on a cluster of VMs or bare-metal servers.
- [Sahara](https://www.openstack.org/software/releases/zed/components/sahara)  
    Framework provisioning service for Big Data processing part of Workload provisioning services. 
- [Freezer](https://www.openstack.org/software/releases/zed/components/freezer)  
    Backup, Restore, and Disaster Recovery service part of Application lifecycle services, provides efficient and flexible block-based backups, file-based incremental backups, and synchronized backups over multiple nodes, while it supports multiple OSes (Linux, Windows, macOS). 
- [Horizon](https://www.openstack.org/software/releases/zed/components/horizon)  
    Dashboard service part of Web frontend services provides an extensible web-based user interface to manage OpenStack services.
- [Ceilometer](https://www.openstack.org/software/releases/zed/components/ceilometer)  
    Metering and data collection service, an operations tool part of Monitoring services, provides efficient data collection, normalization, and transformation for telemetry purposes.
- [Monasca](https://www.openstack.org/software/releases/zed/components/monasca)  
    Monitoring service, an operations tool part of Monitoring services, provides highly-scalable, fault-tolerant monitoring as a service solution (MaaS), together with high-speed metrics processing, querying, alarm, and notification engines.
- [Cloudkitty](https://www.openstack.org/software/releases/zed/components/cloudkitty)  
    Billing and chargeback service, an operations tool part of Billing and Business logic services, introduces rating as a service (RaaS) to convert rating metrics into service pricing. 
- [Rally](https://www.openstack.org/software/releases/zed/components/rally)  
    For benchmarking and performance analysis, an operations tool part of Testing/Benchmarking services, that automates the detection of the impact changes in software architecture and hardware have on OpenStack performance.
- [Kuryr](https://www.openstack.org/software/releases/zed/components/kuryr)  
    Networking Integration enabler for Containers running on OpenStack.

# Manual guide
- OpenStack consists of a complex set of tools, designed to run on powerful bare metal servers in enterprise level datacenters. Due to its complexity, it requires a larger amount of computing resources than what a local workstation could offer. This makes the installation of OpenStack on personal workstations a real challenge. While there are a few solutions designed to simplify and automate the installation for local workstations, not all are successful in setting up a working OpenStack environment. These solutions have been tested on very specific environmental conditions and may not work in every setting.

- In addition to bootstrapping the cloud environment itself, populating the image store is another challenging task. Preparing the OpenStack cloud with OS images involves a variety of tools and image conversion methods.

- The local OpenStack cloud was bootstrapped with a tool called [Microstack](https://opendev.org/x/microstack). Once the cloud was provisioned, it displayed the URL of the local cloud Dashboard together with the credentials of the cloud admin. After successfully authenticating, land on OpenStack cloud Dashboard. The Dashboard displays an overview of cloud compute resources utilization. Using the navigation menu from the left we can create projects, manage users and credentials, and even provision new VM instances.

# Benefits
Key benefits of using OpenStack are:

- It is an open source solution.
- It is a cloud computing platform for public and private clouds.
- It offers a flexible, customizable, vendor-neutral environment. 
- It provides a high level of security.
- It provides high availability.
- It supports Artificial Intelligence (AI) and Machine Learning (ML).
- It facilitates automation throughout the stages of the cloud lifecycle.
- It is cost-effective, achieved by reducing system management overhead and avoiding vendor lock-in.

---
# References
1. https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS151.x+2T2023/block-v1:LinuxFoundationX+LFS151.x+2T2023+type@sequential+block@9dac140f040a4639a576447185bd3237/block-v1:LinuxFoundationX+LFS151.x+2T2023+type@vertical+block@cd2a02615b7c402caa46a0da2082081c
2. https://www.openstack.org/
3. https://openinfra.dev/